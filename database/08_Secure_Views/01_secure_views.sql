CREATE OR REPLACE VIEW secure.customer_contact AS SELECT customer_id,LEFT(customer_name,1)||'***' masked_customer_name,CASE WHEN phone_number IS NULL THEN NULL ELSE repeat('*',greatest(length(phone_number)-4,0))||right(phone_number,4) END masked_phone,region_id FROM core.customer;
CREATE OR REPLACE VIEW secure.underwriting_reporting AS SELECT customer_id,risk_score_category,CASE WHEN medical_risk_score IS NULL THEN NULL WHEN medical_risk_score>=70 THEN 'High' WHEN medical_risk_score>=40 THEN 'Medium' ELSE 'Low' END approved_risk_band FROM core.underwriting;
REVOKE ALL ON SCHEMA landing,core FROM PUBLIC;
GRANT USAGE ON SCHEMA mart_finance,mart_sales,mart_marketing,mart_underwriting,mart_executive TO insurance_powerbi_reader;
