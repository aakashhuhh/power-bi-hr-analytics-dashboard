# HR Analytics Dashboard using Power BI

This project analyses employee attrition and workforce patterns using a combination of SQL data cleaning and a Power BI dashboard. It is designed to help HR and business stakeholders understand which employee groups are most likely to leave and why.

## Project Overview

The dashboard explores:

- Attrition rate by age group
- Attrition by department and job role
- Attrition by education field and salary slab
- Attrition by tenure, overtime, and gender
- Overall employee trends and workforce insights

The analysis is based on the file `HR Data.csv` and the SQL transformations in `HR_Analytics.sql`.

## Files in This Project

- `HR Data.csv` — raw employee dataset used for analysis
- `HR_Analytics.sql` — SQL script for cleaning, standardising, deduplicating, and creating views for dashboard analysis
- `HR Analytics dashboard.pbix` — Power BI report file
- `HR Analytics dashboard.pdf` — exported PDF version of the dashboard

## What This Project Demonstrates

- Data cleaning and transformation using SQL
- Duplicate removal and standardisation of inconsistent values
- Creation of analysis views for attrition insights
- Building a Power BI dashboard for interactive visualisation

## How to Use This Project

1. Open `HR Analytics dashboard.pbix` in Power BI Desktop to interact with the dashboard.
2. Review `HR_Analytics.sql` to understand the data preparation steps.
3. Use `HR Data.csv` if you want to reproduce or extend the analysis in another tool.

## Suggested Tools

- Microsoft Power BI Desktop
- SQL Server Management Studio (SSMS) or any SQL Server-compatible environment
- Excel or CSV viewer for quick dataset inspection

## Outcome

This project provides a practical example of how SQL and Power BI can be combined to create an HR analytics dashboard focused on employee attrition and workforce behaviour.

## Notes

The SQL script includes steps for:

- adding an attrition indicator column
- removing unused columns
- identifying and removing duplicate rows
- standardising inconsistent values
- creating views for attrition analysis
