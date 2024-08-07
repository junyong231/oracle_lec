SELECT *
FROM tabs; -- hr 계정이 소유하고 있는 테이블 정보

SELECT last_name||' '||first_name  AS NAME -- JAVA였다면 + 썼겠지만 안됨
FROM employees;
-- 오라클은 문자(열), 날짜를  ' ' 안에 나타낸다

SELECT first_name fn -- 별칭 만들기 쉽다
       ,CONCAT (CONCAT (last_name, ' '), first_name) AS "우하하",
       CONCAT (CONCAT (last_name, ' '), first_name) 킥킥
FROM employees; --이렇게도 공백을 표현할 수 있다.