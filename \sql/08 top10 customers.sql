-- Question 8: Top 10 customers
-- Goal: find the 10 customers who bring in the most revenue.
-- Choice: revenue = "subtotal" (before tax and shipping).

SELECT
    sc.customerid,
    CASE
        WHEN sc.storeid IS NOT NULL THEN ss.name                -- a store: show store name
        ELSE pp.firstname || ' ' || pp.lastname                 -- a person: show first name + last name
    END AS customer_name,
    CASE
        WHEN sc.storeid IS NOT NULL THEN 'B2B'                  -- store = business customer
        ELSE 'B2C'                                              -- person = private customer
    END AS customer_type,
    ROUND(SUM(ssoh.subtotal), 2) AS total_revenue
FROM sales.salesorderheader ssoh
JOIN sales.customer sc
    ON ssoh.customerid = sc.customerid
LEFT JOIN person.person pp                                      -- LEFT JOIN: keep customers who are not a person
    ON sc.personid = pp.businessentityid
LEFT JOIN sales.store ss                                        -- LEFT JOIN: keep customers who are not a store
    ON sc.storeid = ss.businessentityid
GROUP BY sc.customerid, customer_name 
ORDER BY total_revenue DESC
LIMIT 10;                                                     