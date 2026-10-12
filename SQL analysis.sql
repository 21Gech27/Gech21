---Creating database suoerstore
create database Superstore
use Superstore
----Data Exploration 
----Viewing the data
select * from Sample_Superstore;
-----Number of rows
SELECT COUNT(*) AS Total_Rows
FROM Sample_Superstore;
-----Number of columns or Count of Columns
SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'Sample_Superstore'
ORDER BY ORDINAL_POSITION;
---- Checking dublicates
SELECT
    [Order_ID],
    [Product_ID],
    COUNT(*) AS Duplicate_Count
FROM Sample_Superstore
GROUP BY
    [Order_ID],
    [Product_ID]
HAVING COUNT(*) > 1;

---- Checking Order Date
SELECT
    MIN(Order_Date) AS First_Order_Date,
    MAX(Order_Date) AS Last_Order_Date
FROM Sample_Superstore;
-----Data Validation
-----Check duplicates
SELECT
    Row_ID,
    COUNT(*) AS Duplicate_Count
FROM Sample_Superstore
GROUP BY Row_ID
HAVING COUNT(*) > 1;

-----Check missing values
SELECT
    COUNT(*) - COUNT(Order_ID) AS Missing_Order_ID,
    COUNT(*) - COUNT(Customer_ID) AS Missing_Customer_ID,
    COUNT(*) - COUNT(Product_ID) AS Missing_Product_ID,
    COUNT(*) - COUNT(Sales) AS Missing_Sales,
    COUNT(*) - COUNT(Profit) AS Missing_Profit
FROM Sample_Superstore;
--------Check negative and Non profitable rows
SELECT COUNT(*) AS Loss_Making_Rows
FROM Sample_Superstore
WHERE Profit < 0;
---Total Sales
SELECT 
    SUM(Sales) AS Total_Sales
FROM Sample_Superstore;
-------Key Performance Indicators (KPIS)
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM Sample_Superstore;

------Calculate Profit Margin
SELECT
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0), 2
    ) AS Profit_Margin_Percent
FROM Sample_Superstore;
------Average Discount
SELECT AVG(Discount) AS Average_Discount
FROM Sample_Superstore;
--------Analyze Sales by Category
SELECT Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Category
ORDER BY Total_Sales DESC;
------Profit by Category
SELECT 
    Category,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Category
ORDER BY Total_Profit DESC;
---Sales by Sub-Category
SELECT
    [Sub_Category],
    SUM(Sales) AS Total_Sales
FROM Sample_Superstore
GROUP BY [Sub_Category]
ORDER BY Total_Sales DESC;

----Profit by Sub-Category
SELECT
    [Sub_Category],
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY [Sub_Category]
ORDER BY Total_Profit DESC;
------Analyze Region
SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;
----Top 10 Products
SELECT TOP 10 Product_Name,
    SUM(Sales) AS Total_Sales
FROM Sample_Superstore
GROUP BY Product_Name
ORDER BY Total_Sales DESC;

----Bottom 10 Products
SELECT TOP 10
    Product_Name,
    SUM(Sales) AS Total_Sales
FROM Sample_Superstore
GROUP BY Product_Name
ORDER BY Total_Sales ASC;

-----Sales by Region
SELECT
    Region,
    SUM(Sales) AS Total_Sales
FROM Sample_Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;
--------Profit by Region
SELECT
    Region,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Region
ORDER BY Total_Profit DESC;
---------Customer Analysis
------•	Top customers by sales 
SELECT TOP 10
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM Sample_Superstore
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;
-------Top Customers by Profit

SELECT TOP 10 Customer_Name,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Customer_Name
ORDER BY Total_Profit DESC;

-----•	Customers with low profitability 
SELECT Customer_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Customer_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-------- Number of Customer with Negative profit

SELECT COUNT(*) AS Customers_With_Negative_Profit
FROM (
    SELECT
        Customer_Name,
        SUM(Profit) AS Total_Profit
    FROM Sample_Superstore
    GROUP BY Customer_Name
    HAVING SUM(Profit) < 0
) AS Negative_Customers;

----Customer with Negative profit
SELECT
    Customer_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Customer_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-------Customer segments with strong performance: 
SELECT Segment,
    COUNT(DISTINCT Customer_Name) AS Total_Customers,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Segment
ORDER BY Total_Profit DESC;
------Monthly Sales Trend
SELECT
    YEAR([Order_Date]) AS Sales_Year,
    DATENAME(MONTH, [Order_Date]) AS Sales_Month,
    SUM(Sales) AS Total_Sales
FROM Sample_Superstore
GROUP BY
    YEAR([Order_Date]),
    MONTH([Order_Date]),
    DATENAME(MONTH, [Order_Date])
ORDER BY
    Sales_Year,
    MONTH([Order_Date]);

-----Discount Analysis by Sales and Profit
 SELECT Discount,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Discount
ORDER BY Discount;
-----Sales and Profit by Segment
SELECT 
    Segment,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Sample_Superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;
-----  KEY PERFORMANCE INDICATORS (KPIS)
SELECT
    ----Total Sales
    SUM(Sales) AS Total_Sales,
    ----Total Profit
    SUM(Profit) AS Total_Profit,
    ----Total Quantity
    SUM(Quantity) AS Total_Quantity,
    ----Total Orders
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ----Total Customers
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    ----Average Order Value
    SUM(Sales) / COUNT(DISTINCT Order_ID) AS Average_Order_Value,
    ----Average Discount
    AVG(Discount) AS Average_Discount,
    ----Profit Margin
    (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin_Percent
FROM Sample_Superstore;

SELECT
    Category,
    FORMAT(SUM(Sales), 'C2', 'en-US') AS Total_Sales,
    FORMAT(SUM(Profit), 'C2', 'en-US') AS Total_Profit
FROM Sample_Superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT
    Category,
    FORMAT(SUM(Profit), 'C2', 'en-US') AS Total_Profit
FROM Sample_Superstore
GROUP BY Category
ORDER BY SUM(Profit) DESC;

 