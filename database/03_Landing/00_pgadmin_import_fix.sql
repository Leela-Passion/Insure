-- Run this once in pgAdmin Query Tool before importing CSVs.
-- It removes the non-source technical column from earlier repository builds.
ALTER TABLE IF EXISTS landing.dim_customer DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.dim_agent DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.dim_region DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.dim_regional_manager DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.dim_policy_protection DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.dim_rider DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.fact_policy DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.fact_rider DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.fact_underwriting DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE IF EXISTS landing.fact_lead_funnel DROP COLUMN IF EXISTS loaded_at;
