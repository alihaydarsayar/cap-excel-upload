

using { UploadExcelSrv } from '../../srv/OrderUpload-Srv';

// Annotations for Customers entity
annotate UploadExcelSrv.Customers with @(
    UI: {
        SelectionFields: [name, email],
        LineItem: [
            {Value: ID, Label: '{i18n>ID}'},
            {Value: name, Label: '{i18n>Name}'},
            {Value: email, Label: '{i18n>Email}'},
            {Value: phoneNumber, Label: '{i18n>PhoneNumber}'},
        ],
        HeaderInfo: {
            TypeName: '{i18n>Customer}', TypeNamePlural: '{i18n>Customers}',
            Title: {
                Label: '{i18n>Name}',
                Value: name
            },
            Description: {Value: email}
        },
        Identification: [
            {Value: name, Label: '{i18n>Name}'},
            {Value: email, Label: '{i18n>Email}'},
            {Value: phoneNumber, Label: '{i18n>PhoneNumber}'},
        ],
        HeaderFacets: [
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>GeneralInformation}', Target: '@UI.FieldGroup#GeneralInfo'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>Orders}', Target: 'orders/@UI.LineItem'},
            {
                $Type : 'UI.ReferenceFacet',
                Label : '<sdfasfd',
                ID : 'sdfasfd',
                Target : '@UI.FieldGroup#sdfasfd',
            },
        ],
        FieldGroup#GeneralInfo: {
            Data: [
                {Value: name},
                {Value: email},
                {Value: phoneNumber},
            ]
        }
    },
    UI.FieldGroup #sdfasfd : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },
            {
                $Type : 'UI.DataField',
                Value : name,
                Label : 'name',
            },
            {
                $Type : 'UI.DataField',
                Value : orders.customers_ID,
                Label : 'customers_ID',
            },
        ],
    },
) {
    phoneNumber @UI.HiddenFilter:false;
    email @UI.HiddenFilter:false;
    ID @UI.Hidden;
};

// Annotations for Orders entity
annotate UploadExcelSrv.Orders with @(
    UI: {
        LineItem: [
            {Value: orderDate, Label: '{i18n>OrderDate}'},
            {Value: totalAmount, Label: '{i18n>TotalAmount}'},

        ],
        Identification: [
            {Value: orderDate, Label: '{i18n>OrderDate}'},
            {Value: totalAmount, Label: '{i18n>TotalAmount}'},

        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>OrderDetails}', Target: '@UI.Identification'},
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>OrderItems}', Target: 'Items/@UI.LineItem'},
        ]
    }
) {
    orderDate @UI.HiddenFilter:false;
    totalAmount @UI.HiddenFilter:false;
    ID @UI.Hidden;
};

// Annotations for OrderItems entity
annotate UploadExcelSrv.OrderItems with @(
    UI: {
        LineItem: [
            {Value: quantity, Label: '{i18n>Quantity}'},
            {Value: title, Label: '{i18n>ProductTitle}'},
            {Value: price, Label: '{i18n>UnitPrice}'},
        ],
        Identification: [
            {Value: quantity, Label: '{i18n>Quantity}'},
            {Value: title, Label: '{i18n>Product}'},
            {Value: price, Label: '{i18n>UnitPrice}'},
        ],
        Facets: [
            {$Type: 'UI.ReferenceFacet', Label: '{i18n>OrderItems}', Target: '@UI.Identification'},
        ]
    }
) {
    quantity @UI.HiddenFilter:false;
    ID @UI.Hidden;
};


