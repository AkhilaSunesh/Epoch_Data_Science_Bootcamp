# Used Car Price Prediction — EDA, Data Cleaning & Feature Engineering

> **Task 3 | Data Science Challenge**  
> Complete exploratory analysis, cleaning, and feature engineering pipeline on the Used Car Price Prediction Dataset.

---

## Repository Contents

| File | Description |
|------|-------------|
| `task-3.ipynb` | Full EDA, cleaning & feature engineering notebook |
| `cleaned_used_cars.csv` | Final cleaned dataset ready for ML |
| `README.md` | This file |

---

## 📊 Dataset Overview

The **Used Car Price Prediction Dataset** contains listings of pre-owned vehicles with attributes covering brand, model, model year, mileage, fuel type, engine specs, transmission, exterior/interior color, accident history, title status, and listing price.

| Property | Value |
|----------|-------|
| Raw Rows | ~4,049 |
| Columns | 12 |
| Target Variable | `price` (USD) |
| Source | [Kaggle — taeefnajib/used-car-price-prediction-dataset](https://www.kaggle.com/datasets/taeefnajib/used-car-price-prediction-dataset) |

### Feature Types
- **Numerical**: `model_year`, `milage` (after cleaning), `price` (after cleaning)
- **Categorical**: `brand`, `model`, `fuel_type`, `transmission`, `ext_col`, `int_col`, `accident`, `clean_title`, `engine`

---

## Data Quality Issues Identified

| Issue | Column(s) | Details |
|-------|-----------|---------|
| String-encoded price | `price` | Stored as `"$33,908"` — requires stripping `$` and `,` |
| String-encoded mileage | `milage` | Stored as `"60,000 mi"` — requires stripping ` mi` and `,` |
| Missing values | `fuel_type`, `accident`, `clean_title`, `int_col`, `engine` | 2–5% null rates per column |
| Duplicate records | All columns | ~40 fully duplicate rows (~1%) |
| Price outliers (low) | `price` | 5 rows with price < $500 (data entry errors) |
| Price outliers (high) | `price` | 5 rows with price > $500,000 (likely errors) |
| Mileage extreme values | `milage` | Long tail above 99th percentile |
| Unstructured engine | `engine` | Raw string like `"2.5L 4 Cylinder"` — needs parsing |

---

## Cleaning Techniques Applied

### 1. Duplicate Removal
```python
df_clean.drop_duplicates(inplace=True)
```
Removed ~40 fully duplicate rows identified by exact match across all columns.

### 2. Data Type Correction
```python
# Price: "$33,908" → 33908.0
df_clean['price'] = df_clean['price'].str.replace(r'[$,]', '', regex=True).astype(float)

# Mileage: "60,000 mi" → 60000.0
df_clean['milage'] = df_clean['milage'].str.replace(r'[, mi]', '', regex=True).astype(float)
```

### 3. Outlier Handling
- **Price**: Rows with `price < $500` or `price > $250,000` removed as data entry errors.
- **Mileage**: Values above the 99th percentile capped using `clip(upper=p99)` to preserve distribution shape.

### 4. Missing Value Imputation

| Column | Strategy | Rationale |
|--------|----------|-----------|
| `fuel_type` | Mode imputation | Gasoline dominates (>60%); safe assumption |
| `accident` | Fill `"Unknown"` | Not knowing ≠ no accident |
| `clean_title` | Fill `"Unknown"` | Same logic as accident |
| `int_col` | Mode imputation | Interior color missing at random |
| `engine` | Mode imputation | Small % missing; mode is reasonable |

### 5. Text Standardisation
All categorical columns were stripped of whitespace and title-cased for consistency.

### 6. Engine Parsing
Regex extraction split the unstructured `engine` string into two clean numeric columns:
```python
engine_displacement = re.search(r'(\d+\.?\d*)L', engine)
engine_cylinders    = re.search(r'(\d+)\s*Cylinder', engine)
```

---

## Feature Engineering

Seven new features were engineered to improve predictive power:

| # | Feature | Formula | Purpose |
|---|---------|---------|---------|
| 1 | `vehicle_age` | `2024 - model_year` | Age in years; more interpretable than raw year |
| 2 | `price_per_mile` | `price / (milage + 1)` | Value retention proxy — cost per mile |
| 3 | `mileage_per_year` | `milage / (vehicle_age + 1)` | Usage intensity — reveals wear rate |
| 4 | `is_luxury_brand` | Brand membership flag `{BMW, Mercedes, Audi, …}` | Binary premium brand indicator |
| 5 | `has_accident` | Parse `accident` column → 0/1 | Cleaner binary for ML than raw text |
| 6 | `is_ev_or_hybrid` | Fuel type membership `{Electric, Hybrid, PHEV}` | Captures green vehicle premium |
| 7 | `age_mileage_score` | `(vehicle_age × milage) / 1,000,000` | Compound depreciation proxy |

Additionally, engine string was decomposed into:
- `engine_displacement` (e.g., `2.5`)
- `engine_cylinders` (e.g., `4`)

**Final dataset: 4,000 rows × 21 columns**

---

## Five Key Insights

### 1. Model Year is the Strongest Price Predictor
Model year shows the highest positive correlation with price (~+0.60). Each additional year of age depreciates a vehicle substantially, confirming that recency dominates pricing.

### 2. Mileage Causes Significant Depreciation
Mileage correlates negatively with price (~-0.45). The relationship is non-linear — the first 50,000 miles carry the steepest depreciation, justifying a log-mileage transformation for future modeling.

### 3. Brand Premium is Real and Measurable
Luxury brands (BMW, Mercedes-Benz, Audi) cluster at median prices 1.5–2× higher than mainstream brands at equivalent age/mileage, confirming that brand name is an independent pricing factor.

### 4. Accident History Suppresses Price by ~$4,000–$6,000
Vehicles with at least one reported accident sell materially below clean-history comparables after controlling for year and mileage. The `has_accident` binary feature directly captures this discount.

### 5.  Electric & Hybrid Vehicles Command a Price Premium
Despite lower mileage costs, EVs and hybrids list at higher prices than gasoline equivalents of the same age. The `is_ev_or_hybrid` flag captures this segment premium that would otherwise be averaged out.

---

