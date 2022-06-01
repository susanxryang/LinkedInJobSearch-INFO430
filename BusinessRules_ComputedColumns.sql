USE INFO430_Proj_08
GO
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





