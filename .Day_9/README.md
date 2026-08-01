# Epochs '26 - Assignment 9: Customer Churn Web App

- **Name:** Akhila Sunesh  
- **MUID:** akhilasunesh@mulearn  

**Deployment link:** [https://akhilasunesh-epoch-data-science-bootcamp--day-9app-sjc8ug.streamlit.app/](https://akhilasunesh-epoch-data-science-bootcamp--day-9app-sjc8ug.streamlit.app/)  
**GitHub repo:** [https://github.com/AkhilaSunesh/Epoch_Data_Science_Bootcamp/tree/main/.Day_9](https://github.com/AkhilaSunesh/Epoch_Data_Science_Bootcamp/tree/main/.Day_9)

---

## Project Summary
For this assignment, I worked with a Kaggle customer churn dataset and developed a practical web application. The app enables users to input customer details such as age, tenure, subscription type, and payment delays to predict whether a customer is likely to churn or remain.

---

## Development Workflow
- **Model Training:** Used a Jupyter Notebook (`train.ipynb`) to preprocess the dataset and remove missing values.  
- **Feature Encoding:** Converted categorical variables (Gender, Subscription Type, Contract Length) into numeric values using Python dictionaries.  
- **Algorithm:** Trained a Random Forest Classifier with `n_estimators=50` and `max_depth=10`.  
- **Frontend:** Designed the interface in Streamlit with a two-column layout for organized input fields.  
- **Inference:** Exported the trained model with `pickle` so that `app.py` can load it and generate predictions instantly.  

---

## Insights
- **Overfitting:** The model achieved ~0.99 accuracy on training data but dropped to ~0.50 on test data, indicating strong overfitting.  
- **Feature Importance:** Support calls and payment delays emerged as the most influential factors in churn prediction.

- <img width="1918" height="951" alt="image" src="https://github.com/user-attachments/assets/eab269c4-ca25-4e20-b5b4-db93f3d2c19c" />


---

## Challenges
- **Large Dataset:** With over 440,000 rows, training was computationally heavy. Restricting the tree depth helped manage performance.  
- **Input Consistency:** Ensuring that Streamlit inputs matched the exact encoding scheme used during training was critical for reliable predictions.  

---

## Future Enhancements
- **Reduce Overfitting:** Apply hyperparameter tuning, regularization, or experiment with alternative models like XGBoost to improve generalization.  
- **UI Improvements:** Add visualizations (charts or plots) to help users see how their inputs compare to the dataset distribution.  

---
