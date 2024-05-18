-- Creates MySQL tables for the SAMHSA TEDS crosswalk from the codebook.pdf found at
-- https://www.datafiles.samhsa.gov/dataset/treatment-episode-data-set-admissions-2020-teds-2020-ds0001
-- https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2021/TEDS-D-2021-datasets/TEDS-D-2021-DS0001/TEDS-D-2021-DS0001-info/TEDS-D-2021-DS0001-info-codebook.pdf
-- https://www.datafiles.samhsa.gov/sites/default/files/field-uploads-protected/studies/TEDS-D-2020/TEDS-D-2020-datasets/TEDS-D-2020-DS0001/TEDS-D-2020-DS0001-info/TEDS-D-2020-DS0001-info-codebook.pdf
-- Use this followed by running the query in the TEDS_conversion.sql file to 
-- change the TEDS-A data from the numeric codes to human readable format.

drop table if exists TEDS_XWALK_AGE;
drop table if exists TEDS_XWALK_ARRESTS;
drop table if exists TEDS_XWALK_ARRESTS_D;
drop table if exists TEDS_XWALK_DAYWAIT;
drop table if exists TEDS_XWALK_DETNLF;
drop table if exists TEDS_XWALK_DETNLF_D;
drop table if exists TEDS_XWALK_DIVISION;
drop table if exists TEDS_XWALK_EDUC;
drop table if exists TEDS_XWALK_EMPLOY;
drop table if exists TEDS_XWALK_EMPLOY_D;
drop table if exists TEDS_XWALK_ETHNIC;
drop table if exists TEDS_XWALK_GENDER;
drop table if exists TEDS_XWALK_LIVARAG;
drop table if exists TEDS_XWALK_LIVARAG_D;
drop table if exists TEDS_XWALK_MARSTAT;
drop table if exists TEDS_XWALK_METHUSE;
drop table if exists TEDS_XWALK_PREG;
drop table if exists TEDS_XWALK_PRIMINC;
drop table if exists TEDS_XWALK_RACE;
drop table if exists TEDS_XWALK_REASON;
drop table if exists TEDS_XWALK_REGION;
drop table if exists TEDS_XWALK_SERVICES;
drop table if exists TEDS_XWALK_SERVICES_D;
drop table if exists TEDS_XWALK_STFIPS;
drop table if exists TEDS_XWALK_VET;
drop table if exists TEDS_XWALK_ALCDRUG;
drop table if exists TEDS_XWALK_ALCFLG   ;
drop table if exists TEDS_XWALK_AMPHFLG  ;
drop table if exists TEDS_XWALK_BARBFLG  ;
drop table if exists TEDS_XWALK_BENZFLG  ;
drop table if exists TEDS_XWALK_COKEFLG  ;
drop table if exists TEDS_XWALK_DETCRIM  ;
drop table if exists TEDS_XWALK_DSMCRIT  ;
drop table if exists TEDS_XWALK_FREQ1    ;
drop table if exists TEDS_XWALK_FREQ1_D  ;
drop table if exists TEDS_XWALK_FREQ2    ;
drop table if exists TEDS_XWALK_FREQ2_D  ;
drop table if exists TEDS_XWALK_FREQ3    ;
drop table if exists TEDS_XWALK_FREQ3_D  ;
drop table if exists TEDS_XWALK_FRSTUSE1 ;
drop table if exists TEDS_XWALK_FRSTUSE2 ;
drop table if exists TEDS_XWALK_FRSTUSE3 ;
drop table if exists TEDS_XWALK_HALLFLG  ;
drop table if exists TEDS_XWALK_HERFLG   ;
drop table if exists TEDS_XWALK_HLTHINS  ;
drop table if exists TEDS_XWALK_IDU      ;
drop table if exists TEDS_XWALK_INHFLG   ;
drop table if exists TEDS_XWALK_LOS      ;
drop table if exists TEDS_XWALK_MARFLG   ;
drop table if exists TEDS_XWALK_METHFLG  ;
drop table if exists TEDS_XWALK_MTHAMFLG ;
drop table if exists TEDS_XWALK_NOPRIOR  ;
drop table if exists TEDS_XWALK_OPSYNFLG ;
drop table if exists TEDS_XWALK_OTCFLG   ;
drop table if exists TEDS_XWALK_OTHERFLG ;
drop table if exists TEDS_XWALK_PCPFLG   ;
drop table if exists TEDS_XWALK_PRIMPAY  ;
drop table if exists TEDS_XWALK_PSOURCE  ;
drop table if exists TEDS_XWALK_PSYPROB  ;
drop table if exists TEDS_XWALK_ROUTE1   ;
drop table if exists TEDS_XWALK_ROUTE2   ;
drop table if exists TEDS_XWALK_ROUTE3   ;
drop table if exists TEDS_XWALK_SEDHPFLG ;
drop table if exists TEDS_XWALK_STIMFLG  ;
drop table if exists TEDS_XWALK_SUB1     ;
drop table if exists TEDS_XWALK_SUB1_D   ;
drop table if exists TEDS_XWALK_SUB2     ;
drop table if exists TEDS_XWALK_SUB2_D   ;
drop table if exists TEDS_XWALK_SUB3     ;
drop table if exists TEDS_XWALK_SUB3_D   ;
drop table if exists TEDS_XWALK_TRNQFLG  ;




-- AGE: Age at admission
CREATE TABLE `TEDS_XWALK_AGE` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_AGE (id, value) values (1,	"12-14 years");
insert into TEDS_XWALK_AGE (id, value) values (2,	"15-17 years");
insert into TEDS_XWALK_AGE (id, value) values (3,	"18-20 years");
insert into TEDS_XWALK_AGE (id, value) values (4,	"21-24 years");
insert into TEDS_XWALK_AGE (id, value) values (5,	"25-29 years");
insert into TEDS_XWALK_AGE (id, value) values (6,	"30-34 years");
insert into TEDS_XWALK_AGE (id, value) values (7,	"35-39 years");
insert into TEDS_XWALK_AGE (id, value) values (8,	"40-44 years");
insert into TEDS_XWALK_AGE (id, value) values (9,	"45-49 years");
insert into TEDS_XWALK_AGE (id, value) values (10, "50-54 years");
insert into TEDS_XWALK_AGE (id, value) values (11, "55-64 years");
insert into TEDS_XWALK_AGE (id, value) values (12, "65 years and older");


-- GENDER: Gender
CREATE TABLE `TEDS_XWALK_GENDER` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_GENDER (id, value) values (1,	"Male");
insert into TEDS_XWALK_GENDER (id, value) values (2,	"Female");
insert into TEDS_XWALK_GENDER (id, value) values (-9,	"Missing/unknown/not collected/invalid");


-- RACE: Race
CREATE TABLE `TEDS_XWALK_RACE` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_RACE (id, value) values (1, "Alaska Native (Aleut, Eskimo, Indian)");
insert into TEDS_XWALK_RACE (id, value) values (2, "American Indian (other than Alaska Native)");
insert into TEDS_XWALK_RACE (id, value) values (3, "Asian or Pacific Islander");
insert into TEDS_XWALK_RACE (id, value) values (4, "Black or African American");
insert into TEDS_XWALK_RACE (id, value) values (5, "White");
insert into TEDS_XWALK_RACE (id, value) values (6, "Asian");
insert into TEDS_XWALK_RACE (id, value) values (7, "Other single race");
insert into TEDS_XWALK_RACE (id, value) values (8, "Two or more races");
insert into TEDS_XWALK_RACE (id, value) values (9, "Native Hawaiian or Other Pacific Islander");
insert into TEDS_XWALK_RACE (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- ETHNIC: Ethnicity
CREATE TABLE `TEDS_XWALK_ETHNIC` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ETHNIC (id, value) values (1, "Puerto Rican");
insert into TEDS_XWALK_ETHNIC (id, value) values (2, "Mexican");
insert into TEDS_XWALK_ETHNIC (id, value) values (3, "Cuban or other specific Hispanic");
insert into TEDS_XWALK_ETHNIC (id, value) values (4, "Not of Hispanic or Latino origin");
insert into TEDS_XWALK_ETHNIC (id, value) values (5, "Hispanic or Latino, specific origin not specified");
insert into TEDS_XWALK_ETHNIC (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- MARSTAT: Marital status
CREATE TABLE `TEDS_XWALK_MARSTAT` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_MARSTAT (id, value) values (1, "Never married");
insert into TEDS_XWALK_MARSTAT (id, value) values (2, "Now married");
insert into TEDS_XWALK_MARSTAT (id, value) values (3, "Separated");
insert into TEDS_XWALK_MARSTAT (id, value) values (4, "Divorced, widowed");
insert into TEDS_XWALK_MARSTAT (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- EDUC: Education
CREATE TABLE `TEDS_XWALK_EDUC` (
  `id` int NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_EDUC (id, value) values (1, "Less than one school grade, no schooling, nursery school, or kindergarten to Grade 8");
insert into TEDS_XWALK_EDUC (id, value) values (2, "Grades 9 to 11");
insert into TEDS_XWALK_EDUC (id, value) values (3, "Grade 12 (or GED)");
insert into TEDS_XWALK_EDUC (id, value) values (4, "1-3 years of college, university, or vocational school");
insert into TEDS_XWALK_EDUC (id, value) values (5, "4 years of college, university, BA/BS, some postgraduate study, or more");
insert into TEDS_XWALK_EDUC (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- employment status at admission
CREATE TABLE `TEDS_XWALK_EMPLOY` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_EMPLOY (id, value) values (1, "Full-time");
insert into TEDS_XWALK_EMPLOY (id, value) values (2, "Part-time");
insert into TEDS_XWALK_EMPLOY (id, value) values (3, "Unemployed");
insert into TEDS_XWALK_EMPLOY (id, value) values (4, "Not in labor force");
insert into TEDS_XWALK_EMPLOY (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- employment status at discharge
CREATE TABLE `TEDS_XWALK_EMPLOY_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_EMPLOY_D (id, value) values (1, "Full-time");
insert into TEDS_XWALK_EMPLOY_D (id, value) values (2, "Part-time");
insert into TEDS_XWALK_EMPLOY_D (id, value) values (3, "Unemployed");
insert into TEDS_XWALK_EMPLOY_D (id, value) values (4, "Not in labor force");
insert into TEDS_XWALK_EMPLOY_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- DETNLF: Detailed not in labor force category at admission
CREATE TABLE `TEDS_XWALK_DETNLF` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_DETNLF (id, value) values (1, "Homemaker");
insert into TEDS_XWALK_DETNLF (id, value) values (2, "Student");
insert into TEDS_XWALK_DETNLF (id, value) values (3, "Retired, disabled");
insert into TEDS_XWALK_DETNLF (id, value) values (4, "Resident of institution");
insert into TEDS_XWALK_DETNLF (id, value) values (5, "Other");
insert into TEDS_XWALK_DETNLF (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- DETNLF_D: Detailed not in labor force category at discharge
CREATE TABLE `TEDS_XWALK_DETNLF_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_DETNLF_D (id, value) values (1, "Homemaker");
insert into TEDS_XWALK_DETNLF_D (id, value) values (2, "Student");
insert into TEDS_XWALK_DETNLF_D (id, value) values (3, "Retired, disabled");
insert into TEDS_XWALK_DETNLF_D (id, value) values (4, "Resident of institution");
insert into TEDS_XWALK_DETNLF_D (id, value) values (5, "Other");
insert into TEDS_XWALK_DETNLF_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- PREG: Pregnant at admission
-- Guidelines: All male clients were recoded to missing for this variable due to the item being not applicable.
CREATE TABLE `TEDS_XWALK_PREG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_PREG (id, value) values (1, "Yes");
insert into TEDS_XWALK_PREG (id, value) values (2, "No");
insert into TEDS_XWALK_PREG (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- VET: Veteran status
CREATE TABLE `TEDS_XWALK_VET` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_VET (id, value) values (1, "Yes");
insert into TEDS_XWALK_VET (id, value) values (2, "No");
insert into TEDS_XWALK_VET (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- LIVARAG: Living arrangements at admission
CREATE TABLE `TEDS_XWALK_LIVARAG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_LIVARAG (id, value) values (1, "Homeless");
insert into TEDS_XWALK_LIVARAG (id, value) values (2, "Dependent living");
insert into TEDS_XWALK_LIVARAG (id, value) values (3, "Independent living");
insert into TEDS_XWALK_LIVARAG (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- LIVARAG_D: Living arrangements at discharge
CREATE TABLE `TEDS_XWALK_LIVARAG_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_LIVARAG_D (id, value) values (1, "Homeless");
insert into TEDS_XWALK_LIVARAG_D (id, value) values (2, "Dependent living");
insert into TEDS_XWALK_LIVARAG_D (id, value) values (3, "Independent living");
insert into TEDS_XWALK_LIVARAG_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- PRIMINC: Source of income/support
CREATE TABLE `TEDS_XWALK_PRIMINC` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_PRIMINC (id, value) values (1, "Wages/salary");
insert into TEDS_XWALK_PRIMINC (id, value) values (2, "Public assistance");
insert into TEDS_XWALK_PRIMINC (id, value) values (3, "Retirement/pension, disability");
insert into TEDS_XWALK_PRIMINC (id, value) values (4, "Other");
insert into TEDS_XWALK_PRIMINC (id, value) values (5, "None");
insert into TEDS_XWALK_PRIMINC (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- ARRESTS: Arrests in past 30 days prior to admission
CREATE TABLE `TEDS_XWALK_ARRESTS` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ARRESTS (id, value) values (0, "None");
insert into TEDS_XWALK_ARRESTS (id, value) values (1, "Once");
insert into TEDS_XWALK_ARRESTS (id, value) values (2, "Two or more times");
insert into TEDS_XWALK_ARRESTS (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- ARRESTS_D: Arrests in past 30 days prior to discharge
CREATE TABLE `TEDS_XWALK_ARRESTS_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ARRESTS_D (id, value) values (0, "None");
insert into TEDS_XWALK_ARRESTS_D (id, value) values (1, "Once");
insert into TEDS_XWALK_ARRESTS_D (id, value) values (2, "Two or more times");
insert into TEDS_XWALK_ARRESTS_D (id, value) values (-9, "Missing/unknown/not collected/invalid");


CREATE TABLE `TEDS_XWALK_STFIPS` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_STFIPS (id, value) values (1, "Alabama");
insert into TEDS_XWALK_STFIPS (id, value) values (2, "Alaska");
insert into TEDS_XWALK_STFIPS (id, value) values (4, "Arizona");
insert into TEDS_XWALK_STFIPS (id, value) values (5, "Arkansas");
insert into TEDS_XWALK_STFIPS (id, value) values (6, "California");
insert into TEDS_XWALK_STFIPS (id, value) values (8, "Colorado");
insert into TEDS_XWALK_STFIPS (id, value) values (9, "Connecticut");
insert into TEDS_XWALK_STFIPS (id, value) values (10, "Delaware");
insert into TEDS_XWALK_STFIPS (id, value) values (11, "District of Columbia");
insert into TEDS_XWALK_STFIPS (id, value) values (12, "Florida");
insert into TEDS_XWALK_STFIPS (id, value) values (13, "Georgia");
insert into TEDS_XWALK_STFIPS (id, value) values (15, "Hawaii");
insert into TEDS_XWALK_STFIPS (id, value) values (17, "Illinois");
insert into TEDS_XWALK_STFIPS (id, value) values (18, "Indiana");
insert into TEDS_XWALK_STFIPS (id, value) values (19, "Iowa");
insert into TEDS_XWALK_STFIPS (id, value) values (20, "Kansas");
insert into TEDS_XWALK_STFIPS (id, value) values (21, "Kentucky");
insert into TEDS_XWALK_STFIPS (id, value) values (22, "Louisiana");
insert into TEDS_XWALK_STFIPS (id, value) values (23, "Maine");
insert into TEDS_XWALK_STFIPS (id, value) values (25, "Massachusetts");
insert into TEDS_XWALK_STFIPS (id, value) values (26, "Michigan");
insert into TEDS_XWALK_STFIPS (id, value) values (27, "Minnesota");
insert into TEDS_XWALK_STFIPS (id, value) values (28, "Mississippi");
insert into TEDS_XWALK_STFIPS (id, value) values (29, "Missouri");
insert into TEDS_XWALK_STFIPS (id, value) values (30, "Montana");
insert into TEDS_XWALK_STFIPS (id, value) values (31, "Nebraska");
insert into TEDS_XWALK_STFIPS (id, value) values (32, "Nevada");
insert into TEDS_XWALK_STFIPS (id, value) values (33, "New Hampshire");
insert into TEDS_XWALK_STFIPS (id, value) values (34, "New Jersey");
insert into TEDS_XWALK_STFIPS (id, value) values (36, "New York");
insert into TEDS_XWALK_STFIPS (id, value) values (37, "North Carolina");
insert into TEDS_XWALK_STFIPS (id, value) values (38, "North Dakota");
insert into TEDS_XWALK_STFIPS (id, value) values (39, "Ohio");
insert into TEDS_XWALK_STFIPS (id, value) values (40, "Oklahoma");
insert into TEDS_XWALK_STFIPS (id, value) values (42, "Pennsylvania");
insert into TEDS_XWALK_STFIPS (id, value) values (44, "Rhode Island");
insert into TEDS_XWALK_STFIPS (id, value) values (45, "South Carolina");
insert into TEDS_XWALK_STFIPS (id, value) values (46, "South Dakota");
insert into TEDS_XWALK_STFIPS (id, value) values (47, "Tennessee");
insert into TEDS_XWALK_STFIPS (id, value) values (48, "Texas");
insert into TEDS_XWALK_STFIPS (id, value) values (49, "Utah");
insert into TEDS_XWALK_STFIPS (id, value) values (50, "Vermont");
insert into TEDS_XWALK_STFIPS (id, value) values (51, "Virginia");
insert into TEDS_XWALK_STFIPS (id, value) values (54, "West Virginia");
insert into TEDS_XWALK_STFIPS (id, value) values (55, "Wisconsin");
insert into TEDS_XWALK_STFIPS (id, value) values (56, "Wyoming");
insert into TEDS_XWALK_STFIPS (id, value) values (72, "Puerto Rico");


-- REGION: Census region
CREATE TABLE `TEDS_XWALK_REGION` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_REGION (id, value) values (0, "U.S. territories");
insert into TEDS_XWALK_REGION (id, value) values (1, "Northeast");
insert into TEDS_XWALK_REGION (id, value) values (2, "Midwest");
insert into TEDS_XWALK_REGION (id, value) values (3, "South");
insert into TEDS_XWALK_REGION (id, value) values (4, "West");

-- DIVISION: Census division
CREATE TABLE `TEDS_XWALK_DIVISION` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_DIVISION (id, value) values (0, "U.S. territories");
insert into TEDS_XWALK_DIVISION (id, value) values (1, "New England");
insert into TEDS_XWALK_DIVISION (id, value) values (2, "Middle Atlantic");
insert into TEDS_XWALK_DIVISION (id, value) values (3, "East North Central");
insert into TEDS_XWALK_DIVISION (id, value) values (4, "West North Central");
insert into TEDS_XWALK_DIVISION (id, value) values (5, "South Atlantic");
insert into TEDS_XWALK_DIVISION (id, value) values (6, "East South Central");
insert into TEDS_XWALK_DIVISION (id, value) values (7, "West South Central");
insert into TEDS_XWALK_DIVISION (id, value) values (8, "Mountain");
insert into TEDS_XWALK_DIVISION (id, value) values (9, "Pacific");

-- SERVICES: Type of treatment service/setting at admission
CREATE TABLE `TEDS_XWALK_SERVICES` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SERVICES (id, value) values (1, "Detox, 24-hour, hospital inpatient");
insert into TEDS_XWALK_SERVICES (id, value) values (2, "Detox, 24-hour, free-standing residential");
insert into TEDS_XWALK_SERVICES (id, value) values (3, "Rehab/residential, hospital (non-detox)");
insert into TEDS_XWALK_SERVICES (id, value) values (4, "Rehab/residential, short term (30 days or fewer)");
insert into TEDS_XWALK_SERVICES (id, value) values (5, "Rehab/residential, long term (more than 30 days)");
insert into TEDS_XWALK_SERVICES (id, value) values (6, "Ambulatory, intensive outpatient");
insert into TEDS_XWALK_SERVICES (id, value) values (7, "Ambulatory, non-intensive outpatient");
insert into TEDS_XWALK_SERVICES (id, value) values (8, "Ambulatory, detoxification");


-- SERVICES_D: Type of treatment service/setting at discharge
CREATE TABLE `TEDS_XWALK_SERVICES_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SERVICES_D (id, value) values (1, "Detox, 24-hour, hospital inpatient");
insert into TEDS_XWALK_SERVICES_D (id, value) values (2, "Detox, 24-hour, free-standing residential");
insert into TEDS_XWALK_SERVICES_D (id, value) values (3, "Rehab/residential, hospital (non-detox)");
insert into TEDS_XWALK_SERVICES_D (id, value) values (4, "Rehab/residential, short term (30 days or fewer)");
insert into TEDS_XWALK_SERVICES_D (id, value) values (5, "Rehab/residential, long term (more than 30 days)");
insert into TEDS_XWALK_SERVICES_D (id, value) values (6, "Ambulatory, intensive outpatient");
insert into TEDS_XWALK_SERVICES_D (id, value) values (7, "Ambulatory, non-intensive outpatient");
insert into TEDS_XWALK_SERVICES_D (id, value) values (8, "Ambulatory, detoxification");

-- METHUSE: Medication-assisted opioid therapy
CREATE TABLE `TEDS_XWALK_METHUSE` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_METHUSE (id, value) values (1, "Yes");
insert into TEDS_XWALK_METHUSE (id, value) values (2, "No");
insert into TEDS_XWALK_METHUSE (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- DAYWAIT: Days waiting to enter substance use treatment
CREATE TABLE `TEDS_XWALK_DAYWAIT` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_DAYWAIT (id, value) values (0, "0");
insert into TEDS_XWALK_DAYWAIT (id, value) values (1, "1-7");
insert into TEDS_XWALK_DAYWAIT (id, value) values (2, "8-14");
insert into TEDS_XWALK_DAYWAIT (id, value) values (3, "15-30");
insert into TEDS_XWALK_DAYWAIT (id, value) values (4, "31 or more");
insert into TEDS_XWALK_DAYWAIT (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- REASON: Reason for discharge
CREATE TABLE `TEDS_XWALK_REASON` (
  `id` int NOT NULL,
  `value` varchar(55) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_REASON (id, value) values (1, "Treatment completed");
insert into TEDS_XWALK_REASON (id, value) values (2, "Dropped out of treatment");
insert into TEDS_XWALK_REASON (id, value) values (3, "Terminated by facility");
insert into TEDS_XWALK_REASON (id, value) values (4, "Transferred to another treatment program or facility");
insert into TEDS_XWALK_REASON (id, value) values (5, "Incarcerated");
insert into TEDS_XWALK_REASON (id, value) values (6, "Death");
insert into TEDS_XWALK_REASON (id, value) values (7, "Other");

-- LOS: Length of stay in treatment (days)
CREATE TABLE `TEDS_XWALK_LOS` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_LOS (id, value) values (1, "1");
insert into TEDS_XWALK_LOS (id, value) values (2, "2");
insert into TEDS_XWALK_LOS (id, value) values (3, "3");
insert into TEDS_XWALK_LOS (id, value) values (4, "4");
insert into TEDS_XWALK_LOS (id, value) values (5, "5");
insert into TEDS_XWALK_LOS (id, value) values (6, "6");
insert into TEDS_XWALK_LOS (id, value) values (7, "7");
insert into TEDS_XWALK_LOS (id, value) values (8, "8");
insert into TEDS_XWALK_LOS (id, value) values (9, "9");
insert into TEDS_XWALK_LOS (id, value) values (10, "10");
insert into TEDS_XWALK_LOS (id, value) values (11, "11");
insert into TEDS_XWALK_LOS (id, value) values (12, "12");
insert into TEDS_XWALK_LOS (id, value) values (13, "13");
insert into TEDS_XWALK_LOS (id, value) values (14, "14");
insert into TEDS_XWALK_LOS (id, value) values (15, "15");
insert into TEDS_XWALK_LOS (id, value) values (16, "16");
insert into TEDS_XWALK_LOS (id, value) values (17, "17");
insert into TEDS_XWALK_LOS (id, value) values (18, "18");
insert into TEDS_XWALK_LOS (id, value) values (19, "19");
insert into TEDS_XWALK_LOS (id, value) values (20, "20");
insert into TEDS_XWALK_LOS (id, value) values (21, "21");
insert into TEDS_XWALK_LOS (id, value) values (22, "22");
insert into TEDS_XWALK_LOS (id, value) values (23, "23");
insert into TEDS_XWALK_LOS (id, value) values (24, "24");
insert into TEDS_XWALK_LOS (id, value) values (25, "25");
insert into TEDS_XWALK_LOS (id, value) values (26, "26");
insert into TEDS_XWALK_LOS (id, value) values (27, "27");
insert into TEDS_XWALK_LOS (id, value) values (28, "28");
insert into TEDS_XWALK_LOS (id, value) values (29, "29");
insert into TEDS_XWALK_LOS (id, value) values (30, "30");
insert into TEDS_XWALK_LOS (id, value) values (31, "31 to 45 days ");
insert into TEDS_XWALK_LOS (id, value) values (32, "46 to 60 days");
insert into TEDS_XWALK_LOS (id, value) values (33, "61 to 90 days");
insert into TEDS_XWALK_LOS (id, value) values (34, "91 to 120 days");
insert into TEDS_XWALK_LOS (id, value) values (35, "121 to 180 days");
insert into TEDS_XWALK_LOS (id, value) values (36, "181 to 365 days");
insert into TEDS_XWALK_LOS (id, value) values (37, "More than a year");

-- PSOURCE: Referral source
CREATE TABLE `TEDS_XWALK_PSOURCE` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_PSOURCE (id, value) values (1, "Individual (includes self-referral)");
insert into TEDS_XWALK_PSOURCE (id, value) values (2, "Alcohol/drug use care provider");
insert into TEDS_XWALK_PSOURCE (id, value) values (3, "Other health care provider");
insert into TEDS_XWALK_PSOURCE (id, value) values (4, "School (educational)");
insert into TEDS_XWALK_PSOURCE (id, value) values (5, "Employer/EAP");
insert into TEDS_XWALK_PSOURCE (id, value) values (6, "Other community referral");
insert into TEDS_XWALK_PSOURCE (id, value) values (7, "Court/criminal justice referral/DUI/DWI");
insert into TEDS_XWALK_PSOURCE (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- DETCRIM: Detailed criminal justice referral
CREATE TABLE `TEDS_XWALK_DETCRIM` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_DETCRIM (id, value) values (1, "State/federal court");
insert into TEDS_XWALK_DETCRIM (id, value) values (2, "Formal adjudication process");
insert into TEDS_XWALK_DETCRIM (id, value) values (3, "Probation/parole");
insert into TEDS_XWALK_DETCRIM (id, value) values (4, "Other recognized legal entity");
insert into TEDS_XWALK_DETCRIM (id, value) values (5, "Diversionary program");
insert into TEDS_XWALK_DETCRIM (id, value) values (6, "Prison");
insert into TEDS_XWALK_DETCRIM (id, value) values (7, "DUI/DWI");
insert into TEDS_XWALK_DETCRIM (id, value) values (8, "Other");
insert into TEDS_XWALK_DETCRIM (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- NOPRIOR: Previous substance use treatment episodes
CREATE TABLE `TEDS_XWALK_NOPRIOR` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_NOPRIOR (id, value) values (0, "No prior treatment episodes");
insert into TEDS_XWALK_NOPRIOR (id, value) values (1, "One prior treatment episode");
insert into TEDS_XWALK_NOPRIOR (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- SUB1: Substance use at admission (primary)
CREATE TABLE `TEDS_XWALK_SUB1` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SUB1 (id, value) values (1, "None");
insert into TEDS_XWALK_SUB1 (id, value) values (2, "Alcohol");
insert into TEDS_XWALK_SUB1 (id, value) values (3, "Cocaine/crack");
insert into TEDS_XWALK_SUB1 (id, value) values (4, "Marijuana/hashish");
insert into TEDS_XWALK_SUB1 (id, value) values (5, "Heroin");
insert into TEDS_XWALK_SUB1 (id, value) values (6, "Non-prescription methadone");
insert into TEDS_XWALK_SUB1 (id, value) values (7, "Other opiates and synthetics");
insert into TEDS_XWALK_SUB1 (id, value) values (8, "PCP");
insert into TEDS_XWALK_SUB1 (id, value) values (9, "Hallucinogens");
insert into TEDS_XWALK_SUB1 (id, value) values (10, "Methamphetamine/speed");
insert into TEDS_XWALK_SUB1 (id, value) values (11, "Other amphetamines");
insert into TEDS_XWALK_SUB1 (id, value) values (12, "Other stimulants");
insert into TEDS_XWALK_SUB1 (id, value) values (13, "Benzodiazepines");
insert into TEDS_XWALK_SUB1 (id, value) values (14, "Other tranquilizers");
insert into TEDS_XWALK_SUB1 (id, value) values (15, "Barbiturates");
insert into TEDS_XWALK_SUB1 (id, value) values (16, "Other sedatives or hypnotics");
insert into TEDS_XWALK_SUB1 (id, value) values (17, "Inhalants");
insert into TEDS_XWALK_SUB1 (id, value) values (18, "Over-the-counter medications");
insert into TEDS_XWALK_SUB1 (id, value) values (19, "Other drugs");
insert into TEDS_XWALK_SUB1 (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- SUB1_D: Substance use at discharge (primary)
CREATE TABLE `TEDS_XWALK_SUB1_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SUB1_D (id, value) values (1, "None");
insert into TEDS_XWALK_SUB1_D (id, value) values (2, "Alcohol");
insert into TEDS_XWALK_SUB1_D (id, value) values (3, "Cocaine/crack");
insert into TEDS_XWALK_SUB1_D (id, value) values (4, "Marijuana/hashish");
insert into TEDS_XWALK_SUB1_D (id, value) values (5, "Heroin");
insert into TEDS_XWALK_SUB1_D (id, value) values (6, "Non-prescription methadone");
insert into TEDS_XWALK_SUB1_D (id, value) values (7, "Other opiates and synthetics");
insert into TEDS_XWALK_SUB1_D (id, value) values (8, "PCP");
insert into TEDS_XWALK_SUB1_D (id, value) values (9, "Hallucinogens");
insert into TEDS_XWALK_SUB1_D (id, value) values (10, "Methamphetamine/speed");
insert into TEDS_XWALK_SUB1_D (id, value) values (11, "Other amphetamines");
insert into TEDS_XWALK_SUB1_D (id, value) values (12, "Other stimulants");
insert into TEDS_XWALK_SUB1_D (id, value) values (13, "Benzodiazepines");
insert into TEDS_XWALK_SUB1_D (id, value) values (14, "Other tranquilizers");
insert into TEDS_XWALK_SUB1_D (id, value) values (15, "Barbiturates");
insert into TEDS_XWALK_SUB1_D (id, value) values (16, "Other sedatives or hypnotics");
insert into TEDS_XWALK_SUB1_D (id, value) values (17, "Inhalants");
insert into TEDS_XWALK_SUB1_D (id, value) values (18, "Over-the-counter medications");
insert into TEDS_XWALK_SUB1_D (id, value) values (19, "Other drugs");
insert into TEDS_XWALK_SUB1_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- ROUTE1: Route of administration (primary)
CREATE TABLE `TEDS_XWALK_ROUTE1` (
  `id` int NOT NULL,
  `value` varchar(75) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ROUTE1 (id, value) values (1, "Oral");
insert into TEDS_XWALK_ROUTE1 (id, value) values (2, "Smoking");
insert into TEDS_XWALK_ROUTE1 (id, value) values (3, "Inhalation");
insert into TEDS_XWALK_ROUTE1 (id, value) values (4, "Injection (intravenous, intramuscular, intradermal, or subcutaneous)");
insert into TEDS_XWALK_ROUTE1 (id, value) values (5, "Other");
insert into TEDS_XWALK_ROUTE1 (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FREQ1: Frequency of use at admission (primary)
CREATE TABLE `TEDS_XWALK_FREQ1` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ1 (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ1 (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ1 (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ1 (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FREQ1_D: Frequency of use at discharge (primary)
CREATE TABLE `TEDS_XWALK_FREQ1_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ1_D (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ1_D (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ1_D (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ1_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FRSTUSE1: Age at first use (primary)
CREATE TABLE `TEDS_XWALK_FRSTUSE1` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FRSTUSE1 (id, value) values (1, "11 years and under");
insert into TEDS_XWALK_FRSTUSE1 (id, value) values (2, "12-14 years");
insert into TEDS_XWALK_FRSTUSE1 (id, value) values (3, "15-17 years");
insert into TEDS_XWALK_FRSTUSE1 (id, value) values (4, "18-20 years");
insert into TEDS_XWALK_FRSTUSE1 (id, value) values (5, "21-24 years");
insert into TEDS_XWALK_FRSTUSE1 (id, value) values (6, "25-29 years");
insert into TEDS_XWALK_FRSTUSE1 (id, value) values (7, "30 years and older");
insert into TEDS_XWALK_FRSTUSE1 (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- SUB2: Substance use at admission (secondary)
CREATE TABLE `TEDS_XWALK_SUB2` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SUB2 (id, value) values (1, "None");
insert into TEDS_XWALK_SUB2 (id, value) values (2, "Alcohol");
insert into TEDS_XWALK_SUB2 (id, value) values (3, "Cocaine/crack");
insert into TEDS_XWALK_SUB2 (id, value) values (4, "Marijuana/hashish");
insert into TEDS_XWALK_SUB2 (id, value) values (5, "Heroin");
insert into TEDS_XWALK_SUB2 (id, value) values (6, "Non-prescription methadone");
insert into TEDS_XWALK_SUB2 (id, value) values (7, "Other opiates and synthetics");
insert into TEDS_XWALK_SUB2 (id, value) values (8, "PCP");
insert into TEDS_XWALK_SUB2 (id, value) values (9, "Hallucinogens");
insert into TEDS_XWALK_SUB2 (id, value) values (10, "Methamphetamine/speed");
insert into TEDS_XWALK_SUB2 (id, value) values (12, "Other amphetamines");
insert into TEDS_XWALK_SUB2 (id, value) values (22, "Other stimulants");
insert into TEDS_XWALK_SUB2 (id, value) values (13, "Benzodiazepines");
insert into TEDS_XWALK_SUB2 (id, value) values (14, "Other tranquilizers");
insert into TEDS_XWALK_SUB2 (id, value) values (15, "Barbiturates");
insert into TEDS_XWALK_SUB2 (id, value) values (16, "Other sedatives or hypnotics");
insert into TEDS_XWALK_SUB2 (id, value) values (17, "Inhalants");
insert into TEDS_XWALK_SUB2 (id, value) values (18, "Over-the-counter medications");
insert into TEDS_XWALK_SUB2 (id, value) values (19, "Other drugs");
insert into TEDS_XWALK_SUB2 (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- SUB2_D: Substance use at discharge (secondary)
CREATE TABLE `TEDS_XWALK_SUB2_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SUB2_D (id, value) values (1, "None");
insert into TEDS_XWALK_SUB2_D (id, value) values (2, "Alcohol");
insert into TEDS_XWALK_SUB2_D (id, value) values (3, "Cocaine/crack");
insert into TEDS_XWALK_SUB2_D (id, value) values (4, "Marijuana/hashish");
insert into TEDS_XWALK_SUB2_D (id, value) values (5, "Heroin");
insert into TEDS_XWALK_SUB2_D (id, value) values (6, "Non-prescription methadone");
insert into TEDS_XWALK_SUB2_D (id, value) values (7, "Other opiates and synthetics");
insert into TEDS_XWALK_SUB2_D (id, value) values (8, "PCP");
insert into TEDS_XWALK_SUB2_D (id, value) values (9, "Hallucinogens");
insert into TEDS_XWALK_SUB2_D (id, value) values (10, "Methamphetamine/speed");
insert into TEDS_XWALK_SUB2_D (id, value) values (12, "Other amphetamines");
insert into TEDS_XWALK_SUB2_D (id, value) values (22, "Other stimulants");
insert into TEDS_XWALK_SUB2_D (id, value) values (13, "Benzodiazepines");
insert into TEDS_XWALK_SUB2_D (id, value) values (14, "Other tranquilizers");
insert into TEDS_XWALK_SUB2_D (id, value) values (15, "Barbiturates");
insert into TEDS_XWALK_SUB2_D (id, value) values (16, "Other sedatives or hypnotics");
insert into TEDS_XWALK_SUB2_D (id, value) values (17, "Inhalants");
insert into TEDS_XWALK_SUB2_D (id, value) values (18, "Over-the-counter medications");
insert into TEDS_XWALK_SUB2_D (id, value) values (19, "Other drugs");
insert into TEDS_XWALK_SUB2_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- ROUTE2: Route of administration (secondary)
CREATE TABLE `TEDS_XWALK_ROUTE2` (
  `id` int NOT NULL,
  `value` varchar(75) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ROUTE2 (id, value) values (1, "Oral");
insert into TEDS_XWALK_ROUTE2 (id, value) values (2, "Smoking");
insert into TEDS_XWALK_ROUTE2 (id, value) values (3, "Inhalation");
insert into TEDS_XWALK_ROUTE2 (id, value) values (4, "Injection (intravenous, intramuscular, intradermal, or subcutaneous)");
insert into TEDS_XWALK_ROUTE2 (id, value) values (5, "Other");
insert into TEDS_XWALK_ROUTE2 (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FREQ2: Frequency of use at admission (secondary)
CREATE TABLE `TEDS_XWALK_FREQ2` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ2 (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ2 (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ2 (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ2 (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- FREQ2_D: Frequency of use at discharge (secondary)
CREATE TABLE `TEDS_XWALK_FREQ2_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ2_D (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ2_D (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ2_D (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ2_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FRSTUSE2: Age at first use (secondary)
CREATE TABLE `TEDS_XWALK_FRSTUSE2` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FRSTUSE2 (id, value) values (1, "11 years and under");
insert into TEDS_XWALK_FRSTUSE2 (id, value) values (2, "12-14 years");
insert into TEDS_XWALK_FRSTUSE2 (id, value) values (3, "15-17 years");
insert into TEDS_XWALK_FRSTUSE2 (id, value) values (4, "18-20 years");
insert into TEDS_XWALK_FRSTUSE2 (id, value) values (5, "21-24 years");
insert into TEDS_XWALK_FRSTUSE2 (id, value) values (6, "25-29 years");
insert into TEDS_XWALK_FRSTUSE2 (id, value) values (7, "30 years and older");
insert into TEDS_XWALK_FRSTUSE2 (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- SUB3: Substance use at admission (tertiary)
CREATE TABLE `TEDS_XWALK_SUB3` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SUB3 (id, value) values (1, "None");
insert into TEDS_XWALK_SUB3 (id, value) values (2, "Alcohol");
insert into TEDS_XWALK_SUB3 (id, value) values (3, "Cocaine/crack");
insert into TEDS_XWALK_SUB3 (id, value) values (4, "Marijuana/hashish");
insert into TEDS_XWALK_SUB3 (id, value) values (5, "Heroin");
insert into TEDS_XWALK_SUB3 (id, value) values (6, "Non-prescription methadone");
insert into TEDS_XWALK_SUB3 (id, value) values (7, "Other opiates and synthetics");
insert into TEDS_XWALK_SUB3 (id, value) values (8, "PCP");
insert into TEDS_XWALK_SUB3 (id, value) values (9, "Hallucinogens");
insert into TEDS_XWALK_SUB3 (id, value) values (10, "Methamphetamine/speed");
insert into TEDS_XWALK_SUB3 (id, value) values (12, "Other amphetamines");
insert into TEDS_XWALK_SUB3 (id, value) values (22, "Other stimulants");
insert into TEDS_XWALK_SUB3 (id, value) values (13, "Benzodiazepines");
insert into TEDS_XWALK_SUB3 (id, value) values (14, "Other tranquilizers");
insert into TEDS_XWALK_SUB3 (id, value) values (15, "Barbiturates");
insert into TEDS_XWALK_SUB3 (id, value) values (16, "Other sedatives or hypnotics");
insert into TEDS_XWALK_SUB3 (id, value) values (17, "Inhalants");
insert into TEDS_XWALK_SUB3 (id, value) values (18, "Over-the-counter medications");
insert into TEDS_XWALK_SUB3 (id, value) values (19, "Other drugs");
insert into TEDS_XWALK_SUB3 (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- SUB3_D: Substance use at discharge (tertiary)
CREATE TABLE `TEDS_XWALK_SUB3_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SUB3_D (id, value) values (1, "None");
insert into TEDS_XWALK_SUB3_D (id, value) values (2, "Alcohol");
insert into TEDS_XWALK_SUB3_D (id, value) values (3, "Cocaine/crack");
insert into TEDS_XWALK_SUB3_D (id, value) values (4, "Marijuana/hashish");
insert into TEDS_XWALK_SUB3_D (id, value) values (5, "Heroin");
insert into TEDS_XWALK_SUB3_D (id, value) values (6, "Non-prescription methadone");
insert into TEDS_XWALK_SUB3_D (id, value) values (7, "Other opiates and synthetics");
insert into TEDS_XWALK_SUB3_D (id, value) values (8, "PCP");
insert into TEDS_XWALK_SUB3_D (id, value) values (9, "Hallucinogens");
insert into TEDS_XWALK_SUB3_D (id, value) values (10, "Methamphetamine/speed");
insert into TEDS_XWALK_SUB3_D (id, value) values (12, "Other amphetamines");
insert into TEDS_XWALK_SUB3_D (id, value) values (22, "Other stimulants");
insert into TEDS_XWALK_SUB3_D (id, value) values (13, "Benzodiazepines");
insert into TEDS_XWALK_SUB3_D (id, value) values (14, "Other tranquilizers");
insert into TEDS_XWALK_SUB3_D (id, value) values (15, "Barbiturates");
insert into TEDS_XWALK_SUB3_D (id, value) values (16, "Other sedatives or hypnotics");
insert into TEDS_XWALK_SUB3_D (id, value) values (17, "Inhalants");
insert into TEDS_XWALK_SUB3_D (id, value) values (18, "Over-the-counter medications");
insert into TEDS_XWALK_SUB3_D (id, value) values (19, "Other drugs");
insert into TEDS_XWALK_SUB3_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- ROUTE3: Route of administration (tertiary)
CREATE TABLE `TEDS_XWALK_ROUTE3` (
  `id` int NOT NULL,
  `value` varchar(75) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ROUTE3 (id, value) values (1, "Oral");
insert into TEDS_XWALK_ROUTE3 (id, value) values (2, "Smoking");
insert into TEDS_XWALK_ROUTE3 (id, value) values (3, "Inhalation");
insert into TEDS_XWALK_ROUTE3 (id, value) values (4, "Injection (intravenous, intramuscular, intradermal, or subcutaneous)");
insert into TEDS_XWALK_ROUTE3 (id, value) values (5, "Other");
insert into TEDS_XWALK_ROUTE3 (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FREQ3: Frequency of use at admission (tertiary)
CREATE TABLE `TEDS_XWALK_FREQ3` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ3 (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ3 (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ3 (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ3 (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FREQ3_D: Frequency of use at discharge (tertiary)
CREATE TABLE `TEDS_XWALK_FREQ3_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ3_D (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ3_D (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ3_D (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ3_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FRSTUSE3: Age at first use (tertiary)
CREATE TABLE `TEDS_XWALK_FRSTUSE3` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FRSTUSE3 (id, value) values (1, "11 years and under");
insert into TEDS_XWALK_FRSTUSE3 (id, value) values (2, "12-14 years");
insert into TEDS_XWALK_FRSTUSE3 (id, value) values (3, "15-17 years");
insert into TEDS_XWALK_FRSTUSE3 (id, value) values (4, "18-20 years");
insert into TEDS_XWALK_FRSTUSE3 (id, value) values (5, "21-24 years");
insert into TEDS_XWALK_FRSTUSE3 (id, value) values (6, "25-29 years");
insert into TEDS_XWALK_FRSTUSE3 (id, value) values (7, "30 years and older");
insert into TEDS_XWALK_FRSTUSE3 (id, value) values (-9, "Missing/unknown/not collected/invalid");


-- IDU: Current IV drug use reported at admission
CREATE TABLE `TEDS_XWALK_IDU` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_IDU (id, value) values (0, "IDU not reported");
insert into TEDS_XWALK_IDU (id, value) values (1, "IDU reported");
insert into TEDS_XWALK_IDU (id, value) values (-9, "No substances reported");

-- ALCFLG: Alcohol reported at admission
CREATE TABLE `TEDS_XWALK_ALCFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ALCFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_ALCFLG (id, value) values (1, "Substance reported");

-- COKEFLG: Cocaine/crack reported at admission
CREATE TABLE `TEDS_XWALK_COKEFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_COKEFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_COKEFLG (id, value) values (1, "Substance reported");

-- MARFLG: Marijuana/hashish reported at admission
CREATE TABLE `TEDS_XWALK_MARFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_MARFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_MARFLG (id, value) values (1, "Substance reported");

-- HERFLG: Heroin reported at admission
CREATE TABLE `TEDS_XWALK_HERFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_HERFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_HERFLG (id, value) values (1, "Substance reported");

-- METHFLG: Non-rx methadone reported at admission
CREATE TABLE `TEDS_XWALK_METHFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_METHFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_METHFLG (id, value) values (1, "Substance reported");

-- OPSYNFLG: Other opiates/synthetics reported at admission
CREATE TABLE `TEDS_XWALK_OPSYNFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_OPSYNFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_OPSYNFLG (id, value) values (1, "Substance reported");

-- PCPFLG: PCP reported at admission
CREATE TABLE `TEDS_XWALK_PCPFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_PCPFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_PCPFLG (id, value) values (1, "Substance reported");

-- HALLFLG: Hallucinogens reported at admission
CREATE TABLE `TEDS_XWALK_HALLFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_HALLFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_HALLFLG (id, value) values (1, "Substance reported");

-- MTHAMFLG: Methamphetamine/speed reported at admission
CREATE TABLE `TEDS_XWALK_MTHAMFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_MTHAMFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_MTHAMFLG (id, value) values (1, "Substance reported");

-- AMPHFLG: Other amphetamines reported at admission
CREATE TABLE `TEDS_XWALK_AMPHFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_AMPHFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_AMPHFLG (id, value) values (1, "Substance reported");

-- STIMFLG: Other stimulants reported at admission
CREATE TABLE `TEDS_XWALK_STIMFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_STIMFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_STIMFLG (id, value) values (1, "Substance reported");

-- BENZFLG: Benzodiazepines reported at admission
CREATE TABLE `TEDS_XWALK_BENZFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_BENZFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_BENZFLG (id, value) values (1, "Substance reported");

-- TRNQFLG: Other tranquilizers reported at admission
CREATE TABLE `TEDS_XWALK_TRNQFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_TRNQFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_TRNQFLG (id, value) values (1, "Substance reported");

-- BARBFLG: Barbiturates reported at admission
CREATE TABLE `TEDS_XWALK_BARBFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_BARBFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_BARBFLG (id, value) values (1, "Substance reported");

-- SEDHPFLG: Other sedatives/hypnotics reported at admission
CREATE TABLE `TEDS_XWALK_SEDHPFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SEDHPFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_SEDHPFLG (id, value) values (1, "Substance reported");

-- INHFLG: Inhalants reported at admission
CREATE TABLE `TEDS_XWALK_INHFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_INHFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_INHFLG (id, value) values (1, "Substance reported");

-- OTCFLG: Over-the-counter medication reported at admission
CREATE TABLE `TEDS_XWALK_OTCFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_OTCFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_OTCFLG (id, value) values (1, "Substance reported");

-- OTHERFLG: Other drug reported at admission
CREATE TABLE `TEDS_XWALK_OTHERFLG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_OTHERFLG (id, value) values (0, "Substance not reported");
insert into TEDS_XWALK_OTHERFLG (id, value) values (1, "Substance reported");

-- ALCDRUG: Substance use type
CREATE TABLE `TEDS_XWALK_ALCDRUG` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ALCDRUG (id, value) values (0, "None");
insert into TEDS_XWALK_ALCDRUG (id, value) values (1, "Alcohol only");
insert into TEDS_XWALK_ALCDRUG (id, value) values (2, "Other drugs only");
insert into TEDS_XWALK_ALCDRUG (id, value) values (3, "Alcohol and other drugs");

-- DSMCRIT: DSM diagnosis (SuDS 4 or SuDS 19)
CREATE TABLE `TEDS_XWALK_DSMCRIT` (
  `id` int NOT NULL,
  `value` varchar(75) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_DSMCRIT (id, value) values (1, "Alcohol-induced disorder");
insert into TEDS_XWALK_DSMCRIT (id, value) values (2, "Substance-induced disorder");
insert into TEDS_XWALK_DSMCRIT (id, value) values (3, "Alcohol intoxication");
insert into TEDS_XWALK_DSMCRIT (id, value) values (4, "Alcohol dependence");
insert into TEDS_XWALK_DSMCRIT (id, value) values (5, "Opioid dependence");
insert into TEDS_XWALK_DSMCRIT (id, value) values (6, "Cocaine dependence");
insert into TEDS_XWALK_DSMCRIT (id, value) values (7, "Cannabis dependence");
insert into TEDS_XWALK_DSMCRIT (id, value) values (8, "Other substance dependence");
insert into TEDS_XWALK_DSMCRIT (id, value) values (9, "Alcohol abuse");
insert into TEDS_XWALK_DSMCRIT (id, value) values (10, "Cannabis abuse");
insert into TEDS_XWALK_DSMCRIT (id, value) values (11, "Other substance abuse");
insert into TEDS_XWALK_DSMCRIT (id, value) values (12, "Opioid abuse");
insert into TEDS_XWALK_DSMCRIT (id, value) values (13, "Cocaine abuse");
insert into TEDS_XWALK_DSMCRIT (id, value) values (14, "Anxiety disorders");
insert into TEDS_XWALK_DSMCRIT (id, value) values (15, "Depressive disorders");
insert into TEDS_XWALK_DSMCRIT (id, value) values (16, "Schizophrenia/other psychotic disorders");
insert into TEDS_XWALK_DSMCRIT (id, value) values (17, "Bipolar disorders");
insert into TEDS_XWALK_DSMCRIT (id, value) values (18, "Attention deficit/disruptive behavior disorders");
insert into TEDS_XWALK_DSMCRIT (id, value) values (19, "Other mental health condition");
insert into TEDS_XWALK_DSMCRIT (id, value) values (-9, "Missing/unknown/not collected/invalid/no or deferred diagnosis");


-- PSYPROB: Co-occurring mental and substance use disorders
CREATE TABLE `TEDS_XWALK_PSYPROB` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_PSYPROB (id, value) values (1, "Yes");
insert into TEDS_XWALK_PSYPROB (id, value) values (2, "No");
insert into TEDS_XWALK_PSYPROB (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- HLTHINS: Health insurance
CREATE TABLE `TEDS_XWALK_HLTHINS` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_HLTHINS (id, value) values (1, "Private insurance, Blue Cross/Blue Shield, HMO");
insert into TEDS_XWALK_HLTHINS (id, value) values (2, "Medicaid");
insert into TEDS_XWALK_HLTHINS (id, value) values (3, "Medicare, other (e.g. TRICARE, CHAMPUS)");
insert into TEDS_XWALK_HLTHINS (id, value) values (4, "None");
insert into TEDS_XWALK_HLTHINS (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- PRIMPAY: Payment source, primary (expected or actual)
CREATE TABLE `TEDS_XWALK_PRIMPAY` (
  `id` int NOT NULL,
  `value` varchar(90) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_PRIMPAY (id, value) values (1, "Self-pay");
insert into TEDS_XWALK_PRIMPAY (id, value) values (2, "Private insurance (Blue Cross/Blue Shield, other health insurance, workers compensation)");
insert into TEDS_XWALK_PRIMPAY (id, value) values (3, "Medicare");
insert into TEDS_XWALK_PRIMPAY (id, value) values (4, "Medicaid");
insert into TEDS_XWALK_PRIMPAY (id, value) values (5, "Other government payments");
insert into TEDS_XWALK_PRIMPAY (id, value) values (6, "No charge (free, charity, special research, teaching)");
insert into TEDS_XWALK_PRIMPAY (id, value) values (7, "Other");
insert into TEDS_XWALK_PRIMPAY (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FREQ_ATND_SELF_HELP: Attendance at substance use self-help groups in past 30 days prior to admission
CREATE TABLE `TEDS_XWALK_FREQ_ATND_SELF_HELP` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ_ATND_SELF_HELP (id, value) values (1, "No attendance");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP (id, value) values  (2, "1-3 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP (id, value) values  (3, "4-7 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP (id, value) values  (4, "8-30 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP (id, value) values  (5, "Some attendance, frequency is unknown");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP (id, value) values  (-9, "Missing/unknown/not collected/invalid");

-- FREQ_ATND_SELF_HELP_D: Attendance at substance use self-help groups in past 30 days prior to discharge
CREATE TABLE `TEDS_XWALK_FREQ_ATND_SELF_HELP_D` (
  `id` int NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values (1, "No attendance");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (2, "1-3 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (3, "4-7 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (4, "8-30 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (5, "Some attendance, frequency is unknown");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (-9, "Missing/unknown/not collected/invalid");