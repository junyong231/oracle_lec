--SCOTT
--문제) emp 에서 ename,pay, 평균급여,  절상 , 절삭 (소수점 3자리)
--ORA-00937: not a single-group group function 집계함수와 일반컬럼 못쓴다 => 서브쿼리로 넣으면 된다 ***************

WITH temp AS (
SELECT ename, sal+NVL(comm,0) pay
         ,(SELECT AVG(sal+NVL(comm,0)) FROM emp) avg_pay
         
FROM emp
)
SELECT t.*
            ,CEIL( ( t.pay - t.avg_pay) * 100) /100 "차 올림"
            ,ROUND  ( t.pay - t.avg_pay,2) "차 반올림"
            ,TRUNC ( t.pay - t.avg_pay, 2) "차 내림"
FROM temp t;

-- 문제2) pay avg_pay, 많다 적다 같다 출력

WITH temp AS (
SELECT ename, sal+NVL(comm,0) pay
         ,(SELECT AVG(sal+NVL(comm,0)) FROM emp) avg_pay
         
FROM emp
)
SELECT t.*
            ,CASE WHEN PAY > avg_pay THEN '많다'
            WHEN PAY < avg_pay THEN '적다'
            ELSE '같다' END 평균대비
FROM temp t ;

--[문제] insa 테이블에서 오늘을 기준으로 생일이 지남 여부를 출력하는 쿼리를 작성하세요 . 
--      ( '지났다', '안지났다', '오늘 ' 처리 )   
-- 1) 1002 이순신 주민번호 오늘날짜의 월/일로 수정 (update)
-- 2) 생일 지남 여부
UPDATE insa
SET ssn =SUBSTR(ssn,0,2) || TO_CHAR(sysdate, 'MMDD')||SUBSTR(ssn,7)
WHERE num = 1002;

ROLLBACK;
COMMIT;

SELECT *
FROM insa;



SELECT e.name,e.birth
        , CASE WHEN TO_CHAR(sysdate, 'mm-dd') > e.birth THEN '지났다'
             WHEN TO_CHAR(sysdate, 'mm-dd') < e.birth THEN '안지났다'
            ELSE '오늘' END 지났는지
FROM (
    SELECT name, TO_CHAR(TO_DATE(SUBSTR(ssn,3,4), 'MM-DD'), 'MM-DD') birth 
    FROM insa
) e;

--문제) insa에서 ssn을 가지고  만나이 계산해서 출력?
-- 만나이 : 올해년도 - 생일년도  생일지났으면 그대로, 안지났으면 -1
-- 성별자리가) 1,2 면 1900  3,4 2000  0,9 1800년대 ,, 56 외국인 1900 . 78 외국인 2000


SELECT  e.*
            ,CASE WHEN TO_CHAR(sysdate, 'mm-dd') > e.birth THEN TO_CHAR(sysdate, 'yyyy') - e.생년
             ELSE TO_CHAR(sysdate, 'yyyy') - e.생년 +1
            END 만나이
FROM (
            SELECT SUBSTR(ssn,8,1) 성별코드 , TO_CHAR(TO_DATE(SUBSTR(ssn,3,4),'mmdd'),'mmdd') birth
            , CASE 
            WHEN  SUBSTR(ssn,8,1) = 1 OR SUBSTR(ssn,8,1) = 2 OR SUBSTR(ssn,8,1) = 5 OR SUBSTR(ssn,8,1) = 6 THEN '19' || TO_CHAR(TO_DATE(SUBSTR(ssn,1,2 ),'yy'),'yy')  
            WHEN  SUBSTR(ssn,8,1) = 3 OR SUBSTR(ssn,8,1) = 4 OR SUBSTR(ssn,8,1) = 7 OR SUBSTR(ssn,8,1) = 8 THEN '20' || TO_CHAR(TO_DATE(SUBSTR(ssn,1,2 ),'yy'),'yy')
            ELSE '18' || TO_CHAR(TO_DATE(SUBSTR(ssn,1,2 ),'yy'),'yy') END 생년
    FROM insa
    ) e;

--쌤 풀이

SELECT t.name, t.ssn, 출생년도, 올해년도
    , 올해년도 - 출생년도  + CASE bs
                               WHEN -1 THEN  -1                               
                               ELSE 0
                               END  만나이  
FROM (
    SELECT name, ssn, TO_CHAR(sysdate , 'yyyy') 올해년도, SUBSTR(ssn,-7,1) 성별, SUBSTR(ssn,0,2) 출생2자리년도
            ,CASE 
            WHEN SUBSTR(ssn,-7,1) IN (1,2,5,6) THEN 1900
            WHEN SUBSTR(ssn,-7,1) IN (3,4,7,8) THEN 2000
            ELSE 1800 END + SUBSTR(ssn,0,2) 출생년도
            , SIGN( TO_DATE(SUBSTR(ssn,3,4),'mmdd') - TRUNC( sysdate) ) bs -- 0,-1 생일 지난거, 1이면 생일 안지났으니 나이 출력할 때 -1 해주기
    FROM insa
        ) t;


SELECT TO_DATE(SUBSTR(ssn,3,4),'mmdd') birth
FROM insa;

-- 자바에서는 Math.random() 임의의 수.. 
-- Random 이라는 클래스 안에 nextInt() 임의의 수..
-- 오라클에도 있다?

--자바에서 패키지는 서로 관련된 클래스들의 묶음
--오라클에서 패키지는 서로 관련된 타입 객체 서브프로그램들을 묶어 놓은 것
--사용 목적은 유지보수 관리 등  자바와 같음..

SELECT sys.dbms_random.value
FROM dual;
-- 0.0 <= 값 < 1.0 생성함

SELECT sys.dbms_random.value (0, 100)
FROM dual;
-- 0~100 사이의 실수가 나옴
SELECT sys.dbms_random.value(1,2)
FROM dual;

SELECT sys.dbms_random.string('U',3)
FROM dual;
--대문자 3개 랜덤

SELECT sys.dbms_random.string('X',5)
FROM dual;
-- 숫자, 대문자 랜덤

SELECT sys.dbms_random.string('L',3)
FROM dual;
-- 소문자 (LOWER)

SELECT sys.dbms_random.string('P',6)
FROM dual;
--대,소,숫자,특문까지 랜덤

SELECT sys.dbms_random.string('A',5)
FROM dual;
--랜덤 알파벳 (대,소)

--문제) 임의의 국어 점수 1개 생성 -> 출력 
-- 임의의 로또 번호 1개 출력
-- 임의의 숫자 6자리 발생시켜서 출력

SELECT TRUNC(sys.dbms_random.value (0, 101) ) "국어 점수"
FROM dual;

SELECT TRUNC(sys.dbms_random.value (1, 46) ) "로또 번호"
FROM dual;

SELECT  (TRUNC(sys.dbms_random.value (0,10)) || TRUNC(sys.dbms_random.value (0,10)) || TRUNC(sys.dbms_random.value (0,10))
            ||TRUNC(sys.dbms_random.value (0,10)) || TRUNC(sys.dbms_random.value (0,10)) || TRUNC(sys.dbms_random.value (0,10)) ) "랜덤 6"
FROM dual;

--쌤 풀이
SELECT ROUND(sys.dbms_random.value (0, 100) ) 국어점수
           ,TRUNC( sys.dbms_random.value (0,1000000) ) --로직이 정확하진 않음
FROM dual;


-- 문제) insa 테이블에서 남자 사원수, 여자 사원수
-- 이후 부서별 남자사원수ㅡ 여자사원수 출력

--첫번째 방법 (SET 집합연산자 - UNION ALL)
SELECT '남자사원수' "성별", COUNT(*) "사원수"
FROM insa
WHERE MOD( SUBSTR(ssn, 8, 1 ), 2 ) = 1
UNION ALL
SELECT '여자사원수' "성별", COUNT(*) "사원수"
FROM insa
WHERE MOD( SUBSTR(ssn, 8, 1 ), 2 ) = 0;

-- 두번째 방법 GROUP BY
SELECT DECODE (  MOD( SUBSTR(ssn, 8, 1 ), 2 )  ,0, '여자', 1,'남자') ,COUNT(*)
FROM insa
GROUP BY  MOD( SUBSTR(ssn, 8, 1 ), 2 ) ;

SELECT buseo 부서명 ,DECODE (  MOD( SUBSTR(ssn, 8, 1 ), 2 )  ,0, '여자', 1,'남자') 성별 ,COUNT(*) 사원수
FROM insa
GROUP BY  MOD( SUBSTR(ssn, 8, 1 ), 2 ), buseo
ORDER BY buseo; --보통 그룹바이 준걸로 오더바이 준다

SELECT buseo,
        COUNT ( CASE 
        WHEN SUBSTR(ssn,8,1) =1 THEN '남자' END
         ) "남자 사원수"
         ,COUNT ( CASE 
        WHEN SUBSTR(ssn,8,1) =2 THEN '여자' END
         ) "여자 사원수"
FROM insa
GROUP BY  buseo;

SELECT buseo, SUBSTR(ssn,8,1)
FROM insa
ORDER BY buseo, SUBSTR(ssn,8,1);

-- 문제) emp에서 최고 급여자, 최저 급여자  사원정보 출력 
-- 문제) emp에서 부서별 최고 급여자, 최저 급여자  사원정보 출력 


SELECT *
FROM emp
WHERE sal IN ( (SELECT MAX(sal) FROM emp) , (SELECT MIN(sal) FROM emp) ) ;
--이런게 되네

SELECT *
FROM emp m
WHERE sal IN ( (SELECT MAX(sal) FROM emp WHERE deptno = m.deptno) , (SELECT MIN(sal) FROM emp WHERE deptno = m.deptno) ) 
ORDER BY deptno;
--머임?







SELECT e.*
FROM (
    SELECT emp.* , RANK () OVER (ORDER BY sal DESC) r
    FROM emp
       ) e
WHERE e.r= 1 OR e.r = (SELECT COUNT(*) FROM emp);



--공동순위에 대한 (꼴찌) 처리가 아쉬울 수 있음
--WHERE e.rank =1 OR e.rank = 12;

SELECT e.*
FROM (
    SELECT emp.* , RANK () OVER (PARTITION BY deptno ORDER BY sal DESC) r
    , RANK () OVER (PARTITION BY deptno ORDER BY sal) ar
    FROM emp
       ) e
WHERE e.r= 1 OR e.ar =1
ORDER BY deptno;


-- 문제  emp 테이블에서 comm이 400이하인 사원 조회 ( comm이 NULL이어도 400 이하)
SELECT e.*
FROM (
    SELECT emp.*, NVL(comm,0) comm2
    FROM emp
        ) e
WHERE e.comm2 <= 400;
--인라인뷰 필요없음
SELECT *
FROM emp
WHERE NVL(comm,0) <= 400;

-- 이렇게도 가능
SELECT *
FROM emp
WHERE comm<= 400 OR comm IS NULL;

--LNNVL 함수 
--컬럼이 NULL인 경우 = TRUE
--함수 내부 조건이 FALSE인 경우 = TRUE

SELECT *
FROM emp
WHERE LNNVL( comm >= 400); 
-- 400 이상 애들 -> 거짓, 400 이하 애들 -> 참, NULL -> 참 ,,


--문제 이번달 마지막 날짜가 몇일까지 있는지 확인?

SELECT TO_CHAR(LAST_DAY(sysdate), 'dd') 마지막날
FROM dual;

--문제) emp에서 sal이 상위 20퍼센트 해당되는 사원 정보?
-- (순위 함수 사용)
SELECT e.*
FROM (
    SELECT emp.*, PERCENT_RANK() OVER(ORDER BY sal) r
    FROM emp
        ) e
WHERE e.r <= 0.2;

--문제) 다음 주 월요일은 휴강입니다 . 날짜 조회 ?

SELECT TO_CHAR( sysdate, 'DS TS(DY)') 현재
        ,NEXT_DAY(sysdate, '월')
FROM dual;

--문제 emp에서 각 사원들의 입사일자를 기준으로 10년 5개월 20일째 되는 날짜를 출력하라 ?

SELECT ename
        , ADD_MONTHS( hiredate, 125) + 20 
FROM emp;



--insa 테이블에서 
--[실행결과]
--                                           부서사원수/전체사원수 == 부/전 비율
--                                           부서의 해당성별사원수/전체사원수 == 부성/전%
--                                           부서의 해당성별사원수/부서사원수 == 성/부%
--                                           
--부서명     총사원수 부서사원수 성별  성별사원수  부/전%   부성/전%   성/부%
--개발부       60       14         F       8       23.3%     13.3%       57.1%
--개발부       60       14         M       6       23.3%     10%       42.9%
--기획부       60       7         F       3       11.7%       5%       42.9%
--기획부       60       7         M       4       11.7%   6.7%       57.1%
--영업부       60       16         F       8       26.7%   13.3%       50%
--영업부       60       16         M       8       26.7%   13.3%       50%
--인사부       60       4         M       4       6.7%   6.7%       100%
--자재부       60       6         F       4       10%       6.7%       66.7%
--자재부       60       6         M       2       10%       3.3%       33.3%
--총무부       60       7         F       3       11.7%   5%           42.9%
--총무부       60       7         M    4       11.7%   6.7%       57.1%
--홍보부       60       6         F       3       10%       5%           50%
--홍보부       60       6         M       
SELECT COUNT(buseo) 부서사원수
FROM insa
GROUP BY buseo;

--푸는중


SELECT buseo, 
FROM insa ;










--쌤풀이
SELECT s.*
  ,ROUND(   부서사원수/총사원수*100, 2) || '%' "부/전%"
  ,ROUND(   성별사원수/총사원수*100, 2) || '%' "부성/전%"
  ,ROUND(   성별사원수/부서사원수*100, 2) || '%'  "성/부%"
FROM (
    SELECT  buseo
    , ( SELECT COUNT(*) FROM insa ) 총사원수
    , ( SELECT COUNT(*) FROM insa WHERE buseo = t.buseo ) 부서사원수
    , gender 성별
    , COUNT(*) 성별사원수
    FROM 
    (
        SELECT buseo, name, ssn
             , DECODE(  MOD(SUBSTR(ssn,-7,1),2), 1,'M','F' ) gender
        FROM insa
    ) t
    GROUP BY buseo, gender
    ORDER BY buseo, gender
) s;
SELECT s.*
  ,ROUND(   부서사원수/총사원수*100, 2) || '%' "부/전%"
  ,ROUND(   성별사원수/총사원수*100, 2) || '%' "부성/전%"
  ,ROUND(   성별사원수/부서사원수*100, 2) || '%'  "성/부%"
FROM (
    SELECT  buseo
    , ( SELECT COUNT(*) FROM insa ) 총사원수
    , ( SELECT COUNT(*) FROM insa WHERE buseo = t.buseo ) 부서사원수
    , gender 성별
    , COUNT(*) 성별사원수
    FROM 
    (
        SELECT buseo, name, ssn
             , DECODE(  MOD(SUBSTR(ssn,-7,1),2), 1,'M','F' ) gender
        FROM insa
    ) t
    GROUP BY buseo, gender
    ORDER BY buseo, gender
) s;


--LISTAGG 함수 (목록 처리 : 특정 '셀' 안에 내용 나열)
LISTAGG(ENAME , ' , ') WITHIN GROUP(ORDER BY ENAME DESC) AS ENAMES 

[실행결과]
10   CLARK/MILLER/KING
20   FORD/JONES/SMITH
30   ALLEN/BLAKE/JAMES/MARTIN/TURNER/WARD
40  사원없음   

SELECT deptno, LISTAGG(ename, ', ') WITHIN GROUP(ORDER BY ename DESC) AS enames
FROM emp 
GROUP BY deptno;


--문제 insa테이블에서 TOP_N분석방식으로 급여 많이 받는 탑텐 조회 ? 

1) 급여 순으로 오더바이
2) 로우넘버 의사칼럼 순번
3) 순번의 1-10명 셀렉트

SELECT ROWNUM, e.*
FROM (    
    SELECT name,basicpay
    FROM insa
    ORDER BY basicpay DESC
) e
WHERE ROWNUM <= 10;

--문제 ) 

SELECT TRUNC(sysdate, 'year') --24년 1/1
           ,TRUNC(sysdate, 'month') -- 24년 8월 1
           ,TRUNC(sysdate, 'dd') --24년 8월 12일
           ,TRUNC(sysdate) --시간분초 절삭
FROM dual;

--문제 (emp테이블) (페이 백단위로 #한개 찍어서 그래프) (LPAD)
[실행결과]
DEPTNO ENAME PAY BAR_LENGTH      
---------- ---------- ---------- ----------
30   BLAKE   2850   29    #############################
30   MARTIN   2650   27    ###########################
30   ALLEN   1900   19    ###################
30   WARD   1750   18    ##################
30   TURNER   1500   15    ###############
30   JAMES   950       10    ##########

SELECT e.* ,ROUND(e.pay/100), RPAD('#', ROUND(e.pay/100), '#') "BAR_LENGTH"
FROM(
SELECT deptno,ename,  (sal+NVL(comm,0)) pay
FROM emp
)e
WHERE e.deptno =30
ORDER BY e.pay DESC;

SELECT TO_CHAR( hiredate, 'WW') -- 연중 몇째주인지  --WW는 1~7일을 첫째주로 친다
            , TO_CHAR(hiredate, 'IW')-- 연중 몇째주인지    --IW는 요일기준(월~일)
            , TO_CHAR(hiredate, 'W') --월중 몇번째주
            , hiredate
            ,TO_CHAR(hiredate , 'day')
FROM emp;
-- 차이?

--문제) emp테이블에서 
--사원수가 가장많은부서,적은부서,사원수 출력

SELECT *
FROM emp e , dept d
WHERE e.deptno=d.deptno;

SELECT *
FROM dept;



        SELECT d.deptno, d.dname, COUNT(e.empno) 사원  --(NVL(COUNT(empno,0)) 이나 COUNT(empno) ㄱㅊ
        --FROM emp e JOIN dept d ON e.deptno =d.deptno  --이제까진 INNER JOIN 이었다 (교집합)
        FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno  --코딩 기준 오른쪽에  dept가 있으니까 라이트아우터조인
        GROUP BY d.deptno, d.dname;

--
SELECT e.*
FROM(
        SELECT d.deptno, d.dname, COUNT(e.empno) 사원 
                    , RANK () OVER(ORDER BY COUNT(e.empno) DESC) rank
        FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno 
        GROUP BY d.deptno, d.dname
        ORDER BY rank
) e
WHERE e.rank =1 OR e.rank =4;
--
WITH temp AS (
        SELECT d.deptno, d.dname, COUNT(e.empno) 사원 
                    , RANK () OVER(ORDER BY COUNT(e.empno) DESC) rnk
        FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno 
        GROUP BY d.deptno, d.dname
        ORDER BY rnk
)
SELECT *
FROM temp
WHERE temp.rnk IN ( (SELECT MAX(rnk) FROM temp) ,(SELECT MIN(rnk) FROM temp) );
--

WITH a AS (
        SELECT d.deptno, d.dname, COUNT(e.empno) 사원 
        FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno 
        GROUP BY d.deptno, d.dname
    ),
        b AS (
        SELECT MAX(사원) maxcnt , MIN(사원) mincnt
        FROM a
    )
SELECT a.deptno,a.dname,a.사원
FROM a,b
WHERE a.사원 IN (b.maxcnt, b.mincnt);




--피벗 언피벗 암기 (모니터 가로세로 그 피벗)
https://blog.naver.com/gurrms95/222697767118

--job별 시원수를 출력

SELECT 
            COUNT( DECODE(job, 'CLERK', 'o') ) CLERK
            ,COUNT( DECODE(job, 'SALESMAN', 'o') ) SALESMAN
            ,COUNT( DECODE(job, 'PRESIDENT', 'o') ) PRESIDENT
            ,COUNT( DECODE(job, 'MANAGER', 'o') ) "MANAGER"
            ,COUNT( DECODE(job, 'ANALYST', 'o') ) ANALYST
            --현재 2행 5열임
FROM emp;

--피벗 (축을 중심으로 회전시키다..라는 뜻)
SELECT 
FROM (피벗 대상 쿼리문)
PIVOT (그룹함수(집계컬럼)) FOR 피벗컬럼 IN (피벗컬럼 AS 별칭....);

SELECT *
FROM (
        SELECT job
        FROM emp
        )
PIVOT (COUNT(job) FOR job IN ('CLERK', 'SALESMAN', 'PRESIDENT', 'MANAGER', 'ANALYST') );

--예2 emp에서 월별 입사한 사원수 조회 ?
-- 1월   2월  3월 .....
--   2      0    5  ....

SELECT TO_CHAR(hiredate , 'yyyy') year
        ,TO_CHAR(hiredate, 'mm' month
FROM emp;

SELECT *
FROM (
    SELECT TO_CHAR(hiredate , 'yyyy') year
            ,TO_CHAR(hiredate, 'mm') month
    FROM emp
)
PIVOT ( COUNT(month) FOR month IN ('01' AS "1월",'02','03','04','05','06','07','08','09','10','11','12') )
ORDER BY year;

--문제) emp 테이블에서 job별 사원수 조회
 
 SELECT *
 FROM (
         SELECT job
         FROM emp
)
PIVOT ( COUNT(job) FOR job IN ('CLERK','SALESMAN','PRESIDENT','MANAGER','ANALYST' ) ) ;


--문제) emp에서 부서별, 잡별 사원수 조회

--DEPTNO DNAME                      'CLERK' 'SALESMAN' 'PRESIDENT'  'MANAGER'  'ANALYST'
------------ -------------- ---------- ---------- ----------- ---------- ---------- ---------- ---------- 
--        10 ACCOUNTING              1          0           1          1          0
--        20 RESEARCH                    1          0           0          1          1
--        30 SALES                        1          4           0          1          0
--        40 OPERATIONS                 0          0           0          0          0

SELECT *
FROM (
        SELECT d.deptno , d.dname , e.job
        FROM dept d LEFT OUTER JOIN emp e ON d.deptno =e.deptno
)
PIVOT ( COUNT(job) FOR job  IN ( 'CLERK', 'SALESMAN', 'PRESIDENT',  'MANAGER',  'ANALYST' ) );

---문제 ) 각 부서별 총 급여합?
SELECT *
FROM (
    SELECT deptno, sal+NVL(comm,0) pay
    FROM emp
)
PIVOT (   SUM(pay)  FOR deptno IN('10', '20', '30', '40' ) ) ;--둘이 다른 경우


--문제 (ㄴㄴ)
SELECT *
FROM (
    SELECT job, deptno, sal, ename
    FROM emp
)
PIVOT ( SUM(sal) AS 합계, MAX(sal) AS 최고액, MAX(ename) AS 최고연봉  FOR deptno IN( '10', '20', '30', '40' ) );


--문제) 생일이 지난 사람  생일 안지난 사람  오늘이 생일인 사람
--                20                        30                      1
SELECT *
FROM (
        SELECT 
                    CASE 
                    WHEN SUBSTR(ssn, 3,4) < TO_CHAR(sysdate, 'mmdd') THEN '생일 지난 사람' 
                    WHEN SUBSTR(ssn, 3,4) > TO_CHAR(sysdate, 'mmdd') THEN '생일 안지난 사람' 
                    ELSE '오늘이 생일인 사람' END 생일판단
        FROM insa
            )
PIVOT ( COUNT(생일판단) FOR 생일판단 IN ('생일 지난 사람', '생일 안지난 사람', '오늘이 생일인 사람' ) );
--그래서 PIVOT이 GROUP BY와 같은 기능을 한다고 한거구나


-- 부서번호를 4자리로 출력하고 싶다.

SELECT   '00' ||deptno -- 제일 안좋은 방법
            , TO_CHAR(deptno, '0999') 
            , LPAD(deptno, 4, '0')
FROM dept;

--암기(프로젝트 사용) 각 부서별 / 출신지역별. 사원수 몇명인지 출력
SELECT city,buseo
FROM insa; --11개의 도시가 있다


    SELECT buseo,city,COUNT(*) 사원수 --이렇게만 하면 사원이 없는 지역은 안나옴 , 나오게 하려면?
    FROM insa
    GROUP BY buseo, city
    ORDER BY buseo, city;
-- 오라클 10g부터 추가된 기능 : PARTITION BY OUT JOIN ..?































--문제) emp 에서 ename,pay, 평균급여,  절상 , 절삭 (소수점 3자리)

SELECT ename, sal+NVL(comm,0)
        , (SELECT ROUND(AVG(sal+NVL(comm,0))) FROM emp)
        , (SELECT  CEIL( AVG(sal+NVL(comm,0))* 100  )/100 FROM emp)
FROM emp;

-- 문제2) pay avg_pay, 많다 적다 같다 출력
SELECT e.*, CASE WHEN e.pay > e.avg_pay THEN '많다'
                 WHEN e.pay < e.avg_pay THEN '적다' END 평균비교
FROM(
SELECT ename, sal+NVL(comm,0) pay
        ,(SELECT ROUND(AVG(sal+NVL(comm,0))) FROM emp) avg_pay
FROM emp
)e;

--[문제] insa 테이블에서 오늘을 기준으로 생일이 지남 여부를 출력하는 쿼리를 작성하세요 . 
--      ( '지났다', '안지났다', '오늘 ' 처리 )   
-- 1) 1002 이순신 주민번호 오늘날짜의 월/일로 수정 (update)
UPDATE insa
SET ssn = SUBSTR(ssn,1,2) || '0812' || SUBSTR(ssn,7)
WHERE name = '이순신' ;
commit;
SELECT *
FROM insa;
-- 2) 생일 지남 여부

SELECT name, ssn, CASE WHEN SUBSTR(ssn,3,4) > TO_CHAR(sysdate,'mmdd') THEN '안지남'
            WHEN SUBSTR(ssn,3,4) < TO_CHAR(sysdate,'mmdd') THEN '지남'
            ELSE '오늘은 내 생일 'END 생일 
FROM insa;

--문제) insa에서 ssn을 가지고  만나이 계산해서 출력?
-- 만나이 : 올해년도 - 생일년도  생일지났으면 그대로, 안지났으면 -1
-- 성별자리가) 1,2 면 1900  3,4 2000  0,9 1800년대 ,, 56 외국인 1900 . 78 외국인 2000
-- 문제) insa 테이블에서 남자 사원수, 여자 사원수



SELECT  CASE WHEN SUBSTR(ssn,8,1) = 1 THEN '남자'
              WHEN SUBSTR(ssn,8,1) = 2 THEN '여자'
              END sex
        ,COUNT ( SUBSTR(ssn,8,1) ) employee
FROM insa
GROUP BY SUBSTR(ssn,8,1);


-- 이후 부서별 남자사원수ㅡ 여자사원수 출력

SELECT buseo
        ,CASE WHEN SUBSTR(ssn, 8, 1) =1 THEN '남자'
              WHEN SUBSTR(ssn, 8, 1) =2 THEN '여자'
              END 성별
        ,COUNT(SUBSTR(ssn, 8, 1)) 사원수
FROM insa
GROUP BY buseo,SUBSTR(ssn, 8, 1)
ORDER BY buseo;

-- 문제) emp에서 최고 급여자, 최저 급여자  사원정보 출력 

SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp) OR sal = (SELECT MIN(sal) FROM emp) ;

-- 문제) emp에서 부서별 최고 급여자, 최저 급여자  사원정보 출력 

SELECT *
FROM emp e
WHERE sal = (SELECT MAX(sal) FROM emp WHERE deptno = e.deptno)
;



-- 문제  emp 테이블에서 comm이 400이하인 사원 조회 ( comm이 NULL이어도 400 이하)
--문제) emp에서 sal이 상위 20퍼센트 해당되는 사원 정보?
-- (순위 함수 사용)
--문제) 다음 주 월요일은 휴강입니다 . 날짜 조회 ?
--문제 emp에서 각 사원들의 입사일자를 기준으로 10년 5개월 20일째 되는 날짜를 출력하라 ?

--insa 테이블에서 
--[실행결과]
--                                           부서사원수/전체사원수 == 부/전 비율
--                                           부서의 해당성별사원수/전체사원수 == 부성/전%
--                                           부서의 해당성별사원수/부서사원수 == 성/부%
--                                           
--부서명     총사원수 부서사원수 성별  성별사원수  부/전%   부성/전%   성/부%
--개발부       60       14         F       8       23.3%     13.3%       57.1%
--개발부       60       14         M       6       23.3%     10%       42.9%
--기획부       60       7         F       3       11.7%       5%       42.9%
--기획부       60       7         M       4       11.7%   6.7%       57.1%
--영업부       60       16         F       8       26.7%   13.3%       50%
--영업부       60       16         M       8       26.7%   13.3%       50%
--인사부       60       4         M       4       6.7%   6.7%       100%
--자재부       60       6         F       4       10%       6.7%       66.7%
--자재부       60       6         M       2       10%       3.3%       33.3%
--총무부       60       7         F       3       11.7%   5%           42.9%
--총무부       60       7         M    4       11.7%   6.7%       57.1%
--홍보부       60       6         F       3       10%       5%           50%
--홍보부       60       6         M       

SELECT e.*
        , ROUND(e.부서별사원수/e.전체 , 3)* 100 || '%' "부/전 비율"
        , ROUND(e.사원수/e.전체 , 3)* 100 || '%' "성/전 비율"
        , ROUND(e.사원수/e.부서별사원수 , 3)* 100 || '%' "성/부 비율"
FROM(
    SELECT  buseo 부서명
            , (SELECT COUNT(*) FROM insa) 전체
            , (SELECT COUNT(buseo) FROM insa WHERE buseo=i.buseo) 부서별사원수
            , DECODE(SUBSTR(SSN,8,1),1,'남자',2,'여자') 성별
            , COUNT(*) 사원수
    FROM insa i
    GROUP BY buseo,SUBSTR(SSN,8,1)
    ORDER BY buseo,성별 DESC
)e;








--문제 insa테이블에서 TOP_N분석방식으로 급여 많이 받는 탑텐 조회 ? 
--문제 (emp테이블) (페이 백단위로 #한개 찍어서 그래프) (LPAD)
--문제) emp테이블에서 
--사원수가 가장많은부서,적은부서,사원수 출력

--예2 emp에서 월별 입사한 사원수 조회 ?
-- 1월   2월  3월 .....
--   2      0    5  ....

--문제) emp 테이블에서 job별 사원수 조회

--문제) emp에서 부서별, 잡별 사원수 조회




