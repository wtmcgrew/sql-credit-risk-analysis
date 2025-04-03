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











