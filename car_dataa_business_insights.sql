USE car;

-- Overall Sales Performance
-- Q1. What are the total number of cars sold, average car price, and total sales value?
-- Business Purpose: To understand the overall sales performance of the business.

SELECT COUNT(*) AS total_car_sold,
AVG(price) AS Average_car_price,
SUM(price) AS total_sales 
FROM car_dataa;



-- 2. Company Performance Analysis
-- Q2. Which car companies have the highest number of sales?
-- Business Purpose: To identify the companies with the highest sales volume in the dataset.
SELECT company,count(*) as total_sold FROM car_dataa
group by company
order by total_sold DESC
limit 10;


-- Q3. Which car companies have the highest average car prices?
-- Business Purpose: To identify companies positioned in higher-priced car segments.
SELECT company , ROUND(AVG(price) ,2)AS company_car_avg_price,
COUNT(*) AS total_sold
from car_dataa
group by company
ORDER BY company_car_avg_price DESC LIMIT 10;


-- Car Model Analysis
-- Q4. What are the top 10 best-selling car models?
-- Business Purpose: To identify the most frequently purchased car models.
SELECT company,model, count(*) AS most_frequently_sold FROM car_dataa
group by model
ORDER BY  most_frequently_sold DESC 
LIMIT 10;

-- Q5. Which car models have the highest average prices?
-- Business Purpose: To identify higher-priced car models while excluding models with very few records.

SELECT company,model ,
AVG(price) AS avg_price ,
COUNT(*) AS car_sold
FROM car_dataa
GROUP BY company,model
HAVING COUNT(*) >= 10
ORDER BY avg_price DESC
limit 10;


-- 4. Transmission Analysis
-- Q6. How do Automatic and Manual transmission cars compare in sales volume and average price?
-- Business Purpose: To compare the popularity and average prices of different transmission types.

SELECT company, 
model,
transmission,
ROUND(AVG(price),2) AS avg_price,
COUNT(*) AS total_sold
FROM car_dataa
GROUP BY company, model , transmission
ORDER BY total_sold DESC LIMIT 10;


-- . Customer Analysis
-- Q7. How do car purchases and average car prices compare by gender?
-- Business Purpose: To understand the distribution of recorded purchases across gender categories

SELECT gender ,
COUNT(*) AS Total_purchases,
AVG(price) as avg_price 
FROM car_dataa
GROUP BY gender;

-- Q8. How do purchases and average car prices vary across annual income segments?
-- Business Purpose: To understand how recorded purchases are distributed across customer income segments.
SELECT annual_segmentaion, COUNT(*) AS Total_records, AVG(price) AS avg_price
FROM car_dataa
GROUP BY annual_segmentaion
ORDER BY  avg_price DESC;


-- 6. Dealer Performance Analysis
-- Q9. Who are the top 10 dealers by number of cars sold?
-- Business Purpose: To identify dealers with the highest recorded sales volume and sales value.

SELECT dealer_name,COUNT(*) AS total_sold,
SUM(price) AS total_sales,
ROUND(AVG(price),2) AS avg_sales  FROM car_dataa
GROUP BY dealer_name
ORDER BY total_sold DESC
LIMIT 10;


-- Q10. Which dealer regions perform best in terms of sales volume and sales value?
-- Business Purpose: To compare sales performance across geographical regions.

SELECT dealer_region , COUNT(*) AS total_sold ,
SUM(price) AS total_sales, 
ROUND(AVG(price),2)  as total_avg FROM car_dataa
GROUP BY dealer_region
ORDER BY  total_sold DESC 
LIMIT 10;

-- 7. Car Category Analysis
-- Q11. Which body styles are the most popular?
-- Business Purpose: To identify the body styles with the highest recorded sales volume

SELECT body_style, 
COUNT(*) AS total_sold, 
SUM(price) as total_sales, 
ROUND(AVG(price),2) AS Total_avg 
FROM car_dataa
GROUP BY body_style 
ORDER BY total_sold DESC;

-- Q12. How are car sales distributed across price categories?
-- Business Purpose: To understand the distribution of car purchases across different price segments.
SELECT price_category , 
COUNT(*) AS total_sold, 
SUM(price) AS total_sales, 
ROUND(AVG(price),2)  AS avg_price 
FROM car_dataa 
GROUP BY price_category;

-- 8. Time-Based Sales Analysis
-- Q13. What is the monthly car sales trend?
-- Business Purpose: To identify changes in recorded sales volume and sales value over time.
SELECT date,COUNT(*) AS total_sold, 
YEAR(date) AS sales_year,
monthname(date) AS month,
MONTH(date) AS mont_number,
SUM(price) AS total_sales, 
ROUND(AVG(price),2) AS avg_price
FROM car_dataa

GROUP BY YEAR(date), MONTH(date), MONTHNAME(date)
ORDER BY month(date);

-- Q14. How does sales performance vary by year?
-- Business Purpose: To compare annual sales volume, total sales value, and average car prices.
SELECT YEAR(date) AS sales_years ,
COUNT(*) AS total_sold, 
SUM(price) AS total_sales , 
ROUND(avg(price),2) as avg_sales 
FROM car_dataa
GROUP BY YEAR(date);

-- 9. Advanced Business Analysis
-- Q15. What is the best-selling model for each car company?
-- Business Purpose: To identify the most frequently purchased model within each company.
WITH model_sales  AS (SELECT company,
model,
COUNT(*) AS car_sold , 
SUM(price) AS total_sales, 
ROUND(AVG(PRICE),2)  AS avg_sales,
DENSE_RANK() OVER(PARTITION BY company ORDER BY COUNT(*) DESC) AS model_rank
FROM car_dataa
GROUP BY company, model)

SELECT company,
model,
car_sold,
total_sales,
avg_sales,
model_rank
FROM model_sales
WHERE model_rank = 1
ORDER BY company;






