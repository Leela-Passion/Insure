# Runbook

## Deployment

Run `deploy.sql` as the platform owner. It creates schemas, raw landing contracts, metadata, quality controls, secure views and empty materialized marts. Then load the CSV files and run `refresh_all.sql`.

## Release gates

1. Confirm CSV header contract and source record counts.
2. Review `dq.exception` and `dq.v_profile_summary`; exceptions must not be deleted.
3. Run `SELECT dq.refresh_exceptions();` and review `dq.exception`; zero rows are valid only when every configured rule passes.
4. Reconcile policy count and premium totals from `core.policy` to `mart_finance.policy_finance`.
5. Privacy reviewer approves changes to `meta.column_governance` and any new join path.
6. Grant Power BI only to the dedicated mart-reader role.

## Key lineage

`landing.fact_policy → core.policy → business.policy360 → mart_finance.policy_finance / mart_sales.agent_performance / mart_executive.region_health`.

`landing.fact_lead_funnel → core.lead → mart_marketing.lead_funnel → mart_executive.region_health`.

`landing.fact_underwriting → core.underwriting → secure.underwriting_reporting / mart_underwriting.risk_portfolio`.
