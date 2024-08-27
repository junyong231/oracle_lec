-- ��������

-- Ȱ�뵵�� ����

-- �ڹ��� ���� �迭 ..? 
-- int [ ] m ; �迭 ũ�� x
-- int size = scanner.nextInt( ) ; // �迭 ũ��
-- m = new int [ size ] ;  

-- '����' ����.. ������ ����Ǵ� ������ �̰��� ����...


-- ���� ������ ����ϴ� ��� 3����..?
-- ��. ������ �ÿ� SQL(����) ������ Ȯ������ ���� ��� (���� ���� ���Ǵ� ���)
--      ��_  WHERE ������..       ������ ����
--      �ٳ��Ϳ��� ��Ʈ�� �˻��� �� ������ ���� üũ => WHERE�� ������ (ó���� Ȯ��X)
-- ��. PL/SQL �� �ȿ��� DDL ���� ����ϴ� ��� ( CREATE ALTER DROP )
--      ��_ ������ �Խ��� ����� �����ϰ� �� �� �ִ� �� (���̹� ī�� ?) 
-- ��. PL/SQL �� �ȿ��� ALTER SYSTEM , ALTER SESSION ��ɾ ����� ��


-- PL/SQL���� ���� ������ ����ϴ� ��� 2���� ?
-- 1. DBMS_SQL ��Ű�� ���
-- 2. EXECUTE IMMEDIATE �� (****)
����: EXEC IMMEDIATE ������������ 
                            [ INTO ������, ... ] -- �������� ������� ������ �Ҵ��ϴ� ���
                            [ USING IN/OUT/IN OUT ] �Ķ����, �Ķ����... ]
                            
                            
 -- �ǽ� ) �͸� ���ν���..
 
 DECLARE 
    vsql  VARCHAR2(1000);
    vdeptno emp.deptno%TYPE;
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE; 
 BEGIN
    vsql := ' SELECT deptno, empno, ename, job ';
    vsql := vsql || ' FROM emp ';
    vsql := vsql || ' WHERE empno = 7369 ';
    DBMS_OUTPUT.PUT_LINE (vsql);
    
    EXECUTE IMMEDIATE vsql
                INTO vdeptno,vempno,vename,vjob ;
    DBMS_OUTPUT.PUT_LINE ( vdeptno || ', ' || vempno || ', ' || vename || ', ' || vjob );
 --EXCEPTION
 END;



-- �ǽ����� : ���� ���ν��� (�Ķ���ͷ� �����ȣ �ޱ�)

CREATE OR REPLACE PROCEDURE up_ndsemp
(
    pempno emp.empno%TYPE
)

IS
    vsql  VARCHAR2(1000);
    vdeptno emp.deptno%TYPE;
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE; 
BEGIN
    vsql := ' SELECT deptno, empno, ename, job ';
    vsql := vsql || ' FROM emp ';
    vsql := vsql || ' WHERE empno = ' || pempno ;
    DBMS_OUTPUT.PUT_LINE (vsql);
    
    EXECUTE IMMEDIATE vsql
                INTO vdeptno,vempno,vename,vjob ;
    DBMS_OUTPUT.PUT_LINE ( vdeptno || ', ' || vempno || ', ' || vename || ', ' || vjob );
 --EXCEPTION
END;

EXEC up_ndsemp(7369);


--�Ķ���� �ִ� �ٸ� ��� USING

CREATE OR REPLACE PROCEDURE up_ndsemp
(
    pempno emp.empno%TYPE
)

IS
    vsql  VARCHAR2(1000);
    vdeptno emp.deptno%TYPE;
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE; 
BEGIN
    vsql := ' SELECT deptno, empno, ename, job ';
    vsql := vsql || ' FROM emp ';
    vsql := vsql || ' WHERE empno = :pempno ' ; -- : �̰� ���ε� (�Է¿�) �Ķ���� ��
    DBMS_OUTPUT.PUT_LINE (vsql);
    
    EXECUTE IMMEDIATE vsql
                INTO vdeptno,vempno,vename,vjob 
                USING IN pempno; -- USING
    DBMS_OUTPUT.PUT_LINE ( vdeptno || ', ' || vempno || ', ' || vename || ', ' || vjob );
 --EXCEPTION
END;

EXEC up_ndsemp(7369);


-- dept ���̺��� ���ο� �μ��� �߰��ϴ� ���� ���� ?


CREATE OR REPLACE PROCEDURE up_ndsInsDEPT
(
    pdname dept.dname%TYPE := NULL
    , ploc dept.loc%TYPE := NULL
)

IS
    vsql  VARCHAR2(1000);
    vdeptno emp.deptno%TYPE;

BEGIN
    
    SELECT NVL( MAX(deptno) , 0 ) + 10 INTO vdeptno FROM dept;


    vsql := ' INSERT INTO dept ( deptno, dname, loc ) ';
    vsql := vsql || '  VALUES ( :vdeptno, :pdname, :ploc ) ';
    

    EXECUTE IMMEDIATE vsql
                USING IN vdeptno,pdname, ploc; 
    COMMIT;
    DBMS_OUTPUT.PUT_LINE ('����');
 --EXCEPTION
END;

EXEC up_ndsInsDEPT ( 'QC' , 'COREA' );


SELECT *
FROM dept;


--���� SQL - DDL�� ��� (���̺� ����)
-- ���̺��, �÷��� �Է� �޾Ƽ� ?


 DECLARE 
    vsql  VARCHAR2(1000);
    vtablename VARCHAR2(20);
    
 BEGIN
 
    vtablename := 'tbl_test';
 
    vsql := ' CREATE TABLE ' || vtablename ;
    vsql := vsql || ' ( ';
    vsql := vsql || ' id NUMBER PRIMARY KEY ';
    vsql := vsql || ' , name VARCHAR2(20)  ';
    vsql := vsql || ' ) ';
    DBMS_OUTPUT.PUT_LINE (vsql);
    
    EXECUTE IMMEDIATE vsql;

    
 --EXCEPTION
 END;

SELECT * FROM user_tables
WHERE table_name LIKE 'TBL_T%';

-- OPEN- FOR�� : ���� ���� ���� : �������� ���ڵ� (Ŀ�� ó��..)
-- �μ� ��ȣ�� �Ķ���ͷ� �޾Ƽ� 20�� 3�� , 

CREATE OR REPLACE PROCEDURE up_ndsInsDEPT
(
    pdeptno dept.deptno%TYPE
)

IS
    vsql  VARCHAR2(1000);
    vcur SYS_REFCURSOR; --Ŀ���� �ڷ������� ������ �� 
    vrow emp%ROWTYPE; -- Ŀ�� �޾ƿ�

BEGIN

    vsql := ' SELECT * ';
    vsql := vsql || '  FROM emp ';
    vsql := vsql || ' WHERE deptno = :pdeptno ' ;
    DBMS_OUTPUT.PUT_LINE (vsql);

--    EXECUTE IMMEDIATE vsql
--                USING IN vdeptno,pdname, ploc; 

-- OPEN FOR�� (Ŀ�� ����)
    OPEN vcur FOR vsql USING pdeptno; -- Ŀ�� ���� , �������� p�Ķ���� �޾Ƽ� ����
    
    LOOP
    
        FETCH vcur INTO vrow;
        EXIT WHEN vcur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( vrow.empno || ', ' || vrow.ename );
        
    END LOOP;
    
    CLOSE vcur;

 --EXCEPTION
END;

EXEC up_ndsInsDEPT ( 10 );





-- emp ���̺��� �˻� ��� ����
-- 1) �˻�����    : 1 �μ���ȣ, 2 �����, 3 ��
-- 2) �˻���      :
CREATE OR REPLACE PROCEDURE up_ndsSearchEmp
(
  psearchCondition NUMBER -- 1. �μ���ȣ, 2.�����, 3. ��
  , psearchWord VARCHAR2
)
IS
  vsql  VARCHAR2(2000);
  vcur  SYS_REFCURSOR;   -- Ŀ�� Ÿ������ ���� ����  9i  REF CURSOR
  vrow emp%ROWTYPE;
BEGIN
  vsql := 'SELECT * ';
  vsql := vsql || ' FROM emp ';
  
  IF psearchCondition = 1 THEN -- �μ���ȣ�� �˻�
    vsql := vsql || ' WHERE  deptno = :psearchWord ';
  ELSIF psearchCondition = 2 THEN -- �����
    vsql := vsql || ' WHERE  REGEXP_LIKE( ename , :psearchWord )';
  ELSIF psearchCondition = 3  THEN -- job
    vsql := vsql || ' WHERE  REGEXP_LIKE( job , :psearchWord , ''i'')';
  END IF; 
   
  OPEN vcur  FOR vsql USING psearchWord;
  LOOP  
    FETCH vcur INTO vrow;
    EXIT WHEN vcur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE( vrow.empno || ' '  || vrow.ename || ' ' || vrow.job );
  END LOOP;   
  CLOSE vcur; 
EXCEPTION
  WHEN NO_DATA_FOUND THEN
      RAISE_APPLICATION_ERROR(-20001, '>EMP DATA NOT FOUND...');
  WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20004, '>OTHER ERROR...');
END;



EXEC UP_NDSSEARCHEMP(1, '20'); 
EXEC UP_NDSSEARCHEMP(2, 'L'); 
EXEC UP_NDSSEARCHEMP(3, 's'); 
