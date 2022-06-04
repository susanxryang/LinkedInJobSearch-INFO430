-- TEAM 8: Susan, Jerray, Jacob, Jason
-- LinkedIn Job Search DB

CREATE DATABASE INFO430_Proj_08
BACKUP DATABASE INFO430_Proj_08 TO DISK = 'C:\SQL\INFO430_Proj_08.BAK'

USE INFO430_Proj_08
GO

-- CREATE TABLE


-- tblUerType --
CREATE TABLE tblUserType
(UserTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
UserTypeName VARCHAR(50) NOT NULL,
UserTypeDescr VARCHAR(200) NULL);
 
-- tblMembership --
CREATE TABLE tblMembershipType
(MembershipTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
MembershipTypeName VARCHAR(50) NOT NULL,
MembershipTypeDescr VARCHAR(200) NULL);

-- tblGender --
CREATE TABLE tblGender
(GenderID INTEGER IDENTITY(1,1) PRIMARY KEY,
GenderName VARCHAR(50) NOT NULL,
Pronouns VARCHAR(50) NOT NULL);
 
-- tblUser--
CREATE TABLE tblUser
(UserID INTEGER IDENTITY(1,1) PRIMARY KEY,
UserFname VARCHAR(50) NOT NULL,
UserLname VARCHAR(50) NOT NULL,
UserTypeID INTEGER FOREIGN KEY(UserTypeID) REFERENCES tblUserType(UserTypeID),
GenderID INTEGER FOREIGN KEY(GenderID) REFERENCES tblGender(GenderID),
UserDOB Date NOT NULL);

-- ALTER TABLE tblUser DROP FOREIGN KEY MembershipID;

-- DROP TABLE tblMembership
-- drop table tblUser
-- DROP TABLE IF EXISTS tblMembership,tblUser;

-- tblMembership --
CREATE TABLE tblMembership
(MembershipID INTEGER IDENTITY(1,1) PRIMARY KEY,
MembershipTypeID INTEGER FOREIGN KEY(MembershipTypeID) REFERENCES tblMembershipType(MembershipTypeID),
UserID INTEGER FOREIGN KEY(UserID) REFERENCES tblUser(UserID),
StartDate Date NOT NULL,
EndDate Date NOT NULL);
 
-- tblSeekingStatus --
CREATE TABLE tblSeekingStatus
(SeekingStatusID INTEGER IDENTITY(1,1) PRIMARY KEY,
SeekingStatusName VARCHAR(50) NOT NULL,
SeekingStatusDescr VARCHAR(200) NULL);


-- DROP TABLE tblUserSeekingStatus
-- tblUserSeekingStatus --
CREATE TABLE tblUserSeekingStatus
(UserSeekingStatusID INTEGER IDENTITY(1,1) PRIMARY KEY,
SeekingStatusID INTEGER FOREIGN KEY(SeekingStatusID) REFERENCES tblSeekingStatus(SeekingStatusID),
UserID INTEGER FOREIGN KEY(UserID) REFERENCES tblUser(UserID),
StartDate Date NOT NULL,
EndDate Date NOT NULL);

-- tblJobType --
CREATE TABLE tblJobType
(JobTypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
JobTypeName VARCHAR(50) NOT NULL,
JobTypeDescr VARCHAR(200) NULL);
 
-- tblLevel --
CREATE TABLE tblLevel
(LevelID INTEGER IDENTITY(1,1) PRIMARY KEY,
LevelName VARCHAR(50) NOT NULL,
LevelDescr VARCHAR(200) NULL);
 
-- tblPosition --
CREATE TABLE tblPosition
(PositionID INTEGER IDENTITY(1,1) PRIMARY KEY,
PositionName VARCHAR(50) NOT NULL,
PositionDescr VARCHAR(200) NULL);
 
-- tblLocation --
CREATE TABLE tblLocation
(LocationID INTEGER IDENTITY(1,1) PRIMARY KEY,
Country VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL);

-- tblEmployerSize --
CREATE TABLE tblEmployerSize
(EmployerSizeID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployerSizeName VARCHAR(50) NOT NULL,
NumRange INT NOT NULL);
 
-- tblIndustry --
CREATE TABLE tblIndustry
(IndustryID INTEGER IDENTITY(1,1) PRIMARY KEY,
IndustryName VARCHAR(50) NOT NULL);
 
-- tblEmployer --
CREATE TABLE tblEmployer
(EmployerID INTEGER IDENTITY(1,1) PRIMARY KEY,
EmployerName VARCHAR(50) NOT NULL,
EmployerDescr VARCHAR(200) NULL,
LocationID INTEGER FOREIGN KEY(LocationID) REFERENCES tblLocation(LocationID),
EmployerSizeID INTEGER FOREIGN KEY(EmployerSizeID) REFERENCES tblEmployerSize(EmployerSizeID),
IndustryID INTEGER FOREIGN KEY(IndustryID) REFERENCES tblIndustry(IndustryID));
 
-- tblJob --
CREATE TABLE tblJob
(JobID INTEGER IDENTITY(1,1) PRIMARY KEY,
JobTitle VARCHAR(255) NOT NULL,
JobTypeID INTEGER FOREIGN KEY(JobTypeID) REFERENCES tblJobType(JobTypeID),
LevelID INTEGER FOREIGN KEY(LevelID) REFERENCES tblLevel(LevelID),
EmployerID INTEGER FOREIGN KEY(EmployerID) REFERENCES tblEmployer(EmployerID),
Salary NUMERIC (15,2) NOT NULL,
JobDescr VARCHAR(200) NULL,
PositionID INTEGER FOREIGN KEY(PositionID) REFERENCES tblPosition(PositionID));

-- tblJobLocation
CREATE TABLE tblJobLocation
(JobLocationID INTEGER IDENTITY(1,1) PRIMARY KEY,
LocationID INTEGER FOREIGN KEY(LocationID) REFERENCES tblLocation(LocationID),
JobID INTEGER FOREIGN KEY(JobID) REFERENCES tblJob(JobID),
);
 
-- tblStatus --
CREATE TABLE tblStatus
(StatusID INTEGER IDENTITY(1,1) PRIMARY KEY,
StatusName VARCHAR(50) NOT NULL,
StatusDescr VARCHAR(200) NULL);

-- tblJobStatus --
CREATE TABLE tblJobStatus
(JobStatusID INTEGER IDENTITY(1,1) PRIMARY KEY,
JobID INTEGER FOREIGN KEY(JobID) REFERENCES tblJob(JobID),
StatusID INTEGER FOREIGN KEY(StatusID) REFERENCES tblStatus(StatusID),
StartDate Date NOT NULL,
EndDate Date NOT NULL);
 
-- tblRole --
CREATE TABLE tblRole
(RoleID INTEGER IDENTITY(1,1) PRIMARY KEY,
RoleName VARCHAR(50) NOT NULL,
RoleDescr VARCHAR(200) NULL);
 
-- tblUserJob --
CREATE TABLE tblUserJob
(UserJobID INTEGER IDENTITY(1,1) PRIMARY KEY,
JobID INTEGER FOREIGN KEY(JobID) REFERENCES tblJob(JobID),
UserID INTEGER FOREIGN KEY(UserID) REFERENCES tblUser(UserID),
RoleID INTEGER FOREIGN KEY(RoleID) REFERENCES tblRole(RoleID));


INSERT INTO tblIndustry 
(IndustryName)
VALUES
('Information Technology'),('Health Care'),('Construction Retail'),('Education Management'),('Financial Services'),
('Accounting'),('Computer Software'),('Higher Education'),('Automotive')

INSERT INTO tblUserType (UserTypeName, UserTypeDescr)
VALUES ('Influencer', 'Users with more than 1000 followers'),('Non-incluencers', 'Users with less than 1000 followers')

INSERT INTO tblMembershipType (MembershipTypeName, MembershipTypeDescr)
VALUES ('Premium', 'Paid Preium Membership'),('Free', 'Free membership')

INSERT INTO tblSeekingStatus (SeekingStatusName, SeekingStatusDescr)
VALUES ('Open to work', 'Currently seeking'), ('Not open to work', 'Not currently seeking')

INSERT INTO tblEmployerSize (EmployerSizeName, NumRange)
VALUES ('Startup', '10'),('X-Small', '50'),('Small', '200'),('Small-Medium', '500'),
('Medium', '1000'), ('Large', '5000'),('X-Large', '10000')

INSERT INTO tblRole (RoleName, RoleDescr)
VALUES ('Recuiter', 'recruiter of this job'),('Applicant', 'Applicant of this job')

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


-- STORED PROCEDURES AND SYNTHETIC TRANSACTIONS

USE INFO430_Proj_08

-- IMPORTANT --
-- Code for reseeding tables (in case you need to repopulate, change 'tblUser' to name of the table)
-- DBCC CHECKIDENT(tblUser, RESEED, 0)


-- GetID Stored Procedures

CREATE PROCEDURE getUserTypeID
@UserTypeN varchar(50),
@UseTypID INT OUTPUT
AS
SET @UseTypID = (SELECT UserTypeID
   FROM tblUserType
   WHERE UserTypeName = @UserTypeN)

GO

CREATE PROCEDURE getJobIDFromTitle
@JobTitle varchar(50),
@JobID INT OUTPUT
AS
SET @JobID = (SELECT JobID FROM tblJob WHERE JobTitle = @JobTitle)

GO
 
CREATE PROCEDURE getMemTypeID
@Memmy varchar(50),
@MemTyID INT OUTPUT
AS
SET @MemTyID = (SELECT MembershipTypeID
   FROM tblMembershipType
   WHERE MembershipTypeName = @Memmy)

GO

CREATE PROCEDURE getGenderID
@GendNam varchar(50),
@Prononny varchar(50),
@GendID INT OUTPUT
AS
SET @GendID = (SELECT GenderID
   FROM tblGender
   WHERE GenderName = @GendNam
   AND Pronouns = @Prononny
)

GO
 
CREATE PROCEDURE getUserID
@UserFNam varchar(50),
@UserLnam varchar(200),
@DOBBY DATE,
@Usy_ID INT OUTPUT
AS
SET @Usy_ID = (SELECT UserID
	FROM tblUser
	WHERE UserFname = @UserFNam
	AND UserLname = @UserLnam
	AND UserDOB = @DOBBY)

GO
 
CREATE PROCEDURE getLocationID
@CityName varchar(50),
@CountryName varchar(50),
@LocID INT OUTPUT
AS
SET @LocID = (SELECT LocationID
  FROM tblLocation
  WHERE City = @CityName
  AND Country = @CountryName)

GO

CREATE PROCEDURE getEmployerSizeID
@EmpSizeName varchar(50),
@EmpSizeID INT OUTPUT
AS
SET @EmpSizeID = (SELECT EmployerSizeID
  FROM tblEmployerSize
  WHERE EmployerSizeName = @EmpSizeName)

GO

CREATE PROCEDURE getIndustryID
@IndName varchar(50),
@IndID INT OUTPUT
AS
SET @IndID = (SELECT GenderID
  FROM tblIndustry
  WHERE IndustryName = @IndName
)
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
 
CREATE PROCEDURE getMemTypeID
@Memmy varchar(50),
@MemTyID INT OUTPUT
AS
SET @MemTyID = (SELECT MembershipTypeID
   FROM tblMembershipType
   WHERE MembershipTypeName = @Memmy)

GO

CREATE PROCEDURE getStatusID
@StatusName varchar(50),
@S_ID INTEGER OUTPUT

AS
SET @S_ID = (SELECT StatusID FROM tblStatus S WHERE S.StatusName = @StatusName)

GO

CREATE PROCEDURE getRoleID
@RName VARCHAR(50),
@RID INTEGER OUTPUT

AS
SET @RID = (
    SELECT RoleID
    FROM tblRole
    WHERE RoleName = @RName)
GO


CREATE PROCEDURE getJobID
@JobTitle varchar(50),
@JobTypeName varchar(50),
@LevelName varchar(50),
@EmployerName varchar(50),
@PositionName varchar(50),
@J_ID INTEGER OUTPUT

AS
SET @J_ID = (SELECT JobID FROM tblJob J
	JOIN tblJobType JT ON J.JobTypeID = JT.JobTypeID
	JOIN tblLevel L ON J.LevelID = L.LevelID
	JOIN tblPosition P ON J.PositionID = P.PositionID
	JOIN tblEmployer E ON J.EmployerID = E.EmployerID
	WHERE J.JobTitle = @JobTitle AND JT.JobTypeName = @JobTypeName AND L.LevelName = @LevelName AND E.EmployerName = @EmployerName AND P.PositionName = @PositionName)

GO

CREATE PROCEDURE jraygetUserID
@UFname VARCHAR(50),
@ULname VARCHAR(50),
@UDOB DATE,
@Userr_ID INTEGER OUTPUT
AS
SET @Userr_ID = (
    SELECT UserID
    FROM tblUser
    WHERE UserFname = @UFname
    AND UserLname = @ULname
    AND UserDOB = @UDOB)

GO

CREATE PROCEDURE getSeekingStatusID
@SeekSName VARCHAR(50),
@Seek_ID INTEGER OUTPUT
AS
SET @Seek_ID = (
    SELECT SeekingStatusID
    FROM tblSeekingStatus
    WHERE @SeekSName = SeekingStatusName)

GO
 
-- Synthetic Tnx, Insert into tblUser
CREATE PROCEDURE insertIntoUser
@UsyTypeNam varchar(50),
@GenNam varchar(50),
@Prons varchar(50),
@UsyFnam varchar(50),
@usyLnam varchar(50),
@UsDoby DATE
AS
DECLARE @U_Type_ID INT, @Gend_ID INT
 
EXEC getUserTypeID
@UserTypeN = @UsyTypeNam,
@UseTypID = @U_Type_ID OUTPUT
 
IF @U_Type_ID IS NULL
   BEGIN
       PRINT '@U_Type_ID Is NULL';
       THROW 58123, '@U_Type_ID cannot be NULL; process is terminating', 1;
   END
 
EXEC getGenderID
@GendNam = @GenNam,
@Prononny = @Prons,
@GendID = @Gend_ID OUTPUT
 
IF @Gend_ID IS NULL
   BEGIN
       PRINT '@Gend_ID Is NULL';
       THROW 59123, '@Gend_ID cannot be null; Process is Terminating', 1;
   END
 
BEGIN TRANSACTION T1
INSERT INTO tblUSER(UserFname, UserLname, UserTypeID, GenderID, UserDOB)
VALUES (@UsyFnam, @usyLnam, @U_Type_ID, @Gend_ID, @UsDoby)
 
IF @@ERROR <> 0
   BEGIN
       PRINT '@@ERROR is printing somewhere, terminating process'
       ROLLBACK TRANSACTION T1
   END
ELSE
   COMMIT TRANSACTION T1

GO
 
-- Wrapper procedure for randomly populating user table
ALTER PROCEDURE [dbo].[wrapperUser]
@RUN INTEGER
AS
DECLARE @Firy varchar(50), @Lasy varchar(50), @Pronnys varchar(50), @Genny varchar(50),
@Dobenie DATE, @UTypee varchar(50), @RANDUserTypeID INT, @RANDGenderTypeID INT,
@RANDUserID INT

WHILE @RUN > 0
	BEGIN
		   SET @RANDUserTypeID = (SELECT LEFT(CAST(RAND() * 2 + 1 AS INT), 3))
		   SET @RANDGenderTypeID = (SELECT LEFT(CAST(RAND() * 3 + 1 AS INT), 3))
		   SET @RANDUserID = @RUN
		   SET @Firy = (SELECT CustomerFname FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @RANDUserID)
		   SET @Lasy = (SELECT CustomerLname FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @RANDUserID)
		   SET @Pronnys = (SELECT Pronouns FROM tblGender WHERE GenderID = @RANDGenderTypeID)
		   SET @Genny = (SELECT GenderName FROM tblGender WHERE GenderID = @RANDGenderTypeID)
		   SET @Dobenie = (SELECT DateOfBirth FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @RANDUserID)
		   SET @UTypee = (SELECT UserTypeName FROM tblUserType WHERE UserTypeID = @RANDUserTypeID)

		   IF @Firy IS NULL OR @Lasy IS NULL OR @Pronnys IS NULL or @Genny IS NULL
		   or @Dobenie IS NULL OR @UTypee IS NULL
		   BEGIN
			   PRINT 'variables are null';
			   THROW 57694, 'variables cannot be null; process terminating', 1;
		   END
 
		EXEC insertIntoUser
		@UsyTypeNam = @UTypee,
		@GenNam = @Genny,
		@Prons = @Pronnys,
		@UsyFnam = @Firy,
		@usyLnam = @Lasy,
		@UsDoby = @Dobenie
 
		SET @RUN = @RUN - 1
	END

GO

-- Synthetic Tnx, Insert into tblMembership
ALTER PROCEDURE insertIntoMembership
@Starty DATE,
@Enddy DATE,
@Fnamm varchar(50),
@Lnamm varchar(50),
@Dobie DATE,
@MembType varchar(50)
AS
DECLARE @MemT_ID INT, @U_ID INT
 
EXEC getMemTypeID
@Memmy = @MembType,
@MemTyID = @MemT_ID OUTPUT
 
IF @MemT_ID IS NULL
  BEGIN
      PRINT '@MemT_ID is NULL';
      THROW 55656, '@MemT_ID cannot be NULL; process is terminating', 1;
  END
 
EXEC getUserID
@UserFNam = @Fnamm,
@UserLnam = @Lnamm,
@DOBBY = @Dobie,
@Usy_ID = @U_ID OUTPUT

IF @U_ID IS NULL
  BEGIN
      -- PRINT 'found uid to be null here'
      PRINT '@U_ID is NULL';
      THROW 55656, '@U_ID cannot be NULL; process is terminating', 1;
  END
 
BEGIN TRANSACTION T1
INSERT INTO tblMembership (StartDate, EndDate, MembershipTypeID, UserID)
VALUES (@Starty, @Enddy, @MemT_ID, @U_ID)
 
IF @@ERROR <> 0
   BEGIN
       PRINT '@@ERROR is showing an error somewhere...terminating process'
       ROLLBACK TRANSACTION T1
   END
ELSE
   COMMIT TRANSACTION T1

GO

-- Wrapper procedure for randomly populating tblMembership
ALTER PROCEDURE [dbo].[wrapperMembership]
@RUN INTEGER
AS
DECLARE @Stary VARCHAR(50), @Eny VARCHAR(50), @Fna VARCHAR(50), @Lna VARCHAR(50),
@Dobb DATE, @MembTypee VARCHAR(100), @RANDUser FLOAT, @RANDMemType FLOAT

WHILE @RUN > 0
	BEGIN
		SET @RANDUser = (SELECT FLOOR(CAST(RAND()* (SELECT COUNT(*) FROM tblUser) AS INT)))
		SET @RANDMemType = (SELECT FLOOR(CAST(RAND()*2 + 1 AS INT)))
		SET @Fna = (SELECT UserFname FROM tblUser WHERE UserID = @RANDUser)
		SET @Lna = (SELECT UserLname FROM tblUser WHERE UserID = @RANDUser)
		SET @Stary = (SELECT GETDATE() - RAND()*1000)
		SET @Eny = (SELECT DATEADD(D, RAND()*200, @Stary))
		SET @Dobb = (SELECT UserDOB FROM tblUser WHERE UserID = @RANDUser)
		SET @MembTypee = (SELECT MembershipTypeName FROM tblMembershipType WHERE MembershipTypeID = @RANDMemType)
		IF @Fna IS NULL OR @Lna  IS NULL OR @Stary IS NULL
		   OR @Eny IS NULL OR @Dobb IS NULL OR @MembTypee IS NULL
		   BEGIN
			  PRINT 'Variables are null';
			  THROW 55656, 'variables cannot be NULL; process is terminating', 1;
		   END
 
		EXEC insertIntoMembership
		@Starty = @Stary,
		@Enddy = @Eny,
		@Fnamm = @Fna,
		@Lnamm = @Lna,
		@Dobie = @Dobb,
		@MembType = @MembTypee
 
		SET @RUN = @RUN - 1
	END

GO

-- Synthetic Tnx, Insert into tblEmployer
CREATE PROCEDURE insertIntoEmployer
@EmpName varchar(50),
@EmpDescr varchar(200),
@CityName varchar(200),
@CountryName varchar(200),
@EmpSizeName varchar(50),
@IName varchar(50)
AS
DECLARE @L_ID INT, @ESize_ID INT, @I_ID INT

EXEC getLocationID
@CityName = @CityName,
@CountryName = @CountryName,
@LocID = @L_ID OUTPUT

IF @L_ID IS NULL
  BEGIN
    PRINT '@L_ID is NULL';
    THROW 55656, '@L_ID cannot be NULL; process is terminating', 1;
END

EXEC getEmployerSizeID
@EmpSizeName = @EmpSizeName,
@EmpSizeID = @ESize_ID OUTPUT

IF @ESize_ID IS NULL
  BEGIN
    PRINT '@ESize_ID is NULL';
    THROW 55656, '@ESize_ID cannot be NULL; process is terminating', 1;
END

EXEC getIndustryID
@IndName = @IName,
@IndID = @I_ID OUTPUT

IF @I_ID IS NULL
  BEGIN
    PRINT '@I_ID is NULL';
    THROW 55656, '@I_ID cannot be NULL; process is terminating', 1;
END

BEGIN TRANSACTION T1
INSERT INTO tblEmployer
    (EmployerName, EmployerDescr, locationID, EmployerSizeID, IndustryID)
VALUES
    (@EmpName, @EmpDescr, @L_ID, @ESize_ID, @I_ID)

IF @@ERROR <> 0
   BEGIN
    PRINT '@@ERROR is showing an error somewhere...terminating process'
    ROLLBACK TRANSACTION T1
END
ELSE
   COMMIT TRANSACTION T1
GO

-- Wrapper procedure for randomly populating tblEmployer
ALTER PROCEDURE [dbo].[wrapperEmployer]
@RUN INTEGER
AS
DECLARE @EName varchar(50),
@EDescr varchar(200),
@CiName varchar(200),
@CoName varchar(200),
@ESizeName varchar(50),
@IName varchar(50), 
@RANDLoc INT, @RANDEmpSize INT, @RANDInd INT

WHILE @RUN > 0
	BEGIN

		SET @RANDLoc = (SELECT LEFT(CAST(RAND()*(SELECT COUNT(*) FROM tblLocation) + 1 AS INT), 3))
		SET @RANDEmpSize = (SELECT LEFT(CAST(RAND()*(SELECT COUNT(*) FROM tblEmployerSize) + 1 AS INT), 3))
		SET @RANDInd = (SELECT LEFT(CAST(RAND()*(SELECT COUNT(*) FROM tblIndustry) + 1 AS INT), 3))
		SET @EName = (SELECT BusinessName FROM PEEPS.dbo.Businesses WHERE BusinessID = @RUN)
		SET @EDescr = (SELECT Email FROM PEEPS.dbo.Businesses WHERE BusinessID = @RUN)
		SET @CiName = (SELECT City FROM tblLocation WHERE LocationID = @RANDLoc)
		SET @CoName = (SELECT Country FROM tblLocation WHERE LocationID = @RANDLoc)
		SET @ESizeName = (SELECT EmployerSizeName FROM tblEmployerSize WHERE EmployerSizeID = @RANDEmpSize)
		SET @IName = (SELECT IndustryName FROM tblIndustry WHERE IndustryID = @RANDInd)
    
		IF @EName IS NULL OR @EDescr IS NULL OR @CiName IS NULL OR 
		@CoName IS NULL OR @ESizeName IS NULL OR @IName IS NULL
		BEGIN
			PRINT 'Variables are null';
			THROW 55656, 'variables cannot be NULL; process is terminating', 1;
		END

		EXEC insertIntoEmployer
		@EmpName = @EName,
		@EmpDescr = @EDescr,
		@CityName = @CiName,
		@CountryName = @CoName,
		@EmpSizeName = @ESizeName,
		@IName = @IName

    SET @RUN = @RUN - 1
    END
GO

-- Procedure for inserting into JobStatus table
ALTER PROCEDURE insertIntoJobStatus
@Job_Title varchar(50),
@Job_Type_Name varchar(50),
@Level_Name varchar(50),
@Employer_Name varchar(50),
@Position_Name varchar(50),
@Status_Name varchar(50),
@Start_Date DATE,
@End_Date DATE
AS
DECLARE @Job_ID INT, @Status_ID INT

EXEC getJobID
@JobTitle = @Job_Title,
@JobTypeName = @Job_Type_Name,
@LevelName = @Level_Name,
@EmployerName = @Employer_Name,
@PositionName = @Position_Name,
@J_ID = @Job_ID OUTPUT

IF @Job_ID IS NULL
	BEGIN
		PRINT '@Job_ID is NULL';
		THROW 55658, 'Job_ID cannot be NULL, process terminating', 1;
	END

EXEC getStatusID
@StatusName = @Status_Name,
@S_ID = @Status_ID OUTPUT

IF @Status_ID IS NULL
	BEGIN
		PRINT '@Status_ID is NULL';
		THROW 55658, 'Status_ID cannot be NULL, process terminating', 1;
	END

BEGIN TRANSACTION T1
INSERT INTO tblJobStatus
VALUES(@Job_ID, @Status_ID, @Start_Date, @End_Date)

IF @@ERROR <> 0
	BEGIN
		PRINT '@@ERROR does not equal 0, process terminating'
		ROLLBACK TRANSACTION T1
	END
ELSE
	COMMIT TRANSACTION T1

GO

-- Wrapper procedure for randomly populating tblJobStatus
ALTER PROCEDURE [dbo].[wrapperJobStatus]
@RUN INTEGER
AS
DECLARE @Job_ID INTEGER,
@Status_ID INTEGER,
@JobTitle varchar(50),
@JobTypeName varchar(50),
@LevelName varchar(50),
@EmployerName varchar(50),
@PositionName varchar(50),
@StatusName varchar(50),
@StartDate DATE,
@EndDate DATE

WHILE @RUN > 0
	BEGIN

		SET @Job_ID = (SELECT FLOOR(CAST(RAND()* (SELECT COUNT(*) FROM tblJob) AS INT)))
		SET @Status_ID =  (SELECT FLOOR(RAND() * 3)+1) -- Select random 1 to 3
		SET @StartDate = (SELECT GETDATE() - RAND()*1000)
		SET @EndDate =  (SELECT DATEADD(D, RAND()*200, @StartDate))
		SET @JobTitle = (SELECT JobTitle FROM tblJob WHERE JobID = @Job_ID)
		SET @JobTypeName = (SELECT JobTypeName FROM tblJobType JT JOIN tblJob J ON JT.JobTypeID = J.JobTypeID WHERE J.JobID = @Job_ID)
		SET @LevelName = (SELECT LevelName FROM tblLevel L JOIN tblJob J ON L.LevelID = J.LevelID WHERE J.JobID = @Job_ID)
		SET @EmployerName = (SELECT EmployerName FROM tblEmployer E JOIN tblJob J ON E.EmployerID = J.EmployerID WHERE J.JobID = @Job_ID)
		SET @PositionName = (SELECT PositionName FROM tblPosition P JOIN tblJob J ON P.PositionID = J.PositionID WHERE J.JobID = @Job_ID)
		SET @StatusName = (SELECT StatusName FROM tblStatus WHERE StatusID = @Status_ID)

		IF @JobTitle IS NULL OR @JobTypeName IS NULL OR @LevelName IS NULL OR @EmployerName IS NULL OR @PositionName IS NULL OR @StatusName IS NULL
			BEGIN 
				PRINT 'A variable is NULL';
				THROW 55658, 'Variables cannot be NULL, process terminating', 1;
			END

		EXEC insertIntoJobStatus
		@Job_Title = @JobTitle,
		@Job_Type_Name = @JobTypeName,
		@Level_Name = @LevelName,
		@Employer_Name = @EmployerName,
		@Position_Name = @PositionName,
		@Status_Name = @StatusName,
		@Start_Date = @StartDate,
		@End_Date = @EndDate

		SET @RUN = @RUN - 1
	END
GO


ALTER PROCEDURE generateJobLocation
@Job_Title varchar(50),
@Job_Type_Name varchar(50),
@Level_Name varchar(50),
@Employer_Name varchar(50),
@Position_Name varchar(50),
@Country_Name varchar(50),
@City_Name varchar(50)

AS
DECLARE @Job_ID INTEGER, @Location_ID INTEGER

EXEC getJobID
@JobTitle = @Job_Title,
@JobTypeName = @Job_Type_Name,
@LevelName = @Level_Name,
@EmployerName = @Employer_Name,
@PositionName = @Position_Name,
@J_ID = @Job_ID OUTPUT

IF @Job_ID IS NULL
	BEGIN
		PRINT '@Job_ID is NULL';
		THROW 55658, 'Job_ID cannot be NULL, process terminating', 1;
	END

EXEC getLocationID
@CityName = @City_Name,
@CountryName = @Country_Name,
@LocID = @Location_ID OUTPUT

IF @Location_ID IS NULL
	BEGIN
		PRINT '@Location_ID is NULL';
		THROW 55658, 'Job_ID cannot be NULL, process terminating', 1;
	END


BEGIN TRANSACTION T1
INSERT INTO tblJobLocation
VALUES(@Location_ID, @Job_ID)

IF @@ERROR <> 0
	BEGIN
		PRINT '@@ERROR does not equal 0, process terminating'
		ROLLBACK TRANSACTION T1
	END
ELSE
	COMMIT TRANSACTION T1

GO


-- Wrapper procedure for randomly populating tblJobLocation
ALTER PROCEDURE [dbo].[wrapperJobLocation]
@Run INTEGER
AS
DECLARE @Job_ID INTEGER,
@Location_ID INTEGER,
@Status_ID INTEGER,
@JobTitle varchar(50),
@JobTypeName varchar(50),
@LevelName varchar(50),
@EmployerName varchar(50),
@PositionName varchar(50),
@CountryName varchar(50),
@CityName varchar(50)

WHILE @RUN > 0
	BEGIN

		SET @Job_ID = (SELECT FLOOR(CAST(RAND()* (SELECT COUNT(*) FROM tblJob) AS INT)))
		SET @Location_ID = (SELECT E.LocationID FROM tblJob J JOIN tblEmployer E ON E.EmployerID = J.EmployerID WHERE J.JobID = @Job_ID)

		SET @JobTitle = (SELECT JobTitle FROM tblJob WHERE JobID = @Job_ID)
		SET @JobTypeName = (SELECT JobTypeName FROM tblJobType JT JOIN tblJob J ON JT.JobTypeID = J.JobTypeID WHERE J.JobID = @Job_ID)
		SET @LevelName = (SELECT LevelName FROM tblLevel L JOIN tblJob J ON L.LevelID = J.LevelID WHERE J.JobID = @Job_ID)
		SET @EmployerName = (SELECT EmployerName FROM tblEmployer E JOIN tblJob J ON E.EmployerID = J.EmployerID WHERE J.JobID = @Job_ID)
		SET @PositionName = (SELECT PositionName FROM tblPosition P JOIN tblJob J ON P.PositionID = J.PositionID WHERE J.JobID = @Job_ID)
		SET @CountryName = (SELECT Country FROM tblLocation WHERE LocationID = @Location_ID)
		SET @CityName = (SELECT City FROM tblLocation WHERE LocationID = @Location_ID)

		IF @JobTitle IS NULL OR @JobTypeName IS NULL OR @LevelName IS NULL OR @EmployerName IS NULL OR @PositionName IS NULL OR @CountryName IS NULL OR @CityName IS NULL
			BEGIN 
				PRINT 'A variable is NULL';
				THROW 55658, 'Variables cannot be NULL, process terminating', 1;
			END

		EXEC generateJobLocation
		@Job_Title = @JobTitle,
		@Job_Type_Name = @JobTypeName,
		@Level_Name = @LevelName,
		@Employer_Name = @EmployerName,
		@Position_Name = @PositionName,
		@Country_Name = @CountryName,
		@City_Name = @CityName

		SET @RUN = @RUN - 1
	END
GO

-- Synthetic Tnx for inserting into tblUserSeekingStatus

ALTER PROCEDURE insertIntoUserSeekingStatus
@Start_Date DATE,
@End_Date DATE,
@User_Fname VARCHAR(50),
@User_Lname VARCHAR(50),
@User_DOB DATE,
@SeekStatus_Name VARCHAR(50)
AS
DECLARE @SS_ID INT, @User_ID INT

EXEC jraygetUserID
@UFname = @User_Fname,
@ULname = @User_Lname,
@UDOB = @User_DOB,
@Userr_ID = @User_ID OUTPUT

IF @User_ID IS NULL
    BEGIN
        PRINT '@User_ID is NULL';
        THROW 55656, '@User_ID cannot be NULL; process is terminating', 1;
    END

EXEC getSeekingStatusID
@SeekSName = @SeekStatus_Name,
@Seek_ID = @SS_ID OUTPUT

IF @SS_ID IS NULL
    BEGIN
        PRINT '@SS_ID is NULL';
        THROW 55656, '@SS_ID cannot be NULL; process is terminating', 1;
    END

BEGIN TRANSACTION T1
INSERT INTO tblUserSeekingStatus (StartDate, EndDate, SeekingStatusID, UserID)
VALUES (@Start_Date, @End_Date, @SS_ID, @User_ID)
 
IF @@ERROR <> 0
   BEGIN
       PRINT '@@ERROR is showing an error somewhere...terminating process'
       ROLLBACK TRANSACTION T1
   END
ELSE
   COMMIT TRANSACTION T1
GO

ALTER PROCEDURE [dbo].[wrapperUserSeekingStatus]
@RUN INTEGER
AS
DECLARE @StartD DATE, @EndD DATE, @F_Name VARCHAR(50), @L_Name VARCHAR(50), 
        @Birthy DATE, @Seeking_Status_Name VARCHAR(50), @RANDUser FLOAT, 
        @RANDSeekName FLOAT

WHILE @RUN > 0
	BEGIN
		SET @RANDUser = (SELECT LEFT(CAST(RAND()*(SELECT COUNT(*) FROM tblUser) AS INT), 3))
		SET @RANDSeekName = (SELECT LEFT(CAST(RAND()*2 + 1 AS INT), 3))
		SET @F_Name = (SELECT UserFname FROM tblUser WHERE UserID = @RANDUser)
		SET @L_Name = (SELECT UserLname FROM tblUser WHERE UserID = @RANDUser)
		SET @StartD = (SELECT GETDATE() - RAND()*1000)
		SET @EndD = (SELECT DATEADD(D, RAND()*200, @StartD))
		SET @Birthy = (SELECT UserDOB FROM tblUser WHERE UserID = @RANDUser)
		SET @Seeking_Status_Name = (SELECT SeekingStatusName FROM tblSeekingStatus 
									WHERE SeekingStatusID = @RANDSeekName)

		IF @StartD IS NULL OR
		   @EndD IS NULL OR
		   @F_Name IS NULL OR
		   @L_Name IS NULL OR
		   @Birthy IS NULL OR
		   @Seeking_Status_Name IS NULL
			BEGIN 
				PRINT 'Variables are null';
				THROW 55656, 'variables cannot be NULL; process is terminating', 1;
			END

		EXEC insertIntoUserSeekingStatus
		@Start_Date = @StartD,
		@End_Date = @EndD,
		@User_Fname = @F_name,
		@User_Lname = @L_Name,
		@User_DOB = @Birthy,
		@SeekStatus_Name = @Seeking_Status_Name

		SET @RUN = @RUN - 1
	END
GO


----- Synthetic Tnx for UserJob -------

ALTER PROCEDURE insertIntoUserJob
@UserF VARCHAR(50),
@UserL VARCHAR(50),
@JobT VARCHAR(100),
@DOB DATE,
@RoleNamy VARCHAR(50)
AS
DECLARE @J_ID INT, @U_ID INT, @R_ID INT

EXEC getUserID
@UserFNam = @UserF,
@UserLNam = @UserL,
@DOBBY = @DOB,
@Usy_ID = @U_ID OUTPUT

IF @U_ID IS NULL
    BEGIN
        PRINT '@U_ID is NULL';
        THROW 55656, '@U_ID cannot be NULL; process is terminating', 1;
    END

EXEC getJobIDFromTitle
@JobTitle = @JobT,
@JobID = @J_ID OUTPUT

IF @J_ID IS NULL
    BEGIN
        PRINT '@J_ID is NULL';
        THROW 55656, '@J_ID cannot be NULL; process is terminating', 1;
    END

EXEC getRoleID
@RName = @RoleNamy,
@RID = @R_ID OUTPUT

IF @R_ID IS NULL
    BEGIN
        PRINT '@R_ID is NULL';
        THROW 55656, '@R_ID cannot be NULL; process is terminating', 1;
    END

BEGIN TRANSACTION T1
INSERT INTO tblUserJob (JobID, UserID, RoleID)
VALUES (@J_ID, @U_ID, @R_ID)
 
IF @@ERROR <> 0
   BEGIN
       PRINT '@@ERROR is showing an error somewhere...terminating process'
       ROLLBACK TRANSACTION T1
   END
ELSE
   COMMIT TRANSACTION T1
GO


-- Procedure for populating userjob
ALTER PROCEDURE [dbo].[wrapperUserJob]
@RUN INTEGER
AS
DECLARE @J_ID INTEGER, @U_ID INTEGER, @R_ID INTEGER, @UFName VARCHAR(50), @ULName VARCHAR(50),
        @J_Titile VARCHAR(50), @R_Namy VARCHAR (50), @UDOB DATE

WHILE @RUN > 0
	BEGIN
        SET @J_ID = (SELECT LEFT(CAST(RAND()* (SELECT COUNT(*) FROM tblJob) AS INT), 3))
        SET @U_ID = (SELECT LEFT(CAST(RAND()* (SELECT COUNT(*) FROM tblUser) AS INT), 3))
        SET @R_ID = 2
        SET @UFName = (SELECT UserFname FROM tblUser WHERE UserID = @U_ID)
        SET @ULName = (SELECT UserLname FROM tblUser WHERE UserID = @U_ID)
        SET @UDOB = (SELECT UserDOB FROM tblUser WHERE UserID = @U_ID)
        SET @J_Titile = (SELECT JobTitle FROM tblJob WHERE JobID = @J_ID)
        SET @R_Namy = (SELECT RoleName FROM tblRole WHERE RoleID = @R_ID)

        IF @J_ID IS NULL OR @U_ID IS NULL OR @R_ID IS NULL
			BEGIN 
				PRINT 'A variable is NULL';
				THROW 55658, 'Variables cannot be NULL, process terminating', 1;
			END

        EXEC insertIntoUserJob
        @UserF = @UFName,
        @UserL = @ULName,
        @JobT = @J_Titile,
        @DOB = @UDOB,
        @RoleNamy = @R_Namy

        SET @RUN = @RUN - 1
	END
GO


-- COMPUTED COLUMNS AND BUSINESS RULES

USE INFO430_Proj_08
GO

-- BUSINESS RULES

-- 1. Influencer can only apply to jobs with the level executive

CREATE FUNCTION strozj_influencer_only_exec()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
		SELECT * FROM tblUserJob UJ
			JOIN tblUser U ON UJ.UserID = U.UserID
			JOIN tblUserType UT ON U.UserTypeID = UT.UserTypeID
			JOIN tblJob J ON UJ.JobID = J.JobID
			JOIN tblLevel L ON J.LevelID = L.LevelID
		WHERE L.LevelName <> 'Executive' AND UT.UserTypeName = 'Influencer'
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblUserJob WITH NOCHECK
ADD CONSTRAINT Influencer_Application_Level_Requirement_Restriction
CHECK (dbo.strozj_influencer_only_exec() = 0)

GO


-- 2. Business Rule: Users cannot add a premium membership within 3 months of their last membership expiring


CREATE FUNCTION strozj_membership_3month_restriction()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
		SELECT * FROM tblMembership M
			JOIN tblMembershipType MT ON M.MembershipTypeID = MT.MembershipTypeID
		WHERE DATEDIFF(MONTH, M.EndDate, GETDATE()) < 3 AND MT.MembershipTypeName = 'Premium'
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblMembership WITH NOCHECK
ADD CONSTRAINT User_Membership_3month_Premium_Restriction
CHECK (dbo.strozj_membership_3month_restriction() = 0)

GO


-- 3. Business Rule: Age < 30 cannot apply to senior level positions

CREATE FUNCTION strozj_young_cannot_apply_senior()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
		SELECT * FROM tblUserJob UJ
			JOIN tblUser U ON UJ.UserID = U.UserID
			JOIN tblUserType UT ON U.UserTypeID = UT.UserTypeID
			JOIN tblJob J ON UJ.JobID = J.JobID
			JOIN tblLevel L ON J.LevelID = L.LevelID
		WHERE L.LevelName = 'Senior' AND DATEDIFF(YEAR, U.UserDOB, GetDate()) < 30
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblUserJob WITH NOCHECK
ADD CONSTRAINT Young_Application_Seniority_Restriction
CHECK (dbo.strozj_young_cannot_apply_senior() = 0)

GO


-- 4. No one can apply to closed or archived jobs 
select *
from tblStatus
GO

CREATE FUNCTION xuanry_fn_NoClosedJobApp()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
    IF EXISTS (SELECT *
    FROM tblUserJob UJ
        JOIN tblJob J ON UJ.JobID = J.JobID
        JOIN tblJobStatus JS ON JS.JobID = J.JobID
        JOIN tblStatus S ON S.StatusID = JS.StatusID
    WHERE S.StatusName = 'Closed' 
        OR S.StatusName = 'Archived')
BEGIN
        SET @RET = 1
    END
    RETURN @RET
END
GO

ALTER TABLE tblUserJob with nocheck
ADD CONSTRAINT CK_NoClosedJobApp
CHECK (dbo.xuanry_fn_NoClosedJobApp() = 0)
GO
-- alter table tblUserJob drop constraint CK_NoClosedJobApp

-- 5. All US software engineer positions has salary > 80k
ALTER FUNCTION xuanry_fn_sde80k()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
    IF EXISTS (SELECT *
    FROM tblJob J
        JOIN tblJobLocation JL ON JL.JobID = J.JobID
        JOIN tblLocation L ON L.LocationID = JL.LocationID
        JOIN tblPosition P ON P.PositionID = J.PositionID
    WHERE L.Country = 'USA' 
        AND J.Salary <= 80000 AND P.PositionName = 'Software Engineer')
BEGIN
        SET @RET = 1
    END
    RETURN @RET
END
GO

ALTER TABLE tblJob with nocheck
ADD CONSTRAINT CK_NoSde80k
CHECK (dbo.xuanry_fn_sde80k() = 0)
GO
-- alter table tblJob drop CONSTRAINT CK_NoSde80k

-- 6. Age <18 cannot apply to jobs
GO
ALTER FUNCTION ageUnder18noJob()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
        SELECT * FROM tblUSER U
            JOIN tblUserJob UJ ON U.UserID = UJ.UserID
            JOIN tblJOB J ON UJ.JobID = J.JobID
            JOIN tblJobType JT ON J.JobTypeID = JT.JobTypeID
        WHERE U.UserDOB > DateADD(Year, -18, GETDATE())
            AND JT.JobTypeName = 'Full-time' OR JT.JobTypeName ='Part-time' 
            OR JT.JobTypeName = 'Contract' OR JT.JobTypeName = 'Seasonal'
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblUserJob WITH NOCHECK
ADD CONSTRAINT SorryTooYoung18job
CHECK (dbo.ageUnder18noJob() = 0)
GO
-- alter table tblUserJob drop constraint SorryTooYoung18job

-- 7. no one over age 24 can apply to internships
ALTER FUNCTION ageOver24noInternshipUhh()
RETURNS INTEGER
AS
BEGIN 

DECLARE @RET INT = 0
    IF EXISTS(
        SELECT * FROM tblUSER U
            JOIN tblUserJob UJ ON U.UserID = UJ.UserID
            JOIN tblJOB J ON UJ.JobID = J.JobID
            JOIN tblJobType JT ON J.JobTypeID = JT.JobTypeID
        WHERE U.UserDOB < DateADD(Year, -24, GETDATE())
            AND JT.JobTypeName = 'Internship'
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblUserJob WITH NOCHECK
ADD CONSTRAINT ageOver24noInternshipPLEASE
CHECK (dbo.ageOver24noInternshipUhh() = 0) 
GO
-- alter table tblUserJob drop constraint ageOver24noInternshipPLEASE

-- 8. Any job higher than mid level cannot be part-time or intern or apprenticeship
CREATE FUNCTION no_partTime_mid_level_higher()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
		SELECT * FROM tblJob J
			JOIN tblLevel L ON J.LevelID = L.LevelID
            JOIN tblJobType JT ON J.JobTypeID = JT.JobTypeID
		WHERE L.LevelID > 4 
        AND JT.JobTypeName = 'Internship' OR JT.JobTypeName = 'Part-time' OR JT.JobTypeName = 'Apprenticeship'
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblJob WITH NOCHECK
ADD CONSTRAINT Mid_Level_Higher_JobType_Restriction
CHECK (dbo.no_partTime_mid_level_higher() = 0)
GO
-- alter table tblJob drop CONSTRAINT Mid_Level_Higher_JobType_Restriction

-- 9. One user cannot apply to same job twice (user job)
ALTER TABLE tblUserJob ADD CONSTRAINT no_duplicate_application UNIQUE (UserID, JobID);
GO

-- 10. One user cannot be both recruiter and applicant for one job (user job)
CREATE FUNCTION cannot_both_recruiter_applicant()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
		SELECT UserID, JobID, SUM(RoleID) FROM tblUserJob UJ
        GROUP BY UserID, JobID
        HAVING SUM(RoleID) >= 3
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblUserJob WITH NOCHECK
ADD CONSTRAINT Both_Recruiter_Applicant_Restriction
CHECK (dbo.cannot_both_recruiter_applicant() = 0)
GO




-- COMPUTED COLUMNS
use INFO430_Proj_08
GO

-- 1. The number of female applicants for a job
 
CREATE FUNCTION xuanry_fn_total_f_app_job(@PK INT)
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = (
    SELECT COUNT(*)
    FROM tblUserJob UJ
        JOIN tblUser U ON UJ.UserID = U.UserID
        JOIN tblJob J ON J.JobID = UJ.JobID
        JOIN tblGender G ON G.GenderID = U.GenderID
    WHERE UJ.RoleID = 2
        AND G.GenderName = 'female'
        AND J.JobID = @PK
    )
    RETURN @RET
END
GO

ALTER TABLE tblJob
ADD Total_Female_Apps AS (dbo.xuanry_fn_total_f_app_job(JobID))
GO


-- 2. Computed Column: The number of male applicants for an job

CREATE FUNCTION xuanry_fn_total_m_app_job(@PK INT)
RETURNS INT
AS
BEGIN
    DECLARE @RET INT = (
    SELECT COUNT(*)
    FROM tblUserJob UJ
        JOIN tblUser U ON UJ.UserID = U.UserID
        JOIN tblJob J ON J.JobID = UJ.JobID
        JOIN tblGender G ON G.GenderID = U.GenderID
    WHERE UJ.RoleID = 2
        AND G.GenderName = 'male'
        AND J.JobID = @PK
    )
    RETURN @RET
END
GO

ALTER TABLE tblJob
ADD Total_Male_Apps AS (dbo.xuanry_fn_total_fm_app_job(JobID))
GO



-- 3. Computed Column: The number of job postings for each company

CREATE FUNCTION strozj_fn_total_num_job_postings_per_employer(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblJob J
    WHERE J.EmployerID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblEmployer
ADD Total_Jobs_Posted AS (dbo.strozj_fn_total_num_job_postings_per_employer(EmployerID))

GO


-- 4. Computed Column: The number of job postings for each level

CREATE FUNCTION strozj_fn_total_number_job_postings_per_level(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblJob J
    WHERE J.LevelID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblLevel
ADD Total_Jobs_Posted_At_Level AS (dbo.strozj_fn_total_number_job_postings_per_level(LevelID))
GO

-- 5. Number of applicants for each job
ALTER FUNCTION numApplicantsPerJob(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblUserJob UJ
    WHERE UJ.JobID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblJob
ADD TotalNumApplicantsPerJob AS 
(dbo.numApplicantsPerJob(JobID)) -- not dbo.


-- 6. Number of applicants each company
GO
CREATE FUNCTION numApplicantsPerCompany(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblUserJob UJ
        JOIN tblJob J ON UJ.JobID = J.JobID
        JOIN tblEmployer E ON J.EmployerID = E.EmployerID
    WHERE E.EmployerID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblEmployer
ADD TotalNumApplicantsPerCompany AS 
(dbo.numApplicantsPerCompany(EmployerID)) 
GO

-- 7. Number of internship positions per company
CREATE FUNCTION numInternshipsByCompany(@PK INT)
RETURNS INT
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblJob J 
        JOIN tblJobType JT ON J.JobTypeID = JT.JobTypeID
        JOIN tblEmployer E ON J.EmployerID = E.EmployerID
    WHERE JT.JobTypeName = 'Internship'
    AND E.EmployerID = @PK
    )
RETURN @RET
END
GO

ALTER TABLE tblEmployer
ADD TotalNumInternshipsPerCompany AS 
(dbo.numInternshipsByCompany(EmployerID)) -- not dbo.
GO


-- 8. Total number of jobs with each job status
CREATE FUNCTION total_jobsNumber_each_jobStatus(@PK INT)
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblJob J
        JOIN tblJobStatus JS ON J.JobID = JS.JobID
        JOIN tblStatus S ON JS.StatusID = S.StatusID
        WHERE S.StatusID = @PK
)
RETURN @RET
END
GO

ALTER TABLE tblStatus
ADD TotalNumberEachJobStatus AS (dbo.total_jobsNumber_each_jobStatus(StatusID))
GO


-- 9. Number of members for each membership type
CREATE FUNCTION members_each_type(@PK INT)
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblMembership M
        JOIN tblMembershipType MT ON M.MembershipTypeID = MT.MembershipTypeID
        WHERE M.MembershipTypeID = @PK
)
RETURN @RET
END
GO

ALTER TABLE tblMembershipType
ADD MembersEachType AS (dbo.members_each_type(MembershipTypeID))
GO



-- COMPLEX QUERIES
USE INFO430_Proj_08

-- 1. Complex query: rank the top 10 industries by the number of OPEN job postings 
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

-- 2. Complex query: rank the companies with the highest average pay
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


-- 3. Complex query: rank the companies with the highest average pay for intership
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

-- 4. Average Salary Job Type
WITH
    CTE_TOP_SALARY_JOBTYPE(JobTypeID, JobTypeName, AvgSalary, RankingSalary)
    AS
    (
        SELECT JT.JobTypeID, JT.JobTypeName, SUM(J.Salary)/COUNT(J.JobID) AS AvgSalary,
            RANK() OVER (ORDER BY SUM(J.Salary)/COUNT(J.JobID) DESC) AS RankingPosting
        FROM tblJobType JT
            JOIN tblJob J ON JT.JobTypeID = J.JobTypeID
        GROUP BY JT.JobTypeID, JT.JobTypeName
    )
SELECT JobTypeID, JobTypeName, AvgSalary, RankingSalary
FROM CTE_TOP_SALARY_JOBTYPE
ORDER BY RankingSalary
GO

CREATE VIEW TOP_SALARY_JOBTYPE AS (
        SELECT JT.JobTypeID, JT.JobTypeName, SUM(J.Salary)/COUNT(J.JobID) AS AvgSalary,
            RANK() OVER (ORDER BY SUM(J.Salary)/COUNT(J.JobID) DESC) AS RankingPosting
        FROM tblJobType JT
            JOIN tblJob J ON JT.JobTypeID = J.JobTypeID
        GROUP BY JT.JobTypeID, JT.JobTypeName
    )
GO


-- 5. User who started a membership in the last month is active member, otherwise is nonactive member
SELECT (CASE
        WHEN StartDate > DATEADD(D, -90, GETDATE())
            THEN 'Active'
        ELSE 'Non-active'
        END) AS labelOfActive, COUNT(UserID) AS NumberOfUsers
FROM
(SELECT U.UserID, U.UserFname, U.UserLname, StartDate AS StartDate
    FROM tblUser U
    JOIN tblMembership M ON M.UserID = U.UserID
    GROUP BY U.UserID, U.UserFname, U.UserLname, M.StartDate) AS tempTable
GROUP BY (CASE
    WHEN StartDate > DATEADD(D, -90, GETDATE())
        THEN 'Active'
    ELSE 'Non-active'
    END)
GO

-- 6. Rank the 10 users that applied to the most number of jobs
WITH CTE_USER_APPLIED_JOBS(UserID, UserFname, UserLname, applied_jobs, RankingPosting)
    AS
    (
        SELECT U.UserID, U.UserFname, U.UserLname, COUNT(UJ.JobID) AS applied_jobs,
            RANK() OVER (ORDER BY COUNT(UJ.JobID) DESC) AS RankingPosting
        FROM tblUser U
            JOIN tblUserSeekingStatus USS ON U.UserID = USS.UserID
            JOIN tblSeekingStatus SS ON USS.SeekingStatusID = SS.SeekingStatusID
            JOIN tblUserJob UJ ON U.UserID = UJ.UserID
        WHERE SS.SeekingStatusName = 'Open to work'
        GROUP BY U.UserID, U.UserFname, U.UserLname
    )
SELECT UserID, UserFname, UserLname, applied_jobs, RankingPosting
FROM CTE_USER_APPLIED_JOBS
WHERE RankingPosting <= 10
ORDER BY RankingPosting
GO

CREATE VIEW CTE_USER_APPLIED_JOBS AS
    (
        SELECT U.UserID, U.UserFname, U.UserLname, COUNT(UJ.JobID) AS applied_jobs,
            RANK() OVER (ORDER BY COUNT(UJ.JobID) DESC) AS RankingPosting
        FROM tblUser U
            JOIN tblUserSeekingStatus USS ON U.UserID = USS.UserID
            JOIN tblSeekingStatus SS ON USS.SeekingStatusID = SS.SeekingStatusID
            JOIN tblUserJob UJ ON U.UserID = UJ.UserID
        WHERE SS.SeekingStatusName = 'Open to work'
        GROUP BY U.UserID, U.UserFname, U.UserLname
    )
GO


-- 7. Calculate the 33 to 66 percentile of cities by their average salaries.
WITH
    CTE_Cities_Salary(City, avgSalary, nTilePosting)
    AS
    (
        SELECT L.City, SUM(J.Salary) / COUNT(JL.JobID) AS avgSalary,
            NTILE(100) OVER (ORDER BY (SUM(J.Salary) / COUNT(JL.JobID)) DESC) AS nTilePosting
        FROM tblLocation L 
            JOIN tblJobLocation JL ON L.LocationID = JL.LocationID
            JOIN tblJob J ON JL.JobID = J.JobID
        GROUP BY L.City
    )
SELECT City, avgSalary, nTilePosting
FROM CTE_Cities_Salary
WHERE nTilePosting BETWEEN 33 AND 66
ORDER BY nTilePosting
GO

CREATE VIEW CTE_Cities_Salary AS
    (
        SELECT L.City, SUM(J.Salary) / COUNT(JL.JobID) AS avgSalary,
            NTILE(100) OVER (ORDER BY (SUM(J.Salary) / COUNT(JL.JobID)) DESC) AS nTilePosting
        FROM tblLocation L 
            JOIN tblJobLocation JL ON L.LocationID = JL.LocationID
            JOIN tblJob J ON JL.JobID = J.JobID
        GROUP BY L.City
    )
GO


USE INFO430_Proj_08

-- 8. FIND THE TOP INDUSTRIES BY SUM_SALARY OF ENTRY LEVEL JOBS
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


-- 9. FIND THE TOP 10 CXO JOBS BY SALARY IN INFORMATION TECHNOLOGY
WITH CTE_TOP_10_CXO_JOBS_BY_SALARY_IN_INFORMATION_TECHNOLOGY
AS (
	SELECT TOP 10 J.JobTitle, J.Salary, P.PositionName
	FROM tblJob J
		JOIN tblEmployer E ON J.EmployerID = E.EmployerID
		JOIN tblIndustry I ON E.IndustryID = I.IndustryID
		JOIN tblLevel L ON J.LevelID = L.LevelID
		JOIN tblPosition P ON J.PositionID = P.PositionID
	WHERE I.IndustryName = 'Information Technology' AND P.PositionName LIKE '%CHIEF%'
	ORDER BY J.Salary DESC)
SELECT JobTitle, Salary, PositionName
FROM CTE_TOP_10_CXO_JOBS_BY_SALARY_IN_INFORMATION_TECHNOLOGY
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
GO


-- MISCELLANEOUS: fix job title to not have '.' since it's breaking insertintouserjob
DECLARE @CURREM VARCHAR(200), @CURRPOS INT, @RAND INT, @CURRJOB INT, @RUN INT, @MATCHPOS INT
SET @RUN = (SELECT COUNT(*) FROM tblJob)
WHILE @RUN > 0
BEGIN
   SET @CURRJOB = @RUN
   SET @CURREM = (SELECT EmployerName FROM tblJob J JOIN tblEmployer E ON J.EmployerID = E.EmployerID AND J.JobID = @CURRJOB)
   SET @CURRPOS = (SELECT P.PositionID FROM tblJob J JOIN tblPosition P ON J.PositionID = P.PositionID AND J.JobID = @CURRJOB)
   SET @RAND = (CEILING(RAND() * 99999))
   IF (@CURREM like '%.%')
      SET @MATCHPOS = (SELECT CHARINDEX('.', @CURREM))
      SET @CURREM = SUBSTRING(@CURREM, 0, (@MATCHPOS))
   UPDATE tblJob 
   SET JobTitle = CONCAT(@CURREM, '') + '-' + CONCAT(@CURRPOS,'') + '-' + CONCAT(@RAND,'')
   WHERE JobID = @CURRJOB
SET @RUN = @RUN - 1
END