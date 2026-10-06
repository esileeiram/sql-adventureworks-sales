-- Question 1: Sales by region in 2024
-- Goal: show the total sales for each region in 2024.
-- Choice: I use "subtotal" (the amount before tax and shipping).
-- Need to erase one version and execute script

-- Version A: by big region (North America, Europe, Pacific)
SELECT
    sst."group" AS region,                          -- "group" needs quotes because it is a reserved SQL word
    ROUND(SUM(ssoh.subtotal), 2) AS total_sales     -- add up all the orders, keep 2 decimals
FROM sales.salesorderheader ssoh                    -- ssoh = short name for the orders table
JOIN sales.salesterritory sst                       -- join the territories table to get the region name
    ON ssoh.territoryid = sst.territoryid            -- the two tables share the column territoryid
WHERE ssoh.orderdate >= '2024-01-01'                -- keep only orders from 1 January 2024...
  AND ssoh.orderdate <  '2025-01-01'                -- ...up to 31 December 2024
GROUP BY sst."group"                                -- one line per region
ORDER BY total_sales DESC;                         -- biggest sales first


-- Version B: same thing, but by territory (more detailed, 10 lines)
SELECT
    sst.name AS territory,
    ROUND(SUM(ssoh.subtotal), 2) AS total_sales
FROM sales.salesorderheader ssoh
JOIN sales.salesterritory sst
    ON ssoh.territoryid = sst.territoryid
WHERE ssoh.orderdate >= '2024-01-01'
  AND ssoh.orderdate <  '2025-01-01'
GROUP BY sst.name
ORDER BY total_sales DESC;
