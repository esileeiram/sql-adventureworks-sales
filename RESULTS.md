# Detailed results

All amounts use `subtotal`. Queries 3 to 9 cover the whole database. Query 1 is limited to 2024\.

## 1\. Sales by region (2024)

| Region | Sales | Share |
| :---- | :---- | :---- |
| North America | 29.40M | 67% |
| Europe | 10.03M | 23% |
| Pacific | 4.25M | 10% |

By territory, Southwest (9.1M), Canada (6.2M) and Northwest (6.0M) make about half of the 2024 sales.

## 2\. Active customers

An active customer placed at least one order in the 6 months before the last order in the database. There are 10,462 active customers out of 19,119 (55%). The other 8,657 (45%) have not ordered recently, they’re a possible target for a reminder campaign.

## 3 and 3bis. Categories and reconciliation

| Category | Sales | Share |
| :---- | :---- | :---- |
| Bikes | 94.65M | 86% |
| Components | 11.80M | 11% |
| Clothing | 2.12M | 2% |
| Accessories | 1.27M | 1% |

Total sales from the order headers (`subtotal`) and from the order lines (`price × quantity × (1 − discount)`) are both 109,846,381.40. The difference is 0.004, so my queries by category and by product do not lose any sales.

## 4\. Sales by salesperson

The 17 salespeople make 80.5M (73% of revenue) for only 12% of the orders (3,806 out of 31,465). Their average order value is about 21,100, compared with 1,060 for orders without a salesperson. The top 3 (Linda Mitchell, Jillian Carson, Michael Blythe) make 37% of the salespeople's sales.

## 5\. Top 5 products

All 5 are versions of the Mountain-200 (different colors and sizes). Together they make 19.0M, or 17% of revenue.

## 6\. B2B / B2C

B2B (stores) \= 80.5M (73%). B2C (individuals) \= 29.4M (27%). These amounts are exactly the same as in query 4 (with / without salesperson). All stores go through a salesperson, and no individual customer has one.

## 7\. Segmentation by amount spent

I sort customers into Low, Medium and High with two thresholds: Q1 (25%) and Q3 (75%).

| Segment | Customers | Total spent | Share | Average |
| :---- | :---- | :---- | :---- | :---- |
| High | 4,780 | 101.52M | 92% | \~21,200 |
| Medium | 9,560 | 8.20M | 7.5% | \~860 |
| Low | 4,779 | 0.13M | 0.1% | \~27 |

The 25% of customers who spend the most make 92% of revenue. The three segments add up to 109.8M, so no customer is lost.

## 8\. Top 10 customers

The 10 best customers are all stores (B2B) and make about 7.9M, or 7% of revenue. The first one (Brakes and Gears) is only 0.8% of the total, and the gap between the 1st (877k) and the 10th (727k) is small. So the concentration comes from a large group of customers (the High segment), not from a few single customers.

## 9\. Online vs in-store customers

| Type | Customers | Orders | Revenue | Share | Average order |
| :---- | :---- | :---- | :---- | :---- | :---- |
| Online | 18,484 | 27,659 | 29.36M | 27% | \~1,060 |
| In store | 635 | 3,806 | 80.49M | 73% | \~21,100 |

Online sales bring 29 times more customers and 7 times more orders, but earn about 3 times less, because an in-store order is worth about 20 times more. Revenue depends on 635 customers (3%). This is a risk, but also an opportunity to increase the online average order value. The two groups do not overlap (18,484 \+ 635 \= 19,119 customers).