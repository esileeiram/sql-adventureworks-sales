-- Question 5: Top 5 products
-- Goal: show the 5 products that bring in the most revenue.
-- Choice: revenue = price x quantity x (1 - discount).
-- This is revenue, not profit, because I do not use the costs.

SELECT
    p.productid,
    p.name AS product_name,
    ROUND(SUM(sod.unitprice * sod.orderqty * (1 - sod.unitpricediscount)), 2) AS total_sales
FROM sales.salesorderdetail sod
JOIN production.product p
    ON sod.productid = p.productid
GROUP BY p.productid, p.name        -- the ID makes sure two products with the same name stay separate
ORDER BY total_sales DESC           -- biggest first
LIMIT 5;                            -- only the first 5 lines