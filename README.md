# AdventureWorks Sales Analysis in SQL

A SQL project (PostgreSQL) that answers 9 business questions about the sales, customers and products of a fictional bike company.

**Database:** AdventureWorks, a sample database made by Microsoft.   
**Skills:** joins, aggregations, Case When, CTEs, percentiles, date filters, data checks.

## Key findings

- **Bikes make 86% of revenue** (94.7M out of 109.8M). The top 5 products are all Mountain-200 bikes.  
- **B2B customers (stores) make 73% of revenue**, with only 635 customers. Online customers (18,484) make 27%.  
- **The top 25% of customers make 92% of revenue.** Revenue depends on a group of big customers, not on a few single ones (top 10 \= 7%).  
- **55% of customers are active** (an order in the last 6 months).

## The analyses

All amounts use `subtotal` (before tax and shipping). Details and tables are in [RESULTS.md](http://RESULTS.md).

| \# | Question | File | Key result |
| :---- | :---- | :---- | :---- |
| 1 | Sales by region, 2024 | `01_sales_by_region.sql` | North America \= 67% (29.4M out of 43.7M) |
| 2 | Active customers | `02_active_customers.sql` | 10,462 out of 19,119 (55%) |
| 3 | Sales by product category | `03_sales_by_category.sql` | Bikes \= 86% |
| 3bis | Reconciliation headers vs lines | `03bis_reconciliation.sql` | Difference of 0.004 on 109.8M |
| 4 | Sales by salesperson | `04_sales_by_salesperson.sql` | Linda Mitchell, 10.4M |
| 5 | Top 5 products | `05_top5_products.sql` | Mountain-200 Black, 38 (4.4M) |
| 6 | Sales by segment (B2B / B2C) | `06_sales_by_segment.sql` | B2B \= 73% |
| 7 | Segmentation by amount spent | `07_customer_segmentation.sql` | "High" (25% of customers) \= 92% of revenue |
| 8 | Top 10 customers | `08_top10_customers.sql` | Brakes and Gears (B2B), 877k |
| 9 | Customers by order type | `09_customers_by_order_type.sql` | Online \= 27% of revenue, in store \= 73% |

## Quality checks

- The sales calculated from order headers and from order lines are the same, within 0.004.  
- Queries 3, 6, 7 and 9 all add up to 109.8M.  
- Queries 4, 6 and 9 give the same split (80.5M / 29.4M).

## My choices

- **`subtotal`, not `totaldue`:** I measure what the company sells, without tax and shipping. I used only one of the two columns in the whole project.  
- **Active customer:** an order in the 6 months before the last order in the database. I do not use today's date, because nobody would be active.  
- **Segments:** quartiles (Q1 and Q3), so 25% Low / 50% Medium / 25% High.  
- **B2B / B2C:** a customer with a `storeid` is a store (B2B), otherwise it is an individual (B2C).  
- **Limit:** I measure revenue, not profit, because I do not use costs.

## How to run it

1. Install PostgreSQL and load AdventureWorks for PostgreSQL (search "AdventureWorks PostgreSQL" on GitHub).  
2. Run the files in `sql/` in order, for example `\i sql/01_sales_by_region.sql` in psql or PGAdmin

The database is not in this repo (too big).  
*AdventureWorks is a sample database, © Microsoft.*