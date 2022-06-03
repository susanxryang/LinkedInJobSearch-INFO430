USE INFO430_Proj_08
 
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
 
-- CREATE PROCEDURE getUserID -- Ran once, works!
-- @UserFNam varchar(50),
-- @UserLnam varchar(200),
-- @DOBBY DATE,
-- @Usy_ID INT OUTPUT
-- AS
-- SET @Usy_ID = (SELECT UserID
--    FROM tblUser
--    WHERE UserFname = @UserFNam
--    AND UserLname = @UserLnam
--    AND UserDOB = @DOBBY)
-- GO
 
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
 
-- INSERT INTO tblUser (UserFname, UserLname, UserDOB)
-- SELECT CustomerFname, CustomerLname, DateOfBirth FROM PEEPS.dbo.tblCUSTOMER
-- select TOP 3 * FROM tblUser
 
 
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
@Dobenie DATE, @UTypee varchar(50), @RUN INT, @RANDUserTypeID INT, @RANDGenderTypeID INT,
@RANDUserID INT
SET @RUN = (SELECT COUNT(*) FROM PEEPS.dbo.tblCUSTOMER)
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
   -- PRINT(@RANDUserTypeID + ',' + @RANDGenderTypeID  + ',' +  @RANDUserID  + ',' +  @Firy + ',' +  
   -- @Lasy + ',' +  @Pronnys + ',' +  @Genny + ',' +  @Dobenie + ',' +  @UTypee)
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
-- SELECT * FROM tblUser

 
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
 
ALTER PROCEDURE [dbo].[wrapperMembership]
AS
DECLARE @Stary VARCHAR(50), @Eny VARCHAR(50), @Fna VARCHAR(50), @Lna VARCHAR(50),
@Dobb DATE, @MembTypee VARCHAR(100), @RUN INT, @RANDUser FLOAT, @RANDMemType FLOAT
SET @RUN = (SELECT COUNT(*) FROM tblUser)
WHILE @RUN > 0
BEGIN
SET @RANDUser = (SELECT FLOOR(CAST(RAND()* (SELECT COUNT(*) FROM tblUser) AS INT)))
SET @RANDMemType = (SELECT FLOOR(CAST(RAND()*2 + 1 AS INT)))
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
@Fnamm = @Fna,
@Lnamm = @Lna,
@Dobie = @Dobb,
@MembType = @MembTypee
 
SET @RUN = @RUN - 1
END

SELECT COUNT(*) FROM tblUser
SELECT * FROM tblMembership
EXEC [wrapperMembership]
SELECT COUNT(*) FROM tblMembership
GO

--  Jacob Code, Populating JobStatus 

-- Get StatusID Procedure
CREATE PROCEDURE getStatusID
@StatusName varchar(50),
@S_ID INTEGER OUTPUT

AS
SET @S_ID = (SELECT StatusID FROM tblStatus S WHERE S.StatusName = @StatusName)

GO

-- Get JobID Procedure
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


-- Synthetic Tnx to Insert into Employer --
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

-- DBCC CHECKIDENT(tblUser, RESEED, 0)

ALTER PROCEDURE [dbo].[wrapperEmployer]
AS
DECLARE @EName varchar(50),
@EDescr varchar(200),
@CiName varchar(200),
@CoName varchar(200),
@ESizeName varchar(50),
@IName varchar(50), 
@RANDLoc INT, @RANDEmpSize INT, @RANDInd INT, @RUN INT
SET @RUN = (SELECT COUNT(*) FROM PEEPS.dbo.Businesses)
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

--  Jacob Code, Populating JobStatus 

-- Get StatusID Procedure
CREATE PROCEDURE getStatusID
@StatusName varchar(50),
@S_ID INTEGER OUTPUT

AS
SET @S_ID = (SELECT StatusID FROM tblStatus S WHERE S.StatusName = @StatusName)

GO

-- Procedure for inserting specific rows into JobStatus
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

-- Procedure for populating JobStatus
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
		SET @EndDate =  (SELECT DATEADD(DAY, 14, @StartDate))

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

-- JobLocation Population Code

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


-- Procedure for populating JobLocation with locationID from Employer table

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

-- Synthetic Tnx for tblUserSeekingStatus

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
AS
DECLARE @StartD DATE, @EndD DATE, @F_Name VARCHAR(50), @L_Name VARCHAR(50), 
        @Birthy DATE, @Seeking_Status_Name VARCHAR(50), @RUN INT, @RANDUser FLOAT, 
        @RANDSeekName FLOAT
SET @RUN = (SELECT COUNT(*) FROM tblUser)
WHILE @RUN > 0
BEGIN
SET @RANDUser = (SELECT LEFT(CAST(RAND()*1000 AS INT), 3))
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

EXEC wrapperUserSeekingStatus


----- Synthetic Tnx for UserJob -------

CREATE PROCEDURE getRoleID
@RName VARCHAR(50),
@RID INTEGER OUTPUT

AS
SET @RID = (
    SELECT RoleID
    FROM tblRole
    WHERE RoleName = @RName)
GO


CREATE PROCEDURE insertIntoUserJob
@UserF VARCHAR(50),
@UserL VARCHAR(50),
@JobT VARCHAR(100),
@RoleNamy VARCHAR(50)
AS
DECLARE @J_ID INT, @U_ID INT, @R_ID INT

EXEC getUserID
@UserFNam = @UserF,
@UserLNam = @UserL,
@Usy_ID = @U_ID OUTPUT

IF @U_ID IS NULL
    BEGIN
        PRINT '@U_ID is NULL';
        THROW 55656, '@U_ID cannot be NULL; process is terminating', 1;
    END

EXEC getJobID
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

-- Procedure for generating a userjob off of existing IDs
ALTER PROCEDURE generateUserJob
@Job_ID INTEGER,
@User_ID INTEGER,
@Role_ID INTEGER
AS

BEGIN TRANSACTION T1
INSERT INTO tblUserJob (JobID, UserID, RoleID)
VALUES(@Job_ID, @User_ID, @Role_ID)

IF @@ERROR <> 0
	BEGIN
		PRINT '@@ERROR does not equal 0, process terminating'
		ROLLBACK TRANSACTION T1
	END
ELSE
	COMMIT TRANSACTION T1
GO

-- Procedure for populating userjob
ALTER PROCEDURE [dbo].[wrapperUserJob]
AS
DECLARE @J_ID INTEGER, @U_ID INTEGER, @R_ID INTEGER, @RUN INTEGER
SET @RUN = (SELECT COUNT(*) FROM tblUser)

WHILE @RUN > 0
	BEGIN
        SET @J_ID = (SELECT LEFT(CAST(RAND()* (SELECT COUNT(*) FROM tblJob) AS INT), 3))
        SET @U_ID = (SELECT LEFT(CAST(RAND()* (SELECT COUNT(*) FROM tblUser) AS INT), 3))
        SET @R_ID = 2

        IF @J_ID IS NULL OR @U_ID IS NULL OR @R_ID IS NULL
			BEGIN 
				PRINT 'A variable is NULL';
				THROW 55658, 'Variables cannot be NULL, process terminating', 1;
			END
        INSERT INTO tblUserJob(JobID, UserID, RoleID)
        VALUES(@J_ID, @U_ID,@R_ID)
        SET @RUN = @RUN - 1
END
GO

EXEC wrapperUserJob
