s--[문제] emp. dept 테이블에서 사원 존재하지 않는 부서번호 부서명


-- 완) 그룹바이에 dname 넣어서 뽑을 수 있게 만듬
WITH d AS (
        SELECT DISTINCT deptno, dname
        FROM dept
)
SELECT e.*
FROM(
SELECT d.dname, d.deptno , COUNT(empno) em
FROM emp e PARTITION BY (deptno) RIGHT OUTER JOIN d ON e.deptno =d.deptno 
GROUP BY d.deptno, d.dname
ORDER BY d.deptno
) e
WHERE e.em=0 ;


--차집합 이용

SELECT deptno
FROM dept
MINUS
SELECT DISTINCT deptno
FROM emp;


SELECT t.deptno, d.dname
FROM (
    SELECT deptno
    FROM dept
    MINUS
    SELECT DISTINCT deptno
    FROM emp
    ) t JOIN dept d ON t.deptno = d.deptno;

--  상관서브쿼리 
SELECT m.deptno, m.dname
FROM dept m
WHERE ( SELECT COUNT(*) FROM emp WHERE deptno = m.deptno) =0;



--(문제) 인사테이블에서 각부서별 여자인원수 파악해서 5명 이상인 부서 정보 출력 ?

SELECT buseo
         --   ,CASE WHEN SUBSTR(ssn,8,1) =2 THEN '여자' END 여자
            ,COUNT(SUBSTR(ssn,8,1) ) 수
            
FROM insa
WHERE SUBSTR(ssn,8,1) =2
GROUP BY buseo, SUBSTR(ssn,8,1)
HAVING COUNT(SUBSTR(ssn,8,1) ) > 5;

-- [문제] insa 테이블
--     [총사원수]      [남자사원수]      [여자사원수] [남사원들의 총급여합]  [여사원들의 총급여합] [남자-max(급여)] [여자-max(급여)]
------------ ---------- ---------- ---------- ---------- ---------- ----------
--        60                31              29           51961200                41430400                  2650000          2550000


SELECT   -- COUNT(*)
            (SELECT COUNT(*) FROM insa WHERE SUBSTR(ssn,8,1) IN (1,2) ) 총사원수
            , (SELECT COUNT(*) FROM insa WHERE SUBSTR(ssn,8,1)=1 )  남자사원수
            , (SELECT COUNT(*) FROM insa WHERE SUBSTR(ssn,8,1)=2 )  여자사원수
            , (SELECT SUM(basicpay+sudang) FROM insa WHERE   SUBSTR(ssn,8,1)=1) 남자총급여
             , (SELECT SUM(basicpay+sudang) FROM insa WHERE   SUBSTR(ssn,8,1)=2) 여자총급여
             ,(SELECT MAX(basicpay+sudang) FROM insa WHERE   SUBSTR(ssn,8,1)=1) 남자맥스
             ,(SELECT MAX(basicpay+sudang) FROM insa WHERE   SUBSTR(ssn,8,1)=2) 여자맥스
FROM insa 
GROUP BY  SUBSTR(ssn,8,1);

-- 그냥 COUNT( DECODE (MOD.....) 이렇게 하나씩해야 한줄나옴


SELECT 
        DECODE( MOD(SUBSTR(ssn,8,1),2) 1, '남자', 0 , '여자' , '전체') || '사원수'
          ,COUNT(*)
          ,SUM(basicpay)
          ,MIN(basicpay)
          ,MAX(basicpay)
FROM insa
GROUP BY MOD(SUBSTR(ssn,8,1),2);


-- [문제] emp 테이블에서~
--      각 부서의 사원수, 부서 총급여합, 부서 평균급여
결과)
    DEPTNO       부서원수       총급여합            평균
---------- ----------       ----------    ----------
        10          3          8750       2916.67
        20          3          6775       2258.33
        30          6         11600       1933.33 
        40          0         0             0
        
        
SELECT d.deptno, COUNT(e.empno) 부서원수 , NVL(SUM(e.sal),0) 총급여 , NVL ( ROUND ( AVG(e.sal) , 2), 0) 평균
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno
GROUP BY d.deptno;
        

-- ROLLUP /CUBE 정리
--GROUP BY에서 사용 (그룹별 합(소계)을 추가로 보여준다)

--롤업 없이 소계 내기
SELECT 
            CASE MOD( SUBSTR(ssn,8,1) , 2 )
            WHEN 1 THEN '남자'
            ELSE '여자' END 성별
            , COUNT(*) 사원수
FROM insa
GROUP BY MOD(SUBSTR(ssn,8,1) , 2 )
UNION
SELECT '전체' , COUNT(*)
FROM insa;

--롤업 사용
SELECT 
            CASE MOD( SUBSTR(ssn,8,1) , 2 )
            WHEN 1 THEN '남자'
            WHEN 0 THEN '여자' 
            ELSE '전체' END 성별
            , COUNT(*) 사원수
FROM insa
GROUP BY ROLLUP ( MOD(SUBSTR(ssn,8,1) , 2 ) );

--큐브 사용
SELECT 
            CASE MOD( SUBSTR(ssn,8,1) , 2 )
            WHEN 1 THEN '남자'
            WHEN 0 THEN '여자' 
            ELSE '전체' END 성별
            , COUNT(*) 사원수
FROM insa
GROUP BY CUBE ( MOD(SUBSTR(ssn,8,1) , 2 ) );

--롤업과 큐브 차이점
--1차적으로 부서별 그룹 나누고, 이후 직위별로 나눔

SELECT buseo,jikwi,COUNT(*) 사원수
FROM insa i
GROUP BY buseo, ROLLUP ( jikwi ) 
ORDER BY buseo;

-- 유니온
SELECT buseo,jikwi,COUNT(*) 사원수
FROM insa i
GROUP BY CUBE (buseo, jikwi)
UNION ALL
SELECT buseo,NULL , COUNT(*) 사원수
FROM insa
GROUP BY buseo
UNION ALL
SELECT null, jikwi, COUNT(*) 사원수
FROM insa
GROUP BY jikwi;
--ORDER BY jikwi ;

--분할 ROLLUP

SELECT buseo, jikwi, COUNT(*) 사원수
FROM insa 
GROUP BY buseo  , ROLLUP ( jikwi )
-- 직위에만 롤업: 부서에 대한 집계 이런식임
ORDER BY buseo, jikwi;

-- GROUPING SET 함수?
SELECT buseo, '', COUNT(*)
FROM insa
GROUP BY buseo;

SELECT '', buseo, COUNT(*)
FROM insa
GROUP BY buseo
UNION
SELECT '', jikwi, COUNT(*)
FROM insa
GROUP BY jikwi;

SELECT buseo, jikwi, COUNT(*)
FROM insa
GROUP BY GROUPING SETS ( buseo, jikwi ) --그룹핑한 집계 '만' 보고 싶을때 
ORDER BY buseo, jikwi;


--피벗 문제
-- 1. 테이블 설계 잘못된 상황에서 쿼리 이상하다고 질문했던 상황
-- DDL문으로 테이블 만들자

CREATE TABLE tbl_pivot
(
    no NUMBER PRIMARY KEY 
     ,name VARCHAR(20) NOT NULL 
    ,jumsu NUMBER(3) 
 );
SELECT *
FROM  tbl_pivot;

INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 1, '박예린', 90 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 2, '박예린', 89 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 3, '박예린', 99 );  -- mat
 
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 4, '안시은', 56 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 5, '안시은', 45 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 6, '안시은', 12 );  -- mat 
 
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 7, '김민', 99 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 8, '김민', 85 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 9, '김민', 100 );  -- mat 

COMMIT; 

SELECT *
FROM  tbl_pivot;

--질문   이름 국 영 수
            ㅇㅇ 10 20 30 이렇게 나오게??
SELECT *
FROM(            
    SELECT TRUNC( (no-1) /3 +1 ) no ,name, jumsu, DECODE( MOD(no,3) ,1,'국어',2,'영어',0,'수학') subject
    FROM tbl_pivot
) 
PIVOT ( SUM(jumsu) FOR subject IN ('국어', '영어', '수학'  ) )
ORDER BY no ASC;


--실행결과
YEAR      MONTH          N
---- ---------- ----------
1980          1          0
1980          2          0
1980          3          0
1980          4          0
1980          5          0
1980          6          0
1980          7          0
1980          8          0
1980          9          0
1980         10          0
1980         11          0

YEAR      MONTH          N
---- ---------- ----------
1980         12          1
1981          1          0
1981          2          2
1981          3          0
1981          4          1
1981          5          1
1981          6          1
1981          7          0
1981          8          0
1981          9          2
1981         10          0

YEAR      MONTH          N
---- ---------- ----------
1981         11          1
1981         12          2
1982          1          1
1982          2          0
1982          3          0
1982          4          0
1982          5          0
1982          6          0
1982          7          0
1982          8          0
1982          9          0

YEAR      MONTH          N
---- ---------- ----------
1982         10          0
1982         11          0
1982         12          0

-- 연도별로 입사한 사원수 출력 (emp) + 월별도 추가해서?
1980 3
1981 6
1982 3 이런 식으로

 
SELECT TO_CHAR(hiredate, 'yyyy') hy
            ,COUNT(*)
FROM emp e PARTITION BY
GROUP BY TO_CHAR(hiredate, 'yyyy')
ORDER BY hy;

SELECT LEVEL --순번 또는 단계를 나타내는 번호
FROM dual
CONNECT BY LEVEL <= 12;
-- ORA-01788: CONNECT BY clause required in this query block : 커넥트 바이 절 필요

SELECT empno, TO_CHAR(hiredate, 'yyyy') hy
        ,TO_CHAR(hiredate, 'mm') hm
FROM emp;
--


--
SELECT year, m.month, NVL(COUNT(empno), 0) n
FROM  (
      SELECT empno, TO_CHAR( hiredate, 'YYYY') year
            , TO_CHAR( hiredate, 'MM' ) month
      FROM emp
     ) e
     PARTITION BY ( e.year ) RIGHT OUTER JOIN 
    (
       SELECT LEVEL month   
       FROM dual
       CONNECT BY LEVEL <= 12
     ) m 
     ON e.month = m.month
     GROUP BY year, m.month
     ORDER BY year, m.month;


-- insa에서 부서별 직위별 사원수

SELECT buseo, jikwi, COUNT(*)
FROM insa
GROUP BY buseo,jikwi
ORDER BY buseo,jikwi;
--각 부서별 직위별 최소 사원 수, 최대 사원수
개발부 부장 1 사원 9 이런식으러


SELECT buseo
        ,(SELECT jikwi,COUNT(jikwi) FROM insa WHERE buseo = '개발부' GROUP BY jikwi)
FROM insa i
GROUP BY buseo
ORDER BY buseo;




-- 2가지를 알면 쉽다
-- 1) 분석함수  FIRST, LAST
--                    집계함수와 같이 사용하여
--                    주어진 그룹에 대해 내부적으로 순위를 매겨 결과를 산출하는 함수

SELECT MAX(sal) 
            ,MAX(ename) KEEP(DENSE_RANK FIRST ORDER BY sal DESC) max_ename 
            ,MIN(sal)
            ,MAX(ename) KEEP(DENSE_RANK LAST ORDER BY sal DESC) max_ename 
FROM emp;

WITH a AS 
(
    SELECT d.deptno, dname, COUNT(empno) cnt
    FROM emp e RIGHT OUTER JOIN dept d ON d.deptno = e.deptno
    GROUP BY d.deptno, dname
)
SELECT MIN(cnt), MIN(dname) KEEP (DENSE_RANK LAST ORDER BY cnt DESC) min_dname
            ,MAX(cnt), MAX(dname) KEEP (DENSE_RANK FIRST ORDER BY cnt DESC) max_dname
            
FROM a;

-- 2)  SELF JOIN 

SELECT a.empno, a.ename, a.mgr , b.ename 상사이름 --  여기 직속상사의 이름 찍으려면?
FROM emp a JOIN emp b ON a.mgr = b.empno; --셀프조인



--NON <EQUAL JOIN>  (관련된 컬럼 없음)
SELECT empno, ename, sal, grade --grade 찍어야되는데 조인조건이 없음 (관련된 컬럼 없음)
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;


-- NON <EQUAL JOIN>  안쓰면
SELECT ename, sal 
   ,  CASE
        WHEN  sal BETWEEN 700 AND 1200 THEN  1
        WHEN  sal BETWEEN 1201 AND 1400 THEN  2
        WHEN  sal BETWEEN 1401 AND 2000 THEN  3
        WHEN  sal BETWEEN 2001 AND 3000 THEN  4
        WHEN  sal BETWEEN 3001 AND 9999 THEN  5
      END grade
FROM emp;



--각 부서별 직위별 최소 사원 수, 최대 사원수 

개발부 부장 1 사원 9 이런식으러
WITH t1 AS (
    SELECT buseo, jikwi, COUNT(num) tot_count
    FROM insa
    GROUP BY buseo, jikwi
)
  , t2 AS (
     SELECT buseo, MIN(tot_count) buseo_min_count
                 , MAX(tot_count) buseo_max_count
     FROM t1
     GROUP BY buseo
  )
SELECT a.buseo, b.jikwi 직위, b.tot_count 최소사원수
FROM t2 a , t1 b
WHERE a.buseo = b.buseo AND a.buseo_min_count= b. tot_count;


-- FIRST/LAST 분석함수 사용해서 풀이....
WITH t AS (
    SELECT buseo, jikwi, COUNT(num) tot_count
    FROM insa
    GROUP BY buseo, jikwi
)
SELECT t.buseo
            ,MIN(t.jikwi) KEEP (DENSE_RANK LAST ORDER BY t.tot_count ASC)  최소직위
            ,MAX(t.tot_count) 최대사원수
            ,MIN(t.jikwi) KEEP (DENSE_RANK FIRST ORDER BY t.tot_count ASC)  최대직위
            ,MIN(t.tot_count) 최소사원수
FROM t
GROUP BY t.buseo
ORDER BY t.buseo;



--(문제) emp 에서 가장 입사일자가 빠른 사원과 느린 사원 입사 차이 일 수

SELECT MAX(hiredate)-MIN(hiredate)
FROM emp;

-- CUME_DIST() 

--PERCENT_RANK() 

-- NTILE() 엔타일 함수
-- ㄴ파티션 별로 expr에 명시된만큼 분할한 결과를 반환하는 함수
--  분할하는 수를 버킷이라고 함

SELECT deptno, ename, sal
        ,NTILE(4) OVER (ORDER BY sal ASC) ntiles
FROM emp;

SELECT deptno, ename, sal
        ,NTILE(2) OVER (PARTITION BY deptno ORDER BY sal ASC) ntiles --버킷 2개 (2분할) 파티션:부서별로  : 부서별로 나누고 2분할 (홀수조는 1:2가 됨)
FROM emp;

--widthbuckets
-- WIDTH_BUCKET(expr,minvalue,maxvalue
SELECT deptno, ename, sal
        ,NTILE(4) OVER (ORDER BY sal ASC) ntiles
        ,WIDTH_BUCKET( sal, 1000, 4000, 4) widthbuckets -- 1000부터 4000 사이 4계층으로 나눈다는 뜻 (한 토막 : 750)
FROM emp;


-- LAG( expr, offset, default_value)
-- ㄴ주어진 그룹과 순서에 따라 다른 행에 있는 값을 참조할 때 사용하는 함수
--          차이점: 선행 행
-- LEAD( expr, offset, default_value)
-- ㄴ주어진 그룹과 순서에 따라 다른 행에 있는 값을 참조할 때 사용하는 함수
--          차이점: 후행 행

SELECT deptno, ename, hiredate, sal
        ,LAG(sal, 1 , 0) OVER (ORDER BY hiredate ) pre_sal -- 이전 행의 값을 줌. 없으면 기본값 0
        ,LEAD(sal, 1 , -1) OVER (ORDER BY hiredate ) next_sal  -- 다음 행의 값을 줌. 없으면 기본값 -1
        ,LAG(sal, 3 , 100) OVER (ORDER BY hiredate ) pre_sal -- 3칸 전의 값
FROM emp
WHERE deptno =30;


------------------------------------------------------------------------------------------------------------------
-- [오라클의 자료형 (Data Type) ]

 1) CHAR[ SIZE(BYTE)단위 ] 문자열 자료형
    
    CHAR = CHAR( 1 BYTE ) = CHAR( 1 ) -- 같은 표현
    CHAR( 3 BYTE ) = CHAR(3) -- 알파벳이면 3글자, 한글이라면 1글자 저장 가능
    CHAR( 3 CHAR)  -- 문자 3개 저장 가능 'abc' 든 '가나다'든 세글자 저장 가능 
    고정 길이의 문자열 자료형
    
    name CHAR ( 10 BYTE ) 
    --맥시멈 2000 바이트까지 크기 할당할 수 있다
    --고정길이 주기**
    예) 주민등록번호 (14), 전화번호ㅡ우편번호,학번 등등
    
    
    --테이블 만들어서 테스트
    
    CREATE TABLE tbl_char
    (
        aa char --   char(1) == char(1 byte)
        , bb char(3) 
        , cc char(3 char) 
    );
    
    SELECT *
    FROM tbl_char;

    INSERT INTO tbl_char(aa,bb,cc) VALUES( 'a' , 'aaa', 'aaa'); -- 이상없음
    INSERT INTO tbl_char(aa,bb,cc) VALUES( 'b' , '한', '한우리');-- 이상없음
    INSERT INTO tbl_char(aa,bb,cc) VALUES( 'b' , '한우리', '한우리'); -- 가운데 한우리가 들어가려면 3*3 = 9바이트 필요

    2) NCHAR 
    N == UNICODE 유니코드
    NCHAR[ ( SIZE ) ]
    NCHAR(1) == NCHAR --아무것도 안준 것과 같다
    NCHAR(10) -- 알파벳이든 한글이든 10글자 ㅇㅋ
    --고정길이 문자열 자료형
    최대 2000 BYTE
    
       
    CREATE TABLE tbl_nchar
    (
        aa char(3) 
        , bb char(3 char) 
        , cc nchar(3) 
    );
    SELECT *
    FROM tbl_nchar;
    
    INSERT INTO tbl_nchar (aa, bb, cc) VALUES ('홍', '홍길', '홍길동'); --이상없음
    INSERT INTO tbl_nchar (aa, bb, cc) VALUES ('홍길동', '홍길동', '홍길동'); --aa에 걸려서 오류 (한글은 3바이트가 한글자)
    
    COMMIT;
    
    
    3) VARCHAR2  가변 길이 문자열 자료형 (VARCHAR와 같은 의미 .. 2는 별칭) 
    VAR: 가변 길이 
    최대 4000 BYTE 
    VARCHAR2 (SIZE BYTE | CHAR)
    VARCHAR2 (1) = VARCHAR2 (1 BYTE) = VARCHAR2
    name VARCHAR2 (10)    에다가 'admin'이라는 5바이트 집어넣으면 남은 5바이트 메모리에서 제거됨
    
    4) NVARCHAR2   (유니코드 가변 길이 문자열 자료형)
    NVARCHAR2 (10) 
    뒤에 따로 BYTE 붙는 형식은 없음 , 그냥 문자열 길이만 설정
    최대 4000 BYTE 
     
    5) NUMBER[ (p [,s] ) ]
    p: precision 정확도 => 전체 자릿수 ( 1 ~ 38 자리 )
    s: scale 규모 => 0을 제외한 ..    소숫점 이하 자릿수 ( -84 ~ 127자리)
    
    NUMBER = NUMBER( 38,127) 
    NUMBER(p) = NUMBER(p,0) : 소수점 0자리
    
    예)
    CREATE TABLE tbl_number
    (
     no NUMBER(2,0) PRIMARY KEY -- 프라이머리 키 -> NN + UN 자동 부여
     , name VARCHAR2( 30 ) NOT NULL 
     , kor NUMBER(3)
     , eng NUMBER(3)
     , mat NUMBER(3) DEFAULT 0
   
    );
    
    SELECT *
    FROM tbl_NUMBER;
    
    COMMIT;
    
    INSERT INTO tbl_NUMBER (no,name,kor,eng,mat) VALUES (1, '홍길동', 90, 80,90);
    --INSERT INTO tbl_NUMBER (no,name,kor,eng,mat) VALUES (2, '일지매', 100, 100); --00947. 00000 -  "not enough values" 5개인데 4개줌 (디폴트라며)
    INSERT INTO tbl_NUMBER (no,name,kor,eng) VALUES (2, '일지매', 100, 100); -- 컬럼에서도 지워줘야됨
    INSERT INTO tbl_NUMBER VALUES (3, '임꺽정', 50, 50, 100); --not enough values mat도 그냥 값을 줘야됨
    INSERT INTO tbl_NUMBER (name,no,kor,eng,mat) VALUES ('대길이', 4, 40, 50,10); --순서 맞춰주면 됨
    INSERT INTO tbl_NUMBER (no,name,kor,eng,mat) VALUES (4, '성춘향', 110, -909, 60.23); --unique constraint (SCOTT.SYS_C007033) violated 유일성 제약조건 위배: no가 유니크였음
    INSERT INTO tbl_NUMBER (no,name,kor,eng,mat) VALUES (5, '성춘향', 110, -909, 56.934); -- 들어가짐 , 56.934는 반올림되서 57됨
    -- 테이블 만들 때 설정한 조건이 결국 -999~999였음 더 조건 좁혀야됨 => 체크드 필요
    ROLLBACK;
 
6) FLOAT [ ( p ) ]  == 내부적으로 NUMBER 처럼 처리됨 ( precision만 있는 NUMBER와 같다)

7) LONG     가변길이(VAR) '문자열' 자료형, 2GB

8) DATE 날짜, 시간   (초까지)
    TIMESTAMP [ ( n ) ]  n안주면 n=6이랑 같음 (초 밑 자릿수 설정.. n=6일 때 , 00:00:00.000000 이렇게 됨)
    

9) RAW( SIZE )  -최대 2000바이트 , 이진데이터 저장
    LONG RAW - 2GB                    이진데이터 저장
: 사진같은거 이진데이터로 저장하는가? ㄴㄴ 사진 파일의 주소를 저장함

10) LOB = 라지 오브젝트
    CLOB = CHAR 라지 오브젝트
    NCLOB =NCHAR 라지..
    BLOB, BFILE...


----------------------------------------------------------------------------------------------------------------------

--FIRST_VALUE 분석함수 : 정렬된 값 중에 첫번째 값 나타냄


SELECT FIRST_VALUE(basicpay) OVER(ORDER BY basicpay DESC)
FROM insa;

SELECT FIRST_VALUE(basicpay) OVER(PARTITION BY buseo ORDER BY basicpay DESC)
FROM insa;

--insa 에서 가장 많은 basicpay , 각 사원의 basicpay의 차이?
SELECT buseo, name, basicpay
            , FIRST_VALUE(basicpay) OVER(ORDER BY basicpay DESC) maxbp
            ,  FIRST_VALUE(basicpay) OVER(ORDER BY basicpay DESC) -basicpay "최고급여자와의 차이"
FROM insa;

--COUNT + OVER : 질의한 행에 누적된 결과 반환

SELECT name, basicpay
    ,COUNT(*) OVER (ORDER BY basicpay ASC)
FROM insa;

SELECT buseo, name, basicpay
    ,COUNT(*) OVER (PARTITION BY buseo ORDER BY basicpay ASC)
FROM insa;

SELECT buseo, name, basicpay
    ,SUM(basicpay) OVER (ORDER BY buseo ASC)
FROM insa; --부서별 급여합..

SELECT buseo, name, basicpay
    ,SUM(basicpay) OVER (PARTITION BY buseo ORDER BY buseo ASC)
FROM insa; --부서별 급여합..



-- AVG + OVER : 질의한 행에 누적된 평균 반환
SELECT buseo, name, basicpay
    ,AVG(basicpay) OVER (ORDER BY buseo ASC)
FROM insa; --부서별 급여 평균?

SELECT buseo, AVG(basicpay)
FROM insa
GROUP BY buseo
ORDER BY buseo;


----------------------------------------------------------------------
--테이블 생성,수정,삭제

-- 테이블 : 데이터 저장소

-- 아이디   문자 10
-- 이름      문자 20
-- 나이       숫자 30
-- 전화번호 문자 20
-- 생일       날짜 
-- 비고       문자 255

CREATE TABLE tbl_sample
(
    id VARCHAR2( 10 )
    ,name VARCHAR2 (20)
    ,age NUMBER(3)
    ,birth DATE
-- 비고랑 전번 안만듬
);

SELECT *
FROM tbl_sample;

SELECT *
FROM tabs
--WHERE table_name LIKE 'TBL\_%' ESCAPE '\' ;
WHERE REGEXP_LIKE ( table_name , '^TBL_', 'i');

DESC tbl_sample;
-- 전화번호, 비고 컬럼 추가 ? => 테이블 수정
-- ALTER
-- 한번의 ADD로 여러개 컬럼 추가 가능...

ALTER TABLE tbl_sample
ADD ( 
        tel VARCHAR2(20) -- DEFAULT '000-0000-0000' 이렇게 줄수도 있음
        ,bigo VARCHAR2(255)
    ) ;

SELECT *
FROM tbl_sample;

DESC tbl_sample;

--비고 컬럼의 크기(혹은 자료형)를 수정하고 싶다 ? MODIFY => 디폴트 타입 사이즈 변경 가능
-- 255 => 100
-- 사이즈는 데이터가 없거나 NULL값만 존재하면 size 줄일 수 있따
-- 자료형을 변경 :  CHAR <=> VARCHAR 상호 변경만 가능.. 값이 없으면 문자-숫자-날짜 다 가능
-- 컬럼명은 그냥 별칭으로 해결

ALTER TABLE tbl_sample
MODIFY (

bigo  VARCHAR2(100) 

);

-- bigo 컬럼명 etc , memo로 바꾸고 싶다 ? 

ALTER TABLE tbl_sample RENAME COLUMN bigo TO memo;

--memo라는 컬럼을 테이블에서 제거해보자 

ALTER TABLE tbl_sample DROP COLUMN memo;

-- 테이블명을 수정하고 싶다면?
-- tbl_sample => tbl_example

RENAME tbl_sample TO tbl_example;
DESC tbl_example;









