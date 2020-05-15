# 5 Cual es el departamento donde hay más rotación de personal?
SELECT departments.dept_no, departments.dept_name, depto_with_more_asignations.employee_asignations
FROM departments
INNER JOIN
(
	SELECT dept_emp.dept_no, COUNT(*) AS employee_asignations
	FROM dept_emp
	GROUP BY dept_emp.dept_no
	ORDER BY employee_asignations DESC
	LIMIT 1
) depto_with_more_asignations
on depto_with_more_asignations.dept_no=departments.dept_no
