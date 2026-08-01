CREATE MATERIALIZED VIEW mart_sales.agent_performance AS SELECT region_id,current_agent_id agent_id,COUNT(*) policy_count,SUM(premium_amount) written_premium,AVG(premium_amount) avg_premium,AVG(payment_gap_months) avg_payment_gap FROM core.policy GROUP BY 1,2 WITH NO DATA;
CREATE UNIQUE INDEX IF NOT EXISTS ux_sales_agent_performance ON mart_sales.agent_performance(region_id,agent_id);
