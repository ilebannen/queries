# 4 Cuales son las 10 personas que han tenido un mayor incremento de salario?
SELECT employees.emp_no, employees.first_name, employees.last_name, ten_employees_max_increment_salary.increment_salary
FROM employees 
INNER JOIN  
(
	SELECT salaries.emp_no, MAX(salary) - MIN(salary) as increment_salary
	FROM salaries 
	GROUP BY salaries.emp_no
	ORDER BY increment_salary DESC
	LIMIT 10
) ten_employees_max_increment_salary 
ON ten_employees_max_increment_salary.emp_no=employees.emp_no;
