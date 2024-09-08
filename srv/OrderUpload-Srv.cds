using {com.alihaydarsayar.order.system as db} from '../db/schema';

service UploadExcelSrv {

    @cds.persistence.skip
    @odata.singleton

    entity UploadExcel {
        @Core.MediaType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        spreadsheet : LargeBinary;
    }

    entity Customers as projection on db.Customers;
    entity Orders    as projection on db.Orders;

}
