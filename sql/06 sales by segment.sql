-- Question 6: Sales by customer segment
-- Goal: show the total sales for each customer segment.
-- Choice: customer with storeid is a store (B2B), customer with only a personid is an individual (B2C).       

SELECT
    CASE
        WHEN sc.storeid IS NOT NULL THEN 'B2B'      -- has a store -> business customer
        WHEN sc.personid IS NOT NULL THEN 'B2C'     -- has a person (and no store) -> private customer
        ELSE 'Unknown'                              -- should never happen
    END AS customer_segment,
    ROUND(SUM(soh.subtotal), 2) AS total_sales
FROM sales.salesorderheader soh
JOIN sales.customer sc
    ON soh.customerid = sc.customerid
GROUP BY customer_segment
ORDER BY total_sales DESC;
-- The order of the WHEN lines matters (SQL stops at the first one that is true).
-- A store contact can have BOTH a storeid and a personid, so B2B must come first.