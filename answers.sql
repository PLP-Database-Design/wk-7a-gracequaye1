-- Question 1
 -- Create a normalized version of the table
CREATE TABLE ProductDetail_1NF AS
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.digit+1), ',', -1)) AS Product
FROM 
    ProductDetail
JOIN
    (SELECT 0 AS digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) n
    ON LENGTH(REPLACE(Products, ',', '')) <= LENGTH(Products)-n.digit
WHERE
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.digit+1), ',', -1)) != ''
ORDER BY
    OrderID;

    -- Question 2

    -- Create Orders table (contains order and customer information)
CREATE TABLE Orders AS
SELECT DISTINCT
    OrderID,
    CustomerName
FROM 
    OrderDetails;

-- Create OrderItems table (contains product and quantity information)
CREATE TABLE OrderItems AS
SELECT 
    OrderID,
    Product,
    Quantity
FROM 
    OrderDetails;

-- Set primary keys
ALTER TABLE Orders ADD PRIMARY KEY (OrderID);
ALTER TABLE OrderItems ADD PRIMARY KEY (OrderID, Product);