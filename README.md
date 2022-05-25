# LinkedInJobSearch-INFO430
Tables:
- [x] UserType (regular vs influencer)
- [ ] Gender
- [x] MemebershipType
- [ ] Membership (GetID)
- [ ] User

- [x] UserSeekingStatus
- [ ] JobStatus
- [x] SeekingStatus
- [x] Status (ONLY job status(active, closed)!!)
- [ ] UserJob

- [x] Role (recruiter vs applicant)
- [ ] Job
- [ ] Employer
- [x] EmployerSize
- [x] Industry

- [ ] Location
- [ ] JobLocation
- [ ] JobType (part-time, full-time, contract/seasonal, internship, apprenticeship)
- [ ] Level (Junior, Mid-level, Senior, Exec)
- [ ] Position



Business rules: (check assignments in google doc: https://docs.google.com/document/d/1o_oB73rdUzYbMu2MnjwLHFvSWBbpU8-GPFMmLb29F7A/edit)
- [ ] User cannot cancel and restart membership within 3 month period (membership)
- [ ] Influencer can only apply to exec jobs (user type)
- [ ] Age < 30 cannot apply to senior positions (position)
- [ ] Age <18 cannot apply to jobs
- [ ] Cannot apply to jobs during national holiday Christmas (job status)
- [ ] Age >24 cannot apply to internships
- [ ] Any job higher than mid level cannot be part-time or intern or apprenticeship
- [ ] One user cannot apply to same job twice (user job)
- [ ] One user cannot be both recruiter and applicant for one job (user job)
- [ ] One cannot apply to closed jobs (job)
- [ ] Exec position must have salary > 200k
- [ ] All employers must have at least 1 US location
- [ ] All US positions has salary > 16k


Computed columns: (check assignments in google doc)
- [ ] Number of applicants for each job
- [ ] Number of applicants for each company
- [ ] Number of internship positions at different time of year
- [ ] Number of postings for each company
- [ ] Number of postings for each job level
- [ ] Total number of jobs with each job status
- [ ] Number of current subscribed members
- [ ] Number of female vs male applicant for a job
- [ ] Number of female vs male applicant for an industry
