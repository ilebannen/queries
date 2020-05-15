# 3 Cual es la edad promedio de contratación por departamento?
SELECT departments.dept_no, departments.dept_name, depto_avg_age_hire.avg_age_hire
FROM departments 
INNER JOIN
(
	SELECT current_dept_emp.dept_no, AVG(employees_years.age_hire) as avg_age_hire
	FROM
	(
		SELECT employees.emp_no, FLOOR(DATEDIFF(employees.hire_date, employees.birth_date)/365) AS age_hire
		FROM employees
	) employees_years 
	JOIN current_dept_emp ON current_dept_emp.emp_no=employees_years.emp_no
	GROUP BY current_dept_emp.dept_no
) depto_avg_age_hire ON depto_avg_age_hire.dept_no=departments.dept_no;
