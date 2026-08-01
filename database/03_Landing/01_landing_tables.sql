-- Raw values intentionally remain text. Do not update/delete landing rows.
CREATE TABLE IF NOT EXISTS landing.dim_customer (customer_id text,customer_name text,phone_number text,gender text,marital_status text,income text,income_band text,occupation text,occupation_risk text,age_at_entry text,preferred_language text,region_id text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.dim_agent (agent_id text,name text,experience_years text,joining_date text,region_id text,performance_rating text,languages_known text,specialisation text,product_wise_conversion_rate text,median_ticket_size text,sales_cycle_efficiency text,drop_off_rate_after_first_call text,upsell_conversion_percentage text,sla_adherence text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.dim_region (region_id text,region_name text,state text,zone text,region_type text,region_dir text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.dim_regional_manager (manager_id text,name text,experience_years text,performance_score text,region_id text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.dim_policy_protection (policy_type_code text,policy_name text,policy_type text,coverage_details text,grace_period text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.dim_rider (rider_type_id text,rider_name text,description text,risk_level text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.fact_policy (policy_id text,customer_id text,policy_type_code text,region_id text,current_agent_id text,nominee_name text,sum_assured text,premium_amount text,policy_start_date text,date_of_purchase text,purchase_quarter text,purchase_year text,purchase_month text,policy_end_date text,date_of_maturity text,status text,last_paid_date text,premium_payment_term text,policy_term text,loan_eligible text,lock_in_period_months text,claim_reason text,underwriting_expenses text,surrender_amount text,total_premium_paid text,payment_gap_months text,amount_withdrawn text,maturity_amount text,total_premium_payable text,fraud_risk_flag text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.fact_rider (rider_record_id text,policy_id text,customer_id text,rider_type_id text,rider_premium text,rider_sum_assured text,rider_start_date text,rider_end_date text,rider_status text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.fact_underwriting (underwriting_id text,customer_id text,bmi_value text,age_at_entry text,blood_pressure_category text,smoking_flag text,alcohol_flag text,sugar_risk_category text,cholesterol_risk_category text,ecg_risk_category text,urine_test_risk_category text,liver_test_risk_category text,kidney_test_risk_category text,preexisting_condition_identified text,preexisting_condition_type text,waiting_period_months text,long_term_medication text,prescription_frequency_monthly text,medical_condition_score text,aggregated_medical_risk_score text,risk_score_category text,base_premium text,loaded_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE IF NOT EXISTS landing.fact_lead_funnel (lead_id text,customer_id text,campaign text,campaign_type text,utm_link text,time_spent_on_pricing_page text,scroll_depth text,page_visits_count text,engagement_score text,downloaded_brochure text,used_maturity_calculator text,compared_plans text,lead_stage text,lead_status text,lead_status_date text,rejection_reason text,rejection_reason_code text,first_time_response_failure text,follow_up_required text,follow_up_date text,follow_up_pitch text,proposal_form_completed text,competitor text,authority text,budget text,need text,timeline text,prospect_needs text,prospect_needs_addressed text,referral_name text,loaded_at timestamptz NOT NULL DEFAULT now());

-- pgAdmin's Import/Export dialog maps the source header to target columns.
-- Keep landing column contracts exactly aligned to the supplied CSV headers.
ALTER TABLE landing.dim_customer DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.dim_agent DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.dim_region DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.dim_regional_manager DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.dim_policy_protection DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.dim_rider DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.fact_policy DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.fact_rider DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.fact_underwriting DROP COLUMN IF EXISTS loaded_at;
ALTER TABLE landing.fact_lead_funnel DROP COLUMN IF EXISTS loaded_at;
