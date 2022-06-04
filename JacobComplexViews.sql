USE INFO430_Proj_08

-- FIND THE TOP INDUSTRIES BY SUM_SALARY OF ENTRY LEVEL JOBS
WITH CTE_INDUSTRIES_BY_SUM_SALARY_OF_ENTRY_LEVEL_JOBS
AS (
	SELECT I.IndustryName, SUM(J.Salary) AS Compensaton_Sum
	FROM tblIndustry I
		JOIN tblEmployer E ON I.IndustryID = E.IndustryID
		JOIN tblJob J ON E.EmployerID = J.EmployerID
		JOIN tblLevel L ON J.LevelID = L.LevelID
	WHERE L.LevelName = 'Entry-level'
	GROUP BY I.IndustryName)
SELECT IndustryName, Compensaton_Sum
FROM CTE_INDUSTRIES_BY_SUM_SALARY_OF_ENTRY_LEVEL_JOBS
ORDER BY Compensaton_Sum
GO

CREATE VIEW INDUSTRIES_BY_SUM_SALARY_OF_ENTRY_LEVEL_JOBS AS (
	SELECT I.IndustryName, SUM(J.Salary) AS Compensaton_Sum
	FROM tblIndustry I
		JOIN tblEmployer E ON I.IndustryID = E.IndustryID
		JOIN tblJob J ON E.EmployerID = J.EmployerID
		JOIN tblLevel L ON J.LevelID = L.LevelID
	WHERE L.LevelName = 'Entry-level'
	GROUP BY I.IndustryName
)

GO


-- FIND THE TOP 10 CXO JOBS BY SALARY IN INFORMATION TECHNOLOGY
WITH CTE_TOP_10_CXO_JOBS_BY_SALARY_IN_INFORMATION_TECHNOLOGY
AS (
	SELECT TOP 10 J.JobTitle, J.Salary, P.PositionName
	FROM tblJob J
		JOIN tblEmployer E ON J.EmployerID = E.EmployerID
		JOIN tblIndustry I ON E.IndustryID = I.IndustryID
		JOIN tblLevel L ON J.LevelID = L.LevelID
		JOIN tblPosition P ON J.PositionID = P.PositionID
	WHERE I.IndustryName = 'Information Technology' AND P.PositionName LIKE '%CHIEF%'
	ORDER BY J.Salary DESC
)
SELECT JobTitle, Salary, PositionName
FROM CTE_TOP_25_CXO_JOBS_BY_SALARY_IN_INFORMATION_TECHNOLOGY
ORDER BY Salary
GO


CREATE VIEW TOP_10_CXO_JOBS_BY_SALARY_IN_INFORMATION_TECHNOLOGY AS (
	SELECT TOP 10 J.JobTitle, J.Salary, P.PositionName
	FROM tblJob J
		JOIN tblEmployer E ON J.EmployerID = E.EmployerID
		JOIN tblIndustry I ON E.IndustryID = I.IndustryID
		JOIN tblLevel L ON J.LevelID = L.LevelID
		JOIN tblPosition P ON J.PositionID = P.PositionID
	WHERE I.IndustryName = 'Information Technology' AND P.PositionName LIKE '%CHIEF%'
	ORDER BY J.Salary DESC
)