-- Constraints are applied to curated standardised views through quality rules; landing remains permissive to preserve source evidence.
CREATE INDEX IF NOT EXISTS ix_policy_customer ON landing.fact_policy(customer_id);
CREATE INDEX IF NOT EXISTS ix_policy_agent ON landing.fact_policy(current_agent_id);
CREATE INDEX IF NOT EXISTS ix_policy_region ON landing.fact_policy(region_id);
CREATE INDEX IF NOT EXISTS ix_lead_customer ON landing.fact_lead_funnel(customer_id);
CREATE INDEX IF NOT EXISTS ix_uw_customer ON landing.fact_underwriting(customer_id);
CREATE INDEX IF NOT EXISTS ix_rider_policy ON landing.fact_rider(policy_id);
CREATE INDEX IF NOT EXISTS ix_governance_lookup ON meta.column_governance(table_schema,table_name,column_name);
