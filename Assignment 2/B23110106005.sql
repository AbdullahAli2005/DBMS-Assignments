CREATE DATABASE CarShowroomDB;

CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    JoinDate DATE
);

CREATE TABLE Cars (
    CarID SERIAL PRIMARY KEY,
    Model VARCHAR(100),
    Brand VARCHAR(50),
    Year INT,
    Price NUMERIC(12, 2),
    Color VARCHAR(30),
    InventoryCount INT
);

CREATE TABLE Salespersons (
    SalespersonID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    HireDate DATE
);

CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    CarID INT REFERENCES Cars(CarID),
    SaleDate DATE,
    SalePrice NUMERIC(12, 2),
    SalespersonID INT REFERENCES Salespersons(SalespersonID)
);

CREATE TABLE ServiceRecords (
    RecordID SERIAL PRIMARY KEY,
    CarID INT REFERENCES Cars(CarID),
    ServiceDate DATE,
    ServiceType VARCHAR(50),
    Cost NUMERIC(12, 2),
    TechnicianID INT
);

INSERT INTO Customers (CustomerName, City, State, JoinDate) VALUES
('Usman Tariq', 'Multan', 'Punjab', '2023-03-12'),
('Nida Farooq', 'Peshawar', 'KPK', '2023-04-18'),
('Omar Siddiqui', 'Quetta', 'Balochistan', '2023-05-08');

INSERT INTO Cars (Model, Brand, Year, Price, Color, InventoryCount) VALUES
('Sonata', 'Hyundai', 2023, 42000, 'Grey', 4),
('Elantra', 'Hyundai', 2022, 31000, 'Blue', 6),
('CX-5', 'Mazda', 2023, 46000, 'White', 3),
('Altima', 'Nissan', 2024, 48000, 'Black', 2),
('Mustang', 'Ford', 2024, 75000, 'Yellow', 1);

INSERT INTO Salespersons (Name, Department, HireDate) VALUES
('Bilal Sheikh', 'Sales', '2021-03-10'),
('Zara Iqbal', 'Sales', '2022-07-22');

INSERT INTO Sales (CustomerID, CarID, SaleDate, SalePrice, SalespersonID) VALUES
(1, 2, '2023-06-14', 30500, 2),
(2, 3, '2023-07-22', 45500, 1),
(3, 5, '2023-08-30', 74000, 2),
(1, 4, '2023-09-18', 47000, 1),
(2, 1, '2023-10-05', 41000, 2);

INSERT INTO ServiceRecords (CarID, ServiceDate, ServiceType, Cost, TechnicianID) VALUES
(2, '2023-11-10', 'Brake Check', 550, 106),
(3, '2023-12-02', 'Oil Change', 180, 105),
(5, '2023-12-18', 'Battery Replacement', 720, 107),
(1, '2024-01-09', 'Tire Alignment', 120, 104),
(4, '2024-02-11', 'Air Filter Change', 90, 108);


-- 1. Total number of customers
SELECT COUNT(*) AS TotalCustomers FROM Customers;

-- 2. Average sale price of all car sales
SELECT AVG(SalePrice) AS AvgSalePrice FROM Sales;

-- 3. Most expensive car ever sold
SELECT MAX(SalePrice) AS MaxSalePrice FROM Sales;

-- 4. Total inventory count of all cars
SELECT SUM(InventoryCount) AS TotalInventory FROM Cars;

-- 5. Earliest and most recent sale dates
SELECT MIN(SaleDate) AS EarliestSale, MAX(SaleDate) AS LatestSale FROM Sales;


-- 1. Group cars by brand and count how many models each brand has
SELECT Brand, COUNT(DISTINCT Model) AS ModelCount
FROM Cars
GROUP BY Brand;

-- 2. Total sales amount for each salesperson
SELECT s.SalespersonID, sp.Name, SUM(s.SalePrice) AS TotalSales
FROM Sales s
JOIN Salespersons sp ON s.SalespersonID = sp.SalespersonID
GROUP BY s.SalespersonID, sp.Name;

-- 3. Average sale price for each car model
SELECT c.Model, AVG(s.SalePrice) AS AvgPrice
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model;

-- 4. Average service cost for each service type
SELECT ServiceType, AVG(Cost) AS AvgCost
FROM ServiceRecords
GROUP BY ServiceType;

-- 5. Count of cars by brand and color combination
SELECT Brand, Color, COUNT(*) AS CarCount
FROM Cars
GROUP BY Brand, Color;


-- 1. Brands that offer more than five different car models
SELECT Brand, COUNT(DISTINCT Model) AS ModelCount
FROM Cars
GROUP BY Brand
HAVING COUNT(DISTINCT Model) > 5;

-- 2. Car models sold more than 10 times
SELECT c.Model, COUNT(s.SaleID) AS SaleCount
FROM Sales s
JOIN Cars c ON s.CarID = c.CarID
GROUP BY c.Model
HAVING COUNT(s.SaleID) > 10;

-- 3. Salespersons whose average sale price > 50,000
SELECT sp.Name, AVG(s.SalePrice) AS AvgSale
FROM Sales s
JOIN Salespersons sp ON s.SalespersonID = sp.SalespersonID
GROUP BY sp.Name
HAVING AVG(s.SalePrice) > 50000;

-- 4. Months with more than 20 sales
SELECT TO_CHAR(SaleDate, 'YYYY-MM') AS SaleMonth, COUNT(*) AS SaleCount
FROM Sales
GROUP BY TO_CHAR(SaleDate, 'YYYY-MM')
HAVING COUNT(*) > 20;

-- 5. Service types where average cost > 500
SELECT ServiceType, AVG(Cost) AS AvgCost
FROM ServiceRecords
GROUP BY ServiceType
HAVING AVG(Cost) > 500;
