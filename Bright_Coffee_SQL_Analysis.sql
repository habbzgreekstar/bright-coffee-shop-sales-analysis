-- Bright Coffee Shop Sales Analysis
-- Databricks SQL
-- Processed table: retail.default.brightcoffee_processed

-- 1. NULL CHECK
-- Checks NULLs in the main analytical fields.
SELECT
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END) AS null_product_category,
    SUM(CASE WHEN product_type IS NULL THEN 1 ELSE 0 END) AS null_product_type,
    SUM(CASE WHEN product_detail IS NULL THEN 1 ELSE 0 END) AS null_product_detail,
    SUM(CASE WHEN transaction_date IS NULL THEN 1 ELSE 0 END) AS null_transaction_date,
    SUM(CASE WHEN transaction_time IS NULL THEN 1 ELSE 0 END) AS null_transaction_time,
    SUM(CASE WHEN transaction_qty IS NULL THEN 1 ELSE 0 END) AS null_transaction_qty,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS null_unit_price
FROM retail.default.brightcoffee_processed;

-- 2. DUPLICATE TRANSACTION CHECK
-- Finds duplicate transaction IDs.
SELECT
    transaction_id,
    COUNT(*) AS duplicate_count
FROM retail.default.brightcoffee_processed
GROUP BY transaction_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- 3. TOTAL REVENUE
SELECT ROUND(SUM(total_amount), 2) AS total_revenue
FROM retail.default.brightcoffee_processed;

-- 4. TOTAL TRANSACTIONS
SELECT COUNT(DISTINCT transaction_id) AS total_transactions
FROM retail.default.brightcoffee_processed;

-- 5. TOTAL UNITS SOLD
SELECT SUM(transaction_qty) AS total_units_sold
FROM retail.default.brightcoffee_processed;

-- 6. AVERAGE TRANSACTION VALUE
SELECT ROUND(AVG(total_amount), 2) AS average_transaction_value
FROM retail.default.brightcoffee_processed;

-- 7. REVENUE BY PRODUCT CATEGORY
-- Groups revenue by category and sorts from highest to lowest.
SELECT
    product_category,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    SUM(transaction_qty) AS units_sold
FROM retail.default.brightcoffee_processed
GROUP BY product_category
ORDER BY total_revenue DESC;

-- 8. REVENUE BY PRODUCT TYPE
SELECT
    product_type,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    SUM(transaction_qty) AS units_sold
FROM retail.default.brightcoffee_processed
GROUP BY product_type
ORDER BY total_revenue DESC;

-- 9. UNITS SOLD BY CATEGORY
SELECT
    product_category,
    SUM(transaction_qty) AS units_sold
FROM retail.default.brightcoffee_processed
GROUP BY product_category
ORDER BY units_sold DESC;

-- 10. TOP 10 BEST-SELLING PRODUCTS
SELECT
    product_detail,
    SUM(transaction_qty) AS units_sold,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM retail.default.brightcoffee_processed
GROUP BY product_detail
ORDER BY units_sold DESC
LIMIT 10;

-- 11. LOW-PERFORMING PRODUCTS
-- Use as a starting point for targeted promotions.
SELECT
    product_detail,
    SUM(transaction_qty) AS units_sold,
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM retail.default.brightcoffee_processed
GROUP BY product_detail
ORDER BY units_sold ASC
LIMIT 10;

-- 12. PEAK SALES TIME: 30-MINUTE BUCKETS
SELECT
    transaction_time_bucket,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    SUM(transaction_qty) AS units_sold
FROM retail.default.brightcoffee_processed
GROUP BY transaction_time_bucket
ORDER BY total_revenue DESC;

-- 13. PEAK SALES TIME: CHRONOLOGICAL VIEW
SELECT
    transaction_time_bucket,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    SUM(transaction_qty) AS units_sold
FROM retail.default.brightcoffee_processed
GROUP BY transaction_time_bucket
ORDER BY transaction_time_bucket;

-- 14. REVENUE BY STORE
SELECT
    store_location,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    SUM(transaction_qty) AS units_sold
FROM retail.default.brightcoffee_processed
GROUP BY store_location
ORDER BY total_revenue DESC;

-- 15. DAILY REVENUE TREND
SELECT
    transaction_date,
    ROUND(SUM(total_amount), 2) AS daily_revenue,
    SUM(transaction_qty) AS units_sold
FROM retail.default.brightcoffee_processed
GROUP BY transaction_date
ORDER BY transaction_date;

-- 16. HIGHEST SALES DAY
SELECT
    transaction_date,
    ROUND(SUM(total_amount), 2) AS daily_revenue
FROM retail.default.brightcoffee_processed
GROUP BY transaction_date
ORDER BY daily_revenue DESC
LIMIT 1;

-- 17. LOWEST SALES DAY
SELECT
    transaction_date,
    ROUND(SUM(total_amount), 2) AS daily_revenue
FROM retail.default.brightcoffee_processed
GROUP BY transaction_date
ORDER BY daily_revenue ASC
LIMIT 1;

-- 18. DAILY KPI REPORT
-- Suitable as the core of an automated daily report.
SELECT
    transaction_date,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS transactions,
    SUM(transaction_qty) AS units_sold,
    ROUND(AVG(total_amount), 2) AS average_transaction_value
FROM retail.default.brightcoffee_processed
GROUP BY transaction_date
ORDER BY transaction_date;

-- 19. EXECUTIVE KPI SNAPSHOT
SELECT
    ROUND(SUM(total_amount), 2) AS total_revenue,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(transaction_qty) AS total_units_sold,
    ROUND(AVG(total_amount), 2) AS average_transaction_value
FROM retail.default.brightcoffee_processed;

-- 20. OPTIONAL REUSABLE VIEW
-- Run only if your Databricks permissions allow CREATE VIEW.
CREATE OR REPLACE VIEW retail.default.brightcoffee_analysis AS
SELECT
    transaction_id,
    transaction_date,
    transaction_time,
    transaction_time_bucket,
    store_location,
    product_category,
    product_type,
    product_detail,
    transaction_qty,
    unit_price,
    total_amount
FROM retail.default.brightcoffee_processed;
