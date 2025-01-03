-- Drop tables if they exist
IF OBJECT_ID('dbo.RATING', 'U') IS NOT NULL DROP TABLE RATING;
IF OBJECT_ID('dbo.PRODUCT', 'U') IS NOT NULL DROP TABLE PRODUCT;
IF OBJECT_ID('dbo.CATEGORY', 'U') IS NOT NULL DROP TABLE CATEGORY;
IF OBJECT_ID('dbo.ORDERS', 'U') IS NOT NULL DROP TABLE ORDERS;
IF OBJECT_ID('dbo.PAYMENT', 'U') IS NOT NULL DROP TABLE PAYMENT;
IF OBJECT_ID('dbo.SHIPMENT', 'U') IS NOT NULL DROP TABLE SHIPMENT;
IF OBJECT_ID('dbo.STAFF', 'U') IS NOT NULL DROP TABLE STAFF;
IF OBJECT_ID('dbo.CUSTOMER', 'U') IS NOT NULL DROP TABLE CUSTOMER;
IF OBJECT_ID('dbo.CART', 'U') IS NOT NULL DROP TABLE CART;

-- Independent tables
CREATE TABLE Category (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Category NVARCHAR(100)
);

CREATE TABLE Staff (
    StaffId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100),
    Address NVARCHAR(200),
    Email NVARCHAR(100) UNIQUE,
    PhoneNumber NVARCHAR(15),
    Salary DECIMAL(10, 2),
    Role NVARCHAR(50)
);

CREATE TABLE Cart (
    CartId INT IDENTITY(1,1) PRIMARY KEY,
);

CREATE TABLE Customer (
    CustomerId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100),
    Address NVARCHAR(200),
    Email NVARCHAR(100) UNIQUE,
    PhoneNumber NVARCHAR(15),
    Membership NVARCHAR(50),
    Point INT,
    CartId INT,
    FOREIGN KEY (CartId) REFERENCES Cart(CartId)
);

CREATE TABLE Product (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100),
    Price DECIMAL(10, 2),
    Quantity INT,
    Warranty NVARCHAR(50),
    Brand NVARCHAR(50),
    Description NVARCHAR(500),
    OtherInfor NVARCHAR(500),
    Image NVARCHAR(200),
    CategoryId INT,
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);

-- Dependent tables
CREATE TABLE Shipment (
    ShipmentId INT IDENTITY(1,1) PRIMARY KEY,
    Status NVARCHAR(50),
    DateShipped DATE,
    ShipperId INT,
    FOREIGN KEY (ShipperId) REFERENCES Staff(StaffId)
);

CREATE TABLE Payment (
    PaymentId INT IDENTITY(1,1) PRIMARY KEY,
    Total DECIMAL(10, 2),
    CreationDate DATE,
    PayDate DATE,
    Status NVARCHAR(50),
    CustomerId INT,
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    CreationDate DATE,
    Status NVARCHAR(50),
    UserId INT,
    PaymentId INT,
    ShipmentId INT,
    FOREIGN KEY (UserId) REFERENCES Customer(CustomerId),
    FOREIGN KEY (PaymentId) REFERENCES Payment(PaymentId),
    FOREIGN KEY (ShipmentId) REFERENCES Shipment(ShipmentId)
);

-- Insert data into Cart
INSERT INTO Cart DEFAULT VALUES;
INSERT INTO Cart DEFAULT VALUES;
INSERT INTO Cart DEFAULT VALUES;

-- Insert data into Staff
INSERT INTO Staff (Name, Address, Email, PhoneNumber, Salary, Role) 
VALUES 
('Alice Johnson', '123 Main St, City A', 'alice.johnson@example.com', '555-1234', 5000.00, 'Manager'),
('Bob Smith', '456 Oak St, City B', 'bob.smith@example.com', '555-5678', 3500.00, 'Sales'),
('Charlie Brown', '789 Pine St, City C', 'charlie.brown@example.com', '555-9101', 4000.00, 'Shipper');

-- Insert data into Category
INSERT INTO Category (Category) 
VALUES ('Smartphones'), ('Accessories'), ('Tablets');

-- Insert data into Customer
INSERT INTO Customer (Name, Address, Email, PhoneNumber, Membership, Point, CartId) 
VALUES 
('John Doe', '101 Maple St, City A', 'john.doe@example.com', '123-456-1234', 'Gold', 500, 1),
('Jane Smith', '202 Birch St, City B', 'jane.smith@example.com', '123-456-5678', 'Silver', 200, 2),
('Samuel Green', '303 Cedar St, City C', 'samuel.green@example.com', '123-456-9101', 'Bronze', 100, 3);

-- Insert data into Product
INSERT INTO Product (Name, Price, Quantity, Warranty, Brand, Description, OtherInfor, Image, CategoryId) 
VALUES 
('iPhone 14', 999.99, 50, '1 Year', 'Apple', 'Latest Apple iPhone 14 with 5G support', 'N/A', 'iphone14.jpg', 1),
('Samsung Galaxy S22', 899.99, 30, '1 Year', 'Samsung', 'High-end Samsung smartphone with AMOLED display', 'N/A', 'galaxy_s22.jpg', 1),
('Apple AirPods', 199.99, 100, '1 Year', 'Apple', 'Wireless Bluetooth earbuds from Apple', 'N/A', 'airpods.jpg', 2),
('Samsung Galaxy Tab S7', 649.99, 40, '1 Year', 'Samsung', 'High-performance Android tablet', 'N/A', 'galaxy_tab_s7.jpg', 3);

-- Insert data into Shipment
INSERT INTO Shipment (Status, DateShipped, ShipperId) 
VALUES 
('Shipped', '2024-12-25', 3),
('Pending', '2024-12-26', 3),
('Shipped', '2024-12-27', 3);

-- Insert data into Payment
INSERT INTO Payment (Total, CreationDate, PayDate, Status, CustomerId) 
VALUES 
(999.99, '2024-12-25', '2024-12-25', 'Completed', 1),
(649.99, '2024-12-26', '2024-12-26', 'Pending', 2),
(199.99, '2024-12-27', '2024-12-27', 'Completed', 3);

-- Insert data into Orders
INSERT INTO Orders (CreationDate, Status, UserId, PaymentId, ShipmentId) 
VALUES 
('2024-12-25', 'Completed', 1, 1, 1),
('2024-12-26', 'Pending', 2, 2, 2),
('2024-12-27', 'Completed', 3, 3, 3);

