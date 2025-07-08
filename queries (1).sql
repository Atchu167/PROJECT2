
-- DROP TABLE IF EXISTS (optional reset)
DROP TABLE IF EXISTS Retail_Data;

-- CREATE TABLE
CREATE TABLE Retail_Data (
    Order_Date DATE,
    Region VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(100),
    Price DECIMAL(10,2),
    Cost DECIMAL(10,2),
    Quantity INT,
    Revenue DECIMAL(12,2),
    Profit DECIMAL(12,2),
    Inventory_Days INT
);

-- INSERT SAMPLE RECORDS
INSERT INTO Retail_Data (
    Order_Date, Region, Category, Sub_Category, Product_Name,
    Price, Cost, Quantity, Revenue, Profit, Inventory_Days
) VALUES
('2023-01-15', 'North', 'Electronics', 'Phones', 'Phone Product 1234', 499.99, 300.00, 10, 4999.90, 1999.90, 45),
('2023-02-10', 'South', 'Furniture', 'Chairs', 'Chair Product 5678', 150.00, 100.00, 5, 750.00, 250.00, 60),
('2023-03-05', 'East', 'Clothing', 'Women', 'Dress Product 9101', 79.99, 50.00, 12, 959.88, 359.88, 40),
('2023-04-22', 'West', 'Grocery', 'Snacks', 'Snack Product 3456', 9.99, 6.00, 30, 299.70, 119.70, 20),
('2023-05-18', 'North', 'Office Supplies', 'Pens', 'Pen Product 7890', 1.50, 0.50, 100, 150.00, 100.00, 35);

-- ALTER: ADD DERIVED COLUMNS
ALTER TABLE Retail_Data ADD COLUMN Order_Year INT;
UPDATE Retail_Data SET Order_Year = YEAR(Order_Date);

ALTER TABLE Retail_Data ADD COLUMN Profit_Margin DECIMAL(6,2);
UPDATE Retail_Data SET Profit_Margin = (Profit / Revenue) * 100
WHERE Revenue != 0;

-- SELECT to VERIFY output
SELECT * FROM Retail_Data;

-- Total Profit by Category & Sub-Category
SELECT Category, Sub_Category,
       SUM(Profit) AS Total_Profit,
       ROUND(AVG(Profit), 2) AS Avg_Profit,
       SUM(Revenue) AS Total_Revenue,
       ROUND(SUM(Profit)/SUM(Revenue)*100, 2) AS Profit_Margin_Percentage
FROM Retail_Data
GROUP BY Category, Sub_Category
ORDER BY Profit_Margin_Percentage ASC;

-- Monthly Trends
SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Month,
       SUM(Revenue) AS Total_Revenue,
       SUM(Profit) AS Total_Profit
FROM Retail_Data
GROUP BY Month
ORDER BY Month;

-- Profit by Region
SELECT Region,
       SUM(Profit) AS Total_Profit
FROM Retail_Data
GROUP BY Region
ORDER BY Total_Profit DESC;
