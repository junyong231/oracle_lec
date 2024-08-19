
--안티조인 NOT IN (굳이?)
SELECT employee_id, first_name, last_name, manager_id, department_id
FROM employees
WHERE department_id NOT IN ( 
                                                SELECT department_id
                                                FROM departments
                                                WHERE location_id = 1700
                                                    );
                                                    
-- 세미조인 EXISTS
SELECT *
FROM departments d
WHERE EXISTS ( SELECT * FROM employees e WHERE d.department_id = e.department_id
                                                                            AND e.salary > 2500 ) ;

-- 조건 맞음 출력하자 : 2500이상 받는 직원있는 부서; 를 출력하자




                
                              
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        
                                                                        