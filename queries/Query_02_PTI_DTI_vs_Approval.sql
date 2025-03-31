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