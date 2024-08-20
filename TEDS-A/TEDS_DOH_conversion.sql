-- Query to convert the TEDS numeric codes to human readable format and load
-- the data in to a new table.  Must have run all the code in codebook_tables.sql first.
-- This query differs from the query found in TEDS_conversion.sql by:
--   the other one uses the original column names from samhsa, this one changes the column names to match DOH format.
--   the other one has all the states while this one strips out any non-Hawaii entries.
--   this one is in mssql format and uses the dbo prefixes the DOH database expects
-- To change the state that gets kept, find the only "INNER JOIN" and change the state name there.
select
  dbo.TEDS_A_combined_data_Hawaii_2015_2021.ADMYR as YearOfAdmission, 
  dbo.TEDS_A_combined_data_Hawaii_2015_2021.CASEID as Caseid,
  dbo.TEDS_A_combined_data_Hawaii_2015_2021.CBSA2010 as Cbsa2010,
  dbo.TEDS_XWALK_STFIPS.value as CensusStateFipsCode,
  dbo.TEDS_XWALK_EDUC.value as Education,
  dbo.TEDS_XWALK_MARSTAT.value as MaritalStatus,
  dbo.TEDS_XWALK_SERVICES.value as TypeOfTreatmentServiceSetting,
  dbo.TEDS_XWALK_DETCRIM.value as DetailedCriminalJusticeReferral,
  dbo.TEDS_XWALK_NOPRIOR.value as PreviousSubstanceUseTreatmentEpisodes,
  dbo.TEDS_XWALK_PSOURCE.value as ReferralSource, 
  dbo.TEDS_XWALK_ARRESTS.value as ArrestsInPast30Days,
  dbo.TEDS_XWALK_EMPLOY.value as EmploymentStatus,
  dbo.TEDS_XWALK_METHUSE.value as MedicationAssistedOpioidTherapy,
  dbo.TEDS_XWALK_PSYPROB.value as CoOccurringMentalAndSubstanceUseDisorders,
  dbo.TEDS_XWALK_PREG.value as PregnantAtAdmission,
  dbo.TEDS_XWALK_GENDER.value as Gender,
  dbo.TEDS_XWALK_VET.value as VeteranStatus,
  dbo.TEDS_XWALK_LIVARAG.value as LivingArrangements,
  dbo.TEDS_XWALK_DAYWAIT.value as DaysWaitingToEnterSubstanceUseTreatment,
  dbo.TEDS_XWALK_DSMCRIT.value as DsmDiagnosisSuds4OrSuds19,
  dbo.TEDS_XWALK_AGE.value as AgeAtAdmission,
  dbo.TEDS_XWALK_RACE.value as Race,
  dbo.TEDS_XWALK_ETHNIC.value as Ethnicity,
  dbo.TEDS_XWALK_DETNLF.value as DetailedNotInLaborForce,
  dbo.TEDS_XWALK_PRIMINC.value as SourceOfIncomeSupport,
  dbo.TEDS_XWALK_SUB1.value as SubstanceUsePrimary,
  dbo.TEDS_XWALK_SUB2.value as SubstanceUseSecondary,
  dbo.TEDS_XWALK_SUB3.value as SubstanceUseTertiary,
  dbo.TEDS_XWALK_ROUTE1.value as RouteOfAdministrationPrimary,
  dbo.TEDS_XWALK_ROUTE2.value as RouteOfAdministrationSecondary,
  dbo.TEDS_XWALK_ROUTE3.value as RouteOfAdministrationTertiary,
  dbo.TEDS_XWALK_FREQ1.value as FrequencyOfUsePrimary,
  dbo.TEDS_XWALK_FREQ2.value as FrequencyOfUseSecondary,
  dbo.TEDS_XWALK_FREQ3.value as FrequencyOfUseTertiary,
  dbo.TEDS_XWALK_FRSTUSE1.value as AgeAtFirstUsePrimary,
  dbo.TEDS_XWALK_FRSTUSE2.value as AgeAtFirstUseSecondary,
  dbo.TEDS_XWALK_FRSTUSE3.value as AgeAtFirstUseTertiary,
  dbo.TEDS_XWALK_HLTHINS.value as HealthInsurance,
  dbo.TEDS_XWALK_PRIMPAY.value as PaymentSourcePrimaryExpectedOrActual,
  dbo.TEDS_XWALK_FREQ_ATND_SELF_HELP.value as AttendanceAtSubstanceUseSelfHelpGroupsInPast30,
  dbo.TEDS_XWALK_ALCFLG.value as AlcoholReportedAtAdmission,
  dbo.TEDS_XWALK_COKEFLG.value as CocaineCrackReportedAtAdmission,
  dbo.TEDS_XWALK_MARFLG.value as MarijuanaHashishReportedAtAdmission,
  dbo.TEDS_XWALK_HERFLG.value as HeroinReportedAtAdmission,
  dbo.TEDS_XWALK_METHFLG.value as NonRxMethadoneReportedAtAdmission,
  dbo.TEDS_XWALK_OPSYNFLG.value as OtherOpiatesSyntheticsReportedAtAdmission,
  dbo.TEDS_XWALK_PCPFLG.value as PcpReportedAtAdmission,
  dbo.TEDS_XWALK_HALLFLG.value as HallucinogensReportedAtAdmission,
  dbo.TEDS_XWALK_MTHAMFLG.value as MethamphetamineSpeedReportedAtAdmission,
  dbo.TEDS_XWALK_AMPHFLG.value as OtherAmphetaminesReportedAtAdmission,
  dbo.TEDS_XWALK_STIMFLG.value as OtherStimulantsReportedAtAdmission,
  dbo.TEDS_XWALK_BENZFLG.value as BenzodiazepinesReportedAtAdmission,
  dbo.TEDS_XWALK_TRNQFLG.value as OtherTranquilizersReportedAtAdmission,
  dbo.TEDS_XWALK_BARBFLG.value as BarbituratesReportedAtAdmission,
  dbo.TEDS_XWALK_SEDHPFLG.value as OtherSedativesHypnoticsReportedAtAdmission,
  dbo.TEDS_XWALK_INHFLG.value as InhalantsReportedAtAdmission,
  dbo.TEDS_XWALK_OTCFLG.value as OverTheCounterMedicationReportedAtAdmission,
  dbo.TEDS_XWALK_OTHERFLG.value as OtherDrugReportedAtAdmission,
  dbo.TEDS_XWALK_DIVISION.value as CensusDivision,
  dbo.TEDS_XWALK_REGION.value as CensusRegion,
  dbo.TEDS_XWALK_IDU.value as CurrentIvDrugUseReportedAtAdmission,
  dbo.TEDS_XWALK_ALCDRUG.value as SubstanceUseType
into dbo.TEDS_A_2021
from 
  dbo.TEDS_A_combined_data_Hawaii_2015_2021
  LEFT JOIN dbo.TEDS_XWALK_STFIPS ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.STFIPS = dbo.TEDS_XWALK_STFIPS.id
  LEFT JOIN dbo.TEDS_XWALK_EDUC ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.EDUC = dbo.TEDS_XWALK_EDUC.id
  LEFT JOIN dbo.TEDS_XWALK_MARSTAT ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.MARSTAT = dbo.TEDS_XWALK_MARSTAT.id
  LEFT JOIN dbo.TEDS_XWALK_SERVICES ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.SERVICES = dbo.TEDS_XWALK_SERVICES.id
  LEFT JOIN dbo.TEDS_XWALK_DETCRIM ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.DETCRIM = dbo.TEDS_XWALK_DETCRIM.id
  LEFT JOIN dbo.TEDS_XWALK_NOPRIOR ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.NOPRIOR = dbo.TEDS_XWALK_NOPRIOR.id
  LEFT JOIN dbo.TEDS_XWALK_PSOURCE ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.PSOURCE = dbo.TEDS_XWALK_PSOURCE.id
  LEFT JOIN dbo.TEDS_XWALK_ARRESTS ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.ARRESTS = dbo.TEDS_XWALK_ARRESTS.id 
  LEFT JOIN dbo.TEDS_XWALK_EMPLOY ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.EMPLOY = dbo.TEDS_XWALK_EMPLOY.id
  LEFT JOIN dbo.TEDS_XWALK_METHUSE ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.METHUSE = dbo.TEDS_XWALK_METHUSE.id 
  LEFT JOIN dbo.TEDS_XWALK_PSYPROB ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.PSYPROB = dbo.TEDS_XWALK_PSYPROB.id
  LEFT JOIN dbo.TEDS_XWALK_PREG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.PREG = dbo.TEDS_XWALK_PREG.id
  LEFT JOIN dbo.TEDS_XWALK_GENDER ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.GENDER = dbo.TEDS_XWALK_GENDER.id
  LEFT JOIN dbo.TEDS_XWALK_VET ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.VET = dbo.TEDS_XWALK_VET.id
  LEFT JOIN dbo.TEDS_XWALK_LIVARAG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.LIVARAG = dbo.TEDS_XWALK_LIVARAG.id
  LEFT JOIN dbo.TEDS_XWALK_DAYWAIT ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.DAYWAIT = dbo.TEDS_XWALK_DAYWAIT.id
  LEFT JOIN dbo.TEDS_XWALK_DSMCRIT ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.DSMCRIT = dbo.TEDS_XWALK_DSMCRIT.id
  LEFT JOIN dbo.TEDS_XWALK_AGE ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.AGE = dbo.TEDS_XWALK_AGE.id
  LEFT JOIN dbo.TEDS_XWALK_RACE ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.RACE = dbo.TEDS_XWALK_RACE.id
  LEFT JOIN dbo.TEDS_XWALK_ETHNIC ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.ETHNIC = dbo.TEDS_XWALK_ETHNIC.id
  LEFT JOIN dbo.TEDS_XWALK_DETNLF ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.DETNLF = dbo.TEDS_XWALK_DETNLF.id
  LEFT JOIN dbo.TEDS_XWALK_PRIMINC ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.PRIMINC = dbo.TEDS_XWALK_PRIMINC.id
  LEFT JOIN dbo.TEDS_XWALK_SUB1 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.SUB1 = dbo.TEDS_XWALK_SUB1.id
  LEFT JOIN dbo.TEDS_XWALK_SUB2 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.SUB2 = dbo.TEDS_XWALK_SUB2.id
  LEFT JOIN dbo.TEDS_XWALK_SUB3 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.SUB3 = dbo.TEDS_XWALK_SUB3.id
  LEFT JOIN dbo.TEDS_XWALK_ROUTE1 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.ROUTE1 = dbo.TEDS_XWALK_ROUTE1.id
  LEFT JOIN dbo.TEDS_XWALK_ROUTE2 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.ROUTE2 = dbo.TEDS_XWALK_ROUTE2.id
  LEFT JOIN dbo.TEDS_XWALK_ROUTE3 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.ROUTE3 = dbo.TEDS_XWALK_ROUTE3.id
  LEFT JOIN dbo.TEDS_XWALK_FREQ1 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.FREQ1 = dbo.TEDS_XWALK_FREQ1.id
  LEFT JOIN dbo.TEDS_XWALK_FREQ2 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.FREQ2 = dbo.TEDS_XWALK_FREQ2.id
  LEFT JOIN dbo.TEDS_XWALK_FREQ3 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.FREQ3 = dbo.TEDS_XWALK_FREQ3.id
  LEFT JOIN dbo.TEDS_XWALK_FRSTUSE1 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.FRSTUSE1 = dbo.TEDS_XWALK_FRSTUSE1.id
  LEFT JOIN dbo.TEDS_XWALK_FRSTUSE2 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.FRSTUSE2 = dbo.TEDS_XWALK_FRSTUSE2.id
  LEFT JOIN dbo.TEDS_XWALK_FRSTUSE3 ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.FRSTUSE3 = dbo.TEDS_XWALK_FRSTUSE3.id
  LEFT JOIN dbo.TEDS_XWALK_HLTHINS ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.HLTHINS = dbo.TEDS_XWALK_HLTHINS.id
  LEFT JOIN dbo.TEDS_XWALK_PRIMPAY ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.PRIMPAY = dbo.TEDS_XWALK_PRIMPAY.id
  LEFT JOIN dbo.TEDS_XWALK_FREQ_ATND_SELF_HELP ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.FREQ_ATND_SELF_HELP = dbo.TEDS_XWALK_FREQ_ATND_SELF_HELP.id
  LEFT JOIN dbo.TEDS_XWALK_ALCFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.ALCFLG = dbo.TEDS_XWALK_ALCFLG.id
  LEFT JOIN dbo.TEDS_XWALK_COKEFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.COKEFLG = dbo.TEDS_XWALK_COKEFLG.id
  LEFT JOIN dbo.TEDS_XWALK_MARFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.MARFLG = dbo.TEDS_XWALK_MARFLG.id
  LEFT JOIN dbo.TEDS_XWALK_HERFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.HERFLG = dbo.TEDS_XWALK_HERFLG.id
  LEFT JOIN dbo.TEDS_XWALK_METHFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.METHFLG = dbo.TEDS_XWALK_METHFLG.id
  LEFT JOIN dbo.TEDS_XWALK_OPSYNFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.OPSYNFLG = dbo.TEDS_XWALK_OPSYNFLG.id
  LEFT JOIN dbo.TEDS_XWALK_PCPFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.PCPFLG = dbo.TEDS_XWALK_PCPFLG.id
  LEFT JOIN dbo.TEDS_XWALK_HALLFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.HALLFLG = dbo.TEDS_XWALK_HALLFLG.id
  LEFT JOIN dbo.TEDS_XWALK_MTHAMFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.MTHAMFLG = dbo.TEDS_XWALK_MTHAMFLG.id
  LEFT JOIN dbo.TEDS_XWALK_AMPHFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.AMPHFLG = dbo.TEDS_XWALK_AMPHFLG.id
  LEFT JOIN dbo.TEDS_XWALK_STIMFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.STIMFLG = dbo.TEDS_XWALK_STIMFLG.id
  LEFT JOIN dbo.TEDS_XWALK_BENZFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.BENZFLG = dbo.TEDS_XWALK_BENZFLG.id
  LEFT JOIN dbo.TEDS_XWALK_TRNQFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.TRNQFLG = dbo.TEDS_XWALK_TRNQFLG.id
  LEFT JOIN dbo.TEDS_XWALK_BARBFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.BARBFLG = dbo.TEDS_XWALK_BARBFLG.id
  LEFT JOIN dbo.TEDS_XWALK_SEDHPFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.SEDHPFLG = dbo.TEDS_XWALK_SEDHPFLG.id
  LEFT JOIN dbo.TEDS_XWALK_INHFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.INHFLG = dbo.TEDS_XWALK_INHFLG.id
  LEFT JOIN dbo.TEDS_XWALK_OTCFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.OTCFLG = dbo.TEDS_XWALK_OTCFLG.id
  LEFT JOIN dbo.TEDS_XWALK_OTHERFLG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.OTHERFLG = dbo.TEDS_XWALK_OTHERFLG.id
  LEFT JOIN dbo.TEDS_XWALK_DIVISION ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.DIVISION = dbo.TEDS_XWALK_DIVISION.id
  LEFT JOIN dbo.TEDS_XWALK_REGION ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.REGION = dbo.TEDS_XWALK_REGION.id
  LEFT JOIN dbo.TEDS_XWALK_IDU ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.IDU = dbo.TEDS_XWALK_IDU.id
  LEFT JOIN dbo.TEDS_XWALK_ALCDRUG ON  dbo.TEDS_A_combined_data_Hawaii_2015_2021.ALCDRUG = dbo.TEDS_XWALK_ALCDRUG.id;
-- created 1,455 records when run just on 2020 data, which matches the number of Hawaii entries in the  dbo.TEDS_A_combined_data_Hawaii_2015_2021 table.
-- When run on the combined data, it made 24,703 records, which is 1,455 more than what is in the current DOH tedsa_concatyears table