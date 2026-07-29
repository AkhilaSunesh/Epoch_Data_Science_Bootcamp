**Name:** Akhila Sunesh
**MUID:** akhilasunesh@mulearn

# Mall Customer Segmentation

## Project Summary
This project applies K-Means clustering to the Mall Customer Segmentation dataset (200 customers) to group shoppers into distinct behavioral segments based on Age, Annual Income, and Spending Score, then translates each segment into a business-friendly customer profile with tailored marketing recommendations.

## Approach
1. **Data Preparation**
   - Loaded the dataset and confirmed there were no missing values.
   - Dropped `CustomerID` (identifier only) and label-encoded `Gender` for reference/profiling.
   - Selected `Age`, `Annual Income (k$)`, and `Spending Score (1-100)` as clustering features.
   - Applied `StandardScaler` to standardize features, since K-Means uses Euclidean distance and unscaled features (e.g., Income ranging up to 137 vs Spending Score up to 99) would bias cluster assignment toward the largest-magnitude feature.

2. **Model Building**
   - Used the **Elbow Method** (inertia vs. k, for k=1 to 10) to find the point of diminishing returns.
   - Cross-checked with the **Silhouette Score** across the same range of k.
   - Selected **k=5** as the optimal number of clusters.
   - Trained the final `KMeans` model (`k-means++` initialization, `n_init=10`, `random_state=42`) and assigned each customer to a cluster.

3. **Visualization**
   - Reduced the 3 scaled features to 2 dimensions using **PCA** purely for visualization.
   - PC1 explains roughly 44% and PC2 roughly 33% of the variance, for a combined ~78% of total variance captured in the 2D projection.
   - Plotted the 2D cluster scatter plot with centroids, plus boxplots of each feature per cluster.

4. **Cluster Profiling & Business Naming**
   - Computed mean Age, Income, and Spending Score per cluster, along with cluster size and gender split.
   - Assigned each cluster a business-friendly name based on its income/spending profile (e.g., "Premium Target Customers", "Budget-Conscious Shoppers").

## Key Observations
- The Elbow plot shows a clear bend around **k=5**, and the Silhouette Score is highest/near-highest in the 5-6 cluster range, supporting 5 as a robust choice.
- The 5 clusters separate cleanly along the Income x Spending Score plane, with Age acting as a secondary differentiator within some groups.
- The two principal components together capture the large majority of the variance in the scaled feature set, so the 2D visualization is a reasonably faithful representation of the actual cluster structure.

## Segments Identified
| Segment | Profile | Suggested Strategy |
|---|---|---|
| Premium Target Customers | High income, high spending | VIP loyalty programs, premium product lines, personalized retention offers |
| Careful Spenders | High income, low spending | Investigate low engagement; targeted promotions to convert spending potential |
| Impulsive Young Spenders | Low income, high spending | Flash sales, trendy affordable lines, buy-now-pay-later options |
| Budget-Conscious Shoppers | Low income, low spending | Value bundles, discounts, essential-goods promotions |
| Average / Standard Customers | Mid income, mid spending | General seasonal campaigns; testing ground for new offers |

## Conclusions
Segmenting mall customers by Age, Income, and Spending Score using K-Means produces business-interpretable groups that go well beyond a one-size-fits-all marketing approach. Each segment has a distinct profile that maps naturally to a differentiated strategy, from premium retention offers for high-value shoppers to value-driven promotions for budget-conscious ones. This segmentation can directly inform targeted campaign design, resource allocation, and customer relationship management for the mall.

