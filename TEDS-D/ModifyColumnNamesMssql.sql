EXEC sp_rename 'dbo.TEDS_D.CASEID', 'Caseid', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.CBSA', 'CoreBasedStatisticalArea', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.PMSA', 'PrimaryMetropolitanStatisticalAreas', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.DISYR', 'YearOfDischarge', 'COLUMN'; 
EXEC sp_rename 'dbo.TEDS_D.NUMSUBS', 'NumSubstancesAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.STFIPS', 'CensusStateFipsCode', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.EDUC', 'Education', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.MARSTAT', 'MaritalStatus', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SERVICES', 'TypeOfTreatmentServiceSetting', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.DETCRIM', 'DetailedCriminalJusticeReferral', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.NOPRIOR', 'PreviousSubstanceUseTreatmentEpisodes', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.PSOURCE', 'ReferralSource', 'COLUMN'; 
EXEC sp_rename 'dbo.TEDS_D.ARRESTS', 'ArrestsInPast30Days', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.EMPLOY', 'EmploymentStatus', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.METHUSE', 'MedicationAssistedOpioidTherapy', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.PSYPROB', 'CoOccurringMentalAndSubstanceUseDisorders', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.PREG', 'PregnantAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.GENDER', 'Gender', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.VET', 'VeteranStatus', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.LIVARAG', 'LivingArrangements', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.DAYWAIT', 'DaysWaitingToEnterSubstanceUseTreatment', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.DSMCRIT', 'DsmDiagnosisSuds4OrSuds19', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.AGE', 'AgeAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.RACE', 'Race', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.ETHNIC', 'Ethnicity', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.DETNLF', 'DetailedNotInLaborForce', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.PRIMINC', 'SourceOfIncomeSupport', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SUB1', 'SubstanceUsePrimary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SUB2', 'SubstanceUseSecondary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SUB3', 'SubstanceUseTertiary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.ROUTE1', 'RouteOfAdministrationPrimary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.ROUTE2', 'RouteOfAdministrationSecondary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.ROUTE3', 'RouteOfAdministrationTertiary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FREQ1', 'FrequencyOfUsePrimary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FREQ2', 'FrequencyOfUseSecondary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FREQ3', 'FrequencyOfUseTertiary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FRSTUSE1', 'AgeAtFirstUsePrimary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FRSTUSE2', 'AgeAtFirstUseSecondary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FRSTUSE3', 'AgeAtFirstUseTertiary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.HLTHINS', 'HealthInsurance', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.PRIMPAY', 'PaymentSourcePrimaryExpectedOrActual', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FREQ_ATND_SELF_HELP', 'AttendanceAtSubstanceUseSelfHelpGroupsInPast30', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.ALCFLG', 'AlcoholReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.COKEFLG', 'CocaineCrackReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.MARFLG', 'MarijuanaHashishReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.HERFLG', 'HeroinReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.METHFLG', 'NonRxMethadoneReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.OPSYNFLG', 'OtherOpiatesSyntheticsReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.PCPFLG', 'PcpReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.HALLFLG', 'HallucinogensReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.MTHAMFLG', 'MethamphetamineSpeedReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.AMPHFLG', 'OtherAmphetaminesReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.STIMFLG', 'OtherStimulantsReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.BENZFLG', 'BenzodiazepinesReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.TRNQFLG', 'OtherTranquilizersReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.BARBFLG', 'BarbituratesReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SEDHPFLG', 'OtherSedativesHypnoticsReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.INHFLG', 'InhalantsReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.OTCFLG', 'OverTheCounterMedicationReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.OTHERFLG', 'OtherDrugReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.DIVISION', 'CensusDivision', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.REGION', 'CensusRegion', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.IDU', 'CurrentIvDrugUseReportedAtAdmission', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.ALCDRUG', 'SubstanceUseType', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.LOS', 'LengthOfStayInTreatment', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SERVICES_D', 'ServiceTypeAtDischarge', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.REASON', 'DischargeReason', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.EMPLOY_D', 'EmploymentStatusAtDischarge', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.LIVARAG_D', 'LivingArrangementsAtDischarge', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.ARRESTS_D', 'ArrestsBeforeDischarge', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.DETNLF_D', 'DetailedNotInLaborForceAtDischarge', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SUB1_D', 'SubstanceUseAtDischargePrimary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SUB2_D', 'SubstanceUseAtDischargeSecondary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.SUB3_D', 'SubstanceUseAtDischargeTertiary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FREQ1_D', 'FrequencyOfUseAtDischargePrimary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FREQ2_D', 'FrequencyOfUseAtDischargeSecondary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FREQ3_D', 'FrequencyOfUseAtDischargeTertiary', 'COLUMN';
EXEC sp_rename 'dbo.TEDS_D.FREQ_ATND_SELF_HELP_D', 'AttendanceAtSubstanceUseSelfHelpGroupsInPast30B4Discharge', 'COLUMN';