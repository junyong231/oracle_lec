 DECLARE
    TYPE EmpDeptType IS RECORD
    (
       deptno dept.deptno%TYPE,
       dname dept.dname%TYPE,
       empno emp.empno%TYPE,
       ename emp.ename%TYPE,
       pay NUMBER
    );
    vedrow EmpDeptType;
    -- 1) Ŀ�� ����
    -- CURSOR Ŀ���� IS (SELECT��) 
    CURSOR vdecursor IS (
        SELECT d.deptno, dname, empno, ename, sal + NVL(comm,0) pay
        FROM dept d JOIN emp e ON d.deptno = e.deptno
    );

BEGIN
    -- 2) Ŀ�� ���� SELECT�� ���� -- ��Ʈ�� F11
    OPEN vdecursor;
    
    -- 3) FETCH = ��������
    LOOP 
        FETCH vdecursor INTO vedrow;
        EXIT WHEN vdecursor%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname 
    || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  ||
    ', ' ||  vedrow.pay );
    END LOOP;

    --4) Ŀ�� close
    CLOSE vdecursor;
    
 END;   