# World Happiness Report — ML Analysis (2017–2019)

> Exploratory Data Analysis and Machine Learning framing of the World Happiness Report dataset published by the UN Sustainable Development Solutions Network (UNSDSN).

**Dataset Source:** [Kaggle – World Happiness Report](https://www.kaggle.com/datasets/unsdsn/world-happiness)

---

## Repository Structure

```
.
├── Day1Task.ipynb      # Full EDA notebook with visualisations
├── README.md           # This file
├── 2017.csv            # World Happiness Report 2017 (155 countries)
├── 2018.csv            # World Happiness Report 2018 (156 countries)
└── 2019.csv            # World Happiness Report 2019 (156 countries)
```

---

## Dataset Overview

The World Happiness Report ranks countries by their citizens' self-reported well-being, collected via the **Gallup World Poll** using the **Cantril Ladder** — a scale where respondents rate their life from 0 (worst possible) to 10 (best possible).

| Year | Countries | Columns | Missing Values |
|------|-----------|---------|----------------|
| 2017 | 155 | 12 | 0 |
| 2018 | 156 | 9  | 1 |
| 2019 | 156 | 9  | 0 |

### Key Columns (2018/2019 naming, used for consistency)

| Column | Description |
|--------|-------------|
| `Country or region` | Country name |
| `Score` | Happiness score (Cantril Ladder, 0–10 scale) |
| `GDP per capita` | Log GDP per capita (PPP) |
| `Social support` | Having someone to rely on in trouble |
| `Healthy life expectancy` | Healthy years of life at birth |
| `Freedom to make life choices` | Satisfaction with freedom |
| `Generosity` | Charitable donations relative to GDP |
| `Perceptions of corruption` | Trust in government & business |

> **Note:** 2017 uses different column names (`Happiness.Score`, `Family`, `Economy..GDP.per.Capita.`, etc.) and includes additional columns: `Whisker.high`, `Whisker.low` (confidence intervals), and `Dystopia.Residual` (hypothetical least-happy baseline).

---

## Problem(s)
1. **Policy Benchmarking** — Identify levers (GDP, health, social programs, governance) that most impact happiness.  
2. **Peer Grouping** — Cluster countries with similar profiles for realistic comparisons.  
3. **Forecasting** — Predict scores from socioeconomic indicators for planning.

## Machine Learning Problem Framing

### Primary: Regression
| Attribute | Detail |
|-----------|--------|
| **Type** | Supervised — Regression |
| **Justification** | The target variable `Score` is continuous (range ≈ 2.69–7.77). Predicting it from socioeconomic features is a classic regression task. |
| **Algorithms to try** | Linear Regression|
| **Evaluation Metrics** | RMSE, MAE, R² |

### Secondary: Clustering
| Attribute | Detail |
|-----------|--------|
| **Type** | Unsupervised — Clustering |
| **Justification** | Without the score label, countries can be grouped by feature similarity to discover natural happiness tiers useful for policy comparison. |
| **Algorithms to try** | K-Means (k=3–5), DBSCAN, Hierarchical Clustering with PCA |
| **Evaluation Metrics** | Silhouette Score, Within-cluster SSE (Elbow method) |

---

## 🎯 Target Variable & Key Features

### Target Variable
**`Score`** (called `Happiness.Score` in 2017) — the composite happiness score per country.

### Key Features (ranked by correlation with Score, 2019)

| Feature | Pearson r | Importance |
|---------|-----------|------------|
| GDP per capita | **0.794** | Very High |
| Healthy life expectancy | **0.780** | Very High |
| Social support | **0.777** | Very High |
| Freedom to make life choices | **0.567** | Moderate |
| Perceptions of corruption | **0.386** |  Low-Moderate |
| Generosity | **0.076** | Negligible |

---

# Key Insights
1. **Top Drivers** — GDP, health, social support dominate; prosperity alone isn’t enough.  
2. **Persistent Gap** — Avg ~5.3, range ~2.7–7.8; same top/bottom countries across years → structural inequality.  
3. **Generosity Weak Link** — r ≈ 0.08; cultural/religious norms drive it, not happiness → drop in ML models.
   
## How to Run

```bash
# Clone the repository
git clone https://github.com/<your-username>/world-happiness-eda.git
cd world-happiness-eda

# Install dependencies
pip install pandas numpy matplotlib seaborn jupyter

# Launch the notebook
jupyter notebook analysis.ipynb
```

---

## Dependencies

- Python 3.8+
- pandas
- numpy
- matplotlib
- seaborn
- jupyter

---

*Analysis by Akhila Sunesh| Data Source: UN Sustainable Development Solutions Network via Kaggle*
