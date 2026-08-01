-- Run as a database administrator. Login management remains outside this repository.
DO $$ BEGIN
  CREATE ROLE insurance_platform_owner NOLOGIN;
  CREATE ROLE insurance_data_engineer NOLOGIN;
  CREATE ROLE insurance_underwriter NOLOGIN;
  CREATE ROLE insurance_powerbi_reader NOLOGIN;
  CREATE ROLE insurance_privacy_reviewer NOLOGIN;
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

COMMENT ON ROLE insurance_powerbi_reader IS 'Can query approved marts only; no landing/core access.';
