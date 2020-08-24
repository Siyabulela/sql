-- SELECT ALL records from table Customers.
SELECT * FROM CUSTOMERS

-- SELECT records only from the name column in the Customers table.
SELECT FirstName FROM CUSTOMERS

-- Show the name of the Customer whose CustomerID is 1.
SELECT FirstName FROM CUSTOMERS WHERE CustomerID = 1

-- UPDATE the record for CustomerID = 1 on the Customer table so that the name is “Lerato Mabitso”
UPDATE CUSTOMERS
 	SET FirstName = 'Lerato',
 		LastName = 'Mabitso'
 	WHERE
 		CustomerID = 1

-- DELETE the record from the Customers table for customer 2 (CustomerID = 2).
DELETE FROM CUSTOMERS
 	WHERE CustomerID = 2
	
-- Select all unique statuses from the Orders table and get a count 
-- of the number of orders for each unique status
SELECT COUNT (DISTINCT Status) AS Number_of_unique_statuses
	FROM Orders
	
-- Return the MAXIMUM payment made on the PAYMENTS table	
SELECT 
    MAX(Amount)
FROM
    PAYMENTS;

-- Select all customers from the “Customers” table, sorted by the “Country” column.
SELECT * FROM CUSTOMERS
ORDER BY Country

-- Select all products with a price BETWEEN R100 and R600.
SELECT * FROM PRODUCTS
 	WHERE BuyPrice
 BETWEEN 100 AND 600

-- Select all fields from “Customers” where country is “Germany” AND city is “Berlin”
SELECT * FROM CUSTOMERS
 	WHERE Country = 'Germany'
 	AND City = 'Berlin'

-- Select all fields from “Customers” where city is “Cape Town” OR “Durban”.
SELECT * FROM CUSTOMERS
 	WHERE City = 'Cape Town'
  	OR City = 'Durban'

-- Select all records from Products where the Price is GREATER than R500.
SELECT * FROM Products
  	WHERE BuyPrice > 500

-- Return the sum of the Amounts on the Payments table.
SELECT 
	SUM(Amount)
FROM
    PAYMENTS;

-- Count the number of shipped orders in the Orders table.
SELECT 
    COUNT(*) 
FROM
    Orders
WHERE
	Status = 'Shipped'

-- Return the average price of all Products, in Rands and in Dollars 
--(assume the exchange rate is R12 to the Dollar).
SELECT 
	AVG(buyPrice) AS DOLLAR,
 	AVG(buyPrice * 12) AS RANDS
FROM 
	Products

-- Using INNER JOIN create a query that selects all Payments with Customer information.
SELECT * FROM Payments
 	INNER JOIN Customers
ON Payments.CustomerId = Customers.CustomerId;

-- Select all products that have turnable front wheels
SELECT * FROM PRODUCTS
WHERE Description LIKE '%Turnable front wheels%'

---------------------------------------TABLES-----------------------------------------------
-- Table Customers contains details of customers (names, address, etc) and a unique Primary key (CustomerID) for every customer in the table
CREATE TABLE Customers
(
	CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
   	Gender VARCHAR,
   	Address VARCHAR(200),
    Phone INT,
    Email VARCHAR(100),
  	City VARCHAR(20),
  	Country VARCHAR(50)
);

--Table Employees contains details of employees (names, email, etc) and a unique Primary key (EmployeeID) for every employee in the table
CREATE TABLE Employees
(
	EmployeeID SERIAL PRIMARY KEY,
	FirstName VARCHAR(50),
    LastName VARCHAR(50),
	Email VARCHAR(100),
	JobTitle VARCHAR(20)
);

--Table Products contains details of every products (Product name, price, etc) and a unique Primary key (ProductID) for each and every product in the table
CREATE TABLE Products
(
	ProductID SERIAL PRIMARY KEY,
	ProductName VARCHAR(100),
	Description VARCHAR(300),
	BuyPrice DECIMAL
);

--Table Orders contains details of orders made by customers and a unique Primary key for every order made in the table.
-- This table links every table in the database because it has foreign keys for Products, Payments and EmployeeID
CREATE TABLE Orders
(
	OrderID SERIAL PRIMARY KEY,
	ProductID INT,
	PaymentID INT,
	FulfilledByEmployeeID INT,
 	FOREIGN KEY (ProductID)
 		REFERENCES Products (ProductID),
 	FOREIGN KEY (PaymentID)
 		REFERENCES Payments (PaymentID),
	FOREIGN KEY (FulfilledByEmployeeID)
		REFERENCES Employees (EmployeeID),
	DateRequired DATE,
	DateShipped DATE NULL,
	Status VARCHAR(20)
);
--Table Payments contains details of purchases of products and a unique Primary key for each and every purchase made in the shop.
--It has a foreign key CustomerID, to link the table with table Customers.
CREATE TABLE Payments
(
	CustomerID INT,
	FOREIGN KEY (CustomerID)
		REFERENCES Customers (CustomerID),
	PaymentID SERIAL PRIMARY KEY,
	PaymentDate DATE,
	Amount DECIMAL
);

INSERT INTO 
    CUSTOMERS (FirstName, LastName, Gender, Address, Phone, Email, City, Country)
VALUES
       ('John','Hibert','Male','284 chaucer st',084789657,'john@gmail.com','Johannesburg','South Africa'),
      ('Thando','Sithole','Female','240 Sect 1',0794445584,'thando@gmail.com','Cape Town','South Africa'),
  ('Leon','Glen','Male','81 Everton Rd,Gillits',0820832830,'Leon@gmail.com','Durban','South Africa'),
	('Charl','Muller','Male','290A Dorset Ecke',448568725,'Charl.muller@yahoo.com','Berlin','Germany'),
	   ('Julia','Stein','Female','2 Wernerring',448672445,'Js234@yahoo.com','Frankfurt','Germany');
	
INSERT INTO 
    EMPLOYEES (FirstName, LastName, Email, JobTitle)
VALUES
	('Kani','Matthew','mat@gmail.com','Manager'),
	('Lesly','Cronje','LesC@gmail.com','Clerk'),
	('Gideon','Maduku','m@gmail.com','Accountant');
	
INSERT INTO 
	Orders (ProductID, PaymentID, FulfilledByEmployeeID, DateRequired, DateShipped, Status)
VALUES
	(1,1,2,'05-09-2018',NULL,'Not shipped'),
	(1,2,2,'04-09-2018','03-09-2018','Shipped'),
	(3,3,3,'06-09-2018',NULL,'Not shipped');

INSERT INTO
	Payments (CustomerID, PaymentDate, Amount)
VALUES
	(1,'01-09-2018',150.75),
	(5,'03-09-2018',150.75),
	(4,'03-09-2018',700.60);

INSERT INTO
	Products (ProductName, Description, BuyPrice)
VALUES
	('Harley Davidson Chopper','This replica features working kickstand, front suspension, gear-shift lever',150.75),
	('Classic Car','Turnable front wheels, steering function',550.75),
	('Sports car','Turnable front wheels, steering function',700.60);
