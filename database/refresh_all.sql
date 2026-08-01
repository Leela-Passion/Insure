\set ON_ERROR_STOP on
SELECT dq.refresh_exceptions();
REFRESH MATERIALIZED VIEW mart_finance.policy_finance;
REFRESH MATERIALIZED VIEW mart_sales.agent_performance;
REFRESH MATERIALIZED VIEW mart_marketing.lead_funnel;
REFRESH MATERIALIZED VIEW mart_underwriting.risk_portfolio;
REFRESH MATERIALIZED VIEW mart_executive.region_health;
