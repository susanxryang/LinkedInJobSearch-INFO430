USE INFO430_Proj_08
GO

-- Business Rules
-- 1. Any job higher than mid level cannot be part-time or intern or apprenticeship
CREATE FUNCTION no_partTime_mid_level_higher()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
		SELECT * FROM tblUserJob UJ
			JOIN tblJob J ON UJ.JobID = J.JobID
			JOIN tblLevel L ON J.LevelID = L.LevelID
            JOIN tblJobType JT ON J.JobTypeID = JT.JobTypeID
		WHERE L.LevelName = 'Junior' 
        OR L.LevelName = 'Associate'
        OR L.LevelName = 'Entry-level'
        AND JT.JobTypeName = 'Internship'
        OR JT.JobTypeName = 'Apprenticeship'
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblUserJob WITH NOCHECK
ADD CONSTRAINT Mid_Level_Higher_JobType_Restriction
CHECK (dbo.no_partTime_mid_level_higher() = 0)
GO

-- 2. One user cannot apply to same job twice (user job)
CREATE FUNCTION same_job_apply_only_once()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
		SELECT * FROM tblUserJob UJ
			JOIN tblJob J ON UJ.JobID = J.JobID
            JOIN tblUser U ON UJ.UserID = U.UserID
		WHERE U.UserID = UJ.UserID AND J.JobID = UJ.JobID
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblUserJob WITH NOCHECK
ADD CONSTRAINT Same_User_Same_Job_Restriction
CHECK (dbo.same_job_apply_only_once() = 0)
GO

-- 3. One user cannot be both recruiter and applicant for one job (user job)
CREATE FUNCTION cannot_both_recruiter_applicant()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
    IF EXISTS(
		SELECT * FROM tblUserJob UJ
		WHERE UJ.RoleID = 1 AND UJ.RoleID = 2
        )
    SET @RET = 1
    RETURN @RET
END
GO

ALTER TABLE tblUserJob WITH NOCHECK
ADD CONSTRAINT Both_Recruiter_Applicant_Restriction
CHECK (dbo.cannot_both_recruiter_applicant() = 0)
GO


-- Computed Columns
-- 1. Total number of jobs with each job status
CREATE FUNCTION total_jobsNumber_each_jobStatus(@PK INT)
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblJob J
        JOIN tblJobStatus JS ON J.JobID = JS.JobID
        WHERE J.EmployerID = @PK
)
RETURN @RET
END
GO


-- 2. Number of current subscribed members
CREATE FUNCTION current_subscribed_members(@PK INT)
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = (
    SELECT COUNT(*) FROM tblMembership M
        JOIN tblMembershipType MT ON M.MembershipTypeID = MT.MembershipTypeID
        WHERE M.UserID = @PK AND MT.MembershipTypeName = 'Premium'
)
RETURN @RET
END
GO

SELECT * FROM tblMembershipType