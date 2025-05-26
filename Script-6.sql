create database sales;
use sales;
CREATE TABLE `sales` (
  `SalesID` int PRIMARY KEY,
  `SalesPersonID` int DEFAULT NULL,
  `CustomerID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `TotalPrice` double DEFAULT NULL,
  `SalesDate` varchar(32) DEFAULT NULL,
  `TransactionNumber` varchar(32) DEFAULT NULL
);


INSERT INTO sales (SalesID, SalesPersonID, CustomerID, ProductID, Quantity, Discount, TotalPrice, SalesDate, TransactionNumber)
VALUES
(1, 101, 1001, 201, 2, 0.1, 180, '2024-01-01', 'TXN001'),
(2, 102, 1002, 202, 1, 0.05, 95, '2024-01-02', 'TXN002'),
(3, 101, 1001, 203, 3, 0.0, 300, '2024-01-03', 'TXN003'),
(4, 103, 1003, 201, 1, 0.1, 90, '2024-01-04', 'TXN004'),
(5, 101, 1001, 202, 4, 0.2, 320, '2024-01-05', 'TXN005'),
(6, 102, 1002, 203, 2, 0.0, 200, '2024-01-06', 'TXN006');


SELECT
  SalesID,
  CustomerID,
  SalesDate,
  TotalPrice,
  ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SalesDate) AS rn
FROM sales;

select *
from (
    SELECT
        SalesPersonID,
        SalesID,
        TotalPrice,
        RANK() OVER (PARTITION BY SalesPersonID ORDER BY TotalPrice DESC) AS sales_rank
  FROM Sales
) ranked_sales
where sales_rank <= 2;


SELECT
  SalesID,
  CustomerID,
  SalesDate,
  TotalPrice,
  LAG(SalesDate) OVER (PARTITION BY CustomerID ORDER BY SalesDate) AS previous_sales_date,
DATEDIFF(SalesDate, LAG(SalesDate) OVER (PARTITION BY CustomerID ORDER BY SalesDate)) AS DaysBetween
FROM sales;

SELECT
  SalesID,
  CustomerID,
  SalesDate,
  TotalPrice,
  LEAD(TotalPrice) OVER (PARTITION BY CustomerID ORDER BY SalesDate) AS next_sale
FROM sales;

SELECT
  SalesID,
  SalesPersonID,
  SalesDate,
  TotalPrice,
  SUM(TotalPrice) OVER (PARTITION BY SalesPersonID ORDER BY SalesDate) AS running_total
FROM sales;

SELECT
  ProductID,
  SalesID,
  Discount,
  AVG(Discount) OVER (PARTITION BY ProductID) AS avg_discount
FROM sales;

 STR_TO_DATE(SalesDate, '%Y-%m-%d')
