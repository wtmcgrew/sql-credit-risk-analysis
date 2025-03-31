-- ==========================================================================
-- Project: Credit Approval Risk Analysis Using SQL
-- Author: Whitney McGrew
-- Description: This SQL script analyzes mock auto loan application data
--              to identify trends in approval decisions based on credit
--              risk factors: FICO, PTI, DTI, LTV, Late Payments.
-- ==========================================================================

-- ============================================================
-- QUERY 1: What is the approval rate by FICO band?
-- ============================================================

-- Create FICO bands and calculate approval rate by band
SELECT
  CASE
  	WHEN fico_score BETWEEN 580 AND 619 THEN '580-619'
  	WHEN fico_score BETWEEN 620 AND 659 THEN '620-659'
  	WHEN fico_score BETWEEN 660 AND 699 THEN '660-699'
  	WHEN fico_score BETWEEN 700 AND 739 THEN '700-739'
  	WHEN fico_score BETWEEN 740 AND 800 THEN '740-800'
  	ELSE 'Unknown'
  END AS fico_band,
  COUNT(*) AS total_apps,
  SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) AS approved_apps,
  ROUND(100.0 * SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END)
  / COUNT(*), 2) AS approval_rate_pct
FROM loan_applications
GROUP BY fico_band
ORDER BY fico_band;

-- ============================================================
-- QUERY 2: Are applicants with high PTI/DTI more likely to be declined?
-- ============================================================

-- Create PTI and DTI bands and calcuate decline rates by band
SELECT
  CASE
  	WHEN ROUND((monthly_auto_payment / monthly_income) * 100, 2) < 10 THEN '<10%'
  	WHEN ROUND((monthly_auto_payment / monthly_income) * 100, 2) < 15 THEN '<15%'
  	WHEN ROUND((monthly_auto_payment / monthly_income) * 100, 2) < 18 THEN '15-18%'
  	ELSE '18%+ (High Risk)'
  END AS pti_band,
  CASE
  	WHEN ROUND((total_monthly_debt / monthly_income) * 100, 2) < 30 THEN '<30%'
  	WHEN ROUND((total_monthly_debt / monthly_income) * 100, 2) < 50 THEN '30-50%'
  	WHEN ROUND((total_monthly_debt / monthly_income) * 100, 2) < 70 THEN '50-70%'
  	ELSE '70%+ (Exceeds Cap)'
  END AS dti_band,
  approval_status,
  COUNT(*) AS app_count
FROM loan_applications
GROUP BY pti_band, dti_band, approval_status
ORDER BY pti_band, dti_band;

-- ============================================================
-- QUERY 3: How does LTV affect approval outcomes?
-- ============================================================

-- Calculate LTV and group by LTV bands to evalaute approval impact
SELECT
  CASE
  	WHEN(requested_loan_amount * 1.0) / vehicle_value <  0.90 THEN '<90%'
  	WHEN(requested_loan_amount * 1.0) / vehicle_value >= 0.90 AND (requested_loan_amount * 1.0) / vehicle_value <  1.00 THEN '90-100%'
  	WHEN(requested_loan_amount * 1.0) / vehicle_value >= 1.00 AND (requested_loan_amount * 1.0) / vehicle_value <= 1.30 THEN '100-130%'
  	WHEN(requested_loan_amount * 1.0) / vehicle_value  > 1.30 AND (requested_loan_amount * 1.0) / vehicle_value <= 1.50 THEN '130-150%'
  	ELSE '>150%'
  END AS ltv_band,
  SUM(CASE WHEN approval_status  = 'Approved' THEN 1 ELSE 0 END) AS approved,
  SUM(CASE WHEN approval_status  = 'Declined' THEN 1 ELSE 0 END) AS declined,
  COUNT(*) AS total_apps,
  ROUND(CAST(SUM(CASE WHEN approval_status = 'Declined' THEN 1 ELSE 0 END) AS float)
  / COUNT(*) * 100, 2) AS decline_rate
FROM loan_applications
WHERE vehicle_value > 0
GROUP BY ltv_band
ORDER BY decline_rate DESC;

-- ============================================================
-- QUERY 4: Do late payments impact approval rates?
-- ============================================================

-- Group by late payment bands and analyze approval outcomes
SELECT
  CASE
  	WHEN late_payments_12mo = 0             THEN '0 Late Payments'
  	WHEN late_payments_12mo BETWEEN 1 AND 2 THEN '1-2 Late Payments'
  	WHEN late_payments_12mo BETWEEN 3 AND 4 THEN '3-4 Late Payments'
  	ELSE '3+ Late Payments'
  END AS delinquency_band,
  SUM(CASE WHEN approval_status = 'Approved' THEN 1 ELSE 0 END) AS approved,
  SUM(CASE WHEN approval_status = 'Declined' THEN 1 ELSE 0 END) AS declined,
  COUNT(*) AS total_apps,
  ROUND(CAST(SUM(CASE WHEN approval_status = 'Declined' THEN 1 ELSE 0 END) AS float)
  / COUNT(*) * 100, 2) AS decline_rate
FROM loan_applications
GROUP BY delinquency_band
ORDER BY decline_rate DESC;

-- ============================================================
-- QUERY 5: What is the profile of a ‘safe’ applicant?
-- ============================================================

-- Calculate average credit profile metrics for approval vs. declined applicants
SELECT
  approval_status, 
  ROUND(AVG(fico_score), 0) AS avg_fico,
  ROUND(AVG(monthly_auto_payment / monthly_income) * 100, 2) AS avg_pti_percent,
  ROUND(AVG(total_monthly_debt / monthly_income) * 100, 2) AS avg_dti_percent,
  ROUND(AVG(requested_loan_amount / vehicle_value) * 100, 2) AS avg_ltv_percent,
  ROUND(AVG(late_payments_12mo), 2) AS avg_late_pays
FROM loan_applications
GROUP BY approval_status
ORDER BY approval_status;
