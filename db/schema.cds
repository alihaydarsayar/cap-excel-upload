namespace com.alihaydarsayar.order.system;

entity Customers {
    key ID          : UUID;
        name        : String(100);
        email       : String(100);
        phoneNumber : String(20);
        orders      : Association to many Orders
                          on orders.customers = $self;
}

entity Orders {
    key ID          : UUID;
        orderDate   : DateTime;
        totalAmount : Decimal(10, 2);
        customers   : Association to Customers;
}
