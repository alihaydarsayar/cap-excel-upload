using UploadExcelSrv as service from '../../srv/OrderUpload-Srv';

annotate service.Customers with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'ID',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Email',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Phone Number',
            Value : phoneNumber,
        },
    ]
);

annotate service.Customers with @(
    UI.HeaderInfo : {
        TypeName : 'Customer',
        TypeNamePlural : 'Customers',
        Title : {
            $Type : 'UI.DataField',
            Value : name
        },
        Description : {
            $Type : 'UI.DataField',
            Value : email
        }
    },
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            
            {
                $Type : 'UI.DataField',
                Label : 'Name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Email',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Phone Number',
                Value : phoneNumber,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     ID : 'OrdersFacet',
        //     Label : 'Orders',
        //     Target : 'orders/@UI.LineItem',
        // },
    ]
);

// annotate service.Orders with @(
//     UI.LineItem : [
//         {
//             $Type : 'UI.DataField',
//             Label : 'Order ID',
//             Value : ID,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'Order Date',
//             Value : orderDate,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'Total Amount',
//             Value : totalAmount,
//         },
//     ]
// );