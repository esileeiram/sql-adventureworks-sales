-- Question 9: Customers by order type
-- Goal: show the customers who bought online and the ones who bought in store.
-- onlineorderflag is TRUE for an online order and FALSE for an in-store order.

-- Part A: summary (how many customers, orders and how much money for each type)
SELECT
    CASE
        WHEN onlineorderflag THEN 'Online'
        ELSE 'In store'
    END AS order_type,
    COUNT(DISTINCT customerid) AS nb_customers,     -- DISTINCT: each customer is counted only once
    COUNT(*) AS nb_orders,                          -- every order is counted
    ROUND(SUM(subtotal), 2) AS total_revenue
FROM sales.salesorderheader
GROUP BY onlineorderflag
ORDER BY nb_customers DESC;


-- Part B: the list of customers with the type of order they made
-- If a customer bought both ways, he or she appears twice.
SELECT DISTINCT                                     -- DISTINCT removes duplicate lines
    customerid,
    CASE
        WHEN onlineorderflag THEN 'Online'
        ELSE 'In store'
    END AS order_type
FROM sales.salesorderheader
ORDER BY order_type, customerid;
-- This list is long (about 19,000 lines): you can add LIMIT to test it.