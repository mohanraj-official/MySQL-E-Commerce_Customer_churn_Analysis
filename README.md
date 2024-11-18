<center><h1>E-Commerce Customer Churn Analysis - Capstone Project - MySQL</h1></center>

|Problem Statement|
|-----------|
|In the realm of e-commerce, businesses face the challenge of understanding customer churn patterns to ensure customer satisfaction and sustained profitability. This project aims to delve into the dynamics of customer churn within an e-commerce domain, utilizing historical transactional data to uncover underlying patterns and drivers of churn. By analyzing customer attributes such as tenure, preferred payment modes, satisfaction scores, and purchase behavior, the project seeks to investigate and understand the dynamics of customer attrition and their propensity to churn. The ultimate objective is to equip e-commerce enterprises with actionable insights to implement targeted retention strategies and mitigate churn, thereby fostering long-term customer relationships and ensuring business viability in a competitive landscape.|

<br>

|Dataset Download|
|-----|
|https://drive.google.com/uc?export=download&id=1iKKCze_Fpk2n_g3BIZBiSjcDFdFcEn3D|

<br>

<center><h2>Data Cleaning</h2></center>

<table>
  <thead>
    <tr>
      <td>Handling Missing Values and Outliers</td>
      <td>Dealing with Inconsistencies</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>➢ Impute mean for the following columns, and round off to the nearest integer if required: WarehouseToHome, HourSpendOnApp, OrderAmountHikeFromlastYear, DaySinceLastOrder.</td>
      <td>➢ Replace occurrences of “Phone” in the 'PreferredLoginDevice' column and “Mobile” in the 'PreferedOrderCat' column with “Mobile Phone” to ensure uniformity.</td>
    </tr>
    <tr>
      <td>➢ Impute mode for the following columns: Tenure, CouponUsed, OrderCount.</td>
      <td>➢ Standardize payment mode values: Replace "COD" with "Cash on Delivery" and "CC" with "Credit Card" in the PreferredPaymentMode column.</td>
    </tr>
    <tr>
      <td>➢ Handle outliers in the 'WarehouseToHome' column by deleting rows where the values are greater than 100.</td>
      <td></td>
    </tr>
  </tbody>
</table>

<br>

## Data Transformation:

<table>
  <thead>
    <tr>
      <td>Column Renaming</td>
      <td>Creating New Columns</td>
      <td>Column Dropping</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>➢ Rename the column "PreferedOrderCat" to "PreferredOrderCat".</td>
      <td>➢ Create a new column named ‘ComplaintReceived’ with values "Yes" if the corresponding value in the ‘Complain’ is 1, and "No" otherwise.</td>
      <td>➢ Drop the columns "Churn" and "Complain" from the table.</td>
    </tr>
    <tr>
      <td>➢ Rename the column "HourSpendOnApp" to "HoursSpentOnApp".</td>
      <td>➢ Create a new column named 'ChurnStatus'. Set its value to “Churned” if the corresponding value in the 'Churn' column is 1, else assign “Active”.</td>
      <td></td>
    </tr>
 
  </tbody>
</table>

<br>

|Data Exploration and Analysis|
|------------------|
|➢ Retrieve the count of churned and active customers from the dataset.|
|➢ Display the average tenure and total cashback amount of customers who churned.|
|➢ Determine the percentage of churned customers who complained.|
|➢ Find the gender distribution of customers who complained.|
|➢ Identify the city tier with the highest number of churned customers whose preferred order category is Laptop & Accessory.|
|➢ Identify the most preferred payment mode among active customers.|
|➢ Calculate the total order amount hike from last year for customers who are single and prefer mobile phones for ordering.|
|➢ Find the average number of devices registered among customers who used UPI as their preferred payment mode.|
|➢ Determine the city tier with the highest number of customers.|
|➢ Identify the gender that utilized the highest number of coupons.|
|➢ List the number of customers and the maximum hours spent on the app in each preferred order category.|
|➢ Calculate the total order count for customers who prefer using credit cards and have the maximum satisfaction score.|
|➢ How many customers are there who spent only one hour on the app and days since their last order was more than 5?|
|➢ What is the average satisfaction score of customers who have complained?|
|➢ List the preferred order category among customers who used more than 5 coupons.|
|➢ List the top 3 preferred order categories with the highest average cashback amount.|
|➢ Find the preferred payment modes of customers whose average tenure is 10 months and who have placed more than 500 orders.|
|➢ Categorize customers based on their distance from the warehouse to home such as 'Very Close Distance' for distances <=5km, 'Close Distance' for <=10km, 'Moderate Distance' for |<=15km, and 'Far Distance' for >15km. Then, display the churn status breakdown for each distance category.|
|➢ List the customer’s order details who are married, live in City Tier-1, and their order counts are more than the average number of orders placed by all customers.|

<br>

| Data Model Creations|
|----|
|![creation of DataBase](https://github.com/user-attachments/assets/f43b2455-a215-46d5-8dae-871cac04d6a7)

<br>

| Data|
|----|
|![Datas](https://github.com/user-attachments/assets/4bb6afc2-92d9-41db-9370-ea8a1749efeb)|

<br>

| Data Cleansing|
|----|
|![Data Cleaning](https://github.com/user-attachments/assets/6ce15842-e3fa-4d04-b9ea-6ae1755aa7d1)|

<br>

|Dealing with Inconsistence|
|----|
|![Dealing with Inconsistence](https://github.com/user-attachments/assets/3bb9f4d8-b32f-4ec1-ad06-195b89e2a700)|

<br>

### Data Transformation

|1 - Column Renaming|
|----|
|![dt-1-Column Renaming](https://github.com/user-attachments/assets/18a39928-f7a6-412a-a6a8-698fee8a4909)|

<br>

|2 - Coulumn Creating|
|----|
|![dt-2-Creating new Column](https://github.com/user-attachments/assets/f46eb5de-3a25-4515-8b07-ae5a616ec422)|

<br>

|3 - Coulumn Dropping|
|----|
|![dt-3-Column Dropping](https://github.com/user-attachments/assets/2427da01-f763-4b98-833d-e70416624b80)|

<br>

|Input Mode Added|
|----|
|![Input Mode Added](https://github.com/user-attachments/assets/397cf64f-6ff3-4b8d-b0d9-7a38e7d54c8a)|


