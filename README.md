# LinkedInJobSearch-INFO430
Tables:
- [x] UserType (regular vs influencer)
- [x] Gender
- [x] MemebershipType
- [x] Membership (Jason)
- [x] User (Jason)

- [x] UserSeekingStatus
- [x] JobStatus (Jerray)
- [x] SeekingStatus
- [x] Status (ONLY job status(active, closed)!!)
- [x] UserJob (Jerray)

- [x] Role (recruiter vs applicant)
- [x] Job (Susan)
- [x] Employer (Susan)
- [x] EmployerSize
- [x] Industry

- [x] Location (Jacob)
- [x] JobLocation (Jacob)
- [x] JobType (part-time, full-time, contract/seasonal, internship, apprenticeship)
- [x] Level (Junior, Mid-level, Senior, Exec)
- [x] Position



Business rules: (check assignments in google doc: https://docs.google.com/document/d/1o_oB73rdUzYbMu2MnjwLHFvSWBbpU8-GPFMmLb29F7A/edit)
- [x] User cannot cancel and restart membership within 3 month period (membership)
- [x] Influencer can only apply to exec jobs (user type)
- [x] Age < 30 cannot apply to senior positions (position)
- [x] Age <18 cannot apply to jobs
- [Removed] Cannot apply to jobs during national holiday Christmas (job status)
- [x] Age >24 cannot apply to internships
- [x] Any job higher than mid level cannot be part-time or intern or apprenticeship
- [x] One user cannot apply to same job twice (user job)
- [x] One user cannot be both recruiter and applicant for one job (user job)
- [x] One cannot apply to closed jobs (job)
- [x] Exec position must have salary > 200k
- [x] All employers must have at least 1 US location
- [x] All US software engineer positions has salary > 80k


Computed columns: (check assignments in google doc)
- [X] Number of applicants for each job
- [X] Number of applicants for each company
- [X] Number of internship positions per company
- [x] Number of postings for each company
- [x] Number of postings for each job level
- [x] Total number of jobs with each job status
- [x] Number of members for each membership type
- [x] Number of female vs male applicant for a job
- [x] Number of female vs male applicant for an industry
