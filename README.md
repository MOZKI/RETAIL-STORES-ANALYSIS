# Project Background
In today’s fast-moving retail industry, data plays a crucial role in helping businesses understand customer behavior, track sales performance, and identify growth opportunities. However, raw data is often messy and unstructured — making it difficult to extract meaningful insights without proper cleaning and analysis.

This project was created to analyze retail store transaction data with the goal of uncovering valuable business insights through end-to-end data analysis.

The process includes:
- **Data Cleaning** using SQL to prepare the dataset for analysis
- **Exploratory Data Analysis (EDA)** to identify the structure of dataset and descriptive statistics
- **Business Analysis** focus on analyzing business metrics and to answer key questions such as:
  1. Which year with the highest revenue ?
  2. Who are the most valuable customer ?
  3. Which product category performed the best ?
- **Visualization** using Tableau interactive dashboard for easier interpretation and communication insights

📂 Raw dataset can be downloaded [here](https://github.com/MOZKI/RETAIL-STORES-ANALYSIS/tree/main/1.RAW_DATASET).  
🧼 Data cleaning was performed using SQL queries. The cleaned dataset is available [here](https://github.com/MOZKI/RETAIL-STORES-ANALYSIS/tree/main/2.DATA%20CLEANING).  
🔍 Exploratory Data Analysis (EDA) SQL scripts can be found [here](https://github.com/MOZKI/RETAIL-STORES-ANALYSIS/tree/main/3.EDA).  
📊 Comprehensive business analysis, including sales performance, top customers, and best-selling categories, is documented [here](https://github.com/MOZKI/RETAIL-STORES-ANALYSIS/tree/main/4.BUSINESS%20ANALYSIS).  
📈 Interactive Tableau dashboard is accessible [here](https://public.tableau.com/app/profile/moh.zaki/viz/RETAIL_STORES_DASHBOARD_PERFORMANCE/DASHBOARDPERFORMANCE)

# Data Sample & Structure
Retail store dataset structure as seen below consists 9 field such as transaction id, customer id, category, item, price per unit, quantity, total spent, payment method, location, and transaction date. With total row count of 11.971 records (clean zero null).  

 
<img width="882" height="168" alt="Screenshot 2025-08-05 at 09 56 01" src="https://github.com/user-attachments/assets/424eb6f7-a7e5-417b-b191-1d6bfed3bcac" />  
<br>
<br>
<img width="189" height="279" alt="Screenshot 2025-08-05 at 09 56 56" src="https://github.com/user-attachments/assets/026268af-4337-4080-b17e-1c6977bbee18" />

# Executive Summary
Overview of Insights  
There was a decline in growth rate in 2023 by -3.7% compared to 2022. However, the business recovered well in 2024, showing a 6.8% increase in growth rate from the previous year.
The main factor of revenue growth in 2024 was the increase in number of transactions, which rose by 228 transactions, while the Average Order Value (AOV) remained relatively stable.
2024 recorded the highest annual revenue of $524,881, with a total of 4,036 transactions.   
Below is the overview page from Tableau. The entire interactive dashboard can be found [here](https://public.tableau.com/app/profile/moh.zaki/viz/RETAIL_STORES_DASHBOARD_PERFORMANCE/DASHBOARDPERFORMANCE)  

<img width="1216" height="513" alt="Screenshot 2025-08-05 at 18 43 28" src="https://github.com/user-attachments/assets/71e39e27-14f6-4f33-8abe-18fe1fde268c" />  

### Sales Trends:
- Focusing on 2024 (the best-performing year), December recorded the highest monthly revenue of $48,467 from 357 transactions, followed by January with $47,909 from 363 transactions. 
Although January had more transactions, December outperformed due to a higher Average Order Value (AOV). February showed the weakest performance with revenue of only $37,145 from 304 transactions.  
  
- Looking at daily revenue trends, Friday generated the highest total revenue of $232,786 with 1,729 transactions, followed by Sunday with $225,991 from 1,736 transactions (higher volume, lower AOV). Monday had the lowest performance due to low transaction volume and smaller AOV purchases.

<img width="1216" height="404" alt="Screenshot 2025-08-05 at 19 15 01" src="https://github.com/user-attachments/assets/1a2160af-bb34-48b0-818c-031be69c0eba" />  

# Recomendations  
- Seasonal peak during December–January (Christmas & New Year holidays): Maximize product availability for high-demand categories to capture increased customer traffic and spending.

- April recorded the highest Average Order Value (AOV) due to fewer customers but higher spending per customer: Consider running high-value item promotions in other months to replicate this pattern.

- February showed low transaction volume and lower AOV purchases: Implement bundle promotions or limited-time offers to boost both transaction volume and AOV.

- Clear end-of-week pattern observed on Friday to Sunday: Maximize availability of products likely to be in high demand during this peak period.

- Monday shows low transaction volume and lower AOV purchases: Consider implementing bundle promotions or special offers to drive engagement and increase revenue at the start of the week.

#
Full version analysis click [here](https://drive.google.com/file/d/1joZ9a7jdKTG1HdXOXTFlIS0zypUX51YF/view?usp=sharing)












