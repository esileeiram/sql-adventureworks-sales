-- Question 3: Sales by product category
-- Goal: show the total sales for each product category.
-- Choice: I calculate the sales from the order lines: price x quantity x (1 - discount)       

SELECT
    pc.name AS category,
    ROUND(SUM(ssod.unitprice * ssod.orderqty * (1 - ssod.unitpricediscount)), 2) AS total_sales
    -- (1 - discount) = we remove the discount (for example 10% discount -> 0.90)
FROM sales.salesorderdetail ssod                     
JOIN production.product p                            -- from the line, find the product
    ON ssod.productid = p.productid
JOIN production.productsubcategory psc               -- from the product, find its subcategory
    ON p.productsubcategoryid = psc.productsubcategoryid
JOIN production.productcategory pc                   -- from the subcategory, find its category
    ON psc.productcategoryid = pc.productcategoryid
GROUP BY pc.name                                     -- one line per category
ORDER BY total_sales DESC;                           -- biggest to lowest