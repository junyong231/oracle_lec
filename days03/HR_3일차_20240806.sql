SELECT first_name, last_name , first_name||' '||last_name NAME
FROM employees
WHERE REGEXP_LIKE (last_name , '^[MN]')
    AND last_name NOT LIKE('Ma%');
    
SELECT *
FROM arirang;