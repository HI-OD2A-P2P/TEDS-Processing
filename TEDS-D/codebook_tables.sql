-- Creates MySQL tables for the SAMHSA TEDS D crosswalk from the codebook.pdf found at
-- https://www.datafiles.samhsa.gov/dataset/treatment-episode-data-set-admissions-2020-teds-2020-ds0001
-- Run the codebool_tables.sql in TEDS-A first.  The two use the same tables, but TEDS-D has some additions,
-- which this file addresses. 
-- Use this followed by running the query in the TEDS_conversion.sql file to 
-- change the TEDS-D data from the numeric codes to human readable format.

-- columns that are in TEDS_D but not TEDS_A
-- LOS, SERVICES_D, REASON, EMPLOY_D, LIVARAG_D, ARRESTS_D, DETNLF_D, SUB1_D, SUB2_D, SUB3_D, FREQ1_D, FREQ2_D, FREQ3_D, FREQ_ATND_SELF_HELP_D
-- Notes:
--  CBSA is a column in the data, but has no set values in the codebook.
--  PMSA, SERVSETD, and NUMSUBS all appear in the data, but do not appear in the codebook.


-- LOS: Length of stay in treatment (days)
CREATE TABLE `TEDS_XWALK_LOS` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_LOS (id, value) values (1,	"1 day");
insert into TEDS_XWALK_LOS (id, value) values (2,	"2 days");
insert into TEDS_XWALK_LOS (id, value) values (3,	"3 days");
insert into TEDS_XWALK_LOS (id, value) values (4,	"4 days");
insert into TEDS_XWALK_LOS (id, value) values (5,	"5 days");
insert into TEDS_XWALK_LOS (id, value) values (6,	"6 days");
insert into TEDS_XWALK_LOS (id, value) values (7,	"7 days");
insert into TEDS_XWALK_LOS (id, value) values (8,	"8 days");
insert into TEDS_XWALK_LOS (id, value) values (9,	"9 days");
insert into TEDS_XWALK_LOS (id, value) values (10,	"10 days");
insert into TEDS_XWALK_LOS (id, value) values (11,	"11 days");
insert into TEDS_XWALK_LOS (id, value) values (12,	"12 days");
insert into TEDS_XWALK_LOS (id, value) values (13,	"13 days");
insert into TEDS_XWALK_LOS (id, value) values (14,	"14 days");
insert into TEDS_XWALK_LOS (id, value) values (15,	"15 days");
insert into TEDS_XWALK_LOS (id, value) values (16,	"16 days");
insert into TEDS_XWALK_LOS (id, value) values (17,	"17 days");
insert into TEDS_XWALK_LOS (id, value) values (18,	"18 days");
insert into TEDS_XWALK_LOS (id, value) values (19,	"19 days");
insert into TEDS_XWALK_LOS (id, value) values (20,	"20 days");
insert into TEDS_XWALK_LOS (id, value) values (21,	"21 days");
insert into TEDS_XWALK_LOS (id, value) values (22,	"23 days");
insert into TEDS_XWALK_LOS (id, value) values (23,	"23 days");
insert into TEDS_XWALK_LOS (id, value) values (24,	"24 days");
insert into TEDS_XWALK_LOS (id, value) values (25,	"25 days");
insert into TEDS_XWALK_LOS (id, value) values (26,	"26 days");
insert into TEDS_XWALK_LOS (id, value) values (27,	"27 days");
insert into TEDS_XWALK_LOS (id, value) values (28,	"28 days");
insert into TEDS_XWALK_LOS (id, value) values (29,	"29 days");
insert into TEDS_XWALK_LOS (id, value) values (30,	"30 days");
insert into TEDS_XWALK_LOS (id, value) values (31,	"31-45 days");
insert into TEDS_XWALK_LOS (id, value) values (32,	"46-60 days");
insert into TEDS_XWALK_LOS (id, value) values (33,	"61-90 days");
insert into TEDS_XWALK_LOS (id, value) values (34,	"91-120 days");
insert into TEDS_XWALK_LOS (id, value) values (35,	"121-180 days");
insert into TEDS_XWALK_LOS (id, value) values (36,	"181-365 days");
insert into TEDS_XWALK_LOS (id, value) values (37,	"Greater than 365 days");

-- SERVICES_D: Type of treatment service/setting at discharge
CREATE TABLE `TEDS_XWALK_SERVICES_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_SERVICES_D (id, value) values (1,	"Detox, 24-hour, hospital inpatient");
insert into TEDS_XWALK_SERVICES_D (id, value) values (2,	"Detox, 24-hour, free-standing residential");
insert into TEDS_XWALK_SERVICES_D (id, value) values (3,	"Rehab/residential, hospital (non-detox)");
insert into TEDS_XWALK_SERVICES_D (id, value) values (4,	"Rehab/residential, short term (30 days or fewer)");
insert into TEDS_XWALK_SERVICES_D (id, value) values (5,	"Rehab/residential, long term (more than 30 days)");
insert into TEDS_XWALK_SERVICES_D (id, value) values (6,	"Ambulatory, intensive outpatient");
insert into TEDS_XWALK_SERVICES_D (id, value) values (7,	"Ambulatory, non-intensive outpatient");
insert into TEDS_XWALK_SERVICES_D (id, value) values (8,	"Ambulatory, detoxification");

-- REASON: Reason for discharge
CREATE TABLE `TEDS_XWALK_REASON` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_REASON (id, value) values (1,	" Treatment completed");
insert into TEDS_XWALK_REASON (id, value) values (2,	" Dropped out of treatment");
insert into TEDS_XWALK_REASON (id, value) values (3,	" Terminated by facility ");
insert into TEDS_XWALK_REASON (id, value) values (4,	" Transferred to another treatment program or facility");
insert into TEDS_XWALK_REASON (id, value) values (5,	" Incarcerated");
insert into TEDS_XWALK_REASON (id, value) values (6,	" Death");
insert into TEDS_XWALK_REASON (id, value) values (7,	" Other");

-- EMPLOY_D: Employment status at discharge
CREATE TABLE `TEDS_XWALK_EMPLOY_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_EMPLOY_D (id, value) values (1,	" Full-time");
insert into TEDS_XWALK_EMPLOY_D (id, value) values (2,	" Part-time");
insert into TEDS_XWALK_EMPLOY_D (id, value) values (3,	" Unemployed"); 
insert into TEDS_XWALK_EMPLOY_D (id, value) values (4,	" Not in labor force");
insert into TEDS_XWALK_EMPLOY_D (id, value) values (-9,	" Missing/unknown/not collected/invalid");

-- LIVARAG_D: Living arrangements at discharge
CREATE TABLE `TEDS_XWALK_LIVARAG_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_LIVARAG_D (id, value) values (1, "Homeless");
insert into TEDS_XWALK_LIVARAG_D (id, value) values (2, "Dependent living"); 
insert into TEDS_XWALK_LIVARAG_D (id, value) values (3, "Independent living"); 
insert into TEDS_XWALK_LIVARAG_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- ARRESTS_D: Arrests in past 30 days prior to discharge
CREATE TABLE `TEDS_XWALK_ARRESTS_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_ARRESTS_D (id, value) values (1,	"12-14 years");
insert into TEDS_XWALK_ARRESTS_D (id, value) values (0,	"None");
insert into TEDS_XWALK_ARRESTS_D (id, value) values (1,	"Once");
insert into TEDS_XWALK_ARRESTS_D (id, value) values (2,	"Two or more times"); 
insert into TEDS_XWALK_ARRESTS_D (id, value) values (-9,	"Missing/unknown/not collected/invalid");

-- DETNLF_D: Detailed not in labor force category at discharge
CREATE TABLE `TEDS_XWALK_DETNLF_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_DETNLF_D (id, value) values (1, "Homemaker");
insert into TEDS_XWALK_DETNLF_D (id, value) values (2, "Student");
insert into TEDS_XWALK_DETNLF_D (id, value) values (3, "Retired, disabled");
insert into TEDS_XWALK_DETNLF_D (id, value) values (4, "Resident of institution");
insert into TEDS_XWALK_DETNLF_D (id, value) values (5, "Other");
insert into TEDS_XWALK_DETNLF_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- SUB1_D: Substance use at discharge (primary)
CREATE TABLE `TEDS_XWALK_SUB1_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
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
insert into TEDS_XWALK_SUB1_D (id, value) values (-9, "Missing/unknown/not collected/invalid"); (id, value) values (1,	"12-14 years");

-- SUB2_D: Substance use at discharge (secondary)
CREATE TABLE `TEDS_XWALK_SUB2_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
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
insert into TEDS_XWALK_SUB2_D (id, value) values (11, "Other amphetamines");
insert into TEDS_XWALK_SUB2_D (id, value) values (12, "Other stimulants");
insert into TEDS_XWALK_SUB2_D (id, value) values (13, "Benzodiazepines");
insert into TEDS_XWALK_SUB2_D (id, value) values (14, "Other tranquilizers");
insert into TEDS_XWALK_SUB2_D (id, value) values (15, "Barbiturates");
insert into TEDS_XWALK_SUB2_D (id, value) values (16, "Other sedatives or hypnotics");
insert into TEDS_XWALK_SUB2_D (id, value) values (17, "Inhalants");
insert into TEDS_XWALK_SUB2_D (id, value) values (18, "Over-the-counter medications");
insert into TEDS_XWALK_SUB2_D (id, value) values (19, "Other drugs");
insert into TEDS_XWALK_SUB2_D (id, value) values (-9, "Missing/unknown/not collected/invalid"); (id, value) values (1,	"12-14 years"); (id, value) values (1,	"12-14 years");

-- SUB3_D: Substance use at discharge (tertiary)
CREATE TABLE `TEDS_XWALK_SUB3_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
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
insert into TEDS_XWALK_SUB3_D (id, value) values (11, "Other amphetamines");
insert into TEDS_XWALK_SUB3_D (id, value) values (12, "Other stimulants");
insert into TEDS_XWALK_SUB3_D (id, value) values (13, "Benzodiazepines");
insert into TEDS_XWALK_SUB3_D (id, value) values (14, "Other tranquilizers");
insert into TEDS_XWALK_SUB3_D (id, value) values (15, "Barbiturates");
insert into TEDS_XWALK_SUB3_D (id, value) values (16, "Other sedatives or hypnotics");
insert into TEDS_XWALK_SUB3_D (id, value) values (17, "Inhalants");
insert into TEDS_XWALK_SUB3_D (id, value) values (18, "Over-the-counter medications");
insert into TEDS_XWALK_SUB3_D (id, value) values (19, "Other drugs");
insert into TEDS_XWALK_SUB3_D (id, value) values (-9, "Missing/unknown/not collected/invalid"); (id, value) values (1,	"12-14 years"); (id, value) values (1,	"12-14 years");

-- FREQ1_D: Frequency of use at discharge (primary)
CREATE TABLE `TEDS_XWALK_FREQ1_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ1_D (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ1_D (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ1_D (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ1_D (id, value) values (-9, "Missing/unknown/not collected/invalid"); (id, value) values (1,	"12-14 years");

-- FREQ1_D: Frequency of use at discharge (secondary)
CREATE TABLE `TEDS_XWALK_FREQ2_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ2_D (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ2_D (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ2_D (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ2_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FREQ3_D: Frequency of use at discharge (tertiary)
CREATE TABLE `TEDS_XWALK_FREQ3_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ3_D (id, value) values (1, "No use in the past month");
insert into TEDS_XWALK_FREQ3_D (id, value) values (2, "Some use");
insert into TEDS_XWALK_FREQ3_D (id, value) values (3, "Daily use");
insert into TEDS_XWALK_FREQ3_D (id, value) values (-9, "Missing/unknown/not collected/invalid");

-- FREQ_ATND_SELF_HELP_D: Attendance at substance use self-help groups in past 30 days prior to discharge
CREATE TABLE `TEDS_XWALK_FREQ_ATND_SELF_HELP_D` (
  `id` int NOT NULL,
  `value` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values (1, "No attendance");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (2, "1-3 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (3, "4-7 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (4, "8-30 times in the past month");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (5, "Some attendance, frequency is unknown");
insert into TEDS_XWALK_FREQ_ATND_SELF_HELP_D (id, value) values  (-9, "Missing/unknown/not collected/invalid");
