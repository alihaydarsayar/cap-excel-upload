using { cuid, managed } from '@sap/cds/common';

namespace com.alihaydarsayar.order.system;

entity Customers : cuid, managed {
    name        : String(100);
    email       : String(100);
    phoneNumber : String(20);
    orders      : Association to many Orders
                      on orders.customers = $self;
}

entity Orders : cuid, managed {
    orderDate   : DateTime;
    totalAmount : Decimal(10, 2);
    customers   : Association to Customers;
    Items       : Composition of many OrderItems;
    currency    : String; // Currency as a String for simplicity
}

entity OrderItems : cuid, managed {
    product     : Association to Products;
    quantity    : Integer;
    title       : String; // Product title
    price       : Decimal(10, 2);
}

entity Products : cuid, managed {
    key ID    : String;
    title     : String;
    description: String;
    price     : Decimal(10, 2);
}
