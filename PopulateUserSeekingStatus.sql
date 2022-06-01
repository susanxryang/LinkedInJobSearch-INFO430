USE INFO430_Proj_08
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

-- Synthetic Tnx --
CREATE PROCEDURE insertIntoUserSeekingStatus
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

CREATE PROCEDURE [dbo].[wrapperUserSeekingStatus]
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
SET @EndD = (SELECT DATEADD(D, 14, @StartD))
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

SELECT * FROM
tblUserSeekingStatus

SELECT * FROM
tblStatus