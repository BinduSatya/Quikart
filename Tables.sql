-- 1. Users Table
CREATE TABLE Users 
(
  UserID        NUMBER(10) PRIMARY KEY,
  FullName      NVARCHAR2(100) NOT NULL,
  Email         NVARCHAR2(100) UNIQUE,
  PhoneNumber   NVARCHAR2(15),
  CreatedAt     DATE DEFAULT SYSDATE
);
-- 2. Addresses Table
CREATE TABLE Addresses 
(
  AddressID     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  UserID        NUMBER,
  AddressLine   NVARCHAR2(255),
  City          NVARCHAR2(50),
  State         NVARCHAR2(50),
  Pincode       NVARCHAR2(10),
  CreatedAt     DATE DEFAULT SYSDATE,
  CONSTRAINT fk_user FOREIGN KEY (UserID) REFERENCES Users (UserID)
);
-- 3. Vendors Table
CREATE TABLE Vendors 
(
  VendorID       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  VendorName     NVARCHAR2(100),
  ContactEmail   NVARCHAR2(100),
  CreatedAt      DATE DEFAULT SYSDATE
);
-- 4. ProductCategories Table
CREATE TABLE ProductCategories 
(
  CategoryID     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  CategoryName   NVARCHAR2(100) NOT NULL
);
-- 5. Products Table
CREATE TABLE Products 
(
  ProductID     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  Name          NVARCHAR2(100) NOT NULL,
  Description   NVARCHAR2(255),
  CategoryID    NUMBER,
  Price         NUMBER(10,2),
  CreatedAt     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_category FOREIGN KEY (CategoryID) REFERENCES ProductCategories (CategoryID)
);
-- 6. Inventory Table
CREATE TABLE Inventory 
(
  InventoryID         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  VendorID            NUMBER,
  ProductID           NUMBER,
  QuantityAvailable   NUMBER,
  LastUpdated         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_inventory_vendor FOREIGN KEY (VendorID) REFERENCES Vendors (VendorID),
  CONSTRAINT fk_inventory_product FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
-- 7. Orders Table
CREATE TABLE Orders 
(
  OrderID       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  UserID        NUMBER,
  VendorID      NUMBER,
  OrderDate     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  TotalAmount   NUMBER(10,2),
  CONSTRAINT fk_orders_user FOREIGN KEY (UserID) REFERENCES Users (UserID),
  CONSTRAINT fk_orders_vendor FOREIGN KEY (VendorID) REFERENCES Vendors (VendorID)
);
-- 8. OrderItems Table
CREATE TABLE OrderItems 
(
  OrderItemID   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  OrderID       NUMBER,
  ProductID     NUMBER,
  Quantity      NUMBER,
  Price         NUMBER(10,2),
  CONSTRAINT fk_orderitems_order FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
  CONSTRAINT fk_orderitems_product FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
-- 9. Payments Table
CREATE TABLE Payments 
(
  PaymentID       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  OrderID         NUMBER,
  PaymentMode     NVARCHAR2(50),
  PaymentStatus   NVARCHAR2(50),
  CONSTRAINT fk_payments_order FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
  PaidAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- 10. DeliveryPartners Table
CREATE TABLE DeliveryPartners 
(
  PartnerID     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  FullName      NVARCHAR2(100),
  PhoneNumber   NVARCHAR2(15)
);
-- 11. Status Table
CREATE TABLE Status 
(
  StatusID     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  StatusName   NVARCHAR2(50)
);
-- 12. DeliveryStatus Table
CREATE TABLE DeliveryStatus 
(
  DeliveryID   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  OrderID      NUMBER,
  StatusID     NUMBER,
  UpdatedAt    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_deliverystatus_order FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
  CONSTRAINT fk_deliverystatus_status FOREIGN KEY (StatusID) REFERENCES Status (StatusID)
);
-- 13. Reviews Table
CREATE TABLE Reviews 
(
  ReviewID    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  UserID      NUMBER,
  ProductID   NUMBER,
  Rating      NUMBER CHECK (Rating BETWEEN 1 AND 5),
  "COMMENT"   NVARCHAR2(255),
  CreatedAt   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_reviews_user FOREIGN KEY (UserID) REFERENCES Users (UserID),
  CONSTRAINT fk_reviews_product FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
