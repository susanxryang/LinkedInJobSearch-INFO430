use INFO430_Proj_08
-- scripting index
SELECT * FROM tblJobStatus


select * from tblMembership

-- populating location
-- INSERT INTO tblLocation (City, Country)
-- SELECT DISTINCT TOP 1000 CustomerCity, 'USA' FROM PEEPS.dbo.tblCUSTOMER

-- populating position
INSERT INTO tblPosition (PositionName)
VALUES ('Marketing Specialist'),
('Marketing Manager'),
('Marketing Director'),
('Graphic Designer'),
('Marketing Research Analyst'),
('Marketing Communications Manager'),
('Marketing Consultant'),
('Product Manager'),
('Public Relations'),
('Social Media Assistant'),
('Brand Manager'),
('SEO Manager'),
('Content Marketing Manager'),
('Copywriter'),
('Media Buyer'),
('Digital Marketing Manager'),
('eCommerce Marketing Specialist'),
('Brand Strategist'),
('Vice President of Marketing'),
('Media Relations Coordinator'),
('Administrative Assistant'),
('Receptionist'),
('Office Manager'),
('Auditing Clerk'),
('Bookkeeper'),
('Account Executive'),
('Branch Manager'),
('Business Manager'),
('Quality Control Coordinator'),
('Administrative Manager'),
('Chief Executive Officer'),
('Business Analyst'),
('Risk Manager'),
('Human Resources'),
('Office Assistant'),
('Secretary'),
('Office Clerk'),
('File Clerk'),
('Account Collector'),
('Administrative Specialist'),
('Executive Assistant'),
('Program Administrator'),
('Program Manager'),
('Administrative Analyst'),
('Data Entry'),
('CEO—Chief Executive Officer'),
('COO—Chief Operating Officer'),
('CFO—Chief Financial Officer'),
('CIO—Chief Information Officer'),
('CTO—Chief Technology Officer'),
('CMO—Chief Marketing Officer'),
('CHRO—Chief Human Resources Officer'),
('CDO—Chief Data Officer'),
('CPO—Chief Product Officer'),
('CCO—Chief Customer Officer'),
('IT Professional'),
('UX Designer & UI Developer'),
('SQL Developer'),
('Web Designer'),
('Web Developer'),
('Help Desk Worker/Desktop Support'),
('Software Engineer'),
('Data Entry'),
('DevOps Engineer'),
('Computer Programmer'),
('Network Administrator'),
('Information Security Analyst'),
('Artificial Intelligence Engineer'),
('Cloud Architect'),
('IT Manager'),
('Technical Specialist'),
('Application Developer'),
('Sales Associate'),
('Sales Representative'),
('Sales Manager'),
('Retail Worker'),
('Store Manager'),
('Sales Representative'),
('Real Estate Broker'),
('Sales Associate'),
('Cashier'),
('Store Manager'),
('Account Executive'),
('Account Manager'),
('Area Sales Manager'),
('Direct Salesperson'),
('Director of Inside Sales'),
('Outside Sales Manager'),
('Sales Analyst'),
('Market Development Manager'),
('B2B Sales Specialist'),
('Sales Engineer'),
('Merchandising Associate'),
('Construction Worker'),
('Taper'),
('Plumber'),
('Heavy Equipment Operator'),
('Vehicle or Equipment Cleaner'),
('Carpenter'),
('Electrician'),
('Painter'),
('Welder'),
('Handyman'),
('Boilermaker'),
('Crane Operator'),
('Building Inspector'),
('Pipefitter'),
('Sheet Metal Worker'),
('Iron Worker'),
('Mason'),
('Roofer'),
('Solar Photovoltaic Installer'),
('Well Driller'),
('Virtual Assistant'),
('Customer Service'),
('Customer Support'),
('Concierge'),
('Help Desk'),
('Customer Service Manager'),
('Technical Support Specialist'),
('Account Representative'),
('Client Service Specialist'),
('Customer Care Associate'),
('Operations Manager'),
('Operations Assistant'),
('Operations Coordinator'),
('Operations Analyst'),
('Operations Director'),
('Vice President of Operations'),
('Operations Professional'),
('Scrum Master'),
('Continuous Improvement Lead'),
('Continuous Improvement Consultant'),
('Credit Authorizer'),
('Benefits Manager'),
('Credit Counselor'),
('Accountant'),
('Bookkeeper'),
('Accounting Analyst'),
('Accounting Director'),
('Accounts Payable/Receivable Clerk'),
('Auditor'),
('Budget Analyst'),
('Controller'),
('Financial Analyst'),
('Finance Manager'),
('Economist'),
('Payroll Manager'),
('Payroll Clerk'),
('Financial Planner'),
('Financial Services Representative'),
('Finance Director'),
('Commercial Loan Officer'),
('Engineer'),
('Mechanical Engineer'),
('Civil Engineer'),
('Electrical Engineer'),
('Assistant Engineer'),
('Chemical Engineer'),
('Chief Engineer'),
('Drafter'),
('Engineering Technician'),
('Geological Engineer'),
('Biological Engineer'),
('Maintenance Engineer'),
('Mining Engineer'),
('Nuclear Engineer'),
('Petroleum Engineer'),
('Plant Engineer'),
('Production Engineer'),
('Quality Engineer'),
('Safety Engineer'),
('Sales Engineer'),
('Researcher'),
('Research Assistant'),
('Data Analyst'),
('Business Analyst'),
('Financial Analyst'),
('Biostatistician'),
('Title Researcher'),
('Market Researcher'),
('Title Analyst'),
('Medical Researcher'),
('Mentor'),
('Tutor/Online Tutor'),
('Teacher'),
('Teaching Assistant'),
('Substitute Teacher'),
('Preschool Teacher'),
('Test Scorer'),
('Online ESL Instructor'),
('Professor'),
('Assistant Professor')
GO


CREATE PROCEDURE getJobID 
@JobTitle varchar(100),
@JobID INT OUTPUT
AS
SET @JobID = (SELECT JobID
   FROM tblJob
   WHERE JobTitle = @JobTitle)
GO

CREATE PROCEDURE getEmployerID 
@EMPNAME varchar(50),
@EMPID INT OUTPUT
AS
SET @EMPID = (SELECT EmployerID
   FROM tblEmployer
   WHERE EmployerName = @EMPNAME)
GO


CREATE PROCEDURE getJobTypeID 
@JTNAME varchar(50),
@JTID INT OUTPUT
AS
SET @JTID = (SELECT JobTypeID
   FROM tblJobType
   WHERE JobTypeName = @JTNAME)
GO

-- -- Procedure for inserting specific rows into JobStatus
-- CREATE PROCEDURE insertIntoJobs
-- @SALARY INTEGER,
-- @NUMAPP INTEGER,
-- @DESC INTEGER,
-- @TITLE INTEGER,
-- @EMPNAME varchar(50),
-- @JobType_ID INT,
-- @Level_ID INT, 
-- @Employer_ID INT, 
-- @Position_ID INT
-- AS
-- DECLARE @JobType_ID INT, @Level_ID INT, @Employer_ID INT, @Position_ID INT

-- EXEC getEmployerID
-- @JobTypeID = @JobType_ID,
-- @LevelID = @Level_ID,
-- @EmployerID = @Employer_ID,
-- @PositionID = @Position_ID,
-- @J_ID = @Job_ID OUTPUT

-- IF @Job_ID IS NULL
-- 	BEGIN
-- 		PRINT '@Job_ID is NULL';
-- 		THROW 55658, 'Job_ID cannot be NULL, process terminating', 1;
-- 	END

-- EXEC strozj_getStatusID
-- @StatusName = @Status_Name,
-- @S_ID = @Status_ID OUTPUT

-- IF @Status_ID IS NULL
-- 	BEGIN
-- 		PRINT '@Status_ID is NULL';
-- 		THROW 55658, 'Status_ID cannot be NULL, process terminating', 1;
-- 	END

-- BEGIN TRANSACTION T1
-- INSERT INTO tblJobStatus
-- VALUES(@Job_ID, @Status_ID, @StartDate, @EndDate)

-- IF @@ERROR <> 0
-- 	BEGIN
-- 		PRINT '@@ERROR does not equal 0, process terminating'
-- 		ROLLBACK TRANSACTION T1
-- 	END
-- ELSE
-- 	COMMIT TRANSACTION T1

-- GO

-- Procedure for generating a job status off of existing IDs
ALTER PROCEDURE insertIntoJobs
AS
DECLARE
@Title varchar(255),
@RANDSal INT,
@RANDType INT,
@RANDLev INT, 
@RANDEmp varchar(50), 
@RANDEmpID INT, 
@RANDPos INT, 
@RUN INT
SET @RUN = 100000

WHILE @RUN > 0
	BEGIN

		SET @RANDSal = (SELECT CEILING(20000 + RAND() * 100000))
		SET @RANDType = (SELECT CEILING(RAND() * (SELECT COUNT(*) FROM tblJobType)))
		SET @RANDLev = (SELECT CEILING(RAND() * (SELECT COUNT(*) FROM tblLevel)))
		SET @RANDEmpID = (SELECT CEILING(RAND() * (SELECT COUNT(*) FROM tblEmployer)))
		SET @RANDEmp = (SELECT EmployerName FROM tblEmployer WHERE EmployerID = @RANDEmpID)
        SET @RANDPos = (SELECT CEILING(RAND() * (SELECT COUNT(*) FROM tblPosition)))
		SET @Title = CONCAT(@RANDEmp, '') + '-' + CONCAT(@RANDPos,'') + '-' + CONCAT(CEILING(RAND() * 99999),'')

        INSERT INTO tblJob
            (JobTitle, JobTypeID, LevelID, EmployerID, Salary, PositionID)
        VALUES
            (@Title, @RANDType, @RANDLev, @RANDEmpID, @RANDSal, @RANDPos)
		SET @RUN = @RUN - 1
	END
GO

-- DELETE FROM tblJob
-- DBCC CHECKIDENT(tblJob, RESEED, 0)

SELECT COUNT(*) FROM tblJob
EXEC insertIntoJobs
SELECT * FROM tblJob
GO

-- declare @randStr VARCHAR(50)
-- set @randStr = 'hello'
-- declare @randNum INT
-- set @randNum = 75
-- declare @concat VARCHAR(50)
-- set @concat = CONCAT(@randStr, '') + '-' + CONCAT(@randNum, '') + CONCAT(CEILING(RAND() * 99999), '')