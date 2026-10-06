-- Question 7: Customer segmentation by amount spent
-- Goal: create segments (Low, Medium, High) based on the total spent by each customer.
-- Choice: I use quartiles:
--   Low = the 25% of customers who spend the least
--   Medium = the middle 50%
--   High = the 25% who spend the most
-- Note: WITH only works for ONE query.

-- Result 1: each customer with his or her segment
WITH customer_spending AS (                 -- Step 1: total spent by each customer
    SELECT
        customerid,
        SUM(subtotal) AS total_spent
    FROM sales.salesorderheader
    GROUP BY customerid
),
thresholds AS (                             -- Step 2: the two limits between the segments
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_spent) AS q1,   -- 25% of customers spend less than q1
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_spent) AS q3    -- 25% of customers spend more than q3
    FROM customer_spending
),
segmentation AS (                           -- Step 3: give a segment to each customer
    SELECT
        cs.customerid,
        cs.total_spent,
        CASE
            WHEN cs.total_spent <  t.q1 THEN 'Low'
            WHEN cs.total_spent <= t.q3 THEN 'Medium'
            ELSE 'High'
        END AS segment
    FROM customer_spending cs
    CROSS JOIN thresholds t                 -- thresholds has only 1 line: CROSS JOIN adds it to every customer
)
SELECT customerid, total_spent, segment
FROM segmentation
ORDER BY total_spent DESC;


-- Result 2: summary by segment (number of customers, money, share of revenue)
WITH customer_spending AS (
    SELECT
        customerid,
        SUM(subtotal) AS total_spent
    FROM sales.salesorderheader
    GROUP BY customerid
),
thresholds AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_spent) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_spent) AS q3
    FROM customer_spending
),
segmentation AS (
    SELECT
        cs.customerid,
        cs.total_spent,
        CASE
            WHEN cs.total_spent <  t.q1 THEN 'Low'
            WHEN cs.total_spent <= t.q3 THEN 'Medium'
            ELSE 'High'
        END AS segment
    FROM customer_spending cs
    CROSS JOIN thresholds t
)
SELECT
    segment,
    COUNT(*) AS nb_customers,
    ROUND(SUM(total_spent), 2) AS segment_total
FROM segmentation
GROUP BY segment
ORDER BY segment_total DESC;