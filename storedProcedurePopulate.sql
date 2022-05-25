-- USE INFO430_Proj_08
 
-- EASY stored procedures
CREATE PROCEDURE getUserTypeID
@UserTypeN varchar(50),
@UseTypID INT OUTPUT
AS
SET @UseTypID = (SELECT UserTypeID
   FROM tblUserType
   WHERE UserTypeName = @UserTypeN)
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
@Prononny varchar(50)
@GendID INT OUTPUT
AS
SET @GendID = (SELECT GenderID
   FROM tblGender
   WHERE GenderName = @GendNam
   AND Pronouns = @Prononny
)
GO
 
CREATE PROCEDURE getUserID -- Ran once, works!
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
 
-- EASY stored procedures
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
 
 
-- Synthetic Tnx --
-- USE INFO430_Proj_08
 
INSERT INTO tblUser (UserFname, UserLname, UserDOB)
SELECT CustomerFname, CustomerLname, DateOfBirth FROM PEEPS.dbo.tblCUSTOMER
select TOP 3 * FROM tblUser
 
 
-- GetID stored procedures
CREATE PROCEDURE getUserTypeID
@UserTypeN varchar(50),
@UseTypID INT OUTPUT
AS
SET @UseTypID = (SELECT UserTypeID
   FROM tblUserType
   WHERE UserTypeName = @UserTypeN)
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
@Prononny varchar(50)
@GendID INT OUTPUT
AS
SET @GendID = (SELECT GenderID
   FROM tblGender
   WHERE GenderName = @GendNam
   AND Pronouns = @Prononny
)
GO
 
ALTER PROCEDURE getUserID -- Ran once, works!
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
 
 
-- Synthetic Tnx User table
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
 
-- Add wrapper (part of syn tnx)
ALTER PROCEDURE [dbo].[wrapperUser]
AS
DECLARE @Firy varchar(50), @Lasy varchar(50), @Pronnys varchar(50), @Genny varchar(50),
@Dobenie DATE, @UTypee varchar(50), @RUN INT, @RANDUserTypeID FLOAT, @RANDGenderTypeID FLOAT,
@RANDUserID FLOAT
SET @RUN = (SELECT COUNT(*) FROM tblUser)
WHILE @RUN > 0
BEGIN
   SET @RANDUserTypeID = (SELECT LEFT(CAST(RAND() * 2 + 1 AS INT), 3))
   SET @RANDGenderTypeID = (SELECT LEFT(CAST(RAND() * 3 + 1 AS INT), 3))
   SET @RANDUserID = (SELECT LEFT(CAST(RAND() * 1000 AS INT), 3))
   SET @Firy = (SELECT UserFname FROM tblUser WHERE UserID = @RANDUserID)
   SET @Lasy = (SELECT UserLname FROM tblUser WHERE UserID = @RANDUserID)
   SET @Pronnys = (SELECT Pronouns FROM tblGender WHERE GenderID = @RANDGenderTypeID)
   SET @Genny = (SELECT GenderName FROM tblGender WHERE GenderID = @RANDGenderTypeID)
   SET @Dobenie = (SELECT UserDOB FROM tblUSER WHERE UserID = @RANDUserID)
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
 
-- execute insert User
EXEC [wrapperUser] -- error b/c user has null values
GO
 
 
-- Synthetic Tnx Membership table --
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
   PRINT @U_ID
  BEGIN
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
 
ALTER PROCEDURE [dbo].[wrapperMembership]
AS
DECLARE @Stary VARCHAR(50), @Eny VARCHAR(50), @Fna VARCHAR(50), @Lna VARCHAR(50),
@Dobb DATE, @MembTypee VARCHAR(100), @RUN INT, @RANDUser FLOAT, @RANDMemType FLOAT
SET @RUN = 1 -- (SELECT COUNT(*) FROM tblUser)
WHILE @RUN > 0
BEGIN
SET @RANDUser = (SELECT LEFT(CAST(RAND()* (SELECT COUNT(*) FROM tblUser) AS INT), 3))
SET @RANDMemType = (SELECT LEFT(CAST(RAND()*2 + 1 AS INT), 3))
SET @Fna = (SELECT UserFname FROM tblUser WHERE UserID = @RANDUser)
SET @Lna = (SELECT UserLname FROM tblUser WHERE UserID = @RANDUser)
SET @Stary = (SELECT GETDATE() - RAND()*1000)
SET @Eny = (SELECT DATEADD(D, 14, @Stary)) -- (SELECT GETDATE() - RAND()*100)
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
@Fnamm = Fna,
@Lnamm = Lna,
@Dobie = @Dobb,
@MembType = @MembTypee
 
SET @RUN = @RUN - 1
END
SELECT COUNT(*) FROM tblMembership
EXEC [wrapperMembership]
SELECT COUNT(*) FROM tblMembership
GO

--  Jacob Code, Populating JobStatus 

-- Get StatusID Procedure
CREATE PROCEDURE strozj_getStatusID
@StatusName varchar(50),
@S_ID INTEGER OUTPUT

AS
SET @S_ID = (SELECT StatusID FROM tblStatus S WHERE S.StatusName = @StatusName)

GO

CREATE PROCEDURE strozj_getJobID
@JobTypeID INT,
@LevelID INT,
@EmployerID INT,
@PositionID INT,
@J_ID INTEGER OUTPUT

AS
SET @J_ID = (SELECT JobID FROM tblJob J WHERE J.JobTypeID = @JobTypeID AND J.LevelID = @LevelID AND J.EmployerID = @EmployerID AND J.PositionID = @PositionID)

GO

-- Procedure for inserting specific rows into JobStatus
CREATE PROCEDURE strozj_insertIntoJobStatus
@JobType_ID INTEGER,
@Level_ID INTEGER,
@Employer_ID INTEGER,
@Position_ID INTEGER,
@Status_Name varchar(50),
@StartDate DATE,
@EndDate DATE
AS
DECLARE @Job_ID INT, @Status_ID INT

EXEC strozj_getJobID
@JobTypeID = @JobType_ID,
@LevelID = @Level_ID,
@EmployerID = @Employer_ID,
@PositionID = @Position_ID,
@J_ID = @Job_ID OUTPUT

IF @Job_ID IS NULL
	BEGIN
		PRINT '@Job_ID is NULL';
		THROW 55658, 'Job_ID cannot be NULL, process terminating', 1;
	END

EXEC strozj_getStatusID
@StatusName = @Status_Name,
@S_ID = @Status_ID OUTPUT

IF @Status_ID IS NULL
	BEGIN
		PRINT '@Status_ID is NULL';
		THROW 55658, 'Status_ID cannot be NULL, process terminating', 1;
	END

BEGIN TRANSACTION T1
INSERT INTO tblJobStatus
VALUES(@Job_ID, @Status_ID, @StartDate, @EndDate)

IF @@ERROR <> 0
	BEGIN
		PRINT '@@ERROR does not equal 0, process terminating'
		ROLLBACK TRANSACTION T1
	END
ELSE
	COMMIT TRANSACTION T1

GO

-- Procedure for generating a job status off of existing IDs
CREATE PROCEDURE strozj_generateJobStatus
@JobID INTEGER,
@StatusID INTEGER,
@StartDate DATE,
@EndDate DATE

AS

BEGIN TRANSACTION T1
INSERT INTO tblJobStatus
VALUES(@JobID, @StatusID, @StartDate, @EndDate)

IF @@ERROR <> 0
	BEGIN
		PRINT '@@ERROR does not equal 0, process terminating'
		ROLLBACK TRANSACTION T1
	END
ELSE
	COMMIT TRANSACTION T1

GO

-- Procedure for populating JobStatus
CREATE PROCEDURE [dbo].[wrapperJobStatus]
AS
DECLARE @Job_ID INTEGER, @Status_ID INTEGER, @Start_Date DATE, @End_Date DATE, @RUN INTEGER

SET @RUN = (SELECT COUNT(*) FROM tblJob)

WHILE @RUN > 0
	BEGIN

		SET @Job_ID = @RUN
		SET @Status_ID = (SELECT FLOOR(RAND() * (8-(5+1))+5)) -- Select random StatusID (1 (Open) or 2 (Closed))
		SET @Start_Date = (SELECT GETDATE() - RAND()*1000)
		SET @End_Date =  (SELECT DATEADD(DAY, 14, @Start_Date))

		IF @Job_ID IS NULL OR @Status_ID IS NULL OR @Start_Date IS NULL OR @End_Date IS NULL
			BEGIN 
				PRINT 'A variable is NULL';
				THROW 55658, 'Variables cannot be NULL, process terminating', 1;
			END

		EXEC strozj_generateJobStatus
		@JobID = @Job_ID,
		@StatusID = @Status_ID,
		@StartDate = @Start_Date,
		@EndDate = @End_Date

		SET @RUN = @RUN -1

	END

GO
