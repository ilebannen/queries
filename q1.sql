# 1 Sueldo promedio por departamento
SELECT departments.dept_name, avg(current_salary_emp.salary)
FROM employees 
INNER JOIN 
(
	 SELECT salaries.emp_no, salaries.salary
    FROM salaries
        INNER JOIN 
		  (	 
		  		 SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
			    FROM salaries
			    GROUP BY emp_no
		  ) emp_salary_last_date
        ON salaries.emp_no=emp_salary_last_date.emp_no AND salaries.from_date=emp_salary_last_date.from_date AND salaries.to_date = emp_salary_last_date.to_date
) current_salary_emp  ON employees.emp_no=current_salary_emp.emp_no
JOIN current_dept_emp ON employees.emp_no=current_dept_emp.emp_no
JOIN departments ON departments.dept_no=current_dept_emp.dept_no
GROUP BY departments.dept_name;
