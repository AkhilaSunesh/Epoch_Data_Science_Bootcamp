**Participant Name:** Akhila Sunesh <br>
**MUID:** akhilasunesh@mulearn

# Customer Churn Prediction

## Business Objective
Customer churn (customers discontinuing a subscription or service) directly reduces recurring
revenue and increases customer acquisition costs, since retaining an existing customer is
cheaper than acquiring a new one. The objective of this project is to build a classification
model that predicts whether a customer is likely to churn, so the business can proactively
target at risk customers with retention offers, support outreach, or pricing adjustments before
they leave.

## Dataset Overview
- **Source:** Customer Churn Dataset (Kaggle)
- **File used:** `customer_churn_dataset-training-master.csv`
- **Rows:** 440,833 customers (one fully empty row removed during cleaning)
- **Columns:** 12 (11 features + target)
- **Class balance:** 249,999 churned (~56.7%) vs 190,833 retained (~43.3%) — reasonably balanced

## Features & Target Variable
| Feature | Description |
|---|---|
| CustomerID | Unique identifier (dropped — not predictive) |
| Age | Customer age |
| Gender | Male / Female |
| Tenure | Number of months/years as a customer |
| Usage Frequency | How often the service is used |
| Support Calls | Number of support calls made |
| Payment Delay | Days of payment delay |
| Subscription Type | Basic / Standard / Premium |
| Contract Length | Monthly / Quarterly / Annual |
| Total Spend | Total amount spent by the customer |
| Last Interaction | Days since last interaction |

**Target variable:** `Churn` (1 = churned, 0 = retained)

## Preprocessing Pipeline
1. **Dropped** one fully-null row (data artifact) and the `CustomerID` column (identifier, not
   predictive).
2. **Missing values:** numeric columns filled with median, categorical columns filled with mode
   (dataset had negligible missingness after the empty-row drop).
3. **Encoding:** `Gender`, `Subscription Type`, and `Contract Length` label-encoded to numeric
   values.
4. **Feature scaling:** `StandardScaler` applied to all features for Logistic Regression, since
   it is distance/coefficient-based; tree-based models used the unscaled feature set since they
   are scale-invariant.
5. **Split:** 80% train / 20% test, stratified on `Churn` to preserve class balance, with
   `random_state=42` for reproducibility.

## Models Implemented
1. Logistic Regression
2. Decision Tree Classifier (max_depth=10)
3. Random Forest Classifier (200 trees)

## Performance Comparison
| Model | Accuracy | Precision | Recall | F1-Score |
|---|---|---|---|---|
| **Random Forest** | 0.9998 | 0.9999 | 0.9997 | 0.9998 |
| Decision Tree | 0.9968 | 0.9999 | 0.9945 | 0.9972 |
| Logistic Regression | 0.8510 | 0.8787 | 0.8555 | 0.8669 |

Confusion matrices for all three models are generated in the notebook.

## Best Model & Justification
**Random Forest** is the best-performing model, achieving the highest scores across every
metric (Accuracy, Precision, Recall, and F1-Score, all above 0.999). It is selected as the
final model because:
- It outperforms the single Decision Tree, showing that ensembling many trees reduces variance
  and overfitting to noise in individual splits.
- It achieves near-perfect balance between precision and recall, meaning it neither misses
  churners (low false negatives) nor generates excessive false alarms (low false positives) —
  both matter for a churn use case with real retention-budget costs.
- Its feature importances are interpretable and business-actionable (see below), unlike
  Logistic Regression, which trailed well behind both tree-based models on this dataset,
  suggesting the relationship between features and churn is non-linear.

## Key Observations
- The dataset is close to linearly inseparable for Logistic Regression (F1 ≈ 0.87), but highly
  separable for tree-based models (F1 ≈ 0.997–0.9998), indicating strong non-linear interactions
  between features and churn.
- Feature importance from the Random Forest model ranks drivers of churn as:
  1. **Support Calls** (0.317) — most important driver
  2. **Total Spend** (0.220)
  3. **Age** (0.151)
  4. **Payment Delay** (0.134)
  5. **Contract Length** (0.088)
  6. Last Interaction, Gender, Tenure, Usage Frequency, Subscription Type (smaller contributions)
- Customers with more support calls and payment delays are strong churn signals, while
  higher total spend is a strong retention signal.

## Business Recommendations
- **Flag high support-call customers early**: since Support Calls is the top driver, route
  customers who exceed a call threshold to a retention/success team before they churn.
- **Monitor payment delays proactively**: customers with delayed payments are at elevated churn
  risk, offer flexible payment plans or reminders to this segment.
- **Reward long-term/high-spend customers**: since Total Spend is protective, loyalty perks or
  tiered discounts can reinforce this behavior.
- **Target contract-length upsells**: since Contract Length matters, incentivizing customers on
  monthly contracts to move to quarterly/annual plans may reduce churn.

## Future Improvements
- Perform hyperparameter tuning (GridSearchCV/RandomizedSearchCV) on the Random Forest to
  further optimize performance and avoid overfitting risk.
- Try gradient boosting models (XGBoost, LightGBM, CatBoost) for comparison.
- Add cross-validation instead of a single train/test split for more robust performance
  estimates.
- Incorporate additional business data (e.g., customer complaints text, product usage logs) to
  enrich the feature set.
- Deploy the model as a scheduled batch scoring job that flags at-risk customers weekly for the
  retention team.

## Repository Contents
- `customer_churn_prediction.ipynb` — full pipeline (preprocessing, model development,
  evaluation, comparison, final model selection)
- `README.md` — this file
- `customer_churn_dataset-training-master.csv` — dataset used

