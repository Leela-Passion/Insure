CREATE TABLE IF NOT EXISTS dq.exception (exception_id bigserial PRIMARY KEY,run_at timestamptz NOT NULL DEFAULT now(),rule_name text NOT NULL,entity_key text,table_name text NOT NULL,column_name text,severity text NOT NULL,exception_detail jsonb NOT NULL,resolved_at timestamptz);
CREATE OR REPLACE FUNCTION dq.refresh_exceptions() RETURNS void LANGUAGE plpgsql AS $$
BEGIN
  -- Rebuild the unresolved exception register from the current load. Source records
  -- remain in landing/core; this only refreshes their quality observations.
  DELETE FROM dq.exception WHERE resolved_at IS NULL;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'customer_name_completeness',customer_id,'core.customer','customer_name','High',jsonb_build_object('customer_id',customer_id)
  FROM core.customer WHERE customer_name IS NULL;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'customer_phone_completeness',customer_id,'core.customer','phone_number','Medium',jsonb_build_object('phone_number',phone_number)
  FROM core.customer WHERE phone_number IS NULL OR length(phone_number) <> 10;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'policy_customer_integrity',policy_id,'core.policy','customer_id','High',jsonb_build_object('customer_id',customer_id)
  FROM dq.v_policy_integrity;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'policy_premium_validity',policy_id,'core.policy','premium_amount','Critical',jsonb_build_object('premium_amount',premium_amount)
  FROM core.policy WHERE premium_amount IS NULL OR premium_amount < 0;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'policy_purchase_date_validity',policy_id,'core.policy','purchase_date','Medium',jsonb_build_object('policy_id',policy_id)
  FROM core.policy WHERE purchase_date IS NULL;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'lead_customer_integrity',l.lead_id,'core.lead','customer_id','High',jsonb_build_object('customer_id',l.customer_id)
  FROM core.lead l LEFT JOIN core.customer c ON c.customer_id=l.customer_id WHERE c.customer_id IS NULL;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'lead_status_date_completeness',lead_id,'core.lead','lead_status_date','Medium',jsonb_build_object('lead_status',lead_status)
  FROM core.lead WHERE lead_status_date IS NULL;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'underwriting_customer_integrity',u.underwriting_id,'core.underwriting','customer_id','High',jsonb_build_object('customer_id',u.customer_id)
  FROM core.underwriting u LEFT JOIN core.customer c ON c.customer_id=u.customer_id WHERE c.customer_id IS NULL;

  INSERT INTO dq.exception(rule_name,entity_key,table_name,column_name,severity,exception_detail)
  SELECT 'rider_policy_integrity',r.rider_record_id,'core.rider','policy_id','High',jsonb_build_object('policy_id',r.policy_id)
  FROM core.rider r LEFT JOIN core.policy p ON p.policy_id=r.policy_id WHERE p.policy_id IS NULL;
END $$;
