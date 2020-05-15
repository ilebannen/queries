# 2 Quien es el administrador con más personas a su cargo y cual es su salario
SELECT employees.emp_no, employees.first_name, employees.last_name, current_salary_of_manager_of_department_with_more_employees.salary
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
	 WHERE salaries.emp_no = (	 	
		 SELECT dept_manager.emp_no
	    FROM dept_manager
        INNER JOIN 
		  (	 
		  		 SELECT dept_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
			    FROM dept_manager
			    GROUP BY dept_no
		  ) dept_manager_last_date
        ON dept_manager.dept_no=dept_manager_last_date.dept_no AND dept_manager.from_date=dept_manager_last_date.from_date AND dept_manager.to_date = dept_manager_last_date.to_date
        WHERE dept_manager.dept_no = (
				SELECT current_dept_emp.dept_no
				FROM current_dept_emp
				GROUP BY current_dept_emp.dept_no
				HAVING count(*) = (
					SELECT MAX(count_employees) max_employees
					FROM (
						SELECT count(*) count_employees
						FROM current_dept_emp 
						GROUP BY current_dept_emp.dept_no
					) count_by_depto
		 		)
		   )
	 )
) current_salary_of_manager_of_department_with_more_employees
ON employees.emp_no=current_salary_of_manager_of_department_with_more_employees.emp_no;
