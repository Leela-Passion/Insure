CREATE SCHEMA IF NOT EXISTS landing;
CREATE SCHEMA IF NOT EXISTS core;
CREATE SCHEMA IF NOT EXISTS meta;
CREATE SCHEMA IF NOT EXISTS dq;
CREATE SCHEMA IF NOT EXISTS secure;
CREATE SCHEMA IF NOT EXISTS business;
CREATE SCHEMA IF NOT EXISTS mart_finance;
CREATE SCHEMA IF NOT EXISTS mart_sales;
CREATE SCHEMA IF NOT EXISTS mart_marketing;
CREATE SCHEMA IF NOT EXISTS mart_underwriting;
CREATE SCHEMA IF NOT EXISTS mart_executive;

CREATE OR REPLACE FUNCTION core.try_date(p_value text) RETURNS date LANGUAGE plpgsql IMMUTABLE AS $$
BEGIN
  IF nullif(btrim(p_value),'') IS NULL THEN RETURN NULL; END IF;
  RETURN CASE WHEN p_value ~ '^\\d{4}-\\d{2}-\\d{2}$' THEN p_value::date ELSE to_date(p_value,'DD-MM-YYYY') END;
EXCEPTION WHEN others THEN RETURN NULL; END $$;
CREATE OR REPLACE FUNCTION core.try_numeric(p_value text) RETURNS numeric LANGUAGE plpgsql IMMUTABLE AS $$
BEGIN RETURN nullif(regexp_replace(btrim(p_value),'[^0-9.\-]','','g'),'')::numeric; EXCEPTION WHEN others THEN RETURN NULL; END $$;
CREATE OR REPLACE FUNCTION core.clean_phone(p_value text) RETURNS text LANGUAGE sql IMMUTABLE AS $$
 SELECT NULLIF(regexp_replace(COALESCE(p_value,''),'[^0-9]','','g'),'') $$;
CREATE OR REPLACE FUNCTION core.normalize_yes_no(p_value text) RETURNS boolean LANGUAGE sql IMMUTABLE AS $$
 SELECT CASE upper(trim(p_value)) WHEN 'Y' THEN true WHEN 'N' THEN false ELSE NULL END $$;
