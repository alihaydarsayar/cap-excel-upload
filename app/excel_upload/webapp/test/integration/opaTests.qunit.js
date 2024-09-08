sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/alihaydarsayar/excelupload/test/integration/FirstJourney',
		'com/alihaydarsayar/excelupload/test/integration/pages/CustomersList',
		'com/alihaydarsayar/excelupload/test/integration/pages/CustomersObjectPage'
    ],
    function(JourneyRunner, opaJourney, CustomersList, CustomersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/alihaydarsayar/excelupload') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCustomersList: CustomersList,
					onTheCustomersObjectPage: CustomersObjectPage
                }
            },
            opaJourney.run
        );
    }
);