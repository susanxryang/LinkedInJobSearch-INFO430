USE INFO430_Proj_08
GO

-- Synthetic Tnx for UserJob

CREATE PROCEDURE getRoleID
@RName VARCHAR(50),
@RID INTEGER OUTPUT

AS
SET @RID = (
    SELECT RoleID
    FROM tblRole
    WHERE RoleName = @RName)
GO

/*
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
*/

/*
CREATE PROCEDURE getJobID 
@JobTitle varchar(100),
@JobID INT OUTPUT
AS
SET @JobID = (SELECT JobID
   FROM tblJob
   WHERE JobTitle = @JobTitle)
GO
*/

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
CREATE PROCEDURE generateUserJob
@JobID INTEGER,
@UserID INTEGER,
@RoleID INTEGER
AS

BEGIN TRANSACTION T1
INSERT INTO tblUserJob
VALUES(@JobID, @UserID, @RoleID)

IF @@ERROR <> 0
	BEGIN
		PRINT '@@ERROR does not equal 0, process terminating'
		ROLLBACK TRANSACTION T1
	END
ELSE
	COMMIT TRANSACTION T1
GO

-- Procedure for populating userjob
CREATE PROCEDURE [dbo].[wrapperUserJob]
AS
DECLARE @J_ID INTEGER, @U_ID INTEGER, @R_ID INTEGER
SET @RUN = 100000

WHILE @RUN > 0
	BEGIN
        SET @J_ID = @RUN
        SET @U_ID = @RUN
        SET @R_ID = @RUN

        IF @J_ID IS NULL OR @U_ID IS NULL OR @R_ID IS NULL
			BEGIN 
				PRINT 'A variable is NULL';
				THROW 55658, 'Variables cannot be NULL, process terminating', 1;
			END

EXEC generateUserJob
@JobID = @J_ID,
@UserID = @U_ID,
@RoleID = @R_ID

SET @RUN = @RUN - 1
END
GO