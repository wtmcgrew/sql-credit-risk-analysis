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