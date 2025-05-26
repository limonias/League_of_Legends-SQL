create database P04_OPT;
use P04_OPT;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select count(*) from sales;


CREATE INDEX indx ON sales (SalesPersonID, SalesDate, Quantity, TotalPrice);

with SalesSum as (
  select
    SalesPersonID,
    sum(Quantity) as TotalQuantity,
    sum(TotalPrice) as TotalRevenue
  from sales
  where SalesDate >= '2018-01-01' and SalesDate < '2018-01-02'
  group by SalesPersonID
)
select
  s.SalesID,
  s.SalesPersonID,
  s.Quantity,
  s.TotalPrice,
  ss.TotalQuantity,
  ss.TotalRevenue
from sales s
left join SalesSum ss
on s.SalesPersonID = ss.SalesPersonID;



