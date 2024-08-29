--Ʈ�����

-- ������ü ����
-- A -> B �� ��ü�� ��
-- 1) A�� ���¿��� �ݾ� ���� �۾� (UPDATE��)
-- 2) B�� ���¿� ������ �ݾ׸�ŭ �Ա� (UPDATE��)

-- (1 , 2) �۾��� ���� ����(Ŀ��)�ϴ���, ���� ���(�ѹ�)�ؾ���. 

--DDL ����̳�, DCL ����� �� ��� ��ü�� Ʈ�������� ��ɱ��� ���Եǰ� �ִ�. (����Ŀ��)
-- Ŀ�� ���ϸ� ������Ʈ ���� ����

--SAVEPOINT
-- SAVEPOINT ��ɾ�� transaction ���� �� ������ ǥ���Ѵ�.
-- ROLLBACK TO SAVEPOINT ��ɾ�� ǥ�� �������� ROLLBACK�ϴµ� ���δ�. �� �۾��� �����ϴٰ� �ѳ��� �Ǽ��� ���Ͽ� rollback�� �Ѵٸ� �� ������ ��� �۾��� �������� ������ �߰��߰��� savepoint�� Ư�� ������ ǥ���ϴ� ���� ����.
-- savepoint Ű����� ���� �����ϴ�.
-- savepoint ��ɾ�� oracle������ ����ϴ� ��ɾ�� �ٸ� DBMS������ �������� �ʴ´�.

CREATE TABLE tbl_dept 
AS ( 
    SELECT *
    FROM dept
);

SELECT *
FROM tbl_DEPT;

--INSERT
insert into tbl_dept values(50,'development','COREA');

SAVEPOINT A;
--Savepoint��(��) �����Ǿ����ϴ�.

-- 2) UPDATE 
UPDATE tbl_dept
SET loc='ROK'
WHERE deptno = 50;

--ROLLBACK 
ROLLBACK TO A;
-- ROK���� COREA�� �ѹ��

ROLLBACK;
--�ֱ� Ŀ�Ա���..

--����A

SELECT *
FROM tbl_dept;
--B���� �����Ѱ� Ȯ�� �ȵǴ� ��

DELETE FROM tbl_dept
WHERE deptno = 40;
-- �ѹ� �ε�.. ȭ��� �տ��� ���������� ����
-- ������ Ŀ�����ڸ��� ����;;

--1 �� ��(��) �����Ǿ����ϴ�.

COMMIT;

--[��Ű��]
CREATE OR REPLACE PROCEDURE ������ü
()
IS
    ���ܰ�ü
BEGIN
     
    SELECT (A�ܰ� Ȯ��)
    UPDATE ( A���� �� ������)
    UPDATE ( B���� �Ա�)
    :
    :
    COMMIT;

EXCEPTION
    ROLLBACK;
    RAISE ���ܹ߻�(-20001, '�ܾ׺���');
END;


CREATE OR REPLACE PACKAGE employee_pkg 
AS
--�������α׷� (���� ���ν��� 2��) �� �ִ� ��Ȳ
procedure print_ename(p_empno number); 
procedure print_sal(p_empno number); 
--�Լ��� �߰�
FUNCTION uf_age
(
    pssn IN VARCHAR2
    , ptype IN NUMBER
)
RETURN NUMBER;
END employee_pkg; 
--Package EMPLOYEE_PKG��(��) �����ϵǾ����ϴ�.
-- ���� �κ�.


--��Ű�� ��ü �κ�

-- ��Ű�� ��ü �κ�
CREATE OR REPLACE PACKAGE BODY employee_pkg 
AS 
   
      procedure print_ename(p_empno number) 
      is 
         l_ename emp.ename%type; 
       begin 
         select ename 
           into l_ename 
           from emp 
           where empno = p_empno; 
       dbms_output.put_line(l_ename); 
      exception 
        when NO_DATA_FOUND then 
         dbms_output.put_line('Invalid employee number'); 
     end print_ename; 
   
   procedure print_sal(p_empno number) is 
      l_sal emp.sal%type; 
    begin 
      select sal 
       into l_sal 
        from emp 
        where empno = p_empno; 
     dbms_output.put_line(l_sal); 
    exception 
      when NO_DATA_FOUND then 
        dbms_output.put_line('Invalid employee number'); 
   end print_sal;  
   
   FUNCTION uf_age
(
   pssn IN VARCHAR2 
  ,ptype IN NUMBER --  1(���� ����)  0(������)
)
RETURN NUMBER
IS
   �� NUMBER(4);  -- ���س⵵
   �� NUMBER(4);  -- ���ϳ⵵
   �� NUMBER(1);  -- ���� ���� ����    -1 , 0 , 1
   vcounting_age NUMBER(3); -- ���� ���� 
   vamerican_age NUMBER(3); -- �� ���� 
BEGIN
   -- ������ = ���س⵵ - ���ϳ⵵    ������������X  -1 ����.
   --       =  ���³��� -1  
   -- ���³��� = ���س⵵ - ���ϳ⵵ +1 ;
   �� := TO_CHAR(SYSDATE, 'YYYY');
   �� := CASE 
          WHEN SUBSTR(pssn,8,1) IN (1,2,5,6) THEN 1900
          WHEN SUBSTR(pssn,8,1) IN (3,4,7,8) THEN 2000
          ELSE 1800
        END + SUBSTR(pssn,1,2);
   �� :=  SIGN(TO_DATE(SUBSTR(pssn,3,4), 'MMDD') - TRUNC(SYSDATE));  -- 1 (����X)

   vcounting_age := �� - �� +1 ;
   -- PLS-00204: function or pseudo-column 'DECODE' may be used inside a SQL statement only
   -- vamerican_age := vcounting_age - 1 + DECODE( ��, 1, -1, 0 );
   vamerican_age := vcounting_age - 1 + CASE ��
                                         WHEN 1 THEN -1
                                         ELSE 0
                                        END;

   IF ptype = 1 THEN
      RETURN vcounting_age;
   ELSE 
      RETURN (vamerican_age);
   END IF;
--EXCEPTION
END uf_age;
  
END employee_pkg; 


SELECT name, ssn, employee_pkg.uf_age( ssn, 1) age
from insa;








