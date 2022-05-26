CREATE DATABASE INFO430_Proj_08
-- BACKUP DATABASE INFO430_Proj_8 TO DISK = '/Users/susanyang/Desktop/INFO430'
BACKUP DATABASE INFO430_Proj_08 TO DISK = 'C:\SQL\INFO430_Proj_08.BAK'

USE INFO430_Proj_08
GO
 
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
NumberOfApplicants INTEGER NOT NULL,
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
StatusDescr VARCHAR(200) NULL,);
 
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


select * from tblGender