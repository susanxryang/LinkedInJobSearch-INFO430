USE INFO430_Proj_08
GO

-- stored procedures
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
SET @IndID = (SELECT IndustryID
FROM tblIndustry
WHERE IndustryName = @IndName
)
GO

-- Synthetic Tnx --
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

CREATE PROCEDURE [dbo].[wrapperEmployer]
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
    -- SET @RANDBus = (SELECT LEFT(CAST(RAND()*(SELECT COUNT(*) FROM PEEPS.dbo.Businesses) + 1 AS INT), 3))
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

SELECT COUNT(*) FROM tblEmployer
EXEC [wrapperEmployer]
SELECT * FROM tblEmployer

-- select * from PEEPS.dbo.Businesses

-- select * from tblStatus

-- DBCC CHECKIDENT(tblStatus, RESEED, 0)

-- DELETE FROM tblStatus WHERE StatusID = 5

-- INSERT INTO tblStatus(StatusName, StatusDescr)
-- VALUES('Closed', 'This job is no longer accepting applications')



-- SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
-- FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
-- WHERE TABLE_NAME='tblUser';

-- ALTER TABLE tblUser DROP CONSTRAINT FK__tblUser__Members__01142BA1
-- alter table tblUser drop COLUMN MembershipID
-- select * from tblUser