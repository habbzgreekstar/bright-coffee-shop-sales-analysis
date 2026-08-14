# Bright Coffee Shop Sales Analysis

## Project Overview

Bright Coffee Shop provided historical transactional sales data for analysis.

The objective was to identify:
- Which products generate the most revenue
- The best-performing times of day
- Sales trends across products and time intervals
- Opportunities to improve sales performance

## Tools Used

- Databricks
- Databricks SQL
- Microsoft Excel
- Canva / PowerPoint
- Miro
- GitHub

## Data Processing

The raw CSV data was loaded into Databricks.

The following transformations were performed:

- Cleaned unit_price values
- Converted unit_price to numeric format
- Calculated total_amount
- Created 30-minute transaction_time_bucket intervals
- Checked data quality and duplicates
- Grouped data by product, category, time and store

## Key Calculation

total_amount = unit_price × transaction_qty

## Key Findings

- Total Revenue: $698,812.33
- Total Transactions: 149,116
- Total Units Sold: 214,470
- Average Transaction Value: $4.69
- Highest Revenue Category: Coffee — $269,952.45
- Highest Revenue Product Type: Barista Espresso — $91,406.20
- Peak Sales Interval: 10:30–11:00 — $44,966.59
- Top Product by Units: Earl Grey Rg — 4,708 units
- Highest Revenue Store: Hell's Kitchen — $236,511.17

## Recommendations

1. Run marketing campaigns during slower time slots.
2. Stock more of the best-selling items.
3. Promote underperforming products.
4. Automate daily sales reporting.
5. Track sales performance across multiple locations.
6. Implement loyalty programmes based on peak customer time slots.

## Deliverables

- Miro Flowchart
- Gantt Chart
- Raw CSV Data
- Databricks SQL Code
- Excel Pivot Tables and Charts
- Dashboard
- PowerPoint Presentation
- Case Study Documentation
