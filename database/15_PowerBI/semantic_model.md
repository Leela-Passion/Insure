# Power BI semantic model

Connect only `insurance_powerbi_reader` to the five `mart_*` schemas. Do not import `landing`, `core`, `business`, or `secure` into Power BI.

Recommended dashboards: Executive uses `mart_executive.region_health`; Finance uses `mart_finance.policy_finance`; Sales uses `mart_sales.agent_performance`; Marketing uses `mart_marketing.lead_funnel`; Underwriting uses `mart_underwriting.risk_portfolio`.

Apply Power BI RLS using a region-access bridge owned by identity administration. Do not use customer, agent, nominee, phone, medical-test, or pre-existing-condition fields in the semantic model. Small-cell suppression should be applied for any regional risk segmentation.
