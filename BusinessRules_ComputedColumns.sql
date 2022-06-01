USE INFO430_Proj_08
GO

-- ALTER TABLE tblJob DROP COLUMN NumberOfApplicants
-- GO
/*
Business Rule: Influencer can only apply to jobs with the level executive
 */

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

/*
Business Rule: Users cannot add a premium membership within 3 months of their last membership expiring
 */

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

/*
Business Rule: Age < 30 cannot apply to senior level positions
 */

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

/*
Computed Column: The number of job postings for each company
 */

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

/*
Computed Column: The number of job postings for each level
 */

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



-- Business rules Susan
-- No one can apply to closed or archived jobs 
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

-- All US software engineer positions has salary > 80k
CREATE FUNCTION xuanry_fn_sde80k()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
    IF EXISTS (SELECT *
    FROM tblJob J
        JOIN tblJobLocation JL ON JL.JobID = J.JobID
        JOIN tblLocation L ON L.LocationID = JL.LocationID
    WHERE L.Country = 'USA' 
        AND J.Salary <= 80000)
BEGIN
        SET @RET = 1
    END
    RETURN @RET
END
GO

ALTER TABLE tblUserJob with nocheck
ADD CONSTRAINT CK_NoSde80k
CHECK (dbo.xuanry_fn_sde80k() = 0)
GO


-- computed columns Susan
use INFO430_Proj_08
GO
/*
Computed Column: The number of female applicants for a job
 */

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

/*
Computed Column: The number of male applicants for an job
 */

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