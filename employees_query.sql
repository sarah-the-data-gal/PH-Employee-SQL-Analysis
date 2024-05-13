-- titles table
CREATE TABLE titles(
	title_id varchar(5) PRIMARY KEY,
	title varchar NOT NULL
);

-- employees table
CREATE TABLE employees(
	emp_no int PRIMARY KEY, 
	emp_title_id varchar(5) references titles(title_id),
	birth_date date,
	first_name varchar(50),
	last_name varchar(50),
	sex varchar NOT NULL,
	hire_date varchar NOT NULL
);

-- departments table
CREATE TABLE departments (
	dept_no varchar(5) PRIMARY KEY,
	emp_no varchar(10)
);

-- department manager table
CREATE TABLE dept_manager(
	dept_no varchar(5) references departments(dept_no),
	emp_no varchar(10)
);

-- department employees table
CREATE TABLE dept_emp(
	emp_no varchar(10) references employees(emp_no),
	dept_no varchar(5) references departments(dept_no)
);
-- salaries table
CREATE TABLE salaries(
	emp_no varchar(10) references employees(emp_no),
	salary int NOT NULL
);

-- 1. details of employees
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries on employees.emp_no= salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%1986';

-- 3. List the manager of each dept with details
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments ON dept_manager.dept_no= departments.dept_no
JOIN employees ON dept_manager.emp_no= employees.emp_no;

-- 4. List the dept # for each employee along with employees details 
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no= dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departmetns.dept_no;

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name= 'Hercules' and last_name LIKE 'B%';

--6. List employees in Sales dept, w/ employee #, last name, first name
SELECT * FROM departments;
SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no= dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no= dept_emp.dept_no
WHERE departments.dept_name= 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT * FROM departments;

SELECT employees.emp_no, employees.last_name, employees.first_name, dept_emp.dept_no
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no= dept_emp.emp_no
INNER JOIN departments
ON departmetns.dept_no= dept_emp.dept_no
WHERE departments.dept_name in ('Sales', 'Development');

-- List the frequency, in desc order, of all employees last names
SELECT last_name, COUNT(last_name) AS "Frequency count"
FROM employees
GROUP BY last_name
ORDER BY "Frequency count" DESC;



