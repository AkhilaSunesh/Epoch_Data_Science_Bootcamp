# Epochs '26 — Assignment 2: Northwind Database Analysis

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
| `screenshots/` | Screenshots of SQL query outputs |

---

## SQL Output Screenshots


---

## Key Insights

**1. No single hero product — demand is spread evenly across the catalog.**
The top 10 products all sold within a narrow band of ~203K–206K units (Louisiana Hot Spiced Okra leads at 206,213). No one SKU dominates.

**2. Revenue is heavily concentrated in a handful of accounts.**
The top customer generated over $9.7M — roughly 58% more than the second-highest (B's Beverages at ~$6.15M). The business leans hard on a small set of major clients.

**3. Steady long-term growth.**
Monthly revenue climbed from ~$2.07M in mid-2012 to a fairly stable $3–3.5M range by 2023 — the business is 50%+ larger by revenue in its later years compared to its early months.

**4. Beverages is the standout category by a wide margin.**
~$92.2M in revenue, nearly 39% ahead of second-place Confections (~$66.3M). Clear priority for inventory and marketing focus.

**5. High-frequency customers ≠ highest revenue customers.**
The top customer by order count (335 orders) also topped revenue — but customers ranked #2–4 by frequency don't match the top revenue ranks. There's a mix of frequent small-basket buyers and infrequent big spenders.

---

## Tools Used

- SQLite via Python's `sqlite3` module
- Pandas for data analysis
- Google Colab as the dev environment
