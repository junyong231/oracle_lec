
--안티조인 (굳이?)
SELECT employee_id, first_name, last_name, manager_id, department_id
FROM employees
WHERE department_id NOT IN ( 
                                                SELECT department_id
                                                FROM departments
                                                WHERE location_id = 1700
                                                    );
                                                    
                                                    