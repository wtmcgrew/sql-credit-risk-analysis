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