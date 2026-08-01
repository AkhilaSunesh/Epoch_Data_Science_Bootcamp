import streamlit as st
import pickle
import numpy as np

# Load model
with open('.Day_9/churn_model.pkl', 'rb') as f:
    model = pickle.load(f)

st.set_page_config(page_title="Churn Risk Analyzer", layout="wide")

st.title("📊 Customer Churn Risk Analyzer")
st.write("Fill in the details below to check if a customer is at risk of leaving.")

# Sidebar for inputs
st.sidebar.header("Customer Details")

age = st.sidebar.number_input("Age", min_value=18, max_value=100, value=30, help="Customer's age")
gender = st.sidebar.selectbox("Gender", ["Female", "Male"])
tenure = st.sidebar.number_input("Tenure (Months)", min_value=0, value=12, help="How long the customer has been with the company")
usage_freq = st.sidebar.number_input("Usage Frequency (per month)", min_value=0, value=10)
support_calls = st.sidebar.number_input("Support Calls", min_value=0, value=2)

payment_delay = st.sidebar.number_input("Payment Delay (Days)", min_value=0, value=0)
sub_type = st.sidebar.selectbox("Subscription Type", ["Basic", "Standard", "Premium"])
contract_len = st.sidebar.selectbox("Contract Length", ["Monthly", "Quarterly", "Annual"])
total_spend = st.sidebar.number_input("Total Spend ($)", min_value=0.0, value=500.0)
last_interaction = st.sidebar.number_input("Days Since Last Interaction", min_value=0, value=5)

# Encode categorical values
gender_val = 0 if gender == "Female" else 1
sub_val = {"Basic": 0, "Standard": 1, "Premium": 2}[sub_type]
contract_val = {"Monthly": 0, "Quarterly": 1, "Annual": 2}[contract_len]

# Prediction
if st.sidebar.button("🔍 Check Customer Status", use_container_width=True):
    features = np.array([[
        age, gender_val, tenure, usage_freq, support_calls,
        payment_delay, sub_val, contract_val, total_spend, last_interaction
    ]])

    result = model.predict(features)[0]
    prob = model.predict_proba(features)[0][1] if hasattr(model, "predict_proba") else None

    st.write("---")
    if result == 1:
        st.error("⚠️ High Risk: Customer is likely to churn.")
        if prob is not None:
            st.metric("Churn Probability", f"{prob:.2%}")
    else:
        st.success("✅ Low Risk: Customer is likely to stay.")
        if prob is not None:
            st.metric("Retention Probability", f"{1-prob:.2%}")
