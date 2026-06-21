CREATE DATABASE PharmacyDB;
USE PharmacyDB;

CREATE TABLE Medicine (
    ID_M INT PRIMARY KEY,
    Name VARCHAR(100),
    Type VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT,
    Expiry_Date DATE
);
SELECT*FROM Medicine;

CREATE TABLE Customer (
    ID_Cu INT PRIMARY KEY,
    Fname VARCHAR(50),
    Lname VARCHAR(50)
);
SELECT*FROM Customer;

CREATE TABLE Phone_Customer (
    ID_Cu INT,
    Customer_Number VARCHAR(20),
    PRIMARY KEY (ID_Cu, Customer_Number),
    FOREIGN KEY (ID_Cu) REFERENCES Customer(ID_Cu)
);
SELECT*FROM Phone_Customer;

CREATE TABLE Suppliers (
    ID_Su INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    Street VARCHAR(100)
);
SELECT*FROM Suppliers;

CREATE TABLE Phone_Suppliers (
    ID_Su INT,
    Supplier_Phone VARCHAR(20),
    PRIMARY KEY (ID_Su, Supplier_Phone),
    FOREIGN KEY (ID_Su) REFERENCES Suppliers(ID_Su)
);
SELECT*FROM Phone_Suppliers;

CREATE TABLE Branch (
    ID_B INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    Phone VARCHAR(20)
);
SELECT*FROM Branch;

CREATE TABLE Sales (
    ID_Sa INT PRIMARY KEY,
    Date DATE,
    Total_Amount DECIMAL(10,2),
    ID_Cu INT,
    ID_B INT,
    FOREIGN KEY (ID_Cu) REFERENCES Customer(ID_Cu),
    FOREIGN KEY (ID_B) REFERENCES Branch(ID_B)
);
SELECT*FROM Sales;

CREATE TABLE Sales_Details (
    ID_Sa INT,
    ID_M INT,
    Quantity INT,
    Price_Per_Unit DECIMAL(10,2),
    PRIMARY KEY (ID_Sa, ID_M),
    FOREIGN KEY (ID_Sa) REFERENCES Sales(ID_Sa),
    FOREIGN KEY (ID_M) REFERENCES Medicine(ID_M)
);
SELECT*FROM Sales_Details;

CREATE TABLE Prescription (
    ID_Per INT PRIMARY KEY,
    Name VARCHAR(100),
    Date DATE,
    Address VARCHAR(150),
    ID_Cu INT,
    FOREIGN KEY (ID_Cu) REFERENCES Customer(ID_Cu)
);
SELECT*FROM Prescription;

CREATE TABLE Phone_Prescription (
    ID_Per INT,
    Prescription_Number VARCHAR(20),
    PRIMARY KEY (ID_Per, Prescription_Number),
    FOREIGN KEY (ID_Per) REFERENCES Prescription(ID_Per)
);
SELECT*FROM Phone_Prescription;

CREATE TABLE Including (
    ID_Per INT,
    ID_M INT,
    PRIMARY KEY (ID_Per, ID_M),
    FOREIGN KEY (ID_Per) REFERENCES Prescription(ID_Per),
    FOREIGN KEY (ID_M) REFERENCES Medicine(ID_M)
);
SELECT*FROM Including;

CREATE TABLE Provides (
    ID_M INT,
    ID_Su INT,
    PRIMARY KEY (ID_M, ID_Su),
    FOREIGN KEY (ID_M) REFERENCES Medicine(ID_M),
    FOREIGN KEY (ID_Su) REFERENCES Suppliers(ID_Su)
);
SELECT*FROM Including;

CREATE TABLE Customer_Product (
    ID_Cu INT,
    ID_M INT,
    Total_Interaction INT,
    PRIMARY KEY (ID_Cu, ID_M),
    FOREIGN KEY (ID_Cu) REFERENCES Customer(ID_Cu),
    FOREIGN KEY (ID_M) REFERENCES Medicine(ID_M)
);
SELECT*FROM Customer_Product;


INSERT INTO Medicine VALUES
(1,'Panadol','Tablet',15.00,100,'2026-05-01'),
(2,'Augmentin','Capsule',45.00,80,'2026-03-10'),
(3,'Cataflam','Tablet',20.00,120,'2025-12-15'),
(4,'Brufen','Syrup',30.00,60,'2026-07-20'),
(5,'Vitamin C','Tablet',10.00,200,'2027-01-01');

INSERT INTO Customer VALUES
(1,'Ahmed','Ali'),
(2,'Sara','Mohamed'),
(3,'Omar','Hassan'),
(4,'Mona','Ibrahim'),
(5,'Youssef','Kamal');

INSERT INTO Phone_Customer VALUES
(1,'01011111111'),
(2,'01022222222'),
(3,'01033333333'),
(4,'01044444444'),
(5,'01055555555');

INSERT INTO Suppliers VALUES
(1,'El-Nile Pharma','Cairo','Nasr City'),
(2,'Health Plus','Giza','Dokki'),
(3,'Medico','Alex','Smouha'),
(4,'Life Care','Cairo','Heliopolis'),
(5,'Pharma Line','Tanta','Center');

INSERT INTO Phone_Suppliers VALUES
(1,'022111111'),
(2,'022222222'),
(3,'033333333'),
(4,'022444444'),
(5,'040555555');

INSERT INTO Branch VALUES
(1,'Main Branch','Nasr City','01090000001'),
(2,'Giza Branch','Dokki','01090000002'),
(3,'Alex Branch','Smouha','01090000003'),
(4,'Helwan Branch','Helwan','01090000004'),
(5,'Maadi Branch','Maadi','01090000005');

INSERT INTO Sales VALUES
(1,'2025-01-01',150.00,1,1),
(2,'2025-01-02',200.00,2,2),
(3,'2025-01-03',75.00,3,3),
(4,'2025-01-04',300.00,4,4),
(5,'2025-01-05',50.00,5,5);

INSERT INTO Sales_Details VALUES
(1,1,2,15.00),
(2,2,3,45.00),
(3,3,1,20.00),
(4,4,4,30.00),
(5,5,5,10.00);

INSERT INTO Prescription VALUES
(1,'Dr Ahmed','2025-01-10','Cairo',1),
(2,'Dr Sara','2025-01-11','Giza',2),
(3,'Dr Omar','2025-01-12','Alex',3),
(4,'Dr Mona','2025-01-13','Helwan',4),
(5,'Dr Youssef','2025-01-14','Maadi',5);

INSERT INTO Phone_Prescription VALUES
(1,'01110000001'),
(2,'01110000002'),
(3,'01110000003'),
(4,'01110000004'),
(5,'01110000005');

INSERT INTO Including VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

INSERT INTO Provides VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

INSERT INTO Customer_Product VALUES
(1,1,3),
(2,2,2),
(3,3,5),
(4,4,1),
(5,5,4);







SELECT Sales.ID_Sa, Sales.Date, Medicine.Name, Sales_Details.Quantity, Sales_Details.Price_Per_Unit
FROM Sales
INNER JOIN Sales_Details ON Sales.ID_Sa = Sales_Details.ID_Sa
INNER JOIN Medicine ON Sales_Details.ID_M = Medicine.ID_M;


SELECT Customer.ID_Cu, Customer.Fname, Customer.Lname, Sales.ID_Sa, Sales.Date
FROM Customer
LEFT JOIN Sales ON Customer.ID_Cu = Sales.ID_Cu;

SELECT ID_M, Name, Price
FROM Medicine
ORDER BY Price DESC;

SELECT Sales.ID_Sa, Sales.Date, Customer.Fname, Customer.Lname, Total_Amount
FROM Sales
INNER JOIN Customer ON Sales.ID_Cu = Customer.ID_Cu
ORDER BY Sales.Date DESC;

SELECT 
    Branch.Name AS Branch_Name,
    Sales.ID_Sa,
    Sales.Date,
    Medicine.Name AS Medicine_Name,
    Sales_Details.Quantity,
    Sales_Details.Price_Per_Unit
FROM Sales
INNER JOIN Sales_Details ON Sales.ID_Sa = Sales_Details.ID_Sa
INNER JOIN Medicine ON Sales_Details.ID_M = Medicine.ID_M
INNER JOIN Branch ON Sales.ID_B = Branch.ID_B
ORDER BY Branch.Name ASC, Sales_Details.Quantity DESC;


SELECT 
    Medicine.Name AS Medicine_Name,
    SUM(Sales_Details.Quantity * Sales_Details.Price_Per_Unit) AS Total_Sales
FROM Sales_Details
INNER JOIN Medicine ON Sales_Details.ID_M = Medicine.ID_M
GROUP BY Medicine.ID_M, Medicine.Name
ORDER BY Total_Sales DESC;