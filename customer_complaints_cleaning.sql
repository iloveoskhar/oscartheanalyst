SELECT * FROM customercomplaintsdb.consumer_complaints_data;

-- Exploratory Analysis of the Customer Complaints data_set

-- identifying Seasonal Patterns in Consumer Complaints
SHOW DATABASES;
USE customercomplaintsdb;
SHOW TABLES;
DESCRIBE consumer_complaints_data;

-- creating view to extract year and month from the date 
complaints_by_month_yearCREATE VIEW complaints_by_month_year AS
SELECT 
    YEAR(`Date submitted`) AS `Year`,
    MONTH(`Date submitted`) AS `Month`,
    COUNT(*) AS `Complaint_Count`
FROM 
    customercomplaintsdb.consumer_complaints_data
GROUP BY 
    `Year`, `Month`;
    
-- Query to see the view
SELECT * FROM customercomplaintsdb.complaints_by_month_year;

-- Determine which products receive the most complaints and the most common issues for these products
-- Query to find the number of complaints by product
SELECT 
	Product,
    COUNT(*) AS `complaint_count`
FROM 
	consumer_complaints_data
GROUP BY
	Product
ORDER BY
	`complaint_count` DESC;

-- Query to find the most common issues for each product
SELECT 
	Product,
    Issue,
    COUNT(*) AS `issue_count`
FROM
	consumer_complaints_data
GROUP BY
	Product, Issue
ORDER BY 
	Product, `issue_count` DESC;
    
 --  Analyze how complaints are typically resolved  
 -- Query to find the distribution of company responses
 
SELECT 
    `Company response to consumer` AS `Response`,
    COUNT(*) AS `Response_Count`
FROM 
    consumer_complaints_data
GROUP BY 
    `Company response to consumer`
ORDER BY 
    `Response_Count` DESC;   

--   Gain insights from complaints with untimely responses  
-- Query to find complaints with untimely responses
SELECT 
    *
FROM 
   consumer_complaints_data
WHERE 
    `Timely response?` = 'No';
    
SELECT
	Product,
    Issue,
    `Company response to consumer` AS `response`,
    COUNT(*) AS `untimely_count`
FROM	customercomplaintsdb.consumer_complaints_data
WHERE 
	`Timely response?` = 'No'
GROUP BY
	Product, Issue, `Company response to consumer`	
ORDER BY 
	`untimely_count` DESC;
