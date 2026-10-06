-- Question 4: Sales by salesperson
-- Goal: show the total sales made by each salesperson.
-- Choice: I group by the salesperson ID, not by the name, because two people could have the same name.

SELECT
    ssp.businessentityid AS salesperson_id,
    pp.firstname || ' ' || pp.lastname AS salesperson_name,   -- first name + space + last name
    ROUND(SUM(soh.subtotal), 2) AS total_sales
FROM sales.salesorderheader soh
JOIN sales.salesperson ssp                                    -- JOIN keeps only orders that have a salesperson
    ON soh.salespersonid = ssp.businessentityid
JOIN person.person pp                                         -- get the name of the salesperson
    ON ssp.businessentityid = pp.businessentityid
GROUP BY ssp.businessentityid, pp.firstname, pp.lastname
ORDER BY total_sales DESC;


-- Check: the total above is NOT 109.8M, because online orders have no salesperson.
-- This query splits ALL the orders in two groups to prove it.
SELECT
    CASE
        WHEN salespersonid IS NULL THEN 'Without salesperson'   -- IS NULL = no value
        ELSE 'With salesperson'
    END AS order_type,
    COUNT(*) AS nb_orders,
    ROUND(SUM(subtotal), 2) AS total_sales
FROM sales.salesorderheader
GROUP BY order_type;
-- The two lines together should give 109.8M (the total from question 3bis).