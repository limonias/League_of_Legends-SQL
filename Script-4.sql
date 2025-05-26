CREATE INDEX idx_covering_sales
ON sales(SalesPersonID, SalesDate, Quantity);

EXPLAIN
WITH SalesAgg AS (
  SELECT 
    SalesPersonID,
    SUM(Quantity) AS TotalQuantityBySalesPerson,
    SUM(TotalPrice) AS TotalRevenueBySalesPerson
  FROM sales
  WHERE SalesDate >= '2018-01-01' AND SalesDate < '2018-01-02'
  GROUP BY SalesPersonID
)
SELECT 
  s.SalesID,
  s.SalesPersonID,
  s.Quantity,
  s.TotalPrice,
  sa.TotalQuantityBySalesPerson,
  sa.TotalRevenueBySalesPerson
FROM sales s
LEFT JOIN SalesAgg sa ON s.SalesPersonID = sa.SalesPersonID;

