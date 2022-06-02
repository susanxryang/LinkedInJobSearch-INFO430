USE INFO430_Proj_08

-- Complex query: rank the top 10 industries by the number of OPEN job postings 
WITH
    CTE_TOP_IND_POSTING(IndustryID, IndustryName, RankingPosting)
    AS
    (
        SELECT I.IndustryID, I.IndustryName,
            RANK() OVER (ORDER BY COUNT(J.JobID) DESC) AS RankingPosting
        FROM tblIndustry I
            JOIN tblEmployer E ON I.IndustryID = E.IndustryID
            JOIN tblJob J ON E.EmployerID = J.EmployerID
            JOIN tblJobStatus JS ON JS.JobID = J.JobID
            JOIN tblStatus S ON S.StatusID = JS.StatusID
        WHERE S.StatusName = 'Open'
        GROUP BY I.IndustryID, I.IndustryName
    )
SELECT IndustryID, IndustryName, RankingPosting
FROM CTE_TOP_IND_POSTING
WHERE RankingPosting <= 10
ORDER BY RankingPosting
GO

CREATE VIEW TOP_IND_POSTING AS (
        SELECT I.IndustryID, I.IndustryName,
            RANK() OVER (ORDER BY COUNT(J.JobID) DESC) AS RankingPosting
        FROM tblIndustry I
            JOIN tblEmployer E ON I.IndustryID = E.IndustryID
            JOIN tblJob J ON E.EmployerID = J.EmployerID
            JOIN tblJobStatus JS ON JS.JobID = J.JobID
            JOIN tblStatus S ON S.StatusID = JS.StatusID
        WHERE S.StatusName = 'Open'
        GROUP BY I.IndustryID, I.IndustryName
    )
GO

-- Complex query: rank the companies with the highest average pay
WITH
    CTE_TOP_EMP_SAL(EmployerID, EmployerName, AvgSalary, RankingSalary)
    AS
    (
        SELECT E.EmployerID, E.EmployerName, SUM(J.Salary)/COUNT(J.JobID) AS AvgSalary,
            RANK() OVER (ORDER BY SUM(J.Salary)/COUNT(J.JobID) DESC) AS RankingPosting
        FROM tblEmployer E
            JOIN tblJob J ON E.EmployerID = J.EmployerID
        GROUP BY E.EmployerID, E.EmployerName
    )
SELECT EmployerID, EmployerName, AvgSalary, RankingSalary
FROM CTE_TOP_EMP_SAL
ORDER BY RankingSalary
GO

CREATE VIEW TOP_EMP_SAL AS (
        SELECT E.EmployerID, E.EmployerName, SUM(J.Salary)/COUNT(J.JobID) AS AvgSalary,
            RANK() OVER (ORDER BY SUM(J.Salary)/COUNT(J.JobID) DESC) AS RankingPosting
        FROM tblEmployer E
            JOIN tblJob J ON E.EmployerID = J.EmployerID
        GROUP BY E.EmployerID, E.EmployerName
    )
GO

-- SELECT * FROM TOP_EMP_SAL


-- Complex query: rank the companies with the highest average pay for intership
WITH
    CTE_TOP_EMP_SAL_INTERN(EmployerID, EmployerName, AvgSalary, RankingSalary)
    AS
    (
        SELECT E.EmployerID, E.EmployerName, SUM(J.Salary)/COUNT(J.JobID) AS AvgSalary,
            RANK() OVER (ORDER BY SUM(J.Salary)/COUNT(J.JobID) DESC) AS RankingPosting
        FROM tblEmployer E
            JOIN tblJob J ON E.EmployerID = J.EmployerID
            JOIN tblJobType JT ON J.JobTypeID = JT.JobTypeID
        WHERE JT.JobTypeName = 'Internship'
        GROUP BY E.EmployerID, E.EmployerName
    )
SELECT EmployerID, EmployerName, AvgSalary, RankingSalary
FROM CTE_TOP_EMP_SAL_INTERN
ORDER BY RankingSalary
GO

CREATE VIEW TOP_EMP_SAL_INTERN AS (
        SELECT E.EmployerID, E.EmployerName, SUM(J.Salary)/COUNT(J.JobID) AS AvgSalary,
            RANK() OVER (ORDER BY SUM(J.Salary)/COUNT(J.JobID) DESC) AS RankingPosting
        FROM tblEmployer E
            JOIN tblJob J ON E.EmployerID = J.EmployerID
            JOIN tblJobType JT ON J.JobTypeID = JT.JobTypeID
        WHERE JT.JobTypeName = 'Internship'
        GROUP BY E.EmployerID, E.EmployerName
    )
GO

-- SELECT * FROM TOP_EMP_SAL_INTERN