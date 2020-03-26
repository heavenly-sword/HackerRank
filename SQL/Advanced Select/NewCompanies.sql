SELECT DISTINCT C.company_code, founder, LM, SM, MGR, EMP
FROM Company C INNER JOIN 
	(
		SELECT COUNT(DISTINCT lead_manager_code) AS LM,
		company_code
		FROM Lead_Manager
		GROUP BY company_code
	) L ON C.company_code = L.company_code
    INNER JOIN 
	(
		SELECT COUNT(DISTINCT senior_manager_code) AS SM,
		company_code
		FROM Senior_Manager
		GROUP BY company_code
	) S ON C.company_code = S.company_code
	INNER JOIN 
	(
		SELECT COUNT(DISTINCT manager_code) AS MGR,
		company_code
		FROM Manager
		GROUP BY company_code
	) M ON C.company_code = M.company_code
	INNER JOIN 
	(
		SELECT COUNT(DISTINCT employee_code) AS EMP,
		company_code
		FROM Employee 
		GROUP BY company_code
	) E ON C.company_code = E.company_code
ORDER BY C.company_code;