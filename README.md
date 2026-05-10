# 🍔 Food Delivery Business Analytics

A complete end-to-end data analytics project on a simulated Indian food delivery platform — covering data cleaning, SQL analysis, and an interactive Power BI dashboard.

---

## 📌 Project Overview

This project analyzes **20,000 orders** across **10 Indian cities** to uncover business insights around revenue, customer behavior, restaurant performance, delivery operations, and cancellation patterns.

**Tools & Technologies used:**

* **Python** — Data Cleaning & Preprocessing
* **Pandas** — Data Manipulation
* **MySQL** — Business Analysis
* **Power BI** — Dashboard & Visualization

---

## 📁 Project Structure

```
food-delivery-analytics/
│
├── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   └── (orders.csv, delivery.csv, restaurants.csv)
│   └── cleaned/
│       ├── customers_cleaned.csv
│       ├── orders_cleaned.csv
│       ├── delivery_cleaned.csv
│       └── restaurants_cleaned.csv
│
├── notebooks/
│   ├── customers_dataset_jupyter_cleaning.ipynb
│   ├── order_dataset_jupyter_cleaning.ipynb
│   ├── delivery_dataset_jupyter_cleaning.ipynb
│   ├── restaurants_dataset_cleaned_jupyter.ipynb
│   └── mysql_data_upload.ipynb
│
├── sql/
│   └── Sql_Analysis.sql
│
├── dashboard/
│   ├── food_delivery_dashboard.pbix
│   ├── dashboard_page1.png
│   ├── dashboard_page2.png
│   └── dashboard_page3.png
│
└── README.md
```

---

## 📊 Datasets

| Dataset | Records | Columns | Description |
|---|---|---|---|
| `customers.csv` | 5,000 | 11 | Customer profiles, segments, activity |
| `orders.csv` | 20,000 | 19 | Orders, payments, amounts, status |
| `delivery.csv` | 20,000 | 9 | Delivery partner, time, distance, weather |
| `restaurants.csv` | 500 | 11 | Restaurant info, ratings, cuisine, commission |

---

## 🧹 Data Cleaning (Python / Pandas)

Each dataset was cleaned in a separate Jupyter Notebook. Steps performed:

- **Null value handling** — mode imputation for `payment_method`, median for `customer_rating`
- **Duplicate detection** — confirmed 0 duplicates across all datasets
- **Data type conversion** — `order_date` to datetime, `order_time` to time object
- **Data validation** — age range (18–100), future signup date detection & removal, rating range (1–5)
- **Feature engineering** — new columns added per dataset:

| Dataset | New Features Created |
|---|---|
| Customers | `age_group`, `high_value_customer`, `customer_tenure_days`, `order_frequency` |
| Orders | `order_month`, `order_day`, `order_hour`, `time_of_day`, `estimated_cost`, `profit`, `is_cancelled`, `is_high_value_order` |
| Delivery | `delivery_speed`, `long_distance_order`, `high_traffic`, `bad_weather`, `is_delivered`, `high_risk_delivery` |
| Restaurants | `high_rated`, `expensive_restaurant`, `fast_prep`, `rating_category`, `commission_tier`, `high_performer` |

---

## 🗄️ SQL Analysis

Cleaned CSVs were uploaded to a **MySQL database** (`food_delivery_analysis`) using SQLAlchemy + PyMySQL, then queried in `Sql_Analysis.sql`.

### Key Queries & Insights

**💰 Business Overview**
| Metric | Result |
|---|---|
| Total Revenue | ₹1.81 Crore |
| Total Profit | ₹1.38 Crore (~76% margin) |
| Total Orders | 20,000 |
| Avg Order Value | ₹908 |
| Total Discounts Given | ₹31.98 Lakh (17.6% of revenue) |

**👥 Customer Analysis**
- Regular customers are the highest revenue segment — ₹81.5 Lakh from 2,208 users
- 90.4% of users are active (4,521 out of 5,000) — strong retention rate
- 479 inactive users are a re-engagement opportunity

**🏙️ City Analysis**
- Bangalore leads in both revenue (₹20.8 Lakh) and profit (₹15.7 Lakh)
- All top 5 cities maintain a consistent ~75% profit margin
- Jaipur shows higher discount dependency compared to other cities

**🍽️ Restaurant & Cuisine Analysis**
- Arya LLC Kitchen is the top revenue-generating restaurant (₹75,242)
- Pizza is the top-performing cuisine — ₹21.25 Lakh revenue, ₹16.16 Lakh profit
- Healthy Food ranks last — potential premium growth opportunity

**🚚 Delivery Analysis**
- 12.69% of orders face late delivery (>60 minutes)
- Rainy/Stormy weather increases avg delivery time by ~31–32% vs clear weather
- High traffic is the single biggest delay factor — 55.7 min avg vs ~38 min in low traffic

**❌ Cancellation Analysis**
- Cash on Delivery has a 17.88% cancellation rate — more than **double** digital payment methods (~7.5–8%)
- Incentivizing UPI/Wallet payments could significantly reduce cancellations

---

## 📈 Power BI Dashboard

A 3-page interactive dashboard with city and cuisine filters, and monthly slicers.

### Page 1 — Executive Business Overview
![Executive Business Overview](dashboard_page1.png)

KPIs: Total Revenue · Total Profit · Total Orders · Avg Order Value · Cancellation % · Late Delivery %

Charts: Revenue vs Profit by City · Monthly Business Performance · Order Status Distribution · Order Volume by Hour

---

### Page 2 — Customer & Sales Intelligence
![Customer & Sales Intelligence](dashboard_page2.png)

KPIs: Repeat Customer % · Avg Customer Spend · Premium Customers · Active Customers · High Value Customers

Charts: Revenue by Customer Segment · Orders by Segment · Revenue & Profit by Segment · Customer Distribution by Age Group · Revenue by Payment Method

---

### Page 3 — Delivery & Operational Performance
![Delivery & Operational Performance](dashboard_page3.png)

KPIs: Avg Delivery Time · Late Delivery % · Avg Delivery Distance · Cancelled Orders · Refund Orders

Charts: Operational Load by Hour · Cities with Highest Late Deliveries · Monthly Delivery Time Trend · Delivery Status by City

---

## ⚙️ How to Run This Project

### 1. Data Cleaning (Python)
```bash
pip install pandas numpy
# Open and run each notebook in the notebooks/ folder
```

### 2. Upload to MySQL
```bash
pip install sqlalchemy pymysql
# Update the connection string in mysql_data_upload.ipynb with your credentials
# engine = create_engine("mysql+pymysql://YOUR_USER:YOUR_PASSWORD@localhost/food_delivery_analysis")
# Run all cells
```

### 3. SQL Analysis
```
# Open Sql_Analysis.sql in MySQL Workbench
# Run queries section by section
```

### 4. Power BI Dashboard
```
# Open food_delivery_dashboard.pbix in Power BI Desktop
# Refresh data source if needed
```

---

## 💡 Key Business Recommendations

1. **Reduce COD orders** — COD cancellation rate is 2× higher than digital payments; offer cashback on UPI/Wallet to shift behavior
2. **Re-engage inactive customers** — 479 inactive users can be targeted with personalized push campaigns
3. **Weather-based ops planning** — Pre-assign more delivery partners during Rainy/Storm forecasts to reduce delays
4. **Leverage Bangalore's success** — Study what makes Bangalore's order economics superior and replicate in lower-performing cities like Lucknow
5. **Promote Healthy Food segment** — Currently the lowest revenue cuisine; premium positioning or health-focused campaigns can unlock this segment
