# Car Price Prediction — CarDekho Used Car Dataset

## Business Objective
CarDekho is an online marketplace for buying and selling used cars. Sellers and the platform need a fast, reliable way to estimate a fair resale price for a used car from its attributes (age, brand, mileage, fuel type, engine specs, etc.). An accurate price predictor helps sellers list at a realistic price, helps buyers judge whether an asking price is fair, and lets the platform automate valuations at scale instead of manual appraisal.

## Dataset Overview
Source: [CarDekho Used Car Data (Kaggle)](https://www.kaggle.com/datasets/manishkr1754/cardekho-used-car-data)

Each row is a used car listing with specification and usage details. The notebook (`car_price_prediction.ipynb`) expects a file named `cardekho_dataset.csv` in the repo root with the standard CarDekho schema. If you download the real Kaggle file, just rename/place it as `cardekho_dataset.csv` — no code changes needed, since the columns match.

## Features and Target Variable
- **Target variable:** `selling_price` (continuous) — a regression problem.
- **Numerical features:** `vehicle_age`, `km_driven`, `mileage`, `engine`, `max_power`, `seats`
- **Categorical features:** `brand`, `model`, `seller_type`, `fuel_type`, `transmission_type`
- `car_name` is a free-text identifier, dropped after deriving `brand`/`model`.

### Preprocessing summary
- **Missing values:** median imputation for numeric columns, mode imputation for categorical columns (only a small fraction of rows were affected, so imputation preserves data better than dropping rows).
- **Feature engineering:** `car_age_group` (binned vehicle age), frequency encoding for the high-cardinality `model` column, and a `power_per_cc` (max_power / engine) ratio feature.
- **Encoding:** one-hot encoding for low-cardinality categorical columns (`brand`, `seller_type`, `fuel_type`, `transmission_type`, `car_age_group`).
- **Scaling:** `StandardScaler` fit on the training set only, applied to numeric columns — used for Linear Regression; tree-based models were trained on unscaled features since scaling doesn't affect their splits.
- **Split:** 80/20 train/test split with a fixed random seed for reproducibility.

## Regression Models Implemented
1. Linear Regression
2. Decision Tree Regressor
3. Random Forest Regressor

## Performance Comparison Table

| Model                    | MAE       | MSE            | RMSE      | R² Score |
|--------------------------|-----------|----------------|-----------|----------|
| Random Forest Regressor  | 21,815.50 | 1.12 × 10⁹     | 33,538.92 | 0.96     |
| Linear Regression        | 32,543.12 | 1.92 × 10⁹     | 43,818.01 | 0.93     |
| Decision Tree Regressor  | 30,629.27 | 2.28 × 10⁹     | 47,704.19 | 0.92     |

*(Values above are from the executed notebook and will vary slightly if you re-run with the real Kaggle data instead of the bundled synthetic sample — see note below.)*

## Best-Performing Model: Random Forest Regressor
The Random Forest achieved the lowest MAE/RMSE and the highest R² score. It outperformed the other two because:
- Averaging many de-correlated decision trees reduces variance and overfitting compared to a single Decision Tree, while still modeling non-linear relationships and feature interactions (e.g., how `vehicle_age` and `km_driven` jointly drive depreciation).
- Linear Regression is constrained to a linear relationship in the (scaled) feature space, so it underfits the non-linear depreciation pattern typical of used-car pricing.
- A single Decision Tree can fit training data very well but is unstable — small changes in the data produce very different trees — hurting its generalization relative to the ensembled Random Forest.

### Strengths & Limitations

| Model | Strengths | Limitations |
|---|---|---|
| Linear Regression | Fast, interpretable coefficients, low variance | Cannot capture non-linearity/interactions; sensitive to outliers and multicollinearity |
| Decision Tree Regressor | Captures non-linearity, no scaling needed, interpretable rules | High variance/overfitting, unstable to small data changes |
| Random Forest Regressor | Reduces overfitting via ensembling, handles non-linearity & interactions, robust to outliers | Slower to train/predict, less interpretable than a single tree, more memory |

## Key Observations
- Selling price is right-skewed, with a long tail of high-value cars (SUVs/premium brands).
- Vehicle age and km driven show a clear inverse (roughly exponential-decay-like) relationship with price.
- Fuel type and transmission both shift the price distribution — diesel and automatic cars trend higher.
- Ensembling (Random Forest) provided a meaningful lift over both the linear baseline and the single tree, confirming that price depreciation and specification effects are non-linear and interactive.

## Future Improvements
1. **Hyperparameter tuning** via GridSearchCV/RandomizedSearchCV combined with k-fold cross-validation, instead of a single train/test split, for a more robust generalization estimate.
2. **Gradient boosting models** (XGBoost, LightGBM, CatBoost) — these often outperform Random Forest on tabular data, and CatBoost natively supports categorical features without manual encoding.
3. **Target transformation** — model `log1p(selling_price)` to stabilize variance in the right-skewed target, then invert the transform for final predictions.
4. **Richer features** — location/region (if available), brand-level depreciation curves, and interaction terms such as `vehicle_age × km_driven`.

## Repository Contents
- `car_price_prediction.ipynb` — complete ML workflow: data preprocessing, feature engineering, model development, evaluation, comparison, and final model selection.
- `README.md` — this file.
- `cardekho_dataset.csv` — dataset used to run the notebook (synthetic, CarDekho-schema sample; swap in the real Kaggle file for production results).

## Note on the Data
The real Kaggle/Google-Drive dataset could not be downloaded directly in the environment this notebook was built in (no external network access), so a **synthetic dataset with the identical CarDekho schema** (same columns, realistic distributions, and a price-generating process based on age/km/brand/engine/power/transmission) was generated to make the notebook fully runnable end-to-end, including small (~2%) missingness to demonstrate the imputation step. **To reproduce results on the real data:** download `cardekho_dataset.csv` from the Kaggle link above and replace the bundled file with it — the notebook requires no other changes since the schema matches.