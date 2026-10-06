-- Question 3bis: Reconciliation (checking my numbers)
-- Goal: check that the total from the order HEADERS is the same as the total from the order LINES.     
-- If they are the same, my queries by category and by product lose no sales.
-- Difference between the two (it should be almost 0, only rounding)
SELECT
    -- Total 1: sum of "subtotal" in the order headers
    (SELECT ROUND(SUM(subtotal), 2)
     FROM sales.salesorderheader) AS total_headers,

    -- Total 2: sum of price x quantity x (1 - discount) in the order lines
    (SELECT ROUND(SUM(unitprice * orderqty * (1 - unitpricediscount)), 2)
     FROM sales.salesorderdetail) AS total_lines; -- Difference between the two (it should be almost 0, only rounding)