# Enterprise Insurance Intelligence Platform

PostgreSQL-first analytical platform built exclusively from the supplied insurance CSV bundle. The project preserves source tables in `landing`, standardises records in `core`, retains quality exceptions, applies metadata-driven security classifications, and exposes only curated marts to Power BI.

## Build order

1. Create a PostgreSQL database and set `INSURANCE_CSV_DIR` to the folder containing the ten supplied CSV files.
2. Run `psql -v ON_ERROR_STOP=1 -f deploy.sql` from this repository root.
3. Load the immutable landing files with `psql -v data_dir="$INSURANCE_CSV_DIR" -f 03_Landing/02_load_landing.psql`.
4. Refresh quality exceptions and marts: `psql -f refresh_all.sql`.

The runbook in `16_Documentation/runbook.md` contains privileges, Power BI connection guidance, and release gates.

For pgAdmin imports, the landing tables have exactly the same columns as the source CSVs. If you used an earlier build, run `03_Landing/00_pgadmin_import_fix.sql` once before importing.

## Repository modules

`00_Governance` roles/classifications • `01_Database` schemas/functions • `02_Snowflake_Model` keys/indexes • `03_Landing` immutable source load • `04_Metadata` governance and rule metadata • `05_Core` standardised source views • `06_Data_Profiling` credibility views • `07_Data_Quality` traceable rules/exceptions • `08_Secure_Views` role-safe access • `09_Business_Layer` Customer/Policy/Agent/Region 360 views • `10–14_*_Mart` Power BI-facing marts • `15_PowerBI` semantic-model guidance • `16_Documentation` operating documentation.

## Design boundaries

- No new operational fact or dimension entities are invented.
- `landing` is raw and immutable; all invalid data remains traceable through quality exceptions.
- Direct PII and medical underwriting data never appear in reporting marts.
- The catalogue classifies data as restricted, confidential, sensitive, or internal and drives secure-view exposure.
