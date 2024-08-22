-- SCOTT 
-- [���� ���ν���(STORED PROCEDURE)]
--CREATE OR REPLACE PROCEDURE ���ν�����
--(
--   �Ű�����( argument, parameter) ����, -- Ÿ���� ũ�� X
--   p�Ű�������   [mode] �ڷ���
--                IN  �Է¿� �Ķ���� (�⺻���)
--                OUT ��¿� �Ķ����
--                IN OUT ��/��¿� �Ķ����
--)
--IS  -- DECLARE
--  ���� ��� ����;
--  v
--BEGIN
--EXCEPTION
--END;

-- ���� ���ν����� �����ϴ� ���( 3����)
--1) EXECUTE ������ ����
--2) �͸� ���ν������� ȣ���ؼ� ����
--3) �� �ٸ� ���� ���ν������� ȣ���ؼ� ����.

-- ���������� ����ؼ� ���̺� ����....
CREATE TABLE tbl_emp
AS
(
   SELECT *
   FROM emp
);
-- Table TBL_EMP��(��) �����Ǿ����ϴ�.
SELECT *
FROM tbl_emp;
-- tbl_emp ���̺��� �����ȣ�� �Է¹޾Ƽ� ����� �����ϴ� ���� -> ���� ���ν���.
DELETE FROM tbl_emp
WHERE empno = 7499;
--  up_  uf_  ut_ ���ξ�... 
CREATE OR REPLACE PROCEDURE up_deltblemp
(
   --- pempno NUMBER(4);
   -- pempno NUMBER
   -- pempno IN tblemp.empno%TYPE
   pempno tbl_emp.empno%TYPE
)
IS
  -- ����, ��� ���� X
BEGIN
   DELETE FROM tbl_emp
   WHERE empno = pempno;
   COMMIT;
--EXCEPTION
   -- ROLLBACK;
END;
-- Procedure UP_DELTBLEMP��(��) �����ϵǾ����ϴ�.
--1) EXECUTE ������ ����
-- EXECUTE UP_DELTBLEMP; -- �Ű����� ��,Ÿ�� X, 
EXECUTE UP_DELTBLEMP(7566);
-- EXECUTE UP_DELTBLEMP('SMITH');
EXECUTE UP_DELTBLEMP(pempno=>7369);

SELECT * 
FROM tbl_emp;

--2) �͸� ���ν������� ȣ���ؼ� ����
--DECLARE
BEGIN
  UP_DELTBLEMP(7499);
-- EXCEPTION
END;

--3) �� �ٸ� ���� ���ν������� ȣ���ؼ� ����.
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
-- [����] dept -> tbl_dept ���̺� ����.
 CREATE TABLE tbl_dept
 AS
  (
     SELECT * 
     FROM dept 
  );  
-- Table TBL_DEPT��(��) �����Ǿ����ϴ�.
-- [����] TBL_DEPT ���������� Ȯ���� �� deptno �÷��� PK �������� ����.
SELECT *
FROM user_constraints
WHERE table_name LIKE 'TBL_D%';


















