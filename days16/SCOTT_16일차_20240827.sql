-- 동적쿼리

-- 활용도가 높다

-- 자바의 동적 배열 ..? 
-- int [ ] m ; 배열 크기 x
-- int size = scanner.nextInt( ) ; // 배열 크기
-- m = new int [ size ] ;  

-- '동적' 쿼리.. 쿼리가 실행되는 시점에 미결정 상태...


-- 동적 쿼리를 사용하는 경우 3가지..?
-- ㄱ. 컴파일 시에 SQL(쿼리) 문장이 확정되지 않은 경우 (가장 많이 사용되는 경우)
--      예_  WHERE 조건절..       미정인 상태
--      다나와에서 노트북 검색할 때 유저가 조건 체크 => WHERE로 들어가야함 (처음에 확정X)
-- ㄴ. PL/SQL 블럭 안에서 DDL 문을 사용하는 경우 ( CREATE ALTER DROP )
--      예_ 유저가 게시판 만들고 수정하고 할 수 있는 곳 (네이버 카페 ?) 
-- ㄷ. PL/SQL 블럭 안에서 ALTER SYSTEM , ALTER SESSION 명령어를 사용할 때


-- PL/SQL에서 동적 쿼리를 사용하는 방법 2가지 ?
-- 1. DBMS_SQL 패키지 사용
-- 2. EXECUTE IMMEDIATE 문 (****)
형식: EXEC IMMEDIATE 동적쿼리문장 
                            [ INTO 변수명, ... ] -- 동적쿼리 결과값을 변수에 할당하는 경우
                            [ USING IN/OUT/IN OUT ] 파라미터, 파라미터... ]
                            
                            
 -- 실습 ) 익명 프로시저..
 
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



-- 실습예제 : 저장 프로시저 (파라미터로 사원번호 받기)

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


--파라미터 주는 다른 방법 USING

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
    vsql := vsql || ' WHERE empno = :pempno ' ; -- : 이거 바인딩 (입력용) 파라미터 됨
    DBMS_OUTPUT.PUT_LINE (vsql);
    
    EXECUTE IMMEDIATE vsql
                INTO vdeptno,vempno,vename,vjob 
                USING IN pempno; -- USING
    DBMS_OUTPUT.PUT_LINE ( vdeptno || ', ' || vempno || ', ' || vename || ', ' || vjob );
 --EXCEPTION
END;

EXEC up_ndsemp(7369);


-- dept 테이블의 새로운 부서를 추가하는 동적 쿼리 ?


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
    DBMS_OUTPUT.PUT_LINE ('성공');
 --EXCEPTION
END;

EXEC up_ndsInsDEPT ( 'QC' , 'COREA' );


SELECT *
FROM dept;


--동적 SQL - DDL문 사용 (테이블 생성)
-- 테이블명, 컬럼명 입력 받아서 ?


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

-- OPEN- FOR문 : 동적 쿼리 실행 : 여러개의 레코드 (커서 처리..)
-- 부서 번호를 파라미터로 받아서 20번 3명 , 

CREATE OR REPLACE PROCEDURE up_ndsInsDEPT
(
    pdeptno dept.deptno%TYPE
)

IS
    vsql  VARCHAR2(1000);
    vcur SYS_REFCURSOR; --커서를 자료형으로 선언할 때 
    vrow emp%ROWTYPE; -- 커서 받아올

BEGIN

    vsql := ' SELECT * ';
    vsql := vsql || '  FROM emp ';
    vsql := vsql || ' WHERE deptno = :pdeptno ' ;
    DBMS_OUTPUT.PUT_LINE (vsql);

--    EXECUTE IMMEDIATE vsql
--                USING IN vdeptno,pdname, ploc; 

-- OPEN FOR문 (커서 때문)
    OPEN vcur FOR vsql USING pdeptno; -- 커서 열고 , 동적쿼리 p파라미터 받아서 실행
    
    LOOP
    
        FETCH vcur INTO vrow;
        EXIT WHEN vcur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( vrow.empno || ', ' || vrow.ename );
        
    END LOOP;
    
    CLOSE vcur;

 --EXCEPTION
END;

EXEC up_ndsInsDEPT ( 10 );





-- emp 테이블에서 검색 기능 구현
-- 1) 검색조건    : 1 부서번호, 2 사원명, 3 잡
-- 2) 검색어      :
CREATE OR REPLACE PROCEDURE up_ndsSearchEmp
(
  psearchCondition NUMBER -- 1. 부서번호, 2.사원명, 3. 잡
  , psearchWord VARCHAR2
)
IS
  vsql  VARCHAR2(2000);
  vcur  SYS_REFCURSOR;   -- 커서 타입으로 변수 선언  9i  REF CURSOR
  vrow emp%ROWTYPE;
BEGIN
  vsql := 'SELECT * ';
  vsql := vsql || ' FROM emp ';
  
  IF psearchCondition = 1 THEN -- 부서번호로 검색
    vsql := vsql || ' WHERE  deptno = :psearchWord ';
  ELSIF psearchCondition = 2 THEN -- 사원명
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
