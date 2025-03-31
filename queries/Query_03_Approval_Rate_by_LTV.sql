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