-- Xóa bảng nếu đã tồn tại
BEGIN
    FOR tbl IN (SELECT table_name FROM user_tables WHERE table_name IN ('RATING', 'PRODUCT', 'CATEGORY', 'ORDERS', 'PAYMENT', 'SHIPMENT', 'STAFF', 'CART', 'CUSTOMER')) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || tbl.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

-- Bảng độc lập
CREATE TABLE Category (
    CategoryId NUMBER PRIMARY KEY,
    Category VARCHAR2(100)
);

CREATE TABLE Staff (
    StaffId NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Address VARCHAR2(200),
    Email VARCHAR2(100) UNIQUE,
    PhoneNumber VARCHAR2(15),
    Salary NUMBER(10, 2),
    Role VARCHAR2(50)
);

CREATE TABLE Cart (
    CartId NUMBER PRIMARY KEY
);

CREATE TABLE Customer (
    CustomerId NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Address VARCHAR2(200),
    Email VARCHAR2(100) UNIQUE,
    PhoneNumber VARCHAR2(15),
    Membership VARCHAR2(50),
    Point NUMBER,
    CartId NUMBER,
    CONSTRAINT FK_Customer_Cart FOREIGN KEY (CartId) REFERENCES Cart(CartId)
);

CREATE TABLE Product (
    ProductId NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Price NUMBER(10, 2),
    Quantity NUMBER,
    Description VARCHAR2(500),
    Image VARCHAR2(200),
    CategoryId NUMBER,
    CONSTRAINT FK_Product_Category FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

-- Bảng phụ thuộc
CREATE TABLE Shipment (
    ShipmentId NUMBER PRIMARY KEY,
    Status VARCHAR2(50),
    DateShipped DATE,
    ShipperId NUMBER,
    CONSTRAINT FK_Shipment_Shipper FOREIGN KEY (ShipperId) REFERENCES Staff(StaffId)
);

CREATE TABLE Payment (
    PaymentId NUMBER PRIMARY KEY,
    Total NUMBER(10, 2),
    CreationDate DATE,
    PayDate DATE,
    Status VARCHAR2(50),
    CustomerId NUMBER,
    CONSTRAINT FK_Payment_Customer FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE Orders (
    OrderId NUMBER PRIMARY KEY,
    CreationDate DATE,
    Status VARCHAR2(50),
    UserId NUMBER,
    PaymentId NUMBER,
    ShipmentId NUMBER,
    CONSTRAINT FK_Order_Customer FOREIGN KEY (UserId) REFERENCES Customer(CustomerId),
    CONSTRAINT FK_Order_Payment FOREIGN KEY (PaymentId) REFERENCES Payment(PaymentId),
    CONSTRAINT FK_Order_Shipment FOREIGN KEY (ShipmentId) REFERENCES Shipment(ShipmentId)
);
--cart
INSERT INTO Cart (CartId) VALUES (1);
INSERT INTO Cart (CartId) VALUES (2);
INSERT INTO Cart (CartId) VALUES (3);
--staff
INSERT INTO Staff (StaffId, Name, Address, Email, PhoneNumber, Salary, Role) 
VALUES (1, 'Alice Johnson', '123 Main St, City A', 'alice.johnson@example.com', '555-1234', 5000.00, 'Manager');

INSERT INTO Staff (StaffId, Name, Address, Email, PhoneNumber, Salary, Role) 
VALUES (2, 'Bob Smith', '456 Oak St, City B', 'bob.smith@example.com', '555-5678', 3500.00, 'Sales');

INSERT INTO Staff (StaffId, Name, Address, Email, PhoneNumber, Salary, Role) 
VALUES (3, 'Charlie Brown', '789 Pine St, City C', 'charlie.brown@example.com', '555-9101', 4000.00, 'Shipper');
--categogy
INSERT INTO Category (CategoryId, Category) VALUES (1, 'Smartphones');
INSERT INTO Category (CategoryId, Category) VALUES (2, 'Accessories');
INSERT INTO Category (CategoryId, Category) VALUES (3, 'Tablets');
--customer
INSERT INTO Customer (CustomerId, Name, Address, Email, PhoneNumber, Membership, Point, CartId) 
VALUES (1, 'John Doe', '101 Maple St, City A', 'john.doe@example.com', '123-456-1234', 'Gold', 500, 1);

INSERT INTO Customer (CustomerId, Name, Address, Email, PhoneNumber, Membership, Point, CartId) 
VALUES (2, 'Jane Smith', '202 Birch St, City B', 'jane.smith@example.com', '123-456-5678', 'Silver', 200, 2);

INSERT INTO Customer (CustomerId, Name, Address, Email, PhoneNumber, Membership, Point, CartId) 
VALUES (3, 'Samuel Green', '303 Cedar St, City C', 'samuel.green@example.com', '123-456-9101', 'Bronze', 100, 3);
--product
INSERT INTO Product (ProductId, Name, Price, Quantity, Description, Image, CategoryId) 
VALUES (1, 'iPhone 14', 999.99, 50, 'Latest Apple iPhone 14 with 5G support', 'iphone14.jpg', 1);

INSERT INTO Product (ProductId, Name, Price, Quantity, Description, Image, CategoryId) 
VALUES (2, 'Samsung Galaxy S22', 899.99, 30, 'High-end Samsung smartphone with AMOLED display', 'galaxy_s22.jpg', 1);

INSERT INTO Product (ProductId, Name, Price, Quantity, Description, Image, CategoryId) 
VALUES (3, 'Apple AirPods', 199.99, 100, 'Wireless Bluetooth earbuds from Apple', 'airpods.jpg', 2);

INSERT INTO Product (ProductId, Name, Price, Quantity, Description, Image, CategoryId) 
VALUES (4, 'Samsung Galaxy Tab S7', 649.99, 40, 'High-performance Android tablet', 'galaxy_tab_s7.jpg', 3);
--shipment
INSERT INTO Shipment (ShipmentId, Status, DateShipped, ShipperId) 
VALUES (1, 'Shipped', TO_DATE('2024-12-25', 'YYYY-MM-DD'), 3);

INSERT INTO Shipment (ShipmentId, Status, DateShipped, ShipperId) 
VALUES (2, 'Pending', TO_DATE('2024-12-26', 'YYYY-MM-DD'), 3);

INSERT INTO Shipment (ShipmentId, Status, DateShipped, ShipperId) 
VALUES (3, 'Shipped', TO_DATE('2024-12-27', 'YYYY-MM-DD'), 3);
--payment
INSERT INTO Payment (PaymentId, Total, CreationDate, PayDate, Status, CustomerId) 
VALUES (1, 999.99, TO_DATE('2024-12-25', 'YYYY-MM-DD'), TO_DATE('2024-12-25', 'YYYY-MM-DD'), 'Completed', 1);

INSERT INTO Payment (PaymentId, Total, CreationDate, PayDate, Status, CustomerId) 
VALUES (2, 649.99, TO_DATE('2024-12-26', 'YYYY-MM-DD'), TO_DATE('2024-12-26', 'YYYY-MM-DD'), 'Pending', 2);

INSERT INTO Payment (PaymentId, Total, CreationDate, PayDate, Status, CustomerId) 
VALUES (3, 199.99, TO_DATE('2024-12-27', 'YYYY-MM-DD'), TO_DATE('2024-12-27', 'YYYY-MM-DD'), 'Completed', 3);
--order
INSERT INTO Orders (OrderId, CreationDate, Status, UserId, PaymentId, ShipmentId) 
VALUES (1, TO_DATE('2024-12-25', 'YYYY-MM-DD'), 'Completed', 1, 1, 1);

INSERT INTO Orders (OrderId, CreationDate, Status, UserId, PaymentId, ShipmentId) 
VALUES (2, TO_DATE('2024-12-26', 'YYYY-MM-DD'), 'Pending', 2, 2, 2);

INSERT INTO Orders (OrderId, CreationDate, Status, UserId, PaymentId, ShipmentId) 
VALUES (3, TO_DATE('2024-12-27', 'YYYY-MM-DD'), 'Completed', 3, 3, 3);


