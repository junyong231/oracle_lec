--저장 프로시저 (STORED PROCEDURE)

--구문 형식
CREATE OR REPLACE PROCEDURE 프로시저명
(
    매개변수 선언
    -- ( , ) 구분 ; 아님  + 타입의 크기는 설정 X
    , p매개변수명 (mode) 자료형
    -- IN 입력용 파라미터 / OUT  출력용 파라미터 / IN OUT 입,출력용 파라미터      기본: IN
    ,
    ,
    p~~
)
IS (DECLARE 자리)  -- 여기다가 변수 / 상수 선언
    v~~
BEGIN
EXCEPTION
END;

DROP PROCEDURE 프로시저명 ; (삭제)

-- 저장 프로시저 실행방법 (3가지)

-- 1) EXECUTE 문에 의한 실행
-- 2) 익명 프로시저에서 호출해서 실행
-- 3) 또 다른 저장 프로시저에서 호출해서 실행.


-- 서브쿼리를 사용해서 테이블 생성...

CREATE TABLE tbl_emp
AS (
    SELECT *
    FROM emp
    );

SELECT *
FROM tbl_emp;


-- tbl_emp에서 사원번호를 입력받아서 사원을 삭제하는 쿼리 -> 저장 프로시저 
DELETE FROM tbl_emp
WHERE empno = 7499; 
-- 데이터가 많으면 이런 쿼리 날리면 오래걸림 => 저장 프로시저 쓰자
-- 수업에선 유저 프로시저라는 뜻으로 up_를 붙임. 

-- 써보기
CREATE OR REPLACE PROCEDURE up_deltblemp
(
    -- pempno NUMBER(4) --한 줄이어도 ( ; ) 안씀 + 크기 지정도 안함
    pempno IN tbl_emp.empno%TYPE -- 이러면 자료형에 대해서 신경 쓸 것이 줄어듬  , 파라미터 용도는 기본이 IN
    
)
IS
    -- 변수, 상수 선언 X 라서 비워둠
BEGIN
    DELETE FROM tbl_emp
    WHERE empno = pempno;  
    
    COMMIT;
    
--EXCEPTION
    --ROLLBACK;
END;
-- Procedure UP_DELTBLEMP이(가) 컴파일되었습니다.
-- SCOTT 프로시저에 등록되어 있음
-- 이제 써보자
-- 1) EXECUTE 문에 의한 실행

EXECUTE up_deltblemp; --PLS-00306: wrong number or types of arguments in call to 'UP_DELTBLEMP'  매개변수 잘쓰라는 오류 뜸
EXECUTE up_deltblemp('KING'); -- 매개변수 안맞게 줘도 실행안됨 오류뜸

EXECUTE up_deltblemp(7566); --PL/SQL 프로시저가 성공적으로 완료되었습니다. JONES뒤졌다
EXECUTE up_deltblemp(pempno=>7369); --PL/SQL 프로시저가 성공적으로 완료되었습니다. SMITH 찎

SELECT *
FROM tbl_emp; --확인. 존스, 스미스 없음

-- 2) 익명 프로시저에서 호출해서 실행

DECLARE
BEGIN
    up_deltblemp(7499); --알렌 삭제
    --PL/SQL 프로시저가 성공적으로 완료되었습니다.
--EXCEPTION
END;


-- 3) 또 다른 저장 프로시저에서 호출해서 실행.

CREATE OR REPLACE PROCEDURE up_deltblemp_test
(
    pempno tbl_emp.empno%TYPE
)
IS
BEGIN
    up_deltblemp(7521); -- ward 
--EXCEPTION
END;
--Procedure UP_DELTBLEMP_TEST이(가) 컴파일되었습니다.

EXECUTE up_deltblemp_test(7521);
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 문제) dept 이용해서 tbl_dept테이블 생성

CREATE TABLE tbl_dept
AS (
    SELECT *
    FROM dept
);

-- 문제) tbl_dept 테이블 제약조건을 확인 후 deptno 컬럼에 PK 제약조건 설정.

DESC tbl_dept;

SELECT *
FROM user_constraints
WHERE table_name LIKE 'TBL_D%';

ALTER TABLE tbl_dept ADD CONSTRAINT PK_tbl_dept PRIMARY KEY(deptno);

--문제) tbl_dept 테이블 SELECT 문 ... DBMS OUTPUT으로 출력하는 저장 프로시저 생성하고 프로시저명은 up_seltbldept로 하라

-- 명시적 커서

CREATE OR REPLACE PROCEDURE up_seltbldept
IS 
    CURSOR vdcursor IS (
                                    SELECT deptno, dname, loc FROM tbl_dept 
                                    ); -- 1) 명시적 선언
    vdrow tbl_dept%ROWTYPE;
BEGIN
--2) 오픈 - 데이터 받기 시작 (실행)
OPEN vdcursor;

--3) FETCH
LOOP
    FETCH vdcursor INTO vdrow; -- vdcursor에서 받아와서 vdrow에 넣기
    EXIT WHEN vdcursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE( vdcursor%ROWCOUNT || ' : ' );
    DBMS_OUTPUT.PUT_LINE(  vdrow.deptno || ', ' || vdrow.dname 
      || ', ' ||  vdrow.loc );

END LOOP;


-- 4) 닫기
CLOSE vdcursor;

--EXCEPTION
END;

--실행
EXEC up_seltbldept;


-- 암시적 커서 (FOR문)
CREATE OR REPLACE PROCEDURE up_seltbldept

IS 
--vdrow tbl_dept%ROWTYPE;

BEGIN
    FOR vdrow IN (SELECT deptno, dname,loc FROM tbl_dept ) 
    LOOP
    --DBMS_OUTPUT.PUT_LINE(' ')
    DBMS_OUTPUT.PUT_LINE( vdrow.deptno || ', ' || vdrow.dname 
      || ', ' ||  vdrow.loc );
    END LOOP;
    
    COMMIT;
--EXCEPTION
END;

EXEC up_seltbldept;


-- 새로운 부서를 추가하는 저장 프로시저 ? (이름은 up_instbldept)
-- 현 10, 20, 30, 40 있으니 다음은 50, 60... 이렇게 가야함 => 시퀀스 ( 50 시작 , 증가치 10 )

SELECT *
FROM  user_sequences;
-- 시퀀스 만들자 seq_tbldept
CREATE SEQUENCE seq_tbldept
INCREMENT BY 10 START WITH 50 NOCACHE  NOORDER  NOCYCLE ;
--Sequence SEQ_TBLDEPT이(가) 생성되었습니다.

DESC tbl_dept;
-- 확인해보니 부서명, 지역은 NULL 괜찮음

CREATE OR REPLACE PROCEDURE up_instbldept
(
    pdname IN tbl_dept.dname%TYPE DEFAULT NULL,
    ploc IN tbl_dept.loc%TYPE := NULL
)
IS -- 여기 deptno의 최댓값 받을 변수 선언하고 계속 +10하면서 써도 됨 지금은 시퀀스로 함..
BEGIN
    INSERT INTO tbl_dept (deptno,dname,loc)
    VALUES ( seq_tbldept.NEXTVAL , pdname, ploc );
    
    COMMIT;
--EXCEPTION
    --ROLLBACK;
END;

EXEC up_instbldept;

SELECT * FROM tbl_dept;

EXEC up_instbldept('QC', 'SEOUL'); -- 위에 설정한 정석적인 삽입형태임 가능

-- EXEC up_instbldept(pdname=>'QC', 'SEOUL'); 하나만 주고 싶거나 뭔가 바뀌었을 때에도 확실하게 줄 수 있는 방법
EXEC up_instbldept(pdname=>'RECRUIT');

-- [문제] 부서번호를 입력받아서 삭제하는 up_deltbldept 저장 프로시저 ?

CREATE OR REPLACE PROCEDURE up_deltbldept
(
    pdno tbl_dept.deptno%TYPE
)
IS

BEGIN

DELETE
FROM tbl_dept
WHERE deptno = pdno;

COMMIT;

--EXCEPTION
END;

EXEC up_deltbldept(50);
EXEC up_deltbldept(80);-- 예외발생 ! (없는 부서 삭제) 인데 안해서 걍 성공뜸


SELECT *
FROM tbl_dept;


-- 문제) 매개변수로 (60, 'x' , 'y') 부서정보 수정되게
--EXEC up_updtbldept( 60, 'X', 'Y' );  -- dname, loc
--EXEC up_updtbldept( pdeptno=>60,  pdname=>'QC3' );  -- loc
--EXEC up_updtbldept( pdeptno=>60,  ploc=>'SEOUL' );  -- 

CREATE OR REPLACE PROCEDURE up_updtbldept
(
    pdno tbl_dept.deptno%TYPE
    ,pdname tbl_dept.dname%TYPE --DEFAULT tbl_dept.dname
    ,pdloc tbl_dept.loc%TYPE --DEFAULT tbl_dept.loc
)
IS
    original_dname tbl_dept.dname%TYPE;
    original_loc tbl_dept.loc%TYPE;
BEGIN

SELECT dname, loc INTO (original_dname, original_loc)
FROM tbl_dept
WHERE deptno = pdno;

   IF  pdname != original_dname
    THEN 
        original_dname := pdname;
    ELSE
        original_dname := original_dname;
    END IF;   

    IF  pdloc != original_loc
    THEN 
        original_loc := pdloc;
    ELSE
        original_loc := original_loc;
    END IF;


UPDATE tbl_dept
SET dname = original_dname
     ,loc =original_loc
WHERE deptno = pdno ;
--풀다가 관둠

--EXCEPTION
END;

EXEC up_updtbldept( 60, 'X', 'Y' ); 
EXEC up_updtbldept( pdeptno=>60,  pdname=>'QC3' );

SELECT *
FROM tbl_dept;

-- 썜풀이 1) -- 틀은 같으나 입력안하면 NULL인걸 생각안함 ㅠ
CREATE OR REPLACE PROCEDURE up_updtbldept
(
    pdno tbl_dept.deptno%TYPE --PK (WHERE에 넣을거임) 라서 널이면 안됨 필수항목이랄까
    ,pdname tbl_dept.dname%TYPE := NULL
    ,pdloc tbl_dept.loc%TYPE := NULL
)
IS 
    vdname tbl_dept.dname%TYPE ;
    vloc tbl_dept.loc%TYPE;
BEGIN

SELECT dname, loc INTO vdname, vloc
FROM tbl_dept
WHERE deptno = pdno;

IF pdname IS NULL AND ploc IS NULL THEN -- 아무것도 안바꾸는 경우
ELSIF pdname IS NULL THEN -- 네임만 바꾼 경우
    UPDATE tbl_dept
    SET loc = ploc
    WHERE deptno = pdno;
ELSE --둘다 바꿈
    UPDATE tbl_dept
    SET loc = ploc, dname = pdname
    WHERE deptno = pdno;
END IF

--EXCEPTION
END;

-- 2)

CREATE OR REPLACE PROCEDURE up_updtbldept
(
    pdno tbl_dept.deptno%TYPE
    ,pdname tbl_dept.dname%TYPE := NULL
    ,pdloc tbl_dept.loc%TYPE := NULL
)
IS 
    vdname tbl_dept.dname%TYPE ;
    vloc tbl_dept.loc%TYPE;
BEGIN

UPDATE tbl_dept
SET dname = NVL(pdname, dname)
    , loc = CASE WHEN pdloc IS NULL THEN loc 
                ELSE pdloc
                END
WHERE deptno = pdno;            

COMMIT ;

--EXCEPTION
END;

EXEC up_updtbldept( pdno=>60,  pdname=>'QC3' );

SELECT *
FROM tbl_dept;

EXEC up_deltbldept(60);
-- 시퀀스 tbldept도 삭제하자
DROP SEQUENCE seq_tbldept;


-- 문제) 명시적 커서를 사용해서 모든 부서원들 조회
-- 부서번호를 파라미터로 받아서 해당 부서원들만 

CREATE OR REPLACE PROCEDURE up_seltblemp
(
    pdno tbl_emp.deptno%TYPE -- :=NULL 이면 선언부(IS) 에서 WHERE 조건 NVL해야됨]
    -- 그것보단 얜 PK..
)
IS
      CURSOR vecursor IS (
        SELECT  * --deptno, empno, ename, sal, comm, job, hiredate, mgr --이거 별로 바꾸니까 되네;
        FROM tbl_emp
        WHERE deptno = pdno
        );
    verow tbl_emp%ROWTYPE;
BEGIN
    
    OPEN vecursor;
    
    LOOP 
        FETCH vecursor INTO verow;
        EXIT WHEN vecursor%NOTFOUND;
        
         DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.empno 
    || ', ' ||  verow.ename  || ', ' || verow.sal  ||
    ', ' ||  verow.comm || ', ' || verow.job || ', ' || verow.hiredate|| ', ' || verow.mgr);
    
    END LOOP;
    
    CLOSE vecursor;
    

END;

EXEC up_seltblemp (20);



-- 커서에 파라미터 ( 개인적으로 별로인듯 pdno , cpdno 두 개 해야되네)
CREATE OR REPLACE PROCEDURE up_seltblemp
(
    pdno tbl_emp.deptno%TYPE -- :=NULL 이면 선언부(IS) 에서 WHERE 조건 NVL해야됨
)
IS
      CURSOR vecursor(cpdno tbl_emp.deptno%TYPE) IS (  -- 커서 앞에 새로 파라미터 '선언'
        SELECT  * --deptno, empno, ename, sal, comm, job, hiredate, mgr
        FROM tbl_emp
        WHERE deptno = cpdno
        );
    verow tbl_emp%ROWTYPE;
BEGIN
    
    OPEN vecursor(pdno);
    
    LOOP 
        FETCH vecursor INTO verow;
        EXIT WHEN vecursor%NOTFOUND;
        
         DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.empno 
    || ', ' ||  verow.ename  || ', ' || verow.sal  ||
    ', ' ||  verow.comm || ', ' || verow.job || ', ' || verow.hiredate|| ', ' || verow.mgr);
    
    END LOOP;
    
    CLOSE vecursor;
    

END;




-- 암시적 커서 (for) 확실히 얘가 제일 좋은듯..
CREATE OR REPLACE PROCEDURE up_seltblemp
(
    pdno tbl_emp.deptno%TYPE
)
IS
BEGIN
    FOR verow IN (SELECT  * 
                  FROM tbl_emp
                  WHERE deptno = pdno ) LOOP
                  
                   DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.empno 
                                                          || ', ' ||  verow.ename  || ', ' || verow.sal  || ', ' ||  
                                                          verow.comm || ', ' || verow.job || ', ' || verow.hiredate|| ', ' || verow.mgr);
                  
                END LOOP;

END;



--저장 프로시저
-- 파라미터 IN 입력 .. OUT 출력 

--사원번호(IN) => 사원이름, 주민번호 (OUT) 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE up_selinsa
(
    pnum IN insa.num%TYPE
    , pname OUT insa.name%TYPE
    , pssn OUT insa.ssn%TYPE
)
IS
    vname insa.name%TYPE;
    vssn insa.ssn%TYPE;
BEGIN
    SELECT name, ssn INTO vname, vssn
    FROM insa
    WHERE num = pnum;

    pname := vname;
    pssn := CONCAT( SUBSTR(vssn, 0, 8 ) , '******');
    

--EXCEPTION
END;

--익명 프로시저에서 호출해서 실행 

-- VARIABLE vname  전역변수마냥 세션 전체에서 사용하는 변수가 되버림
DECLARE -- 여기서만 쓸거니까 안에서 쓰자
    vname insa.name%TYPE;
    vssn insa.ssn%TYPE;
BEGIN
  up_selinsa ( 1001 ,vname, vssn); --받는 변수명도 씀
  DBMS_OUTPUT.PUT_LINE( vname || ', ' || vssn); -- 받는 변수명에 담아놨으니 출력ㄱ
--EXCEPTION
END;


-- IN/OUT 입출력용 파라미터 예시 ?! ( IN , OUT 같은 변수 사용)
-- 주민등록번호 ssn  14자리를 파라미터 IN
-- 생년월일의 해당되는 주민번호 6자리를 파라미터 OUT


CREATE OR REPLACE PROCEDURE up_ssn
(
    pssn IN OUT VARCHAR2
)
IS
BEGIN
    pssn := SUBSTR(pssn, 0, 6);
    
--EXCEPTION
END;

DECLARE
    vssn VARCHAR2(14) := '111113-1111115' ;
BEGIN
    up_ssn(vssn);
    DBMS_OUTPUT.PUT_LINE( vssn ); -- IN OUT
END;

-- 저장함수 ,STORED FUNCTION 
-- 주민등록번호 => 성별 체크
--  리턴 자료형              리턴값 '남자' '여자'
--      VARCHAR2

CREATE OR REPLACE FUNCTION uf_gender
(
    pssn insa.ssn%TYPE
)
RETURN VARCHAR2

IS
    vgender VARCHAR2(6);
BEGIN
    IF MOD(SUBSTR(pssn, 8 , 1),2) =1 THEN vgender := '남자';
    ELSE vgender := '여자';
    END IF;

RETURN (vgender);

--EXCEPTION
END;
--Function UF_GENDER이(가) 컴파일되었습니다.

SELECT num,name, ssn, UF_GENDER(ssn) gender, uf_age(ssn,0) age
FROM insa;


-- uf_age 만들어서 ssn 넣으면 나이 계산해주는 함수 >?!

CREATE OR REPLACE FUNCTION uf_age
(
    pssn insa.ssn%TYPE
)
RETURN NUMBER

IS

    vsgi NUMBER;
    vbirth NUMBER;
    vage NUMBER;
    
BEGIN

IF SUBSTR(pssn,-7,1) IN (1,2,5,6) THEN vbirth := 1900+ SUBSTR(pssn,0,2);
ELSIF  SUBSTR(pssn,-7,1) IN (3,4,7,8) THEN vbirth:= 2000+ SUBSTR(pssn,0,2);
ELSE vbirth := 1800+ SUBSTR(pssn,0,2);
END IF;

IF  SIGN( TO_DATE(SUBSTR(pssn,3,4),'mmdd') - TRUNC( sysdate) ) = 0
    OR SIGN( TO_DATE(SUBSTR(pssn,3,4),'mmdd') - TRUNC( sysdate) ) = -1
    THEN vage :=  TO_CHAR(sysdate , 'yyyy') - vbirth -1;
    ELSE vage := TO_CHAR(sysdate , 'yyyy') - vbirth;
END IF;


    RETURN (vage);
        
END;

-- 쌤풀이

CREATE OR REPLACE FUNCTION uf_age
(
   pssn IN VARCHAR2
   , ptype IN NUMBER -- 만나이 0, 세는 나이 1
)
RETURN NUMBER
IS
    ㄱ NUMBER(4);  -- 올해년도
    ㄴ NUMBER(4) ;  -- 생일년도
    ㄷ NUMBER(1);  -- 생일지남 여부      -1   0    1
    vcounting_age NUMBER(3); -- 세는 나이
    vamerican_age NUMBER(3); -- 만 나이
BEGIN
  -- 만나이 = 올해년도 - 생일년도      생일지났여부X -1
  --       =    세는나이 -1          생일지났여부X -1 
  -- 세는나이 = 올해년도 - 생일년도 + 1
  ㄱ := TO_CHAR(SYSDATE,'YYYY');
  ㄴ := CASE 
           WHEN SUBSTR(pssn, -7,1) IN (1,2,5,6) THEN 1900
           WHEN SUBSTR(pssn, -7,1) IN (3,4,7,8) THEN 2000
           ELSE 1800
        END + SUBSTR(pssn,0,2);
  ㄷ := SIGN( TO_DATE(SUBSTR(pssn,3,4), 'MMDD') - TRUNC(SYSDATE) ); --   -1 X     
  vcounting_age := ㄱ - ㄴ + 1;
  vamerican_age := vcounting_age -1 + CASE ㄷ
                                         WHEN 1 THEN -1
                                         ELSE 0
                                      END;
  IF ptype = 1 THEN 
     RETURN vcounting_age;
  ELSE
     RETURN vamerican_age;
  END IF; 
--EXCEPTION
END;


-- 예) 주민등록번호-> 1998.01.20(화) 형식의 문자열로 반환하는 저장함수 작성.테스트-- 
--예) 주민등록번호-> 1998.01.20(화) 형식의 문자열로 반환하는 저장함수 작성.테스트
-- uf_birth



CREATE OR REPLACE FUNCTION uf_birth
(
    pssn insa.ssn%TYPE
)
RETURN VARCHAR2
IS

    vbdate DATE;

BEGIN

    vbdate := TO_DATE ( SUBSTR(pssn,0,6) );
    
    RETURN  TO_CHAR( vbdate, 'yyyy.mm.dd (dy)' ) ;

END;

SELECT name, uf_birth(ssn)
FROM insa;

-- 쌤풀이

CREATE OR REPLACE FUNCTION uf_birth
(
    pssn insa.ssn%TYPE
)
RETURN VARCHAR2
IS
    
    vcentury NUMBER(2);
    vbdate DATE;

BEGIN

    vbdate := TO_DATE ( SUBSTR(pssn,0,6) );
    vcentury := CASE 
           WHEN SUBSTR(pssn, -7,1) IN (1,2,5,6) THEN 19
           WHEN SUBSTR(pssn, -7,1) IN (3,4,7,8) THEN 20
           ELSE 18
           END ;
    
    vbdate := vcentury || vbdate;
    
           
    RETURN  TO_CHAR( TO_DATE( vbdate )  , 'yyyy.mm.dd (dy)') ;

END;


--문제

CREATE TABLE tbl_score
(
     num   NUMBER(4) PRIMARY KEY
   , name  VARCHAR2(20)
   , kor   NUMBER(3)  
   , eng   NUMBER(3)
   , mat   NUMBER(3)  
   , tot   NUMBER(3)
   , avg   NUMBER(5,2)
   , rank  NUMBER(4) 
   , grade CHAR(1 CHAR)
);

SELECT *
FROM tbl_score;

CREATE SEQUENCE seq_tblscore; -- 1부터 1씩 증가하는 시퀀스

SELECT *
FROM user_sequences;

-- 문제 1) 학생을 추가하는 저장 프로시저 추가 ?

--EXEC up_insertscore(1001, '홍길동', 89,44,55 );
--EXEC up_insertscore(1002, '윤재민', 49,55,95 );
--EXEC up_insertscore(1003, '김도균', 90,94,95 );
-- 학번은 시퀀스로..

CREATE OR REPLACE PROCEDURE up_insertscore
(
    pname tbl_score.name%TYPE
    ,pkor tbl_score.kor%TYPE
    ,peng tbl_score.kor%TYPE
    ,pmat tbl_score.kor%TYPE
    
)
IS
    vtot NUMBER(3) := 0;
    vavg NUMBER(5,2) ;
    vgrade tbl_score.grade%TYPE;
BEGIN
    
    vtot := pkor + peng + pmat;
    vavg := vtot / 3 ;
    
    IF vavg >= 90 THEN vgrade := 'A';
    ELSIF vavg >= 80 THEN vgrade := 'B';
    ELSIF vavg >= 70 THEN vgrade := 'C';
    ELSIF vavg >= 60 THEN vgrade := 'D';
    ELSE vgrade := 'F';
    END IF;
    
    INSERT INTO tbl_score (num, name, kor, eng, mat, tot, avg, grade, rank)
    VALUES (seq_tblscore.NEXTVAL, pname, pkor, peng, pmat, vtot, vavg, vgrade, 1);
    
    -- 등수 줄거면 이 자리에서 업데이트문 넣으면 됨
     up_rankScore; -- 저장 프로시저 안에 저장 프로시저 넣기 가능
    
    COMMIT;
    

--EXCEPTION
END;

EXEC up_insertscore( '홍길동', 89,44,55 );
EXEC up_insertscore( '윤재민', 49,55,95 );
EXEC up_insertscore( '김도균', 90,94,95 );
EXEC up_insertscore( '이몽룡', 100,10,90 );


-- 문제2) up_updateScore( 1, 100, 100, 100 ) ; 업데이트하는 저장프로시저 up_updateScore

--EXEC up_updateScore( 1, 100, 100, 100 );
--EXEC up_updateScore( 1, pkor =>34 );
--EXEC up_updateScore( 1, pkor =>34, pmat => 90 );
--EXEC up_updateScore( 1, peng =>45, pmat => 90 );


CREATE OR REPLACE PROCEDURE up_updateScore
(
    pnum tbl_score.num%TYPE
    ,pkor tbl_score.kor%TYPE := NULL
    ,peng tbl_score.eng%TYPE := NULL
    ,pmat tbl_score.mat%TYPE := NULL
)
IS
    vkor tbl_score.kor%TYPE;
    veng tbl_score.eng%TYPE;
    vmat tbl_score.mat%TYPE;
    
    vtot NUMBER(3) := 0;
    vavg NUMBER(5,2) ;
    vgrade tbl_score.grade%TYPE;

BEGIN
    SELECT kor, eng, mat INTO vkor,veng,vmat
    FROM tbl_score
    WHERE num = pnum;

    vtot := NVL(pkor, vkor) + NVL(peng, veng) + NVL(pmat, vmat);
    vavg := vtot / 3 ;
    
    IF vavg >= 90 THEN vgrade := 'A';
    ELSIF vavg >= 80 THEN vgrade := 'B';
    ELSIF vavg >= 70 THEN vgrade := 'C';
    ELSIF vavg >= 60 THEN vgrade := 'D';
    ELSE vgrade := 'F';
    END IF;
    
    
UPDATE tbl_score
SET kor = NVL(pkor, vkor)
    , eng = NVL(peng, veng)
    , mat = NVL(pmat, vmat)
    , tot =   vtot --NVL(pkor,kor) + NVL(peng,eng) + NVL(pmat,mat)
    , avg = vavg
    , grade = vgrade
    , rank = 1
WHERE num = pnum;

up_rankScore;
COMMIT;

END;

EXEC up_updateScore( 1, peng =>45, pmat => 90 ); -- 이거 파라미터라서 peng여야됨 eng가 아니라..!
EXEC up_updateScore( 1, 100 , 100 );

SELECT *
FROM tbl_score;



ROLLBACK;


-- 문제) tbl_score 테이블의 모든 학생의 등수를 매기는 프로시저 ?!
-- up_rankScore

CREATE OR REPLACE up_rankScore

IS
    vavg NUMBER(5,2) ;
    
BEGIN
    SELECT avg INTO vavg
    FROM tbl_score;
    
    FOR num IN 1 .. MAX(num)
    LOOP
        IF 
    
    END LOOP;
    
    


END;




CREATE OR REPLACE PROCEDURE up_rankScore
IS
BEGIN
    UPDATE tbl_score p
    SET rank = ( SELECT COUNT(*)+1 FROM tbl_score c WHERE p.tot < c.tot  );
    COMMIT;
--EXCEPTION
END;

EXEC up_rankScore;


-- up_deleteScore  학생 1명 학번 갖고 삭제

CREATE OR REPLACE PROCEDURE up_deleteScore
(
    pnum tbl_score.num%TYPE
)
IS
BEGIN
    
    DELETE
    FROM tbl_score
    WHERE num = pnum;
    up_rankScore;
    
    COMMIT;
END;

EXEC up_deleteScore(4);
SELECT *
FROM tbl_score;


-- up_selectScore 모든학생 정보 조회 (커서)

CREATE OR REPLACE PROCEDURE up_selectScore
IS
BEGIN

FOR vsrow IN (SELECT * FROM tbl_score)
LOOP
    DBMS_OUTPUT.PUT_LINE ( vsrow.num ||', ' || vsrow.name|| ', ' || vsrow.kor ||', ' || vsrow.eng ||', ' || vsrow.mat ||', ' || vsrow.avg ||', ' || vsrow.rank ||', ' || vsrow.grade );
    
END LOOP;

END;

EXEC up_selectScore;



-- 명시적 .. 
CREATE OR REPLACE PROCEDURE up_selectScore
IS
    CURSOR vs_cur IS (SELECT * FROM tbl_score);

    vsrow tbl_score%ROWTYPE;

BEGIN
OPEN vs_cur;


LOOP
FETCH vs_cur INTO vsrow  ;
    EXIT WHEN vs_cur%NOTFOUND; -- 패치다음 이게 와야함
    DBMS_OUTPUT.PUT_LINE ( vsrow.num ||', ' || vsrow.name|| ', ' || vsrow.kor ||', ' || vsrow.eng ||', ' || vsrow.mat ||', ' || vsrow.avg ||', ' || vsrow.rank ||', ' || vsrow.grade );

END LOOP;

CLOSE vs_cur;

END;

EXEC up_selectScore;



CREATE OR REPLACE PROCEDURE up_selectScore
IS
  --1) 커서 선언
  CURSOR vcursor IS (SELECT * FROM tbl_score);
  vrow tbl_score%ROWTYPE;
BEGIN
  --2) OPEN  커서 실제 실행..
  OPEN vcursor;
  --3) FETCH  커서 INTO 
  LOOP  
    FETCH vcursor INTO vrow;
    EXIT WHEN vcursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(  
           vrow.num || ', ' || vrow.name || ', ' || vrow.kor
           || vrow.eng || ', ' || vrow.mat || ', ' || vrow.tot
           || vrow.avg || ', ' || vrow.grade || ', ' || vrow.rank
        );
  END LOOP;
  --4) CLOSE
  CLOSE vcursor;
--EXCEPTION
  -- ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE up_selectinsa
(
    --커서를 파라미터로 ?
    pinsacursor SYS_REFCURSOR --오라클 9i 이전엔 REF CURSORS
    
)
IS
    vname insa.name%TYPE;
    vbasicpay insa.basicpay%TYPE;
    vcity insa.city%TYPE;
    
BEGIN
--오픈 필요없다
LOOP
    FETCH pinsacursor INTO vname, vcity, vbasicpay ;
    EXIT WHEN pinsacursor%NOTFOUND ;
    DBMS_OUTPUT.PUT_LINE(vname || ', ' || vcity || ', ' || vbasicpay);
END LOOP;

CLOSE pinsacursor;
--EXCEPTION
END;

CREATE OR REPLACE PROCEDURE up_insacursor_test
IS
    vinsacursor SYS_REFCURSOR;

BEGIN
    OPEN vinsacursor FOR SELECT name,city,basicpay FROM insa;
    up_selectinsa( vinsacursor );
END;

EXEC up_insacursor_test;

-- [ 트리거 ] --

CREATE TABLE tbl_exam1
(
   id NUMBER PRIMARY KEY
   , name VARCHAR2(20)
);

CREATE TABLE tbl_exam2
(
   memo VARCHAR2(100)
   , ilja DATE DEFAULT SYSDATE
);

-- TBL_exam1 테이블에 insert, update, delete 이벤트ㅏㄱ 발생하면
-- 자동으로 tbl_exam2 테이블에 1에서 어떤 작업이 일어났는지 로그로 기록하는 트리거.
create or replace trigger ut_log
AFTER -- 로그니까 한 다음 남김 = 애프터
insert OR delete OR UPDATE ON tbl_exam1 --트리거가 테이블1에 정의되었기 때문에 :OLD.name 이런식으로 소환가능
for each row -- 매 한줄한줄마다 --이게 있어야 :OLD, :NEW 사용 가능

--DECLARE
    -- 뱐수선언
BEGIN 
    IF INSERTING THEN
         INSERT INTO tbl_exam2 (memo) VALUES (:new.name || '인서트') ;   -- 실행구문 
    ELSIF DELETING THEN
         INSERT INTO tbl_exam2 (memo) VALUES (:OLD.name || '삭제') ;
         ELSIF UPDATING THEN
         INSERT INTO tbl_exam2 (memo) VALUES (:OLD.name || '->' || :NEW.NAME || '수정') ;
    END IF;
    
    
END;
--
UPDATE tbl_exam1
SET NAME = 'admin'
where id = 1;
--
select * FROM tbl_exam1;
select * FROM tbl_exam2;
insert into tbl_exam1 VALUES (1, 'hong');
insert into tbl_exam1 VALUES (2, 'kong');
--
delete from tbl_exam1
where id = 1;
rollback;
--
commit;

-- 아래는 실행 ㄴㄴ
create or replace trigger ut_deletelog
AFTER
delete ON tbl_exam1
for each row 

BEGIN
    INSERT INTO tbl_exam2 (memo) VALUES (:OLD.name || '삭제.. 하나도모르겠는데') ;   -- 실행구문
END;

delete from tbl_exam1
where id = 1;

------- tbl_exam1 대상 테이블로 DML문이 근무시간(9-17시) 외 또는 주말에는 처리 안되게 트리거 걸자.
CREATE OR REPLACE TRIGGER UT_LOG_BEFORE
BEFORE
INSERT OR UPDATE OR DELETE ON tbl_exam1
--FOR EACH ROW
--DECLARE
    
BEGIN
    IF TO_CHAR(SYSDATE,'DY') IN ('토','일')
    OR TO_CHAR(SYSDATE,'HH24') < 9 
    OR TO_CHAR(SYSDATE,'HH24') > 16 THEN
    RAISE_APPLICATION_ERROR(-20001, '근무시간이 아님. DML 못해 집 가시오');       -- 강제로 예외를 발생
    END IF;
END;

INSERT INTO TBL_EXAM1 VALUES (2, 'PARK');
--
DROP TABLE TBL_DEPT;
DROP TABLE TBL_EMP;
DROP TABLE TBL_EXAM1;
DROP TABLE TBL_EXAM2;
DROP TABLE TBL_SCORE;
--
