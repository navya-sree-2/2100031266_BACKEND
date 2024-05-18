-- creating tables

CREATE TABLE Customers (
    CustomerId INTEGER PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Email VARCHAR(40) NOT NULL,
    DateOfBirth DATE NOT NULL
);

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Price INTEGER NOT NULL
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
    OrderItemID INTEGER PRIMARY KEY,
    OrderID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- inserting values
INSERT INTO Customers VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1985-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '1990-06-20');

INSERT INTO Products VALUES
(1, 'Laptop', 1000),
(2, 'Smartphone', 600),
(3, 'Headphones', 100);

INSERT INTO Orders VALUES
(1, 1, '2023-01-10'),
(2, 2, '2023-01-12');

INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity) VALUES
(1, 1, 1, 1),
(2, 1, 3, 2),
(3, 2, 2, 1),
(4, 2, 3, 1);

-- Query - 1:

SELECT * FROM Customers;

-- Query - 2:

SELECT * FROM Orders WHERE OrderDate LIKE '2023-01-%';

-- Query - 3:

SELECT o.OrderID, c.FirstName, c.LastName, c.Email, o.OrderDate
FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID;

-- Query - 4:

SELECT oi.OrderID, oi.ProductID, p.ProductName, oi.Quantity
FROM OrderItems oi JOIN Products p ON oi.ProductID = p.ProductID
ORDER BY oi.OrderID ASC;

-- Query - 5:

SELECT c.CustomerID, c.FirstName, c.LastName, SUM(p.Price * oi.Quantity) AS TotalAmountSpent
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerID;

-- Query - 6:

SELECT p.ProductName, COUNT(oi.Quantity) AS TotalQuantity
FROM Products p JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID ORDER BY TotalQuantity DESC;

-- Query - 7:

SELECT MONTH(o.OrderDate) AS Month, COUNT(DISTINCT o.OrderID) AS TotalOrders,
SUM(p.Price * oi.Quantity) AS TotalSalesAmount FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE YEAR(o.OrderDate) = 2023 GROUP BY MONTH(o.OrderDate);

-- Query - 8:

SELECT c.CustomerID, c.FirstName, c.LastName, SUM(p.Price * oi.Quantity) AS TotalAmountSpent
FROM Customers c JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerID HAVING SUM(p.Price * oi.Quantity) > 1000;



