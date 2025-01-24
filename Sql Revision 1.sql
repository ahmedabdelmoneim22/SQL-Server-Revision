--SQL-Server--
--1>>(DDL)Data-Definition-Language لغة تعريف البيانات.
---------------
--(1)Create.
--(2)Alter.
--(3)Drop.
--(4)Truncate.
---------------
--1--Create.
Create Database MusaDatabase;
-----------------------------
Create Table anaMusaEmployees (
EmployeeID INT PRIMARY KEY,
FirstName VarChar(255) Not Null,
LastName VarChar(255) Not Null,
Department VarChar(255),
Salary Decimal(10,2))
---------------------------
--2--Alter.
--1. Adding Columns;
Alter Table anaMusaEmployees 
Add Email VarChar(255);
--2. Modifying Columns;
ALTER TABLE anaMusaEmployees 
Alter Column Salary DECIMAL(13,2);
--3. Dropping a column;
ALTER TABLE anaMusaEmployees 
DROP COLUMN Email;
--4. Adding a primary key Constraint;
ALTER TABLE anaMusaEmployees
ADD CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID);
--5. Dropping a foreign key Constraint:
ALTER TABLE anaMusaEmployees
DROP CONSTRAINT PK_Employees;
--6. Renaming a column:
EXEC sp_rename 'anaMusaEmployees.Salary',  'Salary$', 'COLUMN';
--+++++++++++++++++++++++++++
--3--DROP.
--1--Dropping Tables:-
DROP TABLE table_name;
--2--Dropping Columns:-
Alter Table table_name 
Drop Column column_name;
--3--Dropping Databases:-
Drop Database Database_name;
--4--Dropping Indexes:-
Drop Index Index_name On Table_name;
--5--Dropping Views:-
Drop View View_name;
--6--Dropping Constraints:-
Alter Table table_name 
Drop Constraint constraint_name;
--++++++++++++++++++++++++++++++
--4--TRUNCATE TABLE table_name;
---------------------------------
--2>>(DML)Data-Manipulation-Language لغة معالجة البيانات.
--1--SELECT.
Select * 
From ECDBMS_DWH.dbo.Fact_Sales;
--WHERE Country = 'Mexico';
--ORDER BY CustomerName; 
--LIMIT 10; 
--GROUP BY Country;
--HAVING COUNT(*) > 5;
--INNER JOIN;
----------------------------
--2--Insert;
INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Moses Musa', 'New York', 'USA');
-----------------------------
INSERT INTO Table1 (column1, column2, ...)
SELECT column1, column2, ...
FROM table2
WHERE condition;
------------------------------
--3--Update;
UPDATE Customers
SET ContactName = 'Moses Musa', City='Sydney'
WHERE CustomerID = 1;
------------------------------
--4--DELETE;
DELETE FROM Customers
WHERE CustomerID = 1;
------------------------------
--3>>(DCL)Data-Control-Language.
------------------------------
--1--Grant;
GRANT SELECT, INSERT ON anaMusaEmployees TO Test;
-------------------------------
--2--Revoke;
REVOKE SELECT, INSERT ON anaMusaEmployees FROM Test;
--------------------------------
--4>>(TCL)Transaction Control Language.
--1--Begin.
--2--COMMIT.
--Run AS block of code.
BEGIN TRANSACTION;
Select * From ECDBMS_DWH.dbo.Fact_Sales;
Select * From ECDBMS_DWH.dbo.Dim_Customers;
COMMIT;
CREATE PROCEDURE My_Procedure
AS
BEGIN
    -- SQL statements here;
END;
-----------------------------
--3--RollBack;
Select * From anaMusaEmployees;
--+++++++++++++++++++++++++++++++++
BEGIN TRANSACTION;
INSERT INTO anaMusaEmployees 
VALUES (1,'Moses','Musa','IT',3000);
--++++++++++++++++++++++++++++++++++
-- If an error occurs or you decide to cancel Run This:-
ROLLBACK;
--++++++++++++++++++++++++++++++++++
CREATE PROCEDURE GetCustomersByCity
@City VARCHAR(50)
AS
BEGIN
    SELECT * FROM Customers WHERE City = @City;
END;
--+++++++++++++++++++++++++++++++++++
---------------------------------
---------------------------------
--1. SELECT: استرجاع البيانات من جدول.
SELECT * 
FROM ECDBMS_DWH.dbo.Fact_Sales;
--2. WHERE: تصفية الصفوف بناءً على شروط.
SELECT * 
FROM ECDBMS_DWH.dbo.Fact_Sales 
WHERE product_amount > 2;
--3. ORDER BY: ترتيب النتائج تصاعديًا أو تنازليًا.
Select * From ECDBMS_DWH.dbo.Fact_Sales 
Order By sales_amount DESC;
--4. GROUP BY: تجميع الصفوف ذات القيم المتشابهة.
SELECT order_key, COUNT(*) as Totalcount
FROM ECDBMS_DWH.dbo.Fact_Sales 
GROUP BY order_key,customer_key;
--5. HAVING: تصفية المجموعات الناتجة عن GROUP BY.
SELECT order_key, COUNT(*) as Totalcount
FROM ECDBMS_DWH.dbo.Fact_Sales 
GROUP BY order_key,customer_key
Having Count(*) > 1;
--6. JOIN: دمج البيانات من جدولين أو أكثر.
SELECT C.customer_state,sum(F.sales_amount) as Sales_Amount
FROM ECDBMS_DWH.dbo.Fact_Sales as F
JOIN ECDBMS_DWH.dbo.Dim_Customers as C 
ON F.customer_key = C.customer_id
Group by C.customer_state
Order By Sales_Amount DESC;
--7. UNION: دمج نتائج استعلامين مختلفين.
/*SELECT name FROM employees 
UNION 
SELECT name FROM employees2;*/
--8. LIMIT: تحديد عدد الصفوف المسترجعة.
SELECT TOP 5 * 
FROM ECDBMS_DWH.dbo.Fact_Sales
Order By product_amount Desc;
--9. INSERT INTO: إضافة سجلات جديدة إلى جدول.
INSERT INTO anaMusaEmployees 
VALUES (1, 'Moses','Musa','Finance','3000');
INSERT INTO anaMusaEmployees 
Values(2,'Ahmed Abdelmonem','Elseaidy','Student','0');
--10. UPDATE: تعديل البيانات في جدول.
UPDATE anaMusaEmployees 
SET FirstName = 'Moses Abdelmonem' 
WHERE FirstName = 'Moses';
----------------------------------
Select * From anaMusaEmployees;
----------------------------------
--11. DELETE: حذف السجلات من جدول.
DELETE FROM anaMusaEmployees 
WHERE EmployeeID = 2;
--12. CREATE TABLE: إنشاء جدول جديد.
CREATE TABLE MusaEmployees (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10, 2)
);
--13. ALTER TABLE: تعديل بنية جدول موجود.
ALTER TABLE MusaEmployees 
ADD Age INT;
--14. DROP TABLE: حذف جدول.
DROP TABLE MusaEmployees;
--15. DISTINCT: استرجاع القيم الفريدة.
SELECT DISTINCT order_key 
FROM ECDBMS_DWH.dbo.Fact_Sales;
--16. COUNT(): عدّ عدد الصفوف.
SELECT COUNT(*) as NumberOfRows
FROM ECDBMS_DWH.dbo.Fact_Sales;
--17. SUM(): حساب مجموع القيم الرقمية.
SELECT SUM(sales_amount) as Total_Sales_Amount
FROM ECDBMS_DWH.dbo.Fact_Sales;
--18. AVG(): حساب المتوسط الحسابي.
SELECT AVG(sales_amount) as AVG_Sales_Amount
FROM ECDBMS_DWH.dbo.Fact_Sales;
--19. MIN() & MAX(): استرجاع أصغر وأكبر قيمة.
SELECT MAX(sales_amount) as MAX,MIN(sales_amount) as MIN 
FROM ECDBMS_DWH.dbo.Fact_Sales;
--20. SUB_QUERY: استعلام داخل استعلام.
SELECT * FROM ECDBMS_DWH.dbo.Fact_Sales 
WHERE sales_amount > 
(SELECT AVG(sales_amount) 
FROM ECDBMS_DWH.dbo.Fact_Sales);
---------------------------------------
---------------------------------------
--1--Select.
--retrieve data from a table استرجاع البيانات من جدول; 
Select * 
From ECDBMS_DWH.dbo.Fact_Sales as f
Where f.product_amount > 1;
------------------------------------
--2--Where.
--Filters rows based on conditions تصفية الصفوف بناءً على الشروط.
Select * 
From ECDBMS_DWH.dbo.Fact_Sales as f
Where f.product_amount > 2;
-----------------------------------
--3--Order BY.
--Sort results in ASC or DESC order.
Select * 
From ECDBMS_DWH.dbo.Fact_Sales as f
Where f.product_amount > 2
Order By sales_amount DESC;
------------------------------------
------------------------------------
--1. GROUP BY:-
--الهدف:-
--تجميع البيانات بناءً على قيم محددة في عمود واحد أو أكثر
--. غالبًا ما يتم استخدامها مع دوال التجميع مثل MIN, MAX, AVG, SUM, وCOUNT.
-->>{Total-Sales-For-Every-State}; 
Select C.customer_state,Sum(F.sales_amount) as Total_sales 
From ECDBMS_DWH.dbo.Fact_Sales as F join ECDBMS_DWH.dbo.Dim_Customers as C
On F.customer_key = C.customer_id
Group By C.customer_state;
---------------------------------
--2. TRIGGER:-
--الهدف:
--إجراء تلقائي يتم تشغيله عند تنفيذ عمليات 
--INSERT, UPDATE, أو DELETE على جدول.
--------------------------
Select * 
From anaMusaEmployees;
--------------------------
CREATE TRIGGER print_After_Insert
ON anaMusaEmployees
AFTER INSERT
AS
BEGIN
    PRINT 'A new employee has been added!';
END;
---------------------------
Insert Into anaMusaEmployees
Values(4,'Moses','Musa','Finance Data analysis','3000');
---------------------------
--4. STORED PROCEDURE:-
--لهدف:
--مجموعة من الأوامر البرمجية المخزنة في قاعدة البيانات والتي يمكن تنفيذها عند الحاجة.
CREATE PROCEDURE get_Fact_Sales
AS
BEGIN
    Select * From ECDBMS_DWH.dbo.Fact_Sales;
END;
--لتنفيذ الإجراء:-
EXEC get_Fact_Sales;
--الاستخدام: لتحسين الأداء وتقليل التكرار.
--------------------------------------------
--5.{UNION vs UNION ALL vs INTERSECT}:-
--UNION:{ دمج النتائج من استعلامين مع إزالة التكرارات}.
--UNION ALL:{دمج النتائج مع الاحتفاظ بالتكرارات}.
--INTERSECT:{استخراج القيم المشتركة بين الاستعلامين}.
--------------------------------------------
SELECT F.customer_key 
FROM ECDBMS_DWH.dbo.Fact_Sales as F 
Intersect
SELECT C.customer_id 
FROM ECDBMS_DWH.dbo.Dim_Customers C;
---------------------------------------------
--6.{DELETE vs TRUNCATE vs DROP}:-
--DELETE:-
--يحذف صفوفًا بناءً على شروط.
--يمكن التراجع باستخدام ROLLBACK.
------------------------------------
Select * From anaMusaEmployees;
------------------------------------
DELETE FROM anaMusaEmployees WHERE EmployeeID = 3;
------------------------------------
--TRUNCATE:-
--يحذف جميع الصفوف بدون شروط.
--لا يمكن التراجع عنه.
TRUNCATE TABLE Employees;
------------------------------------
--DROP:-
--يحذف الجدول بالكامل مع البيانات والبنية.
DROP TABLE Employees;
------------------------------------
--أعلى راتب:-
SELECT Top 1 sales_amount
FROM ECDBMS_DWH.dbo.Fact_Sales 
ORDER BY sales_amount DESC;
-------------------------------------
--أقل راتب:-
SELECT Top 2 sales_amount
FROM ECDBMS_DWH.dbo.Fact_Sales 
ORDER BY sales_amount ASC;
-------------------------------------
--الرواتب الفريدة:-
SELECT distinct Top 2 sales_amount
FROM ECDBMS_DWH.dbo.Fact_Sales 
ORDER BY sales_amount ASC;
-------------------------------------
--المفاتيح والفهارس:-
--PRIMARY KEY:-
--يضمن التميّز وعدم وجود قيم NULL.
--مثال:
CREATE TABLE employees (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);
--FOREIGN KEY:-
--يربط جدولين ببعضهما.
--مثال:-
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(Id)
);
--UNIQUE:
--يضمن أن القيم في العمود فريدة.
--مثال:-
CREATE TABLE employees2 (
    email VARCHAR(100) UNIQUE
);
--INDEX:-
--{يحسن أداء استرجاع البيانات.}
--مثال:
CREATE INDEX idx_name 
ON employees2(email);
----------------------------------
--Normalization:-{تنظيم قواعد البيانات لتقليل التكرار وتحسين الكفاءة}.
----------------------------------
--{Structure Query Languages: SQL Server}.
--1>>SQL statements.
/*
1. SELECT:
2. WHERE:
3. ORDER BY:
4. GROUP BY:
5. HAVING:
6. JOIN:
7. INSERT INTO:
8. UPDATE:
9. DELETE:
10. CREATE TABLE:
11. ALTER TABLE:
12. DROP TABLE:
13. DISTINCT:
14. LIMIT:
15. COUNT():
16. AVG(), SUM(), MIN(), MAX():
17. UNION:
18. UNION ALL:
19. INTERSECT:
20. TRUNCATE TABLE:
*/
--2>>Join.
--1. INNER JOIN.
--INNER JOIN
--2. LEFT JOIN (or LEFT OUTER JOIN).
--LEFT JOIN.
--3. RIGHT JOIN (or RIGHT OUTER JOIN).
--RIGHT JOIN.
--4. FULL JOIN (or FULL OUTER JOIN).
--FULL JOIN.
-->>>{Matching-Key}<<<--
-------------------------
--3>>{SUM(), AVG(), COUNT(), MIN(), MAX()}<<--
--SELECT Column_name, Aggregate_function(Column_name)
--FROM Table_name
--GROUP BY Column_name;
-------------------------
--4>>{Query 1: Total Sales per Product}.
--{Query 2: Total Sales per Region}.
--{Query 3: Average Sales per Product}.
--GROUP BY with Multiple Columns:GROUP BY Product, Region;
--Filtering Groups with HAVING;
-------------------------
--5>>Common-Aggregate-Functions<<--
--COUNT();
--SUM();
--AVG();
--MIN();
--MAX();
------------------------
--6>>UNION, UNION ALL, and INTERSECT;
------------------------
--UNION.
--UNION ALL.
--INTERSECT.
------------------------
--7>>Subqueries;
--1--WHERE Salary > (SELECT AVG(Salary) FROM Employees);
--2--WHERE Department IN (SELECT Department FROM Departments WHERE City = 'New York');
--3--WHERE (Product_Name, Price) IN (SELECT Product_Name, Price FROM Store2);
--4--WHERE Salary > (SELECT AVG(Salary) FROM Employees e2 WHERE e1.Department = e2.Department);
--5--FROM (SELECT Department, Salary FROM Employees) AS DeptSalaries;
--6--SELECT Name, Salary, (Salary / (SELECT SUM(Salary) FROM Employees) * 100) AS SalaryPercentage;
-------------------
--8>>Types of Ranking Functions;
--1--ROW_NUMBER();
--2--RANK();
--3--DENSE_RANK();
--4--NTILE(n);
-------------------
--<Ranking_Function>() OVER (PARTITION BY column_name ORDER BY column_name);
-------------------
--9>>Types of Constraints<<
--1>>NOT NULL;
--2>>UNIQUE;
--3>>PRIMARY KEY>>Not Null and Unique;
--4>>FOREIGN KEY>>Links one table to another by PK.
--5>>CHECK>>{Age INT CHECK (Age >= 18 AND Age <= 60)}.
--6>>DEFAULT>>{HireDate DATE DEFAULT GETDATE()}.
--7>>INDEX>>{CREATE INDEX idx_salary ON Employees(Salary)}.
------------------
--10>>Rules;
--SELECT [columns]
--FROM [tables]
--WHERE [conditions]
--GROUP BY [columns]
--HAVING [conditions]
--ORDER BY [columns]
--LIMIT [n];
------------------
--11>>Variables;
--SELECT @@version; -- Returns the database version;
--SELECT @@datadir; -- Returns the directory path for database files;
------------------
DECLARE @VariableName DataType;
SET @VariableName = Value;
------------------
DECLARE @EmployeeCount INT;
SELECT @EmployeeCount = COUNT(*) FROM Employees;
PRINT @EmployeeCount;
------------------
--12>>IF;
/*IF condition THEN
    -- Code to execute if condition is true
ELSE
    -- Code to execute if condition is false
END IF;*/
------------------
DECLARE @Salary INT = 5000;

IF @Salary > 4000
BEGIN
    PRINT 'Salary is above 4000.';
    IF @Salary > 6000
    BEGIN
        PRINT 'Salary is also above 6000.';
    END
    ELSE
    BEGIN
        PRINT 'Salary is below 6000.';
    END
END
ELSE
BEGIN
    PRINT 'Salary is below 4000.';
END
--------------------------------------
--------------------------------------
--13>>SQL Functions;
--1>>A. Built-In Functions;
--1--Aggregate Functions;
-->>SUM(), AVG(), MIN(), MAX(), COUNT()<<--
--2--String Functions;
-->>UPPER(), LOWER(), CONCAT(), SUBSTRING().
--3--Date and Time Functions;
-->>NOW(), GETDATE(), DATEADD(), DATEDIFF().
--4--Mathematical Functions;
-->>ROUND(), CEIL(), FLOOR(), ABS().
--5--Conversion Functions;
-->>>Built-In Functions Examples<<<--
--SELECT COUNT(*) AS TotalEmployees FROM Employees;
--SELECT AVG(Salary) AS AverageSalary FROM Employees;
--SELECT MAX(Salary) AS HighestSalary FROM Employees;
--------------------------------------
--2>>User-Defined Functions Examples;
--أمثلة على الوظائف المحددة من قبل المستخدم;
--------------------------------------
CREATE FUNCTION GetEmployeesAboveSalary(@MinSalary INT)
RETURNS TABLE
AS
RETURN
(
    SELECT Name, Salary 
	FROM Employees 
	WHERE Salary > @MinSalary;
);
--------------------------------------
SELECT * FROM dbo.GetEmployeesAboveSalary(5000);
--------------------------------------
-->>ReusAbility إمكانية إعادة الاستخدام;
--------------------------------------
--14>>SQL-Views-SQL عرض;
--1>>Virtual-Table الجدول الافتراضي;
--2>>Read-Only or Up_datable للقراءة فقط أو قابلة للتحديث;
--3>>Security حماية;
-----------------------------
/*CREATE VIEW view_name AS
SELECT Columns
FROM Table_name
WHERE Condition;*/
-----------------------------
--->>SELECT * FROM View_name;<<---
--->>DROP VIEW view_name;<<---
-----------------------------
--CREATE VIEW EmployeeView AS
--SELECT EmployeeID, FirstName, LastName, Department, Salary
--FROM Employees
--WHERE Salary > 5000;
----------------------------
-->>15>الإجراءات المخزنة (Stored Procedures) في SQL<<<--
/*
الإجراء المخزن هو عبارة عن مجموعة من تعليمات SQL يتم تخزينها في قاعدة البيانات وتنفيذها عند الحاجة.
يساعد في تقليل تكرار الكود وتحسين الأداء من خلال تقليل النقل بين العميل والخادم.
*/
--->>>إنشاء إجراء لتحديث راتب موظف معين:<<<---
--------------------------------------
CREATE PROCEDURE UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary DECIMAL(10, 2)
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
END;
-------------------------------------
EXEC UpdateEmployeeSalary @EmployeeID = 101, @NewSalary = 6000.00;
-------------------------------------
--16--كيفية إنشاء فهرس في SQL:-
/*CREATE INDEX Index_name 
ON Table_name (Column_name);*/
-------------------------------------
--17--Trigger:-يتم تنفيذه تلقائيًا;
--1--BEFORE Trigger.
--2--AFTER Trigger.
--3--INSTEAD OF Trigger.
------------------------
--1. Trigger قبل الإدراج (BEFORE INSERT);
CREATE TRIGGER trigger_name
BEFORE INSERT
ON table_name
FOR EACH ROW
BEGIN
    -- الإجراء الذي يتم تنفيذه
END;
------------------------
--2. Trigger بعد الإدراج (AFTER INSERT);
CREATE TRIGGER trigger_name
AFTER INSERT
ON table_name
FOR EACH ROW
BEGIN
    -- الإجراء الذي يتم تنفيذه
END;
------------------------
CREATE TRIGGER salary_check
AFTER INSERT
ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary > 5000 THEN
        PRINT 'New employee has a high salary!';
    END IF;
END;
------------------------
------------------------
--18--Cursor:-{استخدامات الـ Cursor:};
-->>المعالجة التكرارية: عندما تحتاج إلى معالجة البيانات صفًا تلو الآخر.<<--
------------------------
--1. إعلان الـ Cursor;
DECLARE cursor_name CURSOR FOR
SELECT column1, column2
FROM table_name
WHERE condition;
------------------------
--2. فتح الـ Cursor;
OPEN cursor_name;
------------------------
--3. استخراج البيانات;
FETCH NEXT FROM cursor_name INTO @variable1, @variable2;
------------------------
--4. معالجة البيانات (حلقة تكرار):LOOP,WHILE;
------------------------
--5. إغلاق الـ Cursor;
------------------------
--CLOSE cursor_name;
--DEALLOCATE cursor_name;
------------------------
Select * 
From ECDBMS_DWH.dbo.Fact_Sales;
------------------------
-->>>المعالجة التكرارية: عندما تحتاج إلى معالجة البيانات صفًا تلو الآخر<<<--
------------------------
DECLARE @product_amount int, @sales_amount float;
-------------------------
DECLARE Sales_cursor CURSOR FOR
Select product_amount,sales_amount
From ECDBMS_DWH.dbo.Fact_Sales;
-------------------------
OPEN Sales_cursor;
-------------------------
-->>جلب القيم<<--
FETCH NEXT FROM Sales_cursor INTO @product_amount, @sales_amount;
-------------------------
WHILE @@FETCH_STATUS = 0
Begin
    PRINT 'Product Amount: ' + CAST(@product_amount AS VarChar) + ', Sales Amount: ' + CAST(@sales_amount AS VarChar);
    FETCH NEXT FROM Sales_cursor INTO @product_amount, @sales_amount;
END;
CLOSE Sales_cursor;
DEALLOCATE Sales_cursor;
-------------------------
-------------------------
--19--Creating a Job in SQL Server.
--SQL Server Agent>>Jobs;
-------------------------
--20-->>Create a database snapshot<<--
/*
لقطات قاعدة البيانات (Database Snapshot) 
في SQL Server هي ميزة تتيح إنشاء نسخة ثابتة
وقابلة للقراءة فقط من قاعدة البيانات في نقطة زمنية معينة.
*/
USE ECDBMS_DWH;
GO
EXEC sp_helpfile;
CREATE DATABASE DWH_Snapshot
ON 
(
    NAME = ECDBMS_DWH,
    FILENAME = 'C:\ECDBMS\DWH_Snapshot_Data2.ss'
)
AS SNAPSHOT OF ECDBMS_DWH;
GO
-----------------------------------------------
-----------------------------------------------
--21--Backup & Restore;
/*
في SQL Server، يتم استخدام النسخ الاحتياطي (Backup) والاستعادة (Restore) 
لحماية البيانات من الفقدان وضمان استرداد البيانات في حالة حدوث مشاكل مثل فشل النظام أو أخطاء بشرية.
*/
-->> النسخ الاحتياطي (Backup) والاستعادة (Restore) <<--
-->>Full Backup (نسخة كاملة)<<--
-->>نسخة احتياطية كاملة<<--
------------Full Backup------------------
BACKUP DATABASE ECDBMS_DWH
TO DISK = 'C:\ECDBMS\ECDBMS_DWH_Full.bak'
WITH FORMAT;
GO
-----------------------------------------
--------------الاستعادة (Restore)---------
/*USE ECDBMS_DWH;
RESTORE DATABASE ECDBMS_DWH
FROM DISK = 'C:\ECDBMS\ECDBMS_DWH_Full.bak'
WITH RECOVERY;
GO*/
------------------------------------------
-->>>Restore From SQL Server Steps<<<--
--Step 1: Connect to the SQL Server;
--Step 2: Databases >> Right Click >>Restore Database;
-------------------------------------------
-------------------------------------------
--22--Jobs--
--Understanding Jobs in SQL Server--
------------------------------------
--1>>Creating and Managing Jobs in SQL Server.
--Step 1: Open SQL Server Agent.
--Step 2: Right-click on Jobs under SQL Server Agent.
--Step 3: Select New Job.
--------------------------------
Select *
From ECDBMS_DWH.dbo.Fact_Sales; 
--------------------------------
USE ECDBMS_DWH;
CREATE DATABASE DWH_Snapshot3
ON 
(
    NAME = ECDBMS_DWH,
    FILENAME = 'C:\ECDBMS\DWH_Snapshot_Data3.ss'
)
AS SNAPSHOT OF ECDBMS_DWH;
GO
-------------------------------
--1.SQL Server Agent;
--2.Jobs>>Right-Click>>New Job...
--3.
--1>>General.
--2>>Steps.
--3>>Schedules الجداول الزمنية.
-------------------------------
-->>Run-Job<<--
--1>>SQL Server Agent;
--2>>Jobs;
--3>>ahmed job;
--4>>Right-Click;
--5>>Start Job at Step...
------------------------------
------------------------------








