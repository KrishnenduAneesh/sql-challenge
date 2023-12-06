--Drop table "Department";

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "title_id" varchar(10)   NOT NULL,
    "birth_date" Date   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" Date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(10)   NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_no" varchar(10)   NOT NULL,
    "emp_no" int   NOT NULL
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

CREATE TABLE "Titles" (
    "title_id" varchar(10)   NOT NULL,
    "title" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "Department" (
    "dept_no" varchar(10)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "dept_no"
     )
);

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_title_id" FOREIGN KEY("title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

--List the employee number, last name, first name, sex, and salary of each employee
SELECT e.emp_no,
       e.last_name,
       e.first_name,
       e.sex,
       s.salary
FROM "Employees" e
JOIN "Salaries" s ON e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986
SELECT emp_no,
       last_name,
       first_name,
	   hire_date
from "Employees" 
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)
SELECT de.dept_no,
       de.emp_no,
       e.last_name,
       e.first_name,
       d.dept_name
FROM "Dept_emp" de
JOIN "Employees" e ON de.emp_no = e.emp_no
JOIN "Department" d ON de.dept_no = d.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
SELECT first_name,
		last_name,
		sex
FROM "Employees"
WHERE  first_name= 'Hercules' AND last_name LIKE 'B%' ; 

--List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       d.dept_name
FROM "Employees" e
JOIN "Dept_emp" de ON e.emp_no = de.emp_no
JOIN "Department" d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       d.dept_name
FROM "Employees" e
JOIN "Dept_emp" de ON e.emp_no = de.emp_no
JOIN "Department" d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');
	
--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT last_name, COUNT(*) AS name_count
FROM "Employees"
GROUP BY last_name
ORDER BY name_count DESC;

COMMIT;