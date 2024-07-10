CREATE DATABASE db_user_management;
USE db_user_management;

CREATE TABLE departments (
   departments_id 
   NAME VARCHAR(100),
   location VARCHAR(100)
);

CREATE TABLE employees(
  NAME VARCHAR(100),
  date_birth DATE,
  hire_date DATE,
  department_id INT,
  POSITION VARCHAR(30),
  base_salary INT
);

CREATE TABLE projects(
  NAME VARCHAR(100),
  budget INT,
  start_date DATE,
  end_date DATE
);

CREATE TABLE employee_projects(
  employee_id INT PRIMARY KEY,
  project_id INT, 
  hrs_worked INT
);


CREATE TABLE salaries (
   employee_id INT, 
   payment_date DATE, 
   gaji_dasar INT, 
   bonus INT, 
   potongan INT, 
   pendapatan INT
);



CREATE TABLE LeaveRequests (
   employee_id INT, 
   request_date DATE, 
   start_date DATE, 
   end_date DATE, 
   STATUS VARCHAR(50)
 );
 
 CREATE TABLE performance_reviews (
    employee_id INT, 
    review_date DATE, 
    reviewer VARCHAR(100), 
    performance_score INT, 
    comments TEXT
 );
-- -------------------------------------------------------------------------------
-- Data Manipulation Language
-- -------------------------------------------------------------------------------

-- INSERT into TABLE: departments
INSERT INTO departments (NAME, location)
   VALUES
      ('HR', 'New York'),
      ('IT', 'San Francisco'),
      ('Finance', 'Chicago'),
      ('Marketing', 'Los Angeles'),
      ('Sales', 'Houston');

-- INSERT into TABLE: employees
INSERT INTO employees (NAME, date_birth, hire_date, department_id, POSITION, base_salary)
   VALUES
      ('Alice Smith', '1985-06-15', '2010-03-01', 1, 'HR Manager', 80000),
      ('Bob Johnson', '1990-09-20', '2012-07-15', 2, 'Software Engineer', 95000),
      ('Charlie Davis', '1982-11-30', '2008-11-01', 3, 'Accountant', 70000),
      ('David Thompson', '1993-04-25', '2014-02-10', 4, 'Marketing Specialist', 65000),
      ('Eve Parker', '1979-01-18', '2005-06-23', 5, 'Sales Executive', 75000);

-- INSERT into TABLE: projects
INSERT INTO projects (NAME, budget, start_date, end_date)
   VALUES
      ('Project Alpha', 5000000, '2022-01-01', '2022-12-31'),
      ('Project Beta', 3000000, '2022-02-01', '2022-11-30'),
      ('Project Gamma', 7000000, '2022-03-01', '2023-03-31'),
      ('Project Delta', 4500000, '2022-04-01', '2022-10-31'),
      ('Project Epsilon', 6000000, '2022-05-01', '2023-05-31');

-- INSERT into TABLE TRANSACTION: employee_projects
INSERT INTO employee_projects (employee_id, project_id, hrs_worked)
   VALUES
      (1, 1, 120),
      (2, 2, 100),
      (3, 3, 140),
      (4, 4, 80),
      (5, 5, 90);

-- INSERT into TABLE: salaries
INSERT INTO salaries (employee_id, payment_date, gaji_dasar, bonus, potongan, pendapatan)
   VALUES
      (1, '2023-01-31', 80000, 5000, 2000, 83000),
      (2, '2023-02-28', 95000, 6000, 2500, 98500),
      (3, '2023-03-31', 70000, 4000, 1500, 72500),
      (4, '2023-04-30', 65000, 3500, 1800, 66700),
      (5, '2023-05-31', 75000, 4500, 2200, 77300);

-- INSERT into TABLE: leave_requests
INSERT INTO LeaveRequests (employee_id, request_date, start_date, end_date, STATUS)
   VALUES
      (1, '2024-01-10', '2024-02-01', '2024-02-10', 'Approved'),
      (2, '2024-02-05', '2024-03-01', '2024-03-05', 'Pending'),
      (3, '2024-03-12', '2024-04-01', '2024-04-07', 'Denied'),
      (4, '2024-04-20', '2024-05-01', '2024-05-10', 'Approved'),
      (5, '2024-05-15', '2024-06-01', '2024-06-05', 'Pending');

-- INSERT into TABLE: performance_reviews
INSERT INTO performance_reviews (employee_id, review_date, reviewer, performance_score, comments)
   VALUES
      (1, '2024-05-01', 'John Doe', 85, 'Konsisten memenuhi ekspektasi. Etos kerja yang kuat.'),
      (2, '2024-05-10', 'Jane Smith', 90, 'Kinerja luar biasa. Pemain tim yang sangat baik.'),
      (3, '2024-05-15', 'Robert Brown', 78, 'Memenuhi ekspektasi. Bisa meningkatkan manajemen waktu.'),
      (4, '2024-05-20', 'Emily White', 88, 'Kinerja yang kuat. Kemampuan memecahkan masalah yang hebat.'),
      (5, '2024-06-01', 'Michael Green', 92, 'Hasil yang luar biasa. Melebihi ekspektasi di sebagian besar area.'),
      (1, '2024-06-10', 'Laura Black', 80, 'Kinerja solid. Dapat diandalkan dan tepat waktu.'),
      (2, '2024-06-15', 'William Grey', 83, 'Kinerja yang baik. Menunjukkan potensi untuk peran kepemimpinan.'),
      (3, '2024-06-20', 'Sophia Blue', 87, 'Konsisten berkinerja baik. Kemampuan analisis yang kuat.'),
      (4, '2024-06-25', 'Oliver Purple', 75, 'Memenuhi persyaratan dasar. Perlu peningkatan dalam komunikasi.'),
      (5, '2024-06-30', 'Isabella Red', 91, 'Kinerja sangat baik. Menunjukkan inisiatif yang kuat.');
      
  
 -- view
 -- 1
 CREATE VIEW gaji_bulanan AS
  SELECT b NAME, POSITION, a NAME, payment_date, gaji_dasar, bonus, potongan, pendapatan FROM departments a JOIN employees b ON a.departments_id = b.departments_id
  JOIN salaries c ON b.employee_id=c.employee_id GROUP BY payment_date ORDER BY payment_date ASC;
  
  SELECT * gaji_bulanan;
  
 -- 2
 CREATE VIEW rata_rata AS
   SELECT a.name, AVG(c.bonus) AS rata_rata_bonus FROM departments a JOIN employees b ON a.departments_id = b.departments_id
   JOIN salaries c ON b.employee_id=c.employee_id GROUP BY departments_id;
   
 SELECT * FROM rata_rata;
 
 -- 3
 CREATE VIEW eval AS
   SELECT b.name, POSITION, a.name, review_date, AVG(c.performance_score) AS skor_kinerja_rata_rata, COUNT(c.employee_id) AS jumlah_ulasan FROM departments a JOIN employees b ON a.departments_id = b.departments_id
   JOIN performance_reviews c ON b.employee_id=c.employee_id GROUP BY c.employee_id ORDER BY review_date AND skor_kinerja_rata_rata;
   
 SELECT * FROM eval;
 
 -- stored procedure
 -- 1
 DELIMITER//
 CREATE PROCEDURE CalculateBonus (employee_id INT, bonus_percentage INT)
 BEGIN
   DECLARE jumlah = bonus_percentage;
   UPDATE salaries (bonus) VALUE jumlah WHERE employee_id = employe_id;
 END;
 DELIMITER;
 
 CALL CalculateBonus(1, 20000);
 
 -- 2 
 DELIMITER//
 CREATE PROCEDURE AdjustSalary (employee_id INT, salary_increment INT)
 BEGIN
   
      
      
 