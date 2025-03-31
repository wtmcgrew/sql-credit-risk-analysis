# Credit Approval Risk Analysis Using SQL

## 📊 Project Overview
This project analyzes mock auto loan application data to explore how key credit risk factors—FICO score, PTI, DTI, LTV, and late payments—influence loan approval decisions. The goal is to simulate real-world underwriting logic using SQL and Excel to surface trends and risk signals.

## 🎯 Objective
To identify common traits of approved vs. declined applicants using SQL queries and data visualization, and to create a clean, portfolio-ready case study demonstrating credit risk analysis skills.

## 🧰 Tools Used
- SQL (SQLite via DBeaver)
- Microsoft Excel (data analysis + visuals)
- GitHub (project documentation)

## 📂 Folder Structure
```
Auto Loan Risk Analysis/
├── data/           # CSV + Excel files
├── queries/        # Individual exploratory SQL files
├── visuals/        # Final PNG screenshots of charts + tables
├── sql_credit_risk_project.sql  # Master SQL script
├── README.md       # This file
```

## 📌 Key Business Questions
1. What is the approval rate by FICO band?
2. Are applicants with high PTI and/or DTI more likely to be declined?
3. How does LTV affect approval outcomes?
4. Do late payments within the last 12 months impact approval rates?
5. What’s the profile of a 'safe' applicant based on common approval traits?

## 🔍 Summary of Insights
- **DTI (%)** showed the strongest correlation with loan decline decisions (13% avg gap).
- **PTI (%)** didn’t show as strong a trend, indicating higher tolerance for monthly payment size.
- **LTV (%)** mattered more at extreme levels (e.g. >130%).
- Even **1–2 late payments** significantly impacted approval odds.
- Approved applicants averaged **higher FICO**, **lower DTI**, and **cleaner credit history**.

## 📈 Visuals
All charts and tables were created in Excel and exported to PNG format. You can find them in the `/visuals/` folder:
- Approval Rate by FICO Band
- Decline Rate by PTI and DTI Bands
- Decline Rate by LTV Band
- Decline Rate by Recent Late Payments
- Side-by-side Profile Comparison (Approved vs. Declined)

## ✅ How to Reproduce
1. Open `sql_credit_risk_project.sql` in any SQL editor (e.g., DBeaver)
2. Run each query to explore the data
3. Open Excel files in `/data/` to view or recreate the charts

## 💼 Author
Whitney McGrew — Senior Credit Analyst | SQL Enthusiast | Credit Risk Professional

Connect with me on [LinkedIn](https://www.linkedin.com/in/whitneymcgrew/)

