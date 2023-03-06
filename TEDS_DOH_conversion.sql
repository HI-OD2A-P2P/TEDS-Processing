
-- Query to convert the TEDS numeric codes to human readable format and load
-- the data in to a new table.  Must have run all the code in codebook_tables.sql first.
-- This query differs from the query found in TEDS_conversion.sql by:
--   the other one uses the original column names from samhsa, this one changes the column names to match DOH format.
--   the other one has all the states while this one strips out any non-Hawaii entries.
-- To change the state that gets kept, find the only "INNER JOIN" and change the state name there.
create table TEDS_A2
select
  TEDS_A_Numeric.ADMYR as YearOfAdmission, 
  TEDS_A_Numeric.CASEID as Caseid,
  TEDS_A_Numeric.CBSA2010 as Cbsa2010,
  TEDS_XWALK_STFIPS.value as CensusStateFipsCode,
  TEDS_XWALK_EDUC.value as Education,
  TEDS_XWALK_MARSTAT.value as MaritalStatus,
  TEDS_XWALK_SERVICES.value as TypeOfTreatmentServiceSetting,
  TEDS_XWALK_DETCRIM.value as DetailedCriminalJusticeReferral,
  TEDS_XWALK_NOPRIOR.value as PreviousSubstanceUseTreatmentEpisodes,
  TEDS_XWALK_PSOURCE.value as ReferralSource, 
  TEDS_XWALK_ARRESTS.value as ArrestsInPast30Days,
  TEDS_XWALK_EMPLOY.value as EmploymentStatus,
  TEDS_XWALK_METHUSE.value as MedicationAssistedOpioidTherapy,
  TEDS_XWALK_PSYPROB.value as CoOccurringMentalAndSubstanceUseDisorders,
  TEDS_XWALK_PREG.value as PregnantAtAdmission,
  TEDS_XWALK_GENDER.value as Gender,
  TEDS_XWALK_VET.value as VeteranStatus,
  TEDS_XWALK_LIVARAG.value as LivingArrangements,
  TEDS_XWALK_DAYWAIT.value as DaysWaitingToEnterSubstanceUseTreatment,
  TEDS_XWALK_DSMCRIT.value as DsmDiagnosisSuds4OrSuds19,
  TEDS_XWALK_AGE.value as AgeAtAdmission,
  TEDS_XWALK_RACE.value as Race,
  TEDS_XWALK_ETHNIC.value as Ethnicity,
  TEDS_XWALK_DETNLF.value as DetailedNotInLaborForce,
  TEDS_XWALK_PRIMINC.value as SourceOfIncomeSupport,
  TEDS_XWALK_SUB1.value as SubstanceUsePrimary,
  TEDS_XWALK_SUB2.value as SubstanceUseSecondary,
  TEDS_XWALK_SUB3.value as SubstanceUseTertiary,
  TEDS_XWALK_ROUTE1.value as RouteOfAdministrationPrimary,
  TEDS_XWALK_ROUTE2.value as RouteOfAdministrationSecondary,
  TEDS_XWALK_ROUTE3.value as RouteOfAdministrationTertiary,
  TEDS_XWALK_FREQ1.value as FrequencyOfUsePrimary,
  TEDS_XWALK_FREQ2.value as FrequencyOfUseSecondary,
  TEDS_XWALK_FREQ3.value as FrequencyOfUseTertiary,
  TEDS_XWALK_FRSTUSE1.value as AgeAtFirstUsePrimary,
  TEDS_XWALK_FRSTUSE2.value as AgeAtFirstUseSecondary,
  TEDS_XWALK_FRSTUSE3.value as AgeAtFirstUseTertiary,
  TEDS_XWALK_HLTHINS.value as HealthInsurance,
  TEDS_XWALK_PRIMPAY.value as PaymentSourcePrimaryExpectedOrActual,
  TEDS_XWALK_FREQ_ATND_SELF_HELP.value as AttendanceAtSubstanceUseSelfHelpGroupsInPast30,
  TEDS_XWALK_ALCFLG.value as AlcoholReportedAtAdmission,
  TEDS_XWALK_COKEFLG.value as CocaineCrackReportedAtAdmission,
  TEDS_XWALK_MARFLG.value as MarijuanaHashishReportedAtAdmission,
  TEDS_XWALK_HERFLG.value as HeroinReportedAtAdmission,
  TEDS_XWALK_METHFLG.value as NonRxMethadoneReportedAtAdmission,
  TEDS_XWALK_OPSYNFLG.value as OtherOpiatesSyntheticsReportedAtAdmission,
  TEDS_XWALK_PCPFLG.value as PcpReportedAtAdmission,
  TEDS_XWALK_HALLFLG.value as HallucinogensReportedAtAdmission,
  TEDS_XWALK_MTHAMFLG.value as MethamphetamineSpeedReportedAtAdmission,
  TEDS_XWALK_AMPHFLG.value as OtherAmphetaminesReportedAtAdmission,
  TEDS_XWALK_STIMFLG.value as OtherStimulantsReportedAtAdmission,
  TEDS_XWALK_BENZFLG.value as BenzodiazepinesReportedAtAdmission,
  TEDS_XWALK_TRNQFLG.value as OtherTranquilizersReportedAtAdmission,
  TEDS_XWALK_BARBFLG.value as BarbituratesReportedAtAdmission,
  TEDS_XWALK_SEDHPFLG.value as OtherSedativesHypnoticsReportedAtAdmission,
  TEDS_XWALK_INHFLG.value as InhalantsReportedAtAdmission,
  TEDS_XWALK_OTCFLG.value as OverTheCounterMedicationReportedAtAdmission,
  TEDS_XWALK_OTHERFLG.value as OtherDrugReportedAtAdmission,
  TEDS_XWALK_DIVISION.value as CensusDivision,
  TEDS_XWALK_REGION.value as CensusRegion,
  TEDS_XWALK_IDU.value as CurrentIvDrugUseReportedAtAdmission,
  TEDS_XWALK_ALCDRUG.value as SubstanceUseType
from 
  TEDS_A_Numeric
  INNER JOIN TEDS_XWALK_STFIPS 
    ON TEDS_A_Numeric.STFIPS = TEDS_XWALK_STFIPS.id 
    AND STFIPS.value = 'Hawaii'
  LEFT JOIN TEDS_XWALK_EDUC ON TEDS_A_Numeric.EDUC = TEDS_XWALK_EDUC.id
  LEFT JOIN TEDS_XWALK_MARSTAT ON TEDS_A_Numeric.MARSTAT = TEDS_XWALK_MARSTAT.id
  LEFT JOIN TEDS_XWALK_SERVICES ON TEDS_A_Numeric.SERVICES = TEDS_XWALK_SERVICES.id
  LEFT JOIN TEDS_XWALK_DETCRIM ON TEDS_A_Numeric.DETCRIM = TEDS_XWALK_DETCRIM.id
  LEFT JOIN TEDS_XWALK_NOPRIOR ON TEDS_A_Numeric.NOPRIOR = TEDS_XWALK_NOPRIOR.id
  LEFT JOIN TEDS_XWALK_PSOURCE ON TEDS_A_Numeric.PSOURCE = TEDS_XWALK_PSOURCE.id
  LEFT JOIN TEDS_XWALK_ARRESTS ON TEDS_A_Numeric.ARRESTS = TEDS_XWALK_ARRESTS.id 
  LEFT JOIN TEDS_XWALK_EMPLOY ON TEDS_A_Numeric.EMPLOY = TEDS_XWALK_EMPLOY.id
  LEFT JOIN TEDS_XWALK_METHUSE ON TEDS_A_Numeric.METHUSE = TEDS_XWALK_METHUSE.id 
  LEFT JOIN TEDS_XWALK_PSYPROB ON TEDS_A_Numeric.PSYPROB = TEDS_XWALK_PSYPROB.id
  LEFT JOIN TEDS_XWALK_PREG ON TEDS_A_Numeric.PREG = TEDS_XWALK_PREG.id
  LEFT JOIN TEDS_XWALK_GENDER ON TEDS_A_Numeric.GENDER = TEDS_XWALK_GENDER.id
  LEFT JOIN TEDS_XWALK_VET ON TEDS_A_Numeric.VET = TEDS_XWALK_VET.id
  LEFT JOIN TEDS_XWALK_LIVARAG ON TEDS_A_Numeric.LIVARAG = TEDS_XWALK_LIVARAG.id
  LEFT JOIN TEDS_XWALK_DAYWAIT ON TEDS_A_Numeric.DAYWAIT = TEDS_XWALK_DAYWAIT.id
  LEFT JOIN TEDS_XWALK_DSMCRIT ON TEDS_A_Numeric.DSMCRIT = TEDS_XWALK_DSMCRIT.id
  LEFT JOIN TEDS_XWALK_AGE ON TEDS_A_Numeric.AGE = TEDS_XWALK_AGE.id
  LEFT JOIN TEDS_XWALK_RACE ON TEDS_A_Numeric.RACE = TEDS_XWALK_RACE.id
  LEFT JOIN TEDS_XWALK_ETHNIC ON TEDS_A_Numeric.ETHNIC = TEDS_XWALK_ETHNIC.id
  LEFT JOIN TEDS_XWALK_DETNLF ON TEDS_A_Numeric.DETNLF = TEDS_XWALK_DETNLF.id
  LEFT JOIN TEDS_XWALK_PRIMINC ON TEDS_A_Numeric.PRIMINC = TEDS_XWALK_PRIMINC.id
  LEFT JOIN TEDS_XWALK_SUB1 ON TEDS_A_Numeric.SUB1 = TEDS_XWALK_SUB1.id
  LEFT JOIN TEDS_XWALK_SUB2 ON TEDS_A_Numeric.SUB2 = TEDS_XWALK_SUB2.id
  LEFT JOIN TEDS_XWALK_SUB3 ON TEDS_A_Numeric.SUB3 = TEDS_XWALK_SUB3.id
  LEFT JOIN TEDS_XWALK_ROUTE1 ON TEDS_A_Numeric.ROUTE1 = TEDS_XWALK_ROUTE1.id
  LEFT JOIN TEDS_XWALK_ROUTE2 ON TEDS_A_Numeric.ROUTE2 = TEDS_XWALK_ROUTE2.id
  LEFT JOIN TEDS_XWALK_ROUTE3 ON TEDS_A_Numeric.ROUTE3 = TEDS_XWALK_ROUTE3.id
  LEFT JOIN TEDS_XWALK_FREQ1 ON TEDS_A_Numeric.FREQ1 = TEDS_XWALK_FREQ1.id
  LEFT JOIN TEDS_XWALK_FREQ2 ON TEDS_A_Numeric.FREQ2 = TEDS_XWALK_FREQ2.id
  LEFT JOIN TEDS_XWALK_FREQ3 ON TEDS_A_Numeric.FREQ3 = TEDS_XWALK_FREQ3.id
  LEFT JOIN TEDS_XWALK_FRSTUSE1 ON TEDS_A_Numeric.FRSTUSE1 = TEDS_XWALK_FRSTUSE1.id
  LEFT JOIN TEDS_XWALK_FRSTUSE2 ON TEDS_A_Numeric.FRSTUSE2 = TEDS_XWALK_FRSTUSE2.id
  LEFT JOIN TEDS_XWALK_FRSTUSE3 ON TEDS_A_Numeric.FRSTUSE3 = TEDS_XWALK_FRSTUSE3.id
  LEFT JOIN TEDS_XWALK_HLTHINS ON TEDS_A_Numeric.HLTHINS = TEDS_XWALK_HLTHINS.id
  LEFT JOIN TEDS_XWALK_PRIMPAY ON TEDS_A_Numeric.PRIMPAY = TEDS_XWALK_PRIMPAY.id
  LEFT JOIN TEDS_XWALK_FREQ_ATND_SELF_HELP ON TEDS_A_Numeric.FREQ_ATND_SELF_HELP = TEDS_XWALK_FREQ_ATND_SELF_HELP.id
  LEFT JOIN TEDS_XWALK_ALCFLG ON TEDS_A_Numeric.ALCFLG = TEDS_XWALK_ALCFLG.id
  LEFT JOIN TEDS_XWALK_COKEFLG ON TEDS_A_Numeric.COKEFLG = TEDS_XWALK_COKEFLG.id
  LEFT JOIN TEDS_XWALK_MARFLG ON TEDS_A_Numeric.MARFLG = TEDS_XWALK_MARFLG.id
  LEFT JOIN TEDS_XWALK_HERFLG ON TEDS_A_Numeric.HERFLG = TEDS_XWALK_HERFLG.id
  LEFT JOIN TEDS_XWALK_METHFLG ON TEDS_A_Numeric.METHFLG = TEDS_XWALK_METHFLG.id
  LEFT JOIN TEDS_XWALK_OPSYNFLG ON TEDS_A_Numeric.OPSYNFLG = TEDS_XWALK_OPSYNFLG.id
  LEFT JOIN TEDS_XWALK_PCPFLG ON TEDS_A_Numeric.PCPFLG = TEDS_XWALK_PCPFLG.id
  LEFT JOIN TEDS_XWALK_HALLFLG ON TEDS_A_Numeric.HALLFLG = TEDS_XWALK_HALLFLG.id
  LEFT JOIN TEDS_XWALK_MTHAMFLG ON TEDS_A_Numeric.MTHAMFLG = TEDS_XWALK_MTHAMFLG.id
  LEFT JOIN TEDS_XWALK_AMPHFLG ON TEDS_A_Numeric.AMPHFLG = TEDS_XWALK_AMPHFLG.id
  LEFT JOIN TEDS_XWALK_STIMFLG ON TEDS_A_Numeric.STIMFLG = TEDS_XWALK_STIMFLG.id
  LEFT JOIN TEDS_XWALK_BENZFLG ON TEDS_A_Numeric.BENZFLG = TEDS_XWALK_BENZFLG.id
  LEFT JOIN TEDS_XWALK_TRNQFLG ON TEDS_A_Numeric.TRNQFLG = TEDS_XWALK_TRNQFLG.id
  LEFT JOIN TEDS_XWALK_BARBFLG ON TEDS_A_Numeric.BARBFLG = TEDS_XWALK_BARBFLG.id
  LEFT JOIN TEDS_XWALK_SEDHPFLG ON TEDS_A_Numeric.SEDHPFLG = TEDS_XWALK_SEDHPFLG.id
  LEFT JOIN TEDS_XWALK_INHFLG ON TEDS_A_Numeric.INHFLG = TEDS_XWALK_INHFLG.id
  LEFT JOIN TEDS_XWALK_OTCFLG ON TEDS_A_Numeric.OTCFLG = TEDS_XWALK_OTCFLG.id
  LEFT JOIN TEDS_XWALK_OTHERFLG ON TEDS_A_Numeric.OTHERFLG = TEDS_XWALK_OTHERFLG.id
  LEFT JOIN TEDS_XWALK_DIVISION ON TEDS_A_Numeric.DIVISION = TEDS_XWALK_DIVISION.id
  LEFT JOIN TEDS_XWALK_REGION ON TEDS_A_Numeric.REGION = TEDS_XWALK_REGION.id
  LEFT JOIN TEDS_XWALK_IDU ON TEDS_A_Numeric.IDU = TEDS_XWALK_IDU.id
  LEFT JOIN TEDS_XWALK_ALCDRUG ON TEDS_A_Numeric.ALCDRUG = TEDS_XWALK_ALCDRUG.id;
-- created 1,455 records when run just on 2020 data, which matches the number of Hawaii entries in the TEDS_A_Numeric table.
-- When run on the combined data, it made 24,703 records, which is 1,455 more than what is in the current DOH tedsa_concatyears table