SELECT last_name, salary,RPAD(':',ROUND(salary/1000/1)+1, '=') "Salary" -- +1해준 이유: 공백 한칸 감안함.
FROM employees
WHERE department_id = 80
ORDER BY ROUND(salary/1000/1) DESC;

UPDATE employees
SET salary = salary * '100.00'
WHERE last_name = 'Perkins';

SELECT *
FROM employees
WHERE Last_name = 'Perkins';