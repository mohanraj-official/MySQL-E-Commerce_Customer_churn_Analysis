-- -------------------------------------------------------         DATA CLEANING       ----------------------------------------------------------------
-- STEP 1 - Set the mean values into variables --------------------------------------------------------------------------------------------------------

SET @WarehouseToHome = (SELECT ROUND(AVG(WarehouseToHome), 0) FROM customer_churn WHERE WarehouseToHome IS NOT NULL);
SET @HourSpendOnApp = (SELECT ROUND(AVG(HourSpendOnApp), 0) FROM customer_churn WHERE HourSpendOnApp IS NOT NULL);
SET @OrderAmountHikeFromlastYear = (SELECT ROUND(AVG(OrderAmountHikeFromlastYear), 0) FROM customer_churn WHERE OrderAmountHikeFromlastYear IS NOT NULL);
SET @DaySinceLastOrder = (SELECT ROUND(AVG(DaySinceLastOrder), 0) FROM customer_churn WHERE DaySinceLastOrder IS NOT NULL);
select @DaySinceLastOrder, @OrderAmountHikeFromlastYear, @HourSpendOnApp, @WarehouseToHome;

-- STEP 2 - Update the Mean values to the column if null ----------------------------------------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;
UPDATE customer_churn SET
	WarehouseToHome = IFNULL(WarehouseToHome, @WarehouseToHome),
    HourSpendOnApp = IFNULL(HourSpendOnApp, @HourSpendOnApp),
    OrderAmountHikeFromlastYear = IFNULL(OrderAmountHikeFromlastYear, @OrderAmountHikeFromlastYear),
    DaySinceLastOrder = IFNULL(DaySinceLastOrder, @DaySinceLastOrder);
SELECT * FROM customer_churn;    

-- STEP 1 - Impute mode for the following columns: Tenure, CouponUsed, OrderCount ---------------------------------------------------------------------

SET @Tenure = (SELECT Tenure FROM customer_churn GROUP BY Tenure ORDER BY count(*) DESC LIMIT 1);
SET @CouponUsed = (SELECT CouponUsed FROM customer_churn GROUP BY CouponUsed ORDER BY count(*) DESC LIMIT 1);
SET @OrderCount = (SELECT OrderCount FROM customer_churn GROUP BY OrderCount ORDER BY count(*) DESC LIMIT 1);
SELECT @OrderCount, @CouponUsed, @Tenure;

-- STEP 2 - set the Mode value for the columns if null ------------------------------------------------------------------------------------------------

UPDATE customer_churn SET
	Tenure = IFNULL(Tenure, @Tenure),
    CouponUsed = IFNULL(CouponUsed, @Tenure),
    OrderCount = IFNULL(OrderCount, @Tenure);
SELECT * FROM customer_churn;

-- STEP 1 - Delete the rows from 'WarehouseToHome' greater than 100 -----------------------------------------------------------------------------------

DELETE FROM customer_churn WHERE WarehouseToHome > 100;
SELECT * FROM customer_churn;

-- --------------------------------------------            Dealing with Inconsistencies           -----------------------------------------------------

UPDATE customer_churn SET
	PreferredLoginDevice = REPLACE(PreferredLoginDevice, "Mobile", "Mobile Phone"),
    PreferedOrderCat = REPLACE(PreferedOrderCat, "Phone", "Mobile Phone");
SELECT * FROM customer_churn;

UPDATE customer_churn SET
	PreferredPaymentMode = "Cash On Delivery" WHERE PreferredPaymentMode = "COD";
UPDATE customeR_churn SET
	PreferredPaymentMode = "Credit Card" WHERE PreferredPaymentMode = "CC";
SELECT * FROM customer_churn;

-- ---------------------------------------------           DATA TRANSFORMATION            -------------------------------------------------------------

-- 1 - Column Renaming --------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE customer_churn
	CHANGE COLUMN PrefereedOrderCat PreferredOrderCat VARCHAR(20);
    
ALTER TABLE customer_churn
	CHANGE COLUMN HourSpendOnApp HoursSpentOnApp int;
SELECT * FROM customer_churn;
    
-- 2 - CREATING NEW COLUMN ----------------------------------------------------------------------------------------------------------------------------

ALTER TABLE customer_churn
ADD COLUMN ComplaintReceived VARCHAR(5);

UPDATE customer_churn
SET ComplaintReceived = CASE
	WHEN Complain = 1 THEN "Yes"
    ELSE "No"
END;
SELECT * FROM customer_churn;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE customer_churn
ADD COLUMN ChurnStatus VARCHAR(10);

UPDATE customer_churn SET 
	ChurnStatus = CASE
    WHEN Churn = 1 THEN "Churned"
    ELSE "Active"
END;
SELECT * FROM customer_churn;


-- ------------------------------------------------------         COLUMN DROPPING          ------------------------------------------------------------
ALTER TABLE customeR_churn
DROP COLUMN Churn;

ALTER TABLE customer_churn
DROP COLUMN Complain;

SELECT * FROM customer_churn;

-- ------------------------------------------------		 DATA EXPLORATION AND ANALYSIS        ---------------------------------------------------------

-- 1 - Retrieve the count of churned and active customers from the dataset-----------------------------------------------------------------------------

SET @`Churned` = (SELECT COUNT(ChurnStatus) FROM customer_churn WHERE ChurnStatus = "Churned");
SET @`Active` = (SELECT COUNT(ChurnStatus) FROM customer_churn WHERE ChurnStatus = "Active");
SELECT @`Churned` AS `Count Of Churned Customers`, @`Active` AS `Count of Active Customers`;

-- 2 - Display the average tenure and total cashback amount of customers who churned ------------------------------------------------------------------

SET @`average` = (SELECT ROUND(AVG(tenure), 2) FROM customer_churn WHERE ChurnStatus = "Churned");
SET @`Total` = (SELECT SUM(CashbackAmount) FROM customer_churn WHERE ChurnStatus = "Churned");
SELECT @average AS `Average of Tenure`, @Total AS `Total Cashback Amount`;

-- 3 - Determine the percentage of churned customers who complained -----------------------------------------------------------------------------------

SET @Churned = (SELECT COUNT(ChurnStatus) FROM customer_churn WHERE ChurnStatus = "Churned");
SET @Complained = (SELECT COUNT(ChurnStatus) FROM customer_churn WHERE ChurnStatus = "Churned" and ComplaintReceived = "Yes");
SET @Percentage = ROUND(((@Complained / @Churned) * 100), 2);
SELECT @Percentage AS `percentage of churned customers who Complained`;

-- 4 - Find the gender distribution of customers who complained ---------------------------------------------------------------------------------------

SELECT Gender, COUNT(*) AS `Number of Complaints`
FROM customer_churn
WHERE ComplaintReceived = "Yes"
GROUP BY Gender;

-- 5 - Identify the city tier with the highest number of churned customers whose preferred order category is Laptop & Accessory -----------------------

SELECT CityTier, COUNT(*) AS `Top Customer`
FROM customer_churn
WHERE ChurnStatus = "Churned" AND PreferredOrderCat = "Laptop & Accessory"
GROUP BY CityTier
ORDER BY `Top Customer` DESC
LIMIT 1;

-- 6 - Identify the most preferred payment mode among active customers --------------------------------------------------------------------------------

SELECT PreferredPaymentMode, COUNT(*) AS `People Count`
FROM customer_churn
WHERE ChurnStatus = "Active"
GROUP BY PreferredPaymentMode
ORDER BY `People Count` DESC;

-- 7 - Calculate the total order amount hike from last year for customers who are single and prefer mobile phones for ordering ------------------------

SELECT SUM(OrderAmountHikeFromlastYear) AS 	`Total Order Amount`
FROM customer_churn
WHERE MaritalStatus = "Single" AND PreferredOrderCat = "Mobile Phone";

-- 8 - Find the average number of devices registered among customers who used UPI as their preferred payment mode -------------------------------------

SELECT AVG(NumberOfDeviceRegistered) AS `Average Device Reistered`
FROM customer_churn
WHERE PreferredPaymentMode = "UPI";

-- 9 - Determine the city tier with the highest number of customers -----------------------------------------------------------------------------------

SELECT CityTier, COUNT(*) AS `Number of Customers`
FROM customer_churn
GROUP BY CityTier
ORDER BY `Number of Customers` DESC
LIMIT 1;

-- 10 - Identify the gender that utilized the highest number of coupons -------------------------------------------------------------------------------

SELECT Gender, COUNT(*) AS `Highest Number of Coupens`
FROM customer_churn
GROUP BY Gender
ORDER BY `Highest Number of Coupens` DESC 
LIMIT 1;

-- 11 - List the number of customers and the maximum hours spent on the app in each preferred order category ------------------------------------------

SELECT PreferredOrderCat AS `Category`, COUNT(*) AS `Number of Customers`, MAX(HoursSpentOnApp) AS `Maximum Spent Time`
FROM customer_churn
GROUP BY PreferredOrderCat;

-- 12 - Calculate the total order count for customers who prefer using credit cards and have the maximum satisfaction score ---------------------------

SELECT SUM(OrderCount) AS `Total Order Count`
FROM customer_churn
WHERE PreferredPaymentMode = "Credit Card"
AND SatisfactionScore = 
	(SELECT MAX(SatisfactionScore)
    FROM customer_churn
    WHERE PreferredPaymentMode = "Credit Card"
	);
select * from customer_churn;

-- 13 - How many customers are there who spent only one hour on the app and days since their last order was more than 5? ------------------------------

SELECT COUNT(*) AS Total_Customers 
FROM customer_churn
WHERE HoursSpentOnApp = 1 AND DaySinceLastOrder > 5;

-- 14 - What is the average satisfaction score of customers who have complained? ----------------------------------------------------------------------

SELECT ROUND(AVG(SatisfactionScore), 0) AS `average satisfaction score`
FROM customer_churn
WHERE ComplaintReceived = "Yes";

-- 15 - List the preferred order category among customers who used more than 5 coupons ----------------------------------------------------------------

SELECT PreferredOrderCat, COUNT(*) `Customers Count` 
FROM customer_churn
WHERE CouponUsed > 5
GROUP BY PreferredOrderCat
ORDER BY `Customers Count` DESC; 

-- 16 - List the top 3 preferred order categories with the highest average cashback amount ------------------------------------------------------------

SELECT PreferredOrderCat, ROUND(AVG(CashbackAmount), 2) AS `Top 3 Average CashBack` 
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY `Top 3 Average CashBack` DESC
LIMIT 3;

-- 17 - Find the preferred payment modes of customers whose average tenure is 10 months and have placed more than 500 orders --------------------------

SELECT PreferredPaymentMode, SUM(OrderCount) AS `Total Count`
FROM customer_churn
WHERE Tenure >= 10 
GROUP BY PreferredPaymentMode
HAVING `Total Count` > 500
ORDER BY `Total Count` DESC;

-- 18 - Categarize the customers with distance --------------------------------------------------------------------------------------------------------

SELECT 
CASE
	WHEN WarehouseToHome <= 5 THEN "Very Close Distance"
    WHEN WarehouseToHome <= 10 THEN "Close Distance"
    WHEN WarehouseToHome <= 15 THEN "Moderate Distance"
    ELSE "Far Distance"
END AS 	`Distance Category`, ChurnStatus, COUNT(*) AS `Total Customers`
FROM customer_churn

GROUP BY `Distance Category`, ChurnStatus;
    
-- 19 -------------------------------------------------------------------------------------------------------------------------------------------------

SELECT CustomerID, CityTier, Gender, PreferredOrderCat, MaritalStatus, OrderCount, CashbackAmount
FROM customer_churn
WHERE MaritalStatus = "Married"	
	AND CityTier = 1 
	AND OrderCount > (SELECT AVG(OrderCount) FROM customer_churn);

-- 20 - CREATE A NEW TABLE ----------------------------------------------------------------------------------------------------------------------------

CREATE TABLE customer_returns
	(ReturnID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT UNIQUE,
    ReturnDate DATE,
    RefundAmount INT);
    
INSERT INTO customer_returns (ReturnID, CustomerID, ReturnDate, RefundAmount) VALUES
(1001, 50022, '2023-01-01', 2130.00),
(1002, 50316, '2023-01-23', 2000.00),
(1003, 51099, '2023-02-14', 2290.00),
(1004, 52321, '2023-03-08', 2510.00),
(1005, 52928, '2023-03-20', 3000.00),
(1006, 53749, '2023-04-17', 1740.00),
(1007, 54206, '2023-04-21', 3250.00),
(1008, 54838, '2023-04-30', 1990.00);

SELECT * FROM customer_returns;


-- 21 - Display the return details along with the customer details of those who have churned and have made complaints ---------------------------------

SELECT cr.ReturnID, cr.CustomerID, cr.ReturnDate, cr.RefundAmount, cc.ComplaintReceived, cc.ChurnStatus
FROM customer_returns cr
JOIN customer_churn cc
	ON cc.CustomerID = cr.CustomerID
WHERE ComplaintReceived = "Yes" AND ChurnStatus = "Churned";



-- ---------------------------------------------------------      CODE TERMINATED     -----------------------------------------------------------------




                

