# E-Commerce Customer Churn Analysis - Capstone Project - MySQL

## Problem Statement

In the realm of e-commerce, businesses face the challenge of understanding customer churn patterns to ensure customer satisfaction and sustained profitability. This project aims to delve into the dynamics of customer churn within an e-commerce domain, utilizing historical transactional data to uncover underlying patterns and drivers of churn. By analyzing customer attributes such as tenure, preferred payment modes, satisfaction scores, and purchase behavior, the project seeks to investigate and understand the dynamics of customer attrition and their propensity to churn. The ultimate objective is to equip e-commerce enterprises with actionable insights to implement targeted retention strategies and mitigate churn, thereby fostering long-term customer relationships and ensuring business viability in a competitive landscape.

---

## Dataset Download

[Download Dataset](https://drive.google.com/uc?export=download&id=1iKKCze_Fpk2n_g3BIZBiSjcDFdFcEn3D)

---

## Data Cleaning

| **Handling Missing Values and Outliers**                                    | **Dealing with Inconsistencies**                                             |
|----------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| Impute mean for columns `WarehouseToHome`, `HourSpendOnApp`, `OrderAmountHikeFromlastYear`, and `DaySinceLastOrder`, rounding off if needed. | Replace "Phone" in `PreferredLoginDevice` and "Mobile" in `PreferedOrderCat` with "Mobile Phone". |
| Impute mode for columns `Tenure`, `CouponUsed`, and `OrderCount`.           | Standardize payment mode values: replace "COD" with "Cash on Delivery" and "CC" with "Credit Card" in `PreferredPaymentMode`. |
| Handle outliers in `WarehouseToHome` by removing rows with values >100.    |                                                                             |

---

## Data Transformation

| **Column Renaming**                         | **Creating New Columns**                                                                            | **Column Dropping**                   |
|---------------------------------------------|-----------------------------------------------------------------------------------------------------|----------------------------------------|
| Rename `PreferedOrderCat` to `PreferredOrderCat`. | Create `ComplaintReceived` column: "Yes" if `Complain` = 1, else "No".                              | Drop `Churn` and `Complain` columns.  |
| Rename `HourSpendOnApp` to `HoursSpentOnApp`. | Create `ChurnStatus` column: "Churned" if `Churn` = 1, else "Active".                              |                                        |

---

## Data Exploration and Analysis

- Retrieve the count of churned and active customers from the dataset.
- Display the average tenure and total cashback amount of customers who churned.
- Determine the percentage of churned customers who complained.
- Find the gender distribution of customers who complained.
- Identify the city tier with the highest number of churned customers whose preferred order category is Laptop & Accessory.
- Identify the most preferred payment mode among active customers.
- Calculate the total order amount hike from last year for customers who are single and prefer mobile phones for ordering.
- Find the average number of devices registered among customers who used UPI as their preferred payment mode.
- Determine the city tier with the highest number of customers.
- Identify the gender that utilized the highest number of coupons.
- List the number of customers and the maximum hours spent on the app in each preferred order category.
- Calculate the total order count for customers who prefer using credit cards and have the maximum satisfaction score.
- Count customers who spent only one hour on the app and have `DaySinceLastOrder` > 5.
- Calculate the average satisfaction score of customers who have complained.
- List the preferred order category among customers who used more than 5 coupons.
- List the top 3 preferred order categories with the highest average cashback amount.
- Find the preferred payment modes of customers whose average tenure is 10 months and who have placed more than 500 orders.
- Categorize customers based on `WarehouseToHome` distance and display the churn status breakdown for each category.
- List customer order details for married customers living in City Tier-1 with order counts above the average.

---

## Data Model Creations
|Database Creation|
|------------|
|![Database Creation](https://github.com/user-attachments/assets/f43b2455-a215-46d5-8dae-871cac04d6a7)

---

## Data Examples

| **Data Preview**                                                                 |
|----------------------------------------------------------------------------------|
| ![Data Preview](https://github.com/user-attachments/assets/4bb6afc2-92d9-41db-9370-ea8a1749efeb) |

---

## Data Cleansing

| **Data Cleaning**                                                                 |
|-----------------------------------------------------------------------------------|
| ![Data Cleaning](https://github.com/user-attachments/assets/6ce15842-e3fa-4d04-b9ea-6ae1755aa7d1) |

---

## Dealing with Inconsistencies

| **Inconsistency Handling**                                                       |
|-----------------------------------------------------------------------------------|
| ![Inconsistencies](https://github.com/user-attachments/assets/3bb9f4d8-b32f-4ec1-ad06-195b89e2a700) |

---

## Data Transformation

### 1. Column Renaming

| **Before and After Renaming**                                                    |
|----------------------------------------------------------------------------------|
| ![Column Renaming](https://github.com/user-attachments/assets/18a39928-f7a6-412a-a6a8-698fee8a4909) |

### 2. Creating New Columns

| **New Column Creation**                                                          |
|----------------------------------------------------------------------------------|
| ![New Columns](https://github.com/user-attachments/assets/f46eb5de-3a25-4515-8b07-ae5a616ec422) |

### 3. Dropping Columns

| **Dropped Columns**                                                              |
|----------------------------------------------------------------------------------|
| ![Dropped Columns](https://github.com/user-attachments/assets/2427da01-f763-4b98-833d-e70416624b80) |

---

## Input Mode Added

| **Input Mode Addition**                                                          |
|----------------------------------------------------------------------------------|
| ![Input Mode](https://github.com/user-attachments/assets/397cf64f-6ff3-4b8d-b0d9-7a38e7d54c8a) |
