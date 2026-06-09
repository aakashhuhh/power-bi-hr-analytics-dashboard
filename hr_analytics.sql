-- ============================================================
-- DATA CLEANING
-- ============================================================

-- Here, I have added a column to the table which has value
-- 1 or 0 depending if attrition is yes or no,
-- as by summing and counting this column,
-- we would get better insights about attrition.

ALTER TABLE dbo.HR_Analytics
ADD attrition_value INT;

UPDATE dbo.HR_Analytics
SET attrition_value =
    CASE
        WHEN attrition = 'Yes' THEN 1
        ELSE 0
    END
FROM dbo.HR_Analytics;

SELECT *
FROM dbo.HR_Analytics;


-- ============================================================
-- REMOVING UNUSED COLUMN
-- ============================================================

-- We had an extra column in our table which had blank values
-- and wasn't of much use for visualization purposes.

ALTER TABLE dbo.HR_Analytics
DROP COLUMN YearsWithCurrManager;


-- ============================================================
-- CHECKING FOR DUPLICATE ROWS
-- ============================================================

SELECT
    empid,
    ROW_NUMBER() OVER (
        PARTITION BY empid
        ORDER BY empid
    ) AS num_rows
FROM dbo.HR_Analytics
ORDER BY 2 DESC;


-- ============================================================
-- REMOVING DUPLICATES
-- ============================================================

-- The data had some duplicate rows in it,
-- so I first imported all distinct rows into another table.
-- Then I truncated the original table and inserted
-- the distinct rows back into it.
--
-- NOTE:
-- One can easily do all these steps within Excel and Power BI,
-- but I still chose to do all the work via SQL and use these
-- results in Power BI to make visualizations,
-- just to get the most out of SQL.

SELECT DISTINCT *
INTO dbo.HR2
FROM dbo.HR_Analytics;

TRUNCATE TABLE dbo.HR_Analytics;

INSERT INTO dbo.HR_Analytics
SELECT *
FROM dbo.HR2;

DROP TABLE dbo.HR2;


SELECT
    empid,
    ROW_NUMBER() OVER (
        PARTITION BY empid
        ORDER BY empid
    ) AS num_rows
FROM dbo.HR_Analytics
ORDER BY 2 DESC;

-- We can see that duplicates are now removed.


-- ============================================================
-- STANDARDIZING COLUMN VALUES
-- ============================================================

-- The data has 'Travel_Rarely' and 'TravelRarely'
-- as two different values in the BusinessTravel column,
-- so I updated the values for consistency.

SELECT BusinessTravel
FROM dbo.HR_Analytics
GROUP BY BusinessTravel;

UPDATE dbo.HR_Analytics
SET BusinessTravel = 'Travel_Rarely'
WHERE BusinessTravel = 'TravelRarely';

SELECT BusinessTravel
FROM dbo.HR_Analytics
GROUP BY BusinessTravel;


-- ============================================================
-- DATA ANALYSIS USING VIEWS
-- ============================================================

-- Our data is now cleaned.
-- The next step is to perform analysis on the data.
--
-- I created different views for:
-- Attrition by Age, Department, Education Field,
-- Job Role, Salary, Years at Company,
-- Gender, and Overtime.
--
-- These saved views can be imported into Power BI
-- for further analysis and visualization.
--
-- NOTE:
-- If the following views already exist,
-- first run the DROP VIEW command.


-- ============================================================
-- ATTRITION VS AGE
-- ============================================================

DROP VIEW IF EXISTS AttVSAge;

CREATE VIEW AttVSAge AS
(
    SELECT
        AgeGroup,
        SUM(Attrition_value) AS [number of employee attrited],
        COUNT(AgeGroup) AS [Employee count],
        (
            CONVERT(FLOAT, SUM(Attrition_value))
            / CONVERT(FLOAT, COUNT(AgeGroup))
        ) * 100 AS Attrition_percentage
    FROM dbo.HR_Analytics
    GROUP BY AgeGroup
);

SELECT *
FROM AttVSAge;


-- ============================================================
-- ATTRITION VS DEPARTMENT
-- ============================================================

DROP VIEW IF EXISTS AttVSDep;

CREATE VIEW AttVSDep AS
SELECT
    Department,
    SUM(Attrition_value) AS [number of employee attrited],
    COUNT(Department) AS TotalEmployeePerDepartment,
    (
        CONVERT(FLOAT, SUM(Attrition_value))
        / CONVERT(FLOAT, COUNT(Department))
    ) * 100 AS Attrition_percentage
FROM dbo.HR_Analytics
GROUP BY Department;

SELECT *
FROM AttVSDep;


-- ============================================================
-- ATTRITION VS EDUCATIONAL FIELD
-- ============================================================

DROP VIEW IF EXISTS AttVSEdu;

CREATE VIEW AttVSEdu AS
SELECT
    EducationField,
    SUM(Attrition_value) AS [number of employee attrited],
    COUNT(EducationField) AS TotalEmployeePerEducation,
    (
        CONVERT(FLOAT, SUM(Attrition_value))
        / CONVERT(FLOAT, COUNT(EducationField))
    ) * 100 AS Attrition_percentage
FROM dbo.HR_Analytics
GROUP BY EducationField;

SELECT *
FROM AttVSEdu;


-- ============================================================
-- ATTRITION VS JOB ROLE
-- ============================================================

DROP VIEW IF EXISTS AttVSJob;

CREATE VIEW AttVSJob AS
SELECT
    JobRole,
    SUM(Attrition_value) AS [number of employee attrited],
    COUNT(JobRole) AS TotalEmployeePerJobrole,
    (
        CONVERT(FLOAT, SUM(Attrition_value))
        / CONVERT(FLOAT, COUNT(JobRole))
    ) * 100 AS Attrition_percentage
FROM dbo.HR_Analytics
GROUP BY JobRole;

SELECT *
FROM AttVSJob;


-- ============================================================
-- ATTRITION VS SALARY SLAB
-- ============================================================

DROP VIEW IF EXISTS AttVSSal;

CREATE VIEW AttVSSal AS
SELECT
    SalarySlab,
    SUM(Attrition_value) AS [number of employee attrited],
    COUNT(SalarySlab) AS TotalEmployeePerSalarySlab,
    (
        CONVERT(FLOAT, SUM(Attrition_value))
        / CONVERT(FLOAT, COUNT(SalarySlab))
    ) * 100 AS Attrition_percentage
FROM dbo.HR_Analytics
GROUP BY SalarySlab;

SELECT *
FROM AttVSSal;


-- ============================================================
-- ATTRITION VS YEARS AT COMPANY
-- ============================================================

DROP VIEW IF EXISTS AttVSYrs;

CREATE VIEW AttVSYrs AS
SELECT
    YearsAtCompany,
    SUM(Attrition_value) AS [number of employee attrited],
    COUNT(YearsAtCompany) AS TotalEmployeePerYearsAtCompany,
    (
        CONVERT(FLOAT, SUM(Attrition_value))
        / CONVERT(FLOAT, COUNT(YearsAtCompany))
    ) * 100 AS Attrition_percentage
FROM dbo.HR_Analytics
GROUP BY YearsAtCompany;

SELECT *
FROM AttVSYrs;


-- ============================================================
-- ATTRITION VS OVERTIME
-- ============================================================

DROP VIEW IF EXISTS AttVSOverT;

CREATE VIEW AttVSOverT AS
SELECT
    OverTime,
    SUM(Attrition_value) AS [number of employee attrited],
    COUNT(OverTime) AS TotalEmployeePerOverTime,
    (
        CONVERT(FLOAT, SUM(Attrition_value))
        / CONVERT(FLOAT, COUNT(OverTime))
    ) * 100 AS Attrition_percentage
FROM dbo.HR_Analytics
GROUP BY OverTime;

SELECT *
FROM AttVSOverT;


-- ============================================================
-- ATTRITION VS GENDER
-- ============================================================

DROP VIEW IF EXISTS AttVSGen;

CREATE VIEW AttVSGen AS
SELECT
    Gender,
    SUM(Attrition_value) AS [number of employee attrited],
    COUNT(Gender) AS TotalEmployeePerGender,
    (
        CONVERT(FLOAT, SUM(Attrition_value))
        / CONVERT(FLOAT, COUNT(Gender))
    ) * 100 AS Attrition_percentage
FROM dbo.HR_Analytics
GROUP BY Gender;

SELECT *
FROM AttVSGen;


-- ============================================================
-- USING CTE FOR ATTRITION ANALYSIS
-- ============================================================

-- One can use CTE here too.

WITH cte (
    AgeGroup,
    emp_attri,
    count_age
) AS
(
    SELECT
        AgeGroup,
        SUM(Attrition_value) AS emp_attri,
        COUNT(AgeGroup)
    FROM dbo.HR_Analytics
    GROUP BY AgeGroup
)

SELECT *,
       (
           CONVERT(FLOAT, emp_attri)
           / CONVERT(FLOAT, count_age)
       ) * 100
FROM cte
ORDER BY emp_attri DESC;
