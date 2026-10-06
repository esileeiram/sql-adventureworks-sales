-- Question 2: Active customers
-- Goal: show the customers who ordered recently.
-- Choice: "recently" = in the 6 months before the LAST order in the database.
-- I did not use today's date, because the data stops in june 2025, so nobody would be active.

-- Part A: list of every active customers, with their name and what they bought
SELECT
    sc.customerid,
    CASE
        WHEN sc.storeid IS NOT NULL THEN ss.name                -- show the store name
        ELSE pp.firstname || ' ' || pp.lastname                 -- first name + space + last name
    END AS customer_name,
    MAX(ssoh.orderdate) AS last_order_date,                      -- most recent order of this customer
    COUNT(*) AS nb_orders,                                      -- number of orders (in the 6 months)
    ROUND(SUM(ssoh.subtotal), 2) AS total_revenue                -- money spent (in the 6 months)
FROM sales.salesorderheader ssoh
JOIN sales.customer sc
    ON ssoh.customerid = sc.customerid
LEFT JOIN person.person pp                                      -- LEFT JOIN keeps ALL customers, even if they are not a person
    ON sc.personid = pp.businessentityid                       
LEFT JOIN sales.store ss                                        -- same here, keeps customers who are not a store
    ON sc.storeid = ss.businessentityid
WHERE ssoh.orderdate >= (SELECT MAX(orderdate) FROM sales.salesorderheader)  -- date of the last order...
                       - INTERVAL '6 months'                                -- ...minus 6 months
GROUP BY sc.customerid, customer_name      
ORDER BY total_revenue DESC;


-- Part B: how many active customers?
SELECT COUNT(DISTINCT customerid) AS nb_active_customers        -- DISTINCT = count each customer only once
FROM sales.salesorderheader
WHERE orderdate >= (SELECT MAX(orderdate) FROM sales.salesorderheader)
                   - INTERVAL '6 months';


-- Part C: how many customers in total? (to calculate the share of active ones (active/total))
SELECT COUNT(DISTINCT customerid) AS nb_customers_total
FROM sales.salesorderheader;