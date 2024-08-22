-- SCOTT 
-- [저장 프로시저(STORED PROCEDURE)]
--CREATE OR REPLACE PROCEDURE 프로시저명
--(
--   매개변수( argument, parameter) 선언, -- 타입의 크기 X
--   p매개변수명   [mode] 자료형
--                IN  입력용 파라미터 (기본모드)
--                OUT 출력용 파라미터
--                IN OUT 입/출력용 파라미터
--)
--IS  -- DECLARE
--  변수 상수 선언;
--  v
--BEGIN
--EXCEPTION
--END;

-- 저장 프로시저를 실행하는 방법( 3가지)
--1) EXECUTE 문으로 실행
--2) 익명 프로시저에서 호출해서 실행
--3) 또 다른 저장 프로시저에서 호출해서 실행.

-- 서브쿼리를 사용해서 테이블 생성....
CREATE TABLE tbl_emp
AS
(
   SELECT *
   FROM emp
);
-- Table TBL_EMP이(가) 생성되었습니다.
SELECT *
FROM tbl_emp;
-- tbl_emp 테이블에서 사원번호를 입력받아서 사원을 삭제하는 쿼리 -> 저장 프로시저.
DELETE FROM tbl_emp
WHERE empno = 7499;
--  up_  uf_  ut_ 접두어... 
CREATE OR REPLACE PROCEDURE up_deltblemp
(
   --- pempno NUMBER(4);
   -- pempno NUMBER
   -- pempno IN tblemp.empno%TYPE
   pempno tbl_emp.empno%TYPE
)
IS
  -- 변수, 상수 선언 X
BEGIN
   DELETE FROM tbl_emp
   WHERE empno = pempno;
   COMMIT;
--EXCEPTION
   -- ROLLBACK;
END;
-- Procedure UP_DELTBLEMP이(가) 컴파일되었습니다.
--1) EXECUTE 문으로 실행
-- EXECUTE UP_DELTBLEMP; -- 매개변수 수,타입 X, 
EXECUTE UP_DELTBLEMP(7566);
-- EXECUTE UP_DELTBLEMP('SMITH');
EXECUTE UP_DELTBLEMP(pempno=>7369);

SELECT * 
FROM tbl_emp;

--2) 익명 프로시저에서 호출해서 실행
--DECLARE
BEGIN
  UP_DELTBLEMP(7499);
-- EXCEPTION
END;

--3) 또 다른 저장 프로시저에서 호출해서 실행.
CREATE OR REPLACE PROCEDURE up_DELTBLEMP_test
(
   pempno IN tbl_emp.empno%TYPE
)
IS
BEGIN
   UP_DELTBLEMP(pempno);
--EXCEPTION
END;
--
SELECT * 
FROM tbl_emp;
--
EXECUTE up_DELTBLEMP_test(7521);
-- CRUD == C(INSERT) R(SELECT) U(UPDATE) D(DELETE)
-- [문제] dept -> tbl_dept 테이블 생성.
 CREATE TABLE tbl_dept
 AS
  (
     SELECT * 
     FROM dept 
  );  
-- Table TBL_DEPT이(가) 생성되었습니다.
-- [문제] TBL_DEPT 제약조건을 확인한 후 deptno 컬럼에 PK 제약조건 설정.
SELECT *
FROM user_constraints
WHERE table_name LIKE 'TBL_D%';


















