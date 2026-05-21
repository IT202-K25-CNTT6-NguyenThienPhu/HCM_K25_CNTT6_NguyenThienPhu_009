CREATE DATABASE dtb_final;
USE dtb_final;

CREATE TABLE Employees (
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number INT UNIQUE,
    hire_date DATE DEFAULT(CURRENT_DATE),
    salary INT CHECK(salary > 0)
);

CREATE TABLE Employee_Details (
	detail_id INT PRIMARY KEY,
    employee_id INT UNIQUE,
    citizen_id INT NOT NULL UNIQUE,
    address TEXT NOT NULL,
    working_status VARCHAR(20) CHECK(ENUM = ('Active','Inactive')),
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Departments (
	department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE Projects (
	project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    department_id INT,
    budget INT CHECK(budget > 0),
    project_status VARCHAR(100) CHECK(ENUM = ('Pending','Doing','Done')),
    CONSTRAINT FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Work_Assignments (
	assignment_id INT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    start_date DATE NOT NULL,
    deadline DATE NOT NULL,
    completed_date DATE,
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    CONSTRAINT FOREIGN KEY (project_id) REFERENCES Projects(employee_id)
);

INSERT INTO Employees
VALUES
	(1,'Nguyen Van A','anv@gmail.com',0901234567,'2022-01-15',12000000),
    (2,'Tran Thi B','btt@gmail.com',0901234568,'2021-05-15',18000000),
    (3,'Le Van C','ele@gmail.com',0901234569,'2023-02-10',9500000),
    (4,'Pham Minh D','dmp@gmail.com',0901265567,'2020-11-05',22000000),
    (5,'Hoang Anh E','eho@gmail.com',0901235767,'2023-01-12',15000000);
    
INSERT INTO Employee_Details
VALUES
	(1,1,123456789,'Ha Noi','Acite'),
    (2,2,234567890,'Hai Phong','Acite'),
    (3,3,345678901,'Da Nang','Inacite'),
    (4,4,456789012,'Ho Chi Minh','Acite'),
    (5,5,567890123,'Can Tho','Acite');
    
INSERT INTO Departments
VALUES
	(1,'IT','Phòng công nghệ thông tin'),
    (2,'HR','Phòng kinh doanh'),
    (3,'Marketing','Phòng marketing'),
    (4,'Finance','Phòng tài chính'),
    (5,'Sales','Phòng kinh doanh');
    
INSERT INTO Projects
VALUES
	(1,'Website Company',1,50000000,'Doing'),
    (2,'Recruitment 2025',2,50000000,'Peding'),
    (3,'Ads Campaign',3,50000000,'Doing'),
    (4,'Accounting System',4,50000000,'Done'),
    (5,'Customer Expansion',5,50000000,'Peding');
    
INSERT INTO Work_Assignments
VALUES
	(101,1,1,'2024-01-10',2024-02-10,NULL),
    (102,2,2,'2024-02-01',2024-03-01,2024-02-25),
    (103,3,3,'2024-03-05',2024-04-05,NULL),
    (104,4,4,'2023-10-10',2024-12-10,2023-12-05),
    (105,5,5,'2024-04-01',2024-05-01,NULL);

-- Câu 2
SELECT department_id,department_name
FROM Departments
WHERE department_name = 'IT' IN (
	SELECT project_name, budget
    FROM Projects
    WHERE budget = budget + 5000000
 );
 
DELETE FROM Work_Assignments
WHERE completed_date IS NOT NULL AND start_date < 2024;


-- Phần 3
-- Câu 1
SELECT project_id, project_name,budget
FROM Projects
WHERE department_name = 'IT' AND budget > 30000000;

-- Câu 2
SELECT employee_id,full_name,email
FROM Employees
WHERE start_date LIKE '2022%' AND email LIKE '%@gmail.com';

-- Câu 3
SELECT employee_id, full_name, salary
FROM Employees
ORDER BY salary DESC
LIMIT 2 OFFSET 3;

-- Phần 4
-- Câu 1
SELECT 
	m.assignment_id,
    e.full_name,
    e.project_name,
    t.start_date,
	t.completed_date
FROM Work_Assignments m
JOIN Projects e ON e.project_id AND t.project_id
JOIN Work_Assignments m ON m.assignment_id AND t.assignment_id;

-- Câu 2
SELECT department_name, SUM(budget) AS total_budget
FROM Projects
WHERE total_budget > 40000000;

-- Câu 3
SELECT employee_id, full_name, working_status
FROM Employee_Details
WHERE full_name 


-- Phần 5
-- Câu 1
CREATE INDEX idx_asignment_date
ON Work_Assignments(start_date,completed_date);
-- Câu 2

-- Phần 6
DELIMITER //
CREATE TRIGGER trg_assignment_insert 
FOR EACH ROW 
BEGIN

END //
DELIMITER ;




