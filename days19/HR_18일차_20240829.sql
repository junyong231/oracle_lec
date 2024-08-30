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
    -- 1) 커서 선언
    -- CURSOR 커서명 IS (SELECT문) 
    CURSOR vdecursor IS (
        SELECT d.deptno, dname, empno, ename, sal + NVL(comm,0) pay
        FROM dept d JOIN emp e ON d.deptno = e.deptno
    );

BEGIN
    -- 2) 커서 오픈 SELECT문 실행 -- 컨트롤 F11
    OPEN vdecursor;
    
    -- 3) FETCH = 가져오다
    LOOP 
        FETCH vdecursor INTO vedrow;
        EXIT WHEN vdecursor%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname 
    || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  ||
    ', ' ||  vedrow.pay );
    END LOOP;

    --4) 커서 close
    CLOSE vdecursor;
    
 END;   