--emp 테이블에서 job 갯수?

SELECT COUNT(DISTINCT job)
FROM emp;

SELECT COUNT(*)
FROM ( 
        SELECT DISTINCT job
        FROM emp
        ) e;

SELECT *
FROM emp;

-- emp부서별 사원수?

SELECT deptno, COUNT(*)  --그룹 바이 절에 있는 컬럼은 집계함수와도 쓸 수 있다.
FROM emp            
GROUP BY deptno --그룹별로 해쳐모여
ORDER BY deptno ASC;

--[문제]  40번 부서는 지금 없는데, 0이라고 띄우려면? 

SELECT COUNT(*)
           ,COUNT(DECODE (deptno, 10, sal)) "10"
           ,COUNT(DECODE (deptno, 20, sal)) "20"
           ,COUNT(DECODE (deptno, 30, sal)) "30"
           ,COUNT(DECODE (deptno, 40, sal)) "40"
FROM emp;
-- COUNT 는 NULL을 세지 않고, DECODE는 조건에 맞지 않으면 NULL을 반환하므로 COUNT는 조건에 부합하는 경우만을 세게 된다.
-- sal은 아무 의미없고 그냥 NULL만 안나오면됨 (comm같은거) 그냥 상수 1같은거 줘도됨 세기만 하면 되니까

SELECT *
FROM emp;

 SELECT '10', COUNT(deptno) 부서별인원
 FROM emp
 WHERE deptno=10
 UNION
 SELECT '20', COUNT(deptno)
 FROM emp
 WHERE deptno=20
 UNION
 SELECT '30', COUNT(deptno)
 FROM emp
 WHERE deptno=30
 UNION
 SELECT '40', COUNT(deptno)
 FROM emp
 WHERE deptno=40
 UNION
 SELECT '전체사원수' , COUNT(*)
 FROM emp;
 
 -- 문제)  insa 에서 총 사원수, 남자 사원수, 여자 사원수 조회?

-- COUNT ,DECODE 이용 
SELECT  COUNT(*) "총 사원수"
            , COUNT(DECODE (SUBSTR(ssn,8,1) ,1 ,'o') ) "남자 사원수" 
            , COUNT(DECODE (SUBSTR(ssn,8,1) ,2 ,'o') ) "여자 사원수" 
FROM insa;

--GROUP BY 이용
SELECT  CASE SUBSTR(ssn, 8, 1) WHEN '1' THEN '남자' ELSE '여자' END "성별"
                            , COUNT(SUBSTR(ssn, 8, 1)) 인원수
FROM insa
GROUP BY SUBSTR(ssn,8,1);



SELECT CASE MOD(SUBSTR(ssn,8,1), 2) WHEN 0 THEN '남자'
                                                      WHEN 1 THEN '여자' END GENDER
         , COUNT(*)
FROM insa
GROUP BY MOD(SUBSTR(ssn,8,1),2); -- 0이냐 1이냐 구분 가능



-- ROLL UP
SELECT CASE MOD(SUBSTR(ssn,8,1), 2) WHEN 0 THEN '여자'
                                                      WHEN 1 THEN '남자' 
                                                      ELSE '전체' END GENDER
         , COUNT(*) 사원수
FROM insa
GROUP BY ROLLUP (MOD(SUBSTR(ssn,8,1),2) ); -- 0이냐 1이냐 구분 가능


--emp에서 급여 가장 많이 받는 사원 정보 조회
SELECT *
FROM emp
WHERE (sal + NVL (comm,0) ) = (
                                                SELECT MAX(sal + NVL(comm,0))
                                                FROM emp
                                            );

--SQL 연산자 (ALL,SUM,ANY,EXIST)
SELECT *
FROM emp
WHERE (sal+ NVL(comm,0)) <= ALL( SELECT sal+ NVL(comm,0) FROM emp) ; --모든 애들보다..(지금은 작은경우 = 제일 조금 받는애)

--문제 ) emp 테이블에서  각 부서별 최고 급여자의 정보 조회 ?

SELECT *
FROM emp
WHERE  (sal+ NVL(comm,0)) = ANY  (
                                                SELECT MAX(sal + NVL(comm,0))
                                                FROM emp
                                                GROUP BY deptno  
                                                    ); --이 코드 틀림: 다른 부서인데 우리 부서 짱이랑 같으면 걔가 찍힐 수 있음

SELECT deptno 부서번호, MAX( sal + NVL(comm,0) ) 급여
FROM emp
GROUP BY deptno
ORDER BY deptno ASC; -- 사원정보를 조회할 수가 없네


SELECT *
FROM emp m
WHERE sal+NVL(comm,0) = (
                                            SELECT MAX(sal+NVL(comm,0)) 
                                            FROM emp s
                                            WHERE deptno = m.deptno --상호 연관 서브 쿼리
                                        );

--emp 테이블의 pay 순위 등수

SELECT *
FROM (
        SELECT m.*
        , (SELECT COUNT(*)+1 FROM emp WHERE sal > m.sal ) RANK
        , (SELECT COUNT(*)+1 FROM emp WHERE sal > m.sal AND deptno =m.deptno ) "부서별 등수"
        FROM emp m
         ) e
WHERE e."부서별 등수" <= 2
ORDER BY deptno ASC , "부서별 등수";

--문제 ) insa에서 부서별 인원수가 10명 이상인 부서를 조회 ?

SELECT *
FROM insa;

SELECT *
FROM (
            SELECT buseo ,COUNT(*) "인원수"
            FROM insa
            GROUP BY buseo
        ) m
WHERE  m."인원수" >= 10;


-- HAVING 
SELECT buseo ,COUNT(*) "인원수"
FROM insa
GROUP BY buseo
HAVING COUNT(*) >= 10; -- 그룹바이 한것에 대한 조건. 위와 똑같은 코드다



--문제) insa에서 여자사원수가 5명 이상인 부서 ?

SELECT buseo ,COUNT( DECODE( MOD(SUBSTR(ssn,8,1),2) ,0 ,'여자' ) ) 여성사원수
FROM insa
GROUP BY buseo
HAVING COUNT( DECODE( MOD(SUBSTR(ssn,8,1),2) ,0 ,'여자' ) )>=5;


SELECT name,buseo,SUBSTR(ssn,8,1)
FROM insa
ORDER BY buseo;


--와우!
SELECT buseo, COUNT(*)
FROM insa
WHERE MOD(SUBSTR(ssn,8,1),2) = 0 --처리 순서를 아니까 여자만 남기고 계산할 수도...!!
GROUP BY buseo
HAVING COUNT(*) >= 5; 


-- [문제] emp 테이블에서
--       사원 전체 평균급여(pay)를 계산한 후
--       각 사원들의 급여가 평균급여보다 많을 경우 "많다" 출력
--                                "   적을 경우 "적다" 출력.
-- 2260.416666666666666666666666666666666667
SELECT AVG( sal + NVL(comm, 0) )  avg_pay
FROM emp;
--
SELECT empno, ename, pay , ROUND( avg_pay, 2) avg_pay
     , CASE 
          WHEN pay > avg_pay   THEN '많다'
          WHEN pay < avg_pay THEN '적다'
          ELSE '같다'
       END
FROM (
        SELECT emp.*
              , sal + NVL(comm,0) pay
              , (SELECT AVG( sal + NVL(comm, 0) )  FROM emp) avg_pay
        FROM emp
    ) e;
    
    
SELECT e.*,
        CASE WHEN pay > avg_pay THEN '많다' 
                WHEN pay < avg_pay THEN '적다' 
                END

FROM (SELECT emp.*
              , sal + NVL(comm,0) pay
              , (SELECT AVG( sal + NVL(comm, 0) )  FROM emp) avg_pay
              FROM emp
              ) e ;


    
    

    
    
-- [문제] emp 테이블에서
--       사원 전체 평균급여(pay)를 계산한 후
--       각 사원들의 급여가 평균급여보다 많을 경우 "많다" 출력
--                                "   적을 경우 "적다" 출력.
-- 2260.416666666666666666666666666666666667
SELECT AVG( sal + NVL(comm, 0) )  avg_pay
FROM emp;
--
SELECT empno, ename, pay , ROUND( avg_pay, 2) avg_pay
     , CASE 
          WHEN pay > avg_pay   THEN '많다'
          WHEN pay < avg_pay THEN '적다'
          ELSE '같다'
       END
FROM (
        SELECT emp.*
              , sal + NVL(comm,0) pay
              , (SELECT AVG( sal + NVL(comm, 0) )  FROM emp) avg_pay
        FROM emp
    ) e;

SELECT e.*
    ,CASE 
        WHEN sal+NVL(comm,0) <(SELECT AVG(sal+NVL(comm,0))FROM emp) THEN '적다'
        ELSE '많다'
    END p
FROM emp e;



--NULLIF 사용
SELECT ename, pay, avg_pay
     , NVL2( NULLIF( SIGN( pay - avg_pay ), 1 ), '적다' , '많다') 
FROM (
        SELECT ename, sal+NVL(comm,0) pay 
            , (SELECT AVG( sal + NVL(comm,0 )) avg_pay FROM emp) avg_pay
        FROM emp
      );



-- emp 테이블에서 최고급여 최저급여 사원 출력
-- 쌤 풀이 붙여넣어야함..

SELECT e.*
FROM (
            SELECT emp.*
            FROM emp
            WHERE  (sal + NVL(comm, 0)) =  (SELECT MAX(sal + NVL(comm, 0)) FROM emp)
            OR (sal + NVL(comm, 0)) = (SELECT MIN(sal + NVL(comm, 0)) FROM emp)
        ) e;

SELECT e.*
FROM emp e
WHERE (sal + NVL(comm, 0)) = (SELECT MAX(sal + NVL(comm, 0)) FROM emp)
      OR (sal + NVL(comm, 0)) = (SELECT MIN(sal + NVL(comm, 0)) FROM emp);

-- 문제) insa에서 서울사람 중 부서별 남자,여자 사원 수, 부서별 남자 급여 총합, 여자 급여 총합 출력 ?

SELECT *
FROM insa;

SELECT e.*
FROM (
            SELECT buseo 부서명, COUNT( DECODE( MOD(SUBSTR(ssn,8,1),2) ,0 ,'ㅋ' ) ) 여자직원
                                , COUNT( DECODE( MOD(SUBSTR(ssn,8,1),2) ,1 ,'ㅋ' ) ) 남자직원
                                , SUM( DECODE( MOD(SUBSTR(ssn,8,1),2) ,1 ,basicpay ) ) "남직원급여"
                                , SUM( DECODE( MOD(SUBSTR(ssn,8,1),2) ,0 ,basicpay ) ) "여직원급여"
                                , SUM(basicpay) "부서별 총급여"
            FROM insa
            WHERE city = '서울'
            GROUP BY buseo
            ) e;
--요구사항 하나씩 해결하다보면 다 나옴.

--다른 풀이용 선행(2차그룹)

SELECT buseo, COUNT(*), jikwi, SUM(basicpay), AVG(basicpay)
FROM insa
GROUP BY ROLLUP (buseo, jikwi ) --롤업하니 전체 부서 평균도 나오네
ORDER BY buseo, jikwi ; 
-- 그룹바이 두번: 부서도 직위대로 쪼개짐

--다른 풀이

SELECT buseo
         , DECODE( MOD(SUBSTR(ssn,8,1),2) ,1 ,'남자' , 0 , '여자' ) 성별
         , COUNT(*) 사원수
         , SUM( basicpay ) "총급여합"
         , SUM( DECODE( MOD(SUBSTR(ssn,8,1),2) ,1 ,basicpay, 0 ) ) "남직원급여"
FROM insa
WHERE city = '서울'
GROUP BY buseo, MOD(SUBSTR(ssn, 8, 1), 2) -- 부서로 나누고 남/녀로 또 나눔 두 성별 다 있는 부서는 2번 찍힘
ORDER BY buseo, MOD(SUBSTR(ssn, 8, 1), 2);



-- ROWNUM (의사컬럼? - 내부적으로 사용)


--【형식】 TOP_N 분석
	SELECT 컬럼명,..., ROWNUM
	FROM (
                SELECT 컬럼명,... from 테이블명
                ORDER BY top_n_컬럼명
              )
    WHERE ROWNUM <= n ;
--탑 3이면 n=3

--오더바이 우선으로 덩어리 작성 -> 인라인으로 바꾸기 -> 로넘 찍고 WHERE에 TOP 찍을 숫자 찍어주면됨 (**중간순위만 노려서 출력 못함 BETWEEN 등)
--TOP_N 분석
SELECT ROWNUM, e.*
FROM (
    SELECT *
    FROM emp
    ORDER BY sal DESC
        ) e 
WHERE ROWNUM <= 3 ;

--사실 한번 더 인라인뷰(또는 WITH)로 감싸면 됨
SELECT *
FROM(
        SELECT ROWNUM "row" , e.*
        FROM (
            SELECT *
            FROM emp
            ORDER BY sal DESC
                ) e 
        )
WHERE "row" BETWEEN 3AND 5;



--ORDER BY 절이 있는 곳에서는 ROWNUM  쓰지말자. 어차피 꼬임
--TOP_N 분석은 오더바이 하고 -> 로넘 붙였으니 순위대로 붙은거임 (정렬하고 정렬된 나열에 숫자만 부여한 느낌)
SELECT ROWNUM, emp.*
FROM emp
ORDER BY sal DESC;

-- ROLLUP, CUBE
--롤업: 그룹화하고 그룹에 대한 부분합


SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
--deptno말고 실제 부서이름이 나오게 하고 싶다? => 조인


SELECT  dname, job,  COUNT(*) 
FROM emp e, dept d
WHERE e.deptno = d.deptno
--GROUP BY e.deptno, dname-- 부서번호로 해쳐모이고, 부서이름으로 또 해쳐모이더라고 사실 같으므로 결과도 같다
--GROUP BY dname, job
--GROUP BY ROLLUP ( dname  ) --롤업: 그룹화하고 그룹에 대한 부분합
GROUP BY ROLLUP ( dname , job  ) --부분합 등장
--ORDER BY e.deptno ASC;
ORDER BY dname ;



-- 2) CUBE: ROLLUP 결과에 GROUP BY 조건에 따라 모든 가능한 그룹핑 조합에 대한 결과 출력
SELECT  dname, job,  COUNT(*) 
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY CUBE ( dname , job  ) --job도 집계됨
ORDER BY dname ;


--순위Rank와 관련된 함수 
-- ORDER BY절 필수(정렬을 해야 순위를 매긴다)
--emp 테이블 급여순으로 등수 매겨보자


SELECT ename, sal  ,sal +NVL(comm,0) pay
            ,RANK(  ) OVER ( ORDER BY sal +NVL(comm,0) DESC ) "RANK() 순번"
            ,DENSE_RANK(  ) OVER ( ORDER BY sal +NVL(comm,0) DESC ) "DENSE_RANK() 순번" --중복 카운팅 안해서 4위도 찍힘
            ,ROW_NUMBER(  ) OVER ( ORDER BY sal +NVL(comm,0) DESC ) "ROW_NUMBER() 순번" --그냥 순서대로 1부터 찍음 PAY의 대소와 관계없고 튜플의 위치에 따른듯
            
FROM emp;

--JONES 2850으로 바꾸자

SELECT *
FROM emp
WHERE ename LIKE ('%JONES%') ; --jones가 몇명인지 원랜 이렇게 검사함

UPDATE emp
SET sal = 2850
WHERE empno = 7566 ;

commit;


--순위 함수 사용 예제
--emp에서 부서별로 급여 순위를 매겨보자


SELECT e.*
FROM (
            SELECT emp.*
        --,  RANK() OVER( 쿼리 파티션 절 가능자리 ORDER BY sal+NVL(comm,0) DESC )
         ,  RANK() OVER( PARTITION BY deptno ORDER BY sal+NVL(comm,0) DESC ) 순위 -- 부서별 순위임
         ,  RANK() OVER(ORDER BY sal+NVL(comm,0) DESC ) 전체순위 
            FROM emp
            ) e
ORDER BY "전체순위";

WHERE "순위" BETWEEN 2 AND 3;
--이렇게 간단하게 되는거였네

--insa 사원들을 14명씩 팀...짜보자

SELECT CEIL(COUNT(*)/14) "팀 수"
FROM insa;


--문제) insa 테이블에서 사원수가 가장 많은 부서의 부서명과 사원 수를 찍어보자
SELECT buseo, COUNT(*)
FROM insa
WHERE SUBSTR(ssn,8,1) = 2
GROUP BY buseo
ORDER BY buseo;

SELECT e.*
FROM(
            SELECT buseo, RANK() OVER( ORDER BY COUNT(*) ) br ,COUNT(*) 사원수
            FROM insa
            GROUP BY buseo
         ) e
WHERE br = 1;
--못하겠따
SELECT e.*
FROM (
            SELECT buseo, COUNT(*)
                        , RANK() OVER( ORDER BY COUNT(*) DESC ) 부서순위
            FROM insa
            GROUP BY buseo
--HAVING RANK() OVER( ORDER BY COUNT(*) DESC ) =1 ; --ORA-30483: window  functions are not allowed here
        ) e
WHERE "부서순위" =1;


-- 문제:insa에서 여자사원수가 가장 많은 부서명 및 사원수 출력

SELECT e.*
FROM (
            SELECT buseo, COUNT(DECODE(MOD(SUBSTR(ssn,8,1),2),0,'여' )) 여자사원수
                        , RANK() OVER( ORDER BY COUNT( DECODE(MOD(SUBSTR(ssn,8,1),2),0,'여' )) DESC  ) 부서순위
            FROM insa
            GROUP BY buseo
        ) e
WHERE "부서순위" =1;

--간단하게 할 수 있따
SELECT e.*
FROM (
            SELECT buseo, COUNT(*)
                        , RANK() OVER( ORDER BY COUNT(*) DESC ) 부서순위
            FROM insa
            WHERE MOD(SUBSTR(ssn,8,1),2) = 0
            GROUP BY buseo
--HAVING RANK() OVER( ORDER BY COUNT(*) DESC ) =1 ; --ORA-30483: window  functions are not allowed here
        ) e
WHERE "부서순위" =1;

--문제 ) insa에서 basicpay 가 상위 10%인 사람의 이름과 basicpay 출력

SELECT e.name,e.basicpay
FROM (
            SELECT name, basicpay
                        ,RANK() OVER( ORDER BY basicpay ) pay
            FROM insa
            
          )  e
WHERE pay <= (SELECT COUNT(*) * 0.1 FROM insa) ;           
--서브쿼리는 신이다...

-- 퍼센트 랭크 함수?!
SELECT e.name,e.basicpay
FROM (
            SELECT name, basicpay
                        ,PERCENT_RANK() OVER( ORDER BY basicpay DESC ) pay -- 소수점으로 퍼센티지 계산되어있음
            FROM insa
            
          )  e
WHERE pay <= 0.1 ;

-- 주말 숙제 프로그래머스 JOIN 빼고 풀어보기..?








