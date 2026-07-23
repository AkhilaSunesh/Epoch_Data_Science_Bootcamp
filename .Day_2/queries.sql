-- Northwind Database SQL Analysis
-- Dataset: https://github.com/jpwhite3/northwind-SQLite3


-- QUERY 1: Top 10 Selling Products by Revenue
-- 
-- Joins Order Details with Products to compute total units sold
-- and total revenue (after discount) per product.
SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity)                                                      AS TotalUnitsSold,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2)        AS TotalRevenue,
    ROUND(AVG(od.Discount) * 100, 2)                                     AS AvgDiscountPct
FROM "Order Details" od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC
LIMIT 10;


-- QUERY 2: Top 10 Customers by Revenue
-- Aggregates orders per customer to find highest-value accounts.
SELECT
    c.CustomerID,
    c.CompanyName,
    c.City,
    c.Country,
    COUNT(DISTINCT o.OrderID)                                             AS TotalOrders,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2)        AS TotalRevenue,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) /
          COUNT(DISTINCT o.OrderID), 2)                                  AS AvgOrderValue
FROM Customers c
JOIN Orders o    ON c.CustomerID  = o.CustomerID
JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName, c.City, c.Country
ORDER BY TotalRevenue DESC
LIMIT 10;


-- QUERY 3: Monthly Sales Trends

-- Groups orders by year-month to reveal seasonal patterns and
-- overall revenue trajectory.
SELECT
    strftime('%Y-%m', o.OrderDate)                                        AS YearMonth,
    COUNT(DISTINCT o.OrderID)                                             AS TotalOrders,
    COUNT(DISTINCT o.CustomerID)                                          AS UniqueCustomers,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2)        AS MonthlyRevenue,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) /
          COUNT(DISTINCT o.OrderID), 2)                                  AS AvgOrderValue
FROM Orders o
JOIN "Order Details" od ON o.OrderID = od.OrderID
WHERE o.OrderDate IS NOT NULL
GROUP BY YearMonth
ORDER BY YearMonth;


-- QUERY 4: Best-Performing Product Categories

-- Ranks all 8 Northwind categories by total revenue and units sold.
SELECT
    c.CategoryID,
    c.CategoryName,
    COUNT(DISTINCT p.ProductID)                                           AS ProductCount,
    SUM(od.Quantity)                                                      AS TotalUnitsSold,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2)        AS TotalRevenue,
    ROUND(AVG(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2)        AS AvgOrderLineRevenue,
    ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) * 100.0 /
          SUM(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))) OVER (), 2) AS RevenueSharePct
FROM Categories c
JOIN Products p          ON c.CategoryID  = p.CategoryID
JOIN "Order Details" od  ON p.ProductID   = od.ProductID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;


-- QUERY 5: Customer Purchase Frequency
-- Measures how often customers order (orders per month) to
-- identify loyal, high-frequency buyers.
SELECT
    c.CustomerID,
    c.CompanyName,
    c.Country,
    COUNT(DISTINCT o.OrderID)                                             AS TotalOrders,
    MIN(o.OrderDate)                                                      AS FirstOrder,
    MAX(o.OrderDate)                                                      AS LastOrder,
    ROUND(
        (julianday(MAX(o.OrderDate)) - julianday(MIN(o.OrderDate))) / 30.0
    , 1)                                                                  AS ActiveMonths,
    ROUND(
        CAST(COUNT(DISTINCT o.OrderID) AS FLOAT) /
        ((julianday(MAX(o.OrderDate)) - julianday(MIN(o.OrderDate))) / 30.0 + 1)
    , 2)                                                                  AS OrdersPerMonth
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName, c.Country
HAVING TotalOrders > 1
ORDER BY TotalOrders DESC
LIMIT 20;
