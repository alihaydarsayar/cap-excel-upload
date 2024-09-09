const cds = require("@sap/cds"); // CDS modülünü projeye dahil eder
const { PassThrough } = require("stream"); // Node.js'in stream modülünden PassThrough sınıfını dahil eder
var xlsx = require("xlsx"); // Excel dosyalarını okumak ve işlemek için xlsx modülünü dahil eder

const { Customers, Order } = cds.entities; // CDS modelindeki Customers ve Order entity'lerini projeye dahil eder

module.exports = async (srv) => {
  /**
   * UploadExcel adlı servis event handler'ı
   * PUT methodu ile veri yükleme işlemi yapılır
   * req, event'in request nesnesidir
   * spreadsheet, UploadExcel entity'sine ait yüklenen veri yapısıdır
   * arrBuffer[], veri parçacıklarını tutar
   * req.headers, event mesajının ya da isteğin başlıklarına erişimi sağlar
   * req.headers.slug, ek bilgiler göndermek için kullanılan başlık bilgisidir
   * PassThrough, veri akışını manipüle etmeden iletmek için kullanılır
   */

  srv.on("PUT", "UploadExcel", async (req, next) => {
    if (req.data.spreadsheet) { // Eğer yüklenen bir spreadsheet varsa
      var table = req.headers.slug; // slug başlığından tablo adını alır
      const sStream = new PassThrough(); // PassThrough nesnesi oluşturulur
      var arrBuffer = []; // Veri parçacıklarını tutacak dizi

      req.data.spreadsheet.pipe(sStream); // Spreadsheet verisi sStream ile işlenmek üzere boru hattına bağlanır
      await new Promise((resolve, reject) => {
        sStream.on("data", (Chunk) => { 
          // PassThrough stream'den gelen veriyi ArrayBuffer'a dönüştürür
          arrBuffer.push(Chunk); // Gelen veri parçacıkları diziye eklenir
        });
        sStream.on("end", async () => {
          var buffer = Buffer.concat(arrBuffer); // Tüm veri parçacıkları birleştirilir
          // workbook, Excel verilerini tutan değişkendir
          var workbook = xlsx.read(buffer, { header: 1, cellDates: true }); 
          let data = []; // Verilerin tutulacağı dizi

          // sheets, workbook'ta bulunan sayfa adlarını tutar
          const sheets = workbook.SheetNames; 
          for (let i = 0; i < sheets.length; i++) {
            // temp, Excel verilerini JSON formatında tutar
            const temp = xlsx.utils.sheet_to_json(
              workbook.Sheets[workbook.SheetNames[0]],
              { header: 1 }
            );

            for (let i = 1; i < temp.length; i++) {
              for (var j = 1; j <= 5; j++) {
                if (temp[i][j] == undefined) temp[i][j] = ""; // Eğer veri yoksa boş string ile doldurur
                temp[i][j] = temp[i][j]; // Veriyi olduğu gibi tutar
              }
            }

            for (let b = 1; b < temp.length; b++) {
              try {
                // oDataObj, her bir satırdaki [row][column] değerlerini tutar
                var oDataObj = {
                  ID: temp[b][0] ? temp[b][0].toString() : "", // ID değeri varsa string'e dönüştürülür
                  name: temp[b][1] ? temp[b][1].toString() : "", // name değeri varsa string'e dönüştürülür
                  email: temp[b][2] ? temp[b][2].toString() : "", // email değeri varsa string'e dönüştürülür
                  phoneNumber: temp[b][3] ? temp[b][3].toString() : "", // phoneNumber değeri varsa string'e dönüştürülür
                  orders: temp[b][4] ? temp[b][4].toString() : "", // orders değeri varsa string'e dönüştürülür
                };
              } catch (err) {
                console.log("error %s", err); // Hata durumunda konsola loglanır
              }
              data.push(oDataObj); // oDataObj nesnesi data dizisine eklenir
            }
          }
          // Eğer data dizisi doluysa, EntityCall() fonksiyonu çağrılır
          if (data) {
            const callResponse = await EntityCall(Customers, data, req);

            if (callResponse == -1)
              reject(req.error(400, JSON.stringify(data))); // Hata durumunda -1 döndürür
            else {
              resolve(
                req.notify({
                  message: "Upload Successful", // Yükleme başarılı mesajı
                  status: 200,
                })
              );
            }
          }
        });
      });
    } else {
      return next(); // Eğer spreadsheet yoksa bir sonraki işleme geç
    }
  });

  /**
   * EntityCall() fonksiyonu, veritabanına veri eklemek için kullanılır
   * @param {*} entity : Verinin ekleneceği Customers tablosu
   * @param {*} data : Eklenecek veri nesnesi
   * @returns : insertResult sonucu döndürülür
   */
  async function EntityCall(entity, data, req) {
    try {
      // Veritabanına INSERT sorgusu ile veri ekleme işlemi
      const insertQuery = INSERT.into(entity).entries(data);
      const insertResult = await cds.transaction(req).run(insertQuery);
      return insertResult; // Başarılı ekleme işleminde sonucu döndür
    } catch (err) {
      console.log("Error %s", err); // Hata olursa konsola loglanır
      return -1; // Hata durumunda -1 döndür
    }
  }


  // srv.on('READ', 'Customers', async (req) => {
  //   console.log('Reading Customers');
  //   const customers = await SELECT.from(Customers);
  //   console.log(`Retrieved ${customers.length} customers`);
  //   return customers;
  // });
  
  // srv.on('READ', 'Orders', async (req) => {
  //   console.log('Reading Orders');
  //   const orders = await SELECT.from(Orders);
  //   console.log(`Retrieved ${orders.length} orders`);
  //   return orders;
  // });

  
};
