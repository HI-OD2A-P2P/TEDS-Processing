CREATE VIEW dbo.teds_d_data_view AS
select distinct
  Caseid,
  AgeAtAdmission,
  YearOfDischarge,
  Gender,
  SubstanceUsePrimary,
  SubstanceUseSecondary,
  SubstanceUseTertiary,
  CASE
    WHEN SubstanceUsePrimary = 'None' Then 0
    WHEN SubstanceUseSecondary = 'None' THEN 1
	WHEN SubstanceUseTertiary = 'None' THEN 2
	Else 3
  END as num_substances
from dbo.TEDS_D;