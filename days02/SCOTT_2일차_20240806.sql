-- SCOTT
-- SCOTT이 소유한 테이블 목록 조회
SELECT *
FROM tabs;
-- == FROM user_tables;
-- FROM all_tables; 
-- FROM dba_tables; 차이점 알기

--insa 테이블 구조 파악

DESC insa;

--insa 모든 정보 조회?
SELECT *
FROM emp;
--IBSADATE 의 표기 98/10/11 => RR/MM/DD 의 표기형식임
-- YY와 RR의 차이??

--도구 - 환경설정 - DB -NLS 와 같은 것이 출력됨
SELECT *
FROM v$nls_parameters;

--emp테이블에서 사원 정보 조회 (사원 정보, 사원명, 입사일자) 조회
-- SELECT 와 FROM 제외 생략 가능
--WITH 
--SELECT 
--FROM 
--WHERE 
--GROUP BY 
--HAVING 
--ORDER BY ;

--월급 = 기본급sal + 수당comm 으로 출력해보자
SELECT empno,ename,hiredate
--       , NVL(comm, 0) --NULL이면 comm그대로, 아니면 0으로 출력
--       , NVL2(comm ,comm, 0) --위와 같다 살짝 삼항연산자같네
--       , sal , comm
--       ,sal+comm AS 월급 --주석으로 빼기 쉽게 개행해서 쓰면 좋다
        ,sal + NVL(comm, 0) pay --별칭도 대문자로 자동변환됨
       
FROM emp;

-- 오라클에서 NULL ?
-- 미확인값

--문제 ? emp 테이블에서 사원번호, 사원명, 직속상사(mgr) 조회
SELECT empno, ename, mgr
        ,NVL(TO_CHAR(mgr), 'CEO') string
        ,NVL (mgr || '', 'CEO') --합쳐서 문자열로 만들고 바꿔버리기 ㄷㄷ
FROM emp;

SELECT '이름은 ''' || ename || '''이고, 직업은 ' || job || '이다.'
FROM emp;

--emp 테이블에서 부서번호가 10번인 사원들만 조회 ?
-- 1) dept(부서) 테이블 정보부터 뽑자
SELECT *
FROM dept;

-- emp테이블에서 각 사원이 속해있는 부서번호만 조회
--SELECT DISTINCT deptno

SELECT *
FROM emp
WHERE deptno = 10;

--문제 ? emp 테이블에서 10번 부서원만 제외하고 나머지 사원들 조회 ?

SELECT *
FROM emp
WHERE deptno != 10; -- ^= 이나 <>  써도 같다 
--WHERE deptno =20 OR deptno =30 OR deptno =40;
--WHERE NOT ( deptno =10 ) ; 도 된다

SELECT *
FROM emp
-- WHERE deptno =20 OR deptno =30 OR deptno =40;
WHERE deptno IN (20,30,40); --위와 완전히 같다 (값의 나열이 옴)

--문제 ? emp 테이블에서 사원명이 FORD인 사원의 모든 정보 출력 ?
SELECT *
FROM emp
WHERE ENAME = UPPER('ford');  --대문자 변환 함수 

SELECT LOWER(ename) , INITCAP( job) --이름 소문자 출력됨, 직업 첫문자 대문자됨
FROM emp;

--문제 ? emp테이블에서 comm이 NULL인 사원의 정보 출력 ?
SELECT *
FROM emp
WHERE comm IS NULL ;

--문제 ? emp테이블에서 월급이 2000이상 4000이하 받는 사람들 조회 , sal + comm 이 월급

SELECT 사원.* , NVL(comm,0) + sal 월급
FROM emp 사원 -- 여기도 별칭 줄 수 있따
WHERE NVL(comm,0) + sal BETWEEN 2000 AND 4000; 
--WHERE 월급 >= 2000 AND 월급<=4000; 에러 뜬다 : FROM - WHERE - SELECT 순으로 진행되니, WHERE단계에선 월급이 없다.

SELECT 사원.* , NVL(comm,0) + sal 월급2
FROM emp 사원 -- 여기도 별칭 줄 수 있따
WHERE NVL(comm,0) + sal >= 2000 AND NVL(comm,0) + sal<=4000; 

--WITH 를 사용해보자
WITH temp AS ( 
               SELECT 사원.* , NVL(comm,0) + sal 월급3
               FROM emp 사원 
             ) --서브쿼리 먼저 실행
SELECT *
FROM temp
WHERE 월급3 >= 2000 AND 월급3 <=4000;

-- 인라인뷰( inline view ) 사용방법
SELECT *
FROM ( 
        SELECT 사원.* , NVL(comm,0) + sal 월급3
        FROM emp 사원 
      ) e 
WHERE e.월급3 >= 2000 AND e.월급3 <= 4000;
-- BETWEEN 써보기
SELECT *
FROM ( 
        SELECT 사원.* , NVL(comm,0) + sal 월급3
        FROM emp 사원 
      ) e 
WHERE e.월급3 BETWEEN 2000 AND 4000;

--문제 insa 테이블에서 70년대생인 사원의 정보를 출력
SELECT *
FROM insa
--WHERE REGEXP_LIKE(SSN, '^7');
WHERE ssn LIKE '%7%';

SELECT name, ssn
       ,SUBSTR(ssn,0,1)주민번호_첫글자
       ,INSTR(ssn,7) 
       -- 7이 들어간 위치가 1인 애들만 뽑아낼수도 있겠네
FROM insa  
WHERE TO_NUMBER( SUBSTR(ssn,0,2) ) BETWEEN 70 AND 79; --TO_NUMBER안해도 자동형변환해주네
--WHERE SUBSTR(ssn,0,1) = 7;
--WHERE INSTR(ssn, 7) = 1;

--SUBSTR--
SELECT name
       ,SUBSTR(ssn,0,8)||'******' RRN
FROM insa ;

SELECT name
       ,CONCAT(SUBSTR(ssn,0,8),'******') RRN 
FROM insa ;

--이런것도 있네 
SELECT name
       ,RPAD( SUBSTR(ssn,0,8),14,'*' ) RRN
FROM insa ;

SELECT name
       ,REPLACE(ssn, SUBSTR(ssn,9,14),'******') RRN
FROM insa ; --이게 되네 ㅋㅋ


SELECT name
       ,REGEXP_REPLACE(ssn, '(\d{6}-\d)\d{6}', '\1******')RRN
    --                      (앞6자리-뒤첫자리 묶고)\나머지자리 를 묶음(\1) 냅두고 다 *로
FROM insa ; 



SELECT name, ssn
    ,SUBSTR(ssn,0,6) 앞자리
    ,SUBSTR(ssn,0,2) YEAR
    ,SUBSTR(ssn,3,2) MONTH
    ,SUBSTR(ssn,5,2) "DATE" 
    --데이트 예약어라서 쓰면 안됨, 꼭 쓰고싶으면 " " 붙이기
    -- '771212' 를 날짜로 형변환 ?
    ,TO_DATE(SUBSTR(ssn,0,6))BIRTH
    --날짜에서 연도만 뽑아오기 (두자리만 가져오기도 가능)
    ,TO_CHAR(TO_DATE(SUBSTR(ssn,0,6)),'YYYY') y
FROM insa
--WHERE TO_DATE(SUBSTR(ssn,0,6)) BETWEEN '70/01/01' AND '79/12/31';
--이게 되네 ㅋㅋㅋ
WHERE TO_CHAR(TO_DATE(SUBSTR(ssn,0,6)),'YY') BETWEEN 70 AND 79;
--이렇게 비교도 가능하군

SELECT ename, hiredate --DATE타입인데도 SUBSTR로 잘라지네
    ,SUBSTR(hiredate, 0,2) year
    ,SUBSTR(hiredate, 4,2) month
    ,SUBSTR(hiredate, -2,2) "DATE"
FROM emp;

SELECT ename, hiredate
    --,TO_CHAR(hiredate, 'format')
    ,TO_CHAR(hiredate, 'YYYY') YEAR --문자열
    ,TO_CHAR(hiredate, 'MM') MONTH --문자열
    ,TO_CHAR(hiredate, 'DD') "DATE" --문자열
    ,TO_CHAR(hiredate, 'DAY') EE --문자열
    
    --EXTRACT() 함수 ? .. 추출
    
    ,EXTRACT( YEAR FROM hiredate) --숫자(오른쪽 정렬)
    ,EXTRACT( MONTH FROM hiredate)
    ,EXTRACT( DAY FROM hiredate)
    
FROM emp;

--오늘 날짜 가지고 놀기

SELECT SYSDATE
    ,TO_CHAR(SYSDATE , 'DS    TS')
    ,CURRENT_TIMESTAMP --나노세컨드까지 나와버림
    
FROM dept; --FROM절은 필수라서 넣음

--insa 테이블에서 70년대 출생 사원 정보 조회.
-- LIKE     SQL 연산자 사용해보자
-- 김씨 사원 찾기
SELECT *
FROM insa
--WHERE name LIKE '김%';
--김 다음 아무거나 라는 뜻.

--WHERE name LIKE '%말%';
--어디든 상관없이 이름에 '말'이 포함되어있다면

--WHERE name LIKE '%자';
--앞에는 뭐든 상관없지만 맨 뒤에는 '자'가 와야함 

--WHERE ssn LIKE '%-1%';
--WHERE ssn LIKE '______-1______';
--남자 사원 가져오기

WHERE ssn LIKE '7_12%';
--70년대 12월생 

--REGEXP_LIKE 함수 
SELECT *
FROM insa
--WHERE REGEXP_LIKE (ssn, '^7.12'); --이건 숫자 아니어도 되니 그닥임
--WHERE REGEXP_LIKE (ssn, '^7[0-9]12');
WHERE REGEXP_LIKE (ssn, '^7\d12');

--김씨 제외 모든 사원 출력 ?
SELECT *
FROM insa
WHERE name NOT LIKE '김%';
--WHERE REGEXP_LIKE( name, '^[^김이]'); --이렇게 하면 여러 성씨 제외도 쌉가능
--대괄호 안에 ^는 부정임.. 밖에 있는건 첫문자

-- [문제]출신도가 서울, 부산, 대구 이면서 전화번호에 5 또는 7이 포함된 자료 출력하되
--      부서명의 마지막 부는 출력되지 않도록함. 
--      (이름, 출신도, 부서명, 전화번호)

--부서명이 두글자 초과하면 어쩔건데...
SELECT name,city,SUBSTR(buseo,1,2)buseo
        ,tel
FROM insa
WHERE (city = '서울' OR city = '부산' OR city = '대구')
    AND (tel LIKE '%5%' OR tel LIKE '%7%');

--정규표현식 쌉가능 
SELECT name,city,SUBSTR(buseo,1,LENGTH(buseo)-1)buseo 
        ,tel
FROM insa
WHERE REGEXP_LIKE(city, '서울|부산|대구')
    AND REGEXP_LIKE(tel, '[57]' );


