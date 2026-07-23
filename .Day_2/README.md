# Epochs '26 Assignment 2: Northwind Database Analysis

## What's This?

Analysis of the [Northwind SQLite database](https://github.com/jpwhite3/northwind-SQLite3) — a classic small-business dataset covering customers, orders, products, categories, suppliers and employees. The goal was to answer real-world business questions using SQL, then explore and visualize the results with Pandas.

---

## Business Questions

1. What are the top 10 selling products (by quantity sold)?
2. Who are the top 10 customers by revenue?
3. What do monthly sales trends look like over time?
4. Which product categories perform best by revenue?
5. Which customers order most frequently?

---

## What's in This Repo

| File | What it is |
|---|---|
| `queries.sql` | Raw SQL queries for each business question |
| `analysis.ipynb` | SQL execution + Pandas analysis + charts |
| `README.md` | You're reading it |

---

## SQL Output Screenshots

<img width="1908" height="736" alt="image" src="https://github.com/user-attachments/assets/1078da89-db0d-48aa-8690-6e310035d264" />
<img width="1071" height="690" alt="image" src="https://github.com/user-attachments/assets/e8b618b7-8df1-4fd3-8112-e1440fcda52b" />
<img width="1102" height="737" alt="image" src="https://github.com/user-attachments/assets/eb3bbfd6-5090-4d81-a8d5-e3ab65c658af" />
<img width="870" height="587" alt="image" src="https://github.com/user-attachments/assets/26a18395-53d8-4cf8-a52f-43a9f4940ec0" />





---

## Key Insights

**1. No single hero product  demand is spread evenly across the catalog.**
The top 10 products all sold within a narrow band of ~203K–206K units (Louisiana Hot Spiced Okra leads at 206,213). No one SKU dominates.

**2. Revenue is heavily concentrated in a handful of accounts.**
The top customer generated over $9.7M  roughly 58% more than the second-highest (B's Beverages at ~$6.15M). The business leans hard on a small set of major clients.

**3. Steady long-term growth.**
Monthly revenue climbed from ~$2.07M in mid-2012 to a fairly stable $3–3.5M range by 2023 — the business is 50%+ larger by revenue in its later years compared to its early months.

**4. Beverages is the standout category by a wide margin.**

**5. High-frequency customers ≠ highest revenue customers.**
The top customer by order count (335 orders) also topped revenue but customers ranked #2–4 by frequency don't match the top revenue ranks. There's a mix of frequent small-basket buyers and infrequent big spenders.

---

## Tools Used

- SQLite via Python's `sqlite3` module
- Pandas for data analysis
- Google Colab as the dev environment
