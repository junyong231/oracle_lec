--empno �ߺ�üũ ���ν���

CREATE OR REPLACE PROCEDURE up_idcheck
(
    pid IN NUMBER
    , pcheck OUT NUMBER --�ߺ� ������ 0/ �ƴϸ� 1
)
IS
BEGIN
    SELECT COUNT(*) INTO pcheck
    FROM emp
    WHERE empno = pid;

--EXCEPTION
END;
--Procedure UP_IDCHECK��(��) �����ϵǾ����ϴ�.

DECLARE
  vcheck NUMBER(1);
BEGIN
   UP_IDCHECK(9999, vcheck);
   DBMS_OUTPUT.PUT_LINE( vcheck );
END ;



SELECT *
FROM emp;

-- ID�� PW �Է� �޾Ƽ� ����ó���ϴ� �������ν���
CREATE OR REPLACE PROCEDURE up_login
(
  pid IN emp.empno%TYPE
  , ppwd IN emp.ename%TYPE
  , pcheck  OUT NUMBER --   0(����), 1(ID ����, pwd x), -1(ID���� X)
)
IS 
  vpwd emp.ename%TYPE;
BEGIN
   SELECT COUNT(*) INTO pcheck
   FROM emp
   WHERE empno = pid;
   
   IF pcheck = 1 THEN  -- ID ����
      SELECT ename INTO vpwd
      FROM emp
      WHERE empno = pid;
      
      IF vpwd = ppwd THEN -- ID ���� O, PWD ��ġ
         pcheck := 0;
      ELSE -- ID ���� O, PWD X
         pcheck := 1;
      END IF;
   ELSE -- ID ����
         pcheck := -1;
   END IF;
   
--EXCEPTION
--  WHEN OTHERS THEN
--    RAISE AP_E)
END;
--Procedure UP_LOGIN��(��) �����ϵǾ����ϴ�.

DECLARE 
    vcheck NUMBER;
BEGIN
    UP_LOGIN( 7369, 'SMITH', vcheck);
    DBMS_OUTPUT.PUT_LINE ( vcheck );
END;




DECLARE
  vcheck NUMBER(1);
BEGIN
   UP_IDCHECK(9999, vcheck);
   DBMS_OUTPUT.PUT_LINE( vcheck );
END ;


--dept ���̺��� ��� �μ� ������ ��ȸ�ϴ� �������ν���
CREATE OR REPLACE PROCEDURE up_selectDept
(
    pdeptcursor OUT SYS_REFCURSOR
    
)
IS 

BEGIN
    OPEN pdeptcursor FOR 
    SELECT *
    FROM dept;
       
--EXCEPTION

END;
--Procedure UP_SELECTDEPT��(��) �����ϵǾ����ϴ�.


-- �μ���ȣ �Է½� �����ع����� ���ν���
CREATE OR REPLACE PROCEDURE up_deletedept
( 
     pdeptno IN dept.deptno%TYPE
)
IS   
BEGIN
    DELETE FROM  dept 
    WHERE deptno = pdeptno;
    COMMIT;
-- EXCEPTION    
END; 
--Procedure UP_DELETEDEPT��(��) �����ϵǾ����ϴ�.
INSERT INTO dept VALUES ( 50 , ' aa' , 'cc');
Commit;

SELECT *
FROM dept;


CREATE OR REPLACE PROCEDURE up_upd
(
    pdeptno IN dept.deptno%TYPE
    ,pdname IN dept.dname%TYPE
    ,ploc IN dept.loc%TYPE
)
IS

BEGIN

    UPDATE dept
    SET dname= pdname , loc =  ploc
    WHERE deptno = pdeptno;
    
    COMMIT;
    
END;

--�߰�
CREATE OR REPLACE PROCEDURE up_cre
(
    pdeptno IN dept.deptno%TYPE
    ,pdname IN dept.dname%TYPE
    ,ploc IN dept.loc%TYPE
)
IS

BEGIN

   INSERT INTO dept VALUES ( pdeptno, pdname, ploc);
    
    COMMIT;
    
END;






