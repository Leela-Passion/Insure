-- Grant only mart read access to the Power BI service principal/group.
GRANT SELECT ON ALL TABLES IN SCHEMA mart_finance,mart_sales,mart_marketing,mart_underwriting,mart_executive TO insurance_powerbi_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA mart_finance GRANT SELECT ON TABLES TO insurance_powerbi_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA mart_sales GRANT SELECT ON TABLES TO insurance_powerbi_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA mart_marketing GRANT SELECT ON TABLES TO insurance_powerbi_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA mart_underwriting GRANT SELECT ON TABLES TO insurance_powerbi_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA mart_executive GRANT SELECT ON TABLES TO insurance_powerbi_reader;
