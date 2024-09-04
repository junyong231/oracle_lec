--empno 중복체크 프로시저

CREATE OR REPLACE PROCEDURE up_idcheck
(
    pid IN NUMBER
    , pcheck OUT NUMBER --중복 없으면 0/ 아니면 1
)
IS
BEGIN
    SELECT COUNT(*) INTO pcheck
    FROM emp
    WHERE empno = pid;

--EXCEPTION
END;
--Procedure UP_IDCHECK이(가) 컴파일되었습니다.

DECLARE
  vcheck NUMBER(1);
BEGIN
   UP_IDCHECK(9999, vcheck);
   DBMS_OUTPUT.PUT_LINE( vcheck );
END ;



SELECT *
FROM emp;

-- ID와 PW 입력 받아서 인정처리하는 저장프로시저
CREATE OR REPLACE PROCEDURE up_login
(
  pid IN emp.empno%TYPE
  , ppwd IN emp.ename%TYPE
  , pcheck  OUT NUMBER --   0(성공), 1(ID 존재, pwd x), -1(ID존재 X)
)
IS 
  vpwd emp.ename%TYPE;
BEGIN
   SELECT COUNT(*) INTO pcheck
   FROM emp
   WHERE empno = pid;
   
   IF pcheck = 1 THEN  -- ID 존재
      SELECT ename INTO vpwd
      FROM emp
      WHERE empno = pid;
      
      IF vpwd = ppwd THEN -- ID 존재 O, PWD 일치
         pcheck := 0;
      ELSE -- ID 존재 O, PWD X
         pcheck := 1;
      END IF;
   ELSE -- ID 존재
         pcheck := -1;
   END IF;
   
--EXCEPTION
--  WHEN OTHERS THEN
--    RAISE AP_E)
END;
--Procedure UP_LOGIN이(가) 컴파일되었습니다.

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


--dept 테이블의 모든 부서 정보를 조회하는 저장프로시저
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
--Procedure UP_SELECTDEPT이(가) 컴파일되었습니다.


-- 부서번호 입력시 삭제해버리는 프로시저
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
--Procedure UP_DELETEDEPT이(가) 컴파일되었습니다.
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

--추가
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






