--SCOTT
--오라헬프에서 CHAR에서 RR YY 차이보고 오기
--오라클 연산자 특_ WHERE절에서만 사용됨
--복습) 산술연산자 나머지연산자 .. MOD(10,3) = 1
--몫 구하기 : 절삭 FLOOR(10/3)
SELECT FLOOR(10/3) 몫
FROM dual;
--6) SET(집합) 연산자
집합 연산의 대상이 되는 두 컬럼의 수가 같고 대응되는 컬럼끼리 데이터타입 같아야 함



    1) UNION     합집합
    
    SELECT COUNT(*)
    FROM (
    SELECT name, city, buseo
        --,COUNT() -- 오류난다 ORA-00937: not a single-group group function
    FROM insa
    WHERE city = '인천' AND buseo ='개발부'
    ) i ;
    
    --UNION
    --부서 개발부이고 출신지 인천인 사람들 합집합?
    SELECT name, city, buseo
    FROM insa
    WHERE city = '인천'
    UNION --교집합 두번 걸리는 애들(인천+개발부 6명) 한 번 빼줌
    SELECT name, city, buseo
    FROM insa
    WHERE buseo ='개발부';
    
    2) UNION ALL 합집합
    --부서 개발부이고 출신지 인천인 사람들 합집합?
    SELECT name, city, buseo
    FROM insa
    WHERE city = '인천'
    -- ORDER BY buseo --ORA-00933: SQL command not properly ended 명령문이 종료 안됨..? 그럼 정렬하려면?
    UNION ALL --교집합 중복 허용 (23명 나옴) 
    SELECT name, city, buseo
    FROM insa
    WHERE buseo ='개발부'
    ORDER BY buseo; -- 얘는 마지막에 넣을 수 있음
    
    SELECT ename,hiredate, dname      --TO_CHAR(deptno) dept     --deptno || ' '
    FROM emp, dept
    WHERE emp.deptno = dept.deptno
    UNION
    SELECT name,ibsadate,buseo
    FROM insa;
    
    --JOIN 조인
    사원이름, 사원명, 입사일자, 부서명 -> 조회하려는데
    emp에는 사원이름, 사원명, 입사일자
    dept에는 부서명
    --> 따로 떨어져있음 = 합치자 -> 부서명을 
    
    사원테이블(자식테이블)
    사원번호/사원명/입사일자/잡/기본급/커미션/부서번호(FK) --/부서명/부서장/내선번호
    
    부서테이블 ->먼저(부모테이블)만들기
    부서번호(PK)/부서명/부서장/내선번호
    
    => 이렇게 쪼개져 있다 = 정규화
    => 다시 합쳐서 가져오는게 조인? FROM emp, dept; 이것만으로 조인임
    
    SELECT empno, ename, hiredate, dname , dept.deptno -- deptno넣으니 오류: ORA-00918: column ambiguously defined 컬럼이 애매하게 선언되어있다.emp,dept 전부 deptno갖고있다
    FROM emp, dept      --조인
    WHERE emp.deptno = dept.deptno; -- 조인조건
    
   --알리아스(별칭)부여로 더 간편하게 할 수 있다
    SELECT empno, ename, hiredate, dname , d.deptno 
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    --완전 동일. 
    SELECT empno, ename, hiredate, dname , d.deptno 
    FROM emp e JOIN dept d ON e.deptno = d.deptno;
    
    3) INTERSECT 교집합
    
    SELECT name, city, buseo
    FROM insa
    WHERE city = '인천'
    INTERSECT
    SELECT name, city, buseo
    FROM insa
    WHERE buseo ='개발부'
    ORDER BY buseo; 
   
    
    4) MINUS     차집합
    
    SELECT name, city, buseo
    FROM insa
    WHERE buseo = '개발부'
    MINUS
    SELECT name, city, buseo
    FROM insa
    WHERE city ='인천'
    ORDER BY buseo; 


-- 만약 city라는 컬럼이 없는 경우인데 유니온 해야한다면?
    SELECT name, NULL city, buseo -- 그냥 NULL로 갯수만 맞춰주면됨 
    FROM insa
    WHERE buseo = '개발부'
    UNION
    SELECT name, city, buseo
    FROM insa
    WHERE city ='인천'
    ORDER BY buseo; 

어쨌든 컬럼수 , 타입수 동일해야함을 기억.. (+오더바이는 마지막)

[계층적 질의 연산자] PRIOR, CONNECT_BY_ROOT

IS [NOT] NAN  (NAN = NOT A NUMBER)
IS [NOT] INFINITE   무한

--
[오라클에서 제공하는 함수 function]
-- 1) 단일행 함수 : 행 하나 당 결과값 리턴.
    -문자
    1) UPPER, LOWER, INITCAP
    SELECT UPPER(dname),LOWER(dname),INITCAP(dname)
    FROM dept;
    
    2) LENGTH 길이
    SELECT dname, LENGTH(dname)
    FROM dept;
    
    3) CONCAT 문자열 연결
    4) SUBSTR 자르기
    SELECT SUBSTR(ssn,8,14) --뒷자리만 가져오기
    FROM insa;
    
    5) INSTR 문자열에서 지정된 문자값의 위치를 숫자로 리턴
    SELECT dname, INSTR(dname,'S',2) --2부터 출발
    FROM dept;
    
    -- 지역번호만,앞자리만 추출
    SELECT TEL
        , SUBSTR(TEL,0,INSTR(TEL,')') -1 ) 지역번호
        , SUBSTR(TEL,INSTR(TEL,')')+1,INSTR(TEL,'-')-INSTR(TEL,')')-1)  앞자리
        , SUBSTR( TEL, INSTR(TEL,'-')+1 ) 뒷자리
    FROM TBL_TEL;
    --변수를 안쓰니 난리가 나네
    
    6) RPAD LPAD
    SELECT RPAD('Corea',12,'*') RPAD -- 12자리 확보했는데 corea 5자리찍음 , 남은 7자리 *로 채움 
    FROM dual;

    SELECT ename, sal + NVL(comm,0) pay
            ,LPAD(sal + NVL(comm,0),10, '*')
    FROM emp;
    
    7)RTRIM (LTRIM) 
    SELECT RTRIM('xyBROWINGyxXxy','xy') "RTRIM example"  --문자열 속에서 우측부터 찾아서 xy 제거 xyxyxy '붙어있었다면' 다지움
           , LTRIM('  zzz xxx xz', ' ') "no" 
           , '[' || TRIM(' XXXX  ') || ']' "TRIM"
    FROM dual;

    8) ASCII ,CHR
    SELECT ASCII('Korea'), CHR(65) CHR -- 첫글자 아스키, 숫자 아스키 해당하는 문자로
    FROM dual;
    
    9) GREATEST, LEAST == MAX/MIN 나열된 애들 중 최대최소 반환
    
    SELECT GREATEST(1,2,4,5) , LEAST(1,2,3,6), GREATEST('A','B') g -- 아스키 기준) 문자도 되긴하네
    FROM dual;

    10) VSIZE 바이트 크기
    SELECT VSIZE(1),VSIZE('A'),VSIZE('ㅎ')
    FROM dual;
    

    -숫자
    1) ROUND(a,b)  반올림함수..
    SELECT 3.141592 ㄱ
            ,ROUND(3.141592,2) ㄴ -- b+1 자리에서 반올림
            ,ROUND(3.141592,3) ㄷ -- 4번째 자리에서 반올림
            ,ROUND(12345.6789,-2) --  . 기준 -2해서 '4'에서 반올림 12300
            ,ROUND(sysdate)
            ,sysdate
    FROM dual;
    
    2)FLOOR () 무조건 소수 첫번째자리부터 절삭 ,, 날짜도 절삭됨
    SELECT FLOOR(3.141592)--3
           ,FLOOR(3.9303)--3
    FROM dual;
    
    3) TRUNC
    SELECT TRUNC(3.141592)
          ,TRUNC(3.941592)
          ,TRUNC(314.1592)
          ,TRUNC(3.141592, 3) -- 특정위치부터 절삭
    FROM dual;
    
    4) CEIL 절상
    SELECT CEIL(3.14), CEIL(3.92)
    FROM dual;
    
    SELECT CEIL(161/10) --게시판 페이지 수 같은건 절상이 필요함
    FROM dual;
    
    5) ABS 절댓값
    SELECT ABS(-10)
    FROM dual;
    
    6)SIGN() 부호 따라 1 0 -1 
    SELECT SIGN(100), SIGN(0), SIGN(-203)
    FROM dual;
    
    7)POWER() 제곱
    SELECT POWER(2,3) --2의 3승
    FROM dual; 
    
    -날짜
    1) SYSDATE
    SELECT SYSDATE "SYSDATE" --출력은 연월일이지만 시간(초)까지 리턴한거임
    FROM dual;
    
    2) ROUND(반올림) ,TRUNC(절삭)
    SELECT ROUND(SYSDATE)  "정오 기준 반올림" , TRUNC(SYSDATE)
    FROM dual;
    
    SELECT ROUND(SYSDATE, 'DD') "일 기준 정오 = 기본값"
         ,ROUND(SYSDATE, 'MONTH') "월 기준 15일 기준"
         ,ROUND(SYSDATE, 'YEAR') "년 기준 6개월!"
    FROM dual;
    
    SELECT SYSDATE 기본
--        , TO_CHAR(SYSDATE, 'ds ts')
--        , TRUNC( SYSDATE )
--        , TO_CHAR(TRUNC( SYSDATE ), 'ds ts')
--        , TRUNC(SYSDATE, 'DD') tr  -- 시간/분/초 절삭
--        , TO_CHAR(TRUNC(SYSDATE, 'DD'), 'ds ts') tr2  -- 시간/분/초 절삭
          , TO_CHAR( TRUNC( SYSDATE, 'MONTH'),'DS TS') "달 기준 절삭"
          
    FROM dual;
    
    --날짜에 산술연산자 사용 ?
    SELECT SYSDATE -3 "DATE" -- '일'이 변함
    FROM dual;
    
    SELECT SYSDATE + ( 2/24) "DATE" -- 시간 바꾸기 (두시간 뒤)
    FROM dual;
    
    --SELECT SYSDATE - 날짜 해버리면 두 날짜 사이의 간격이 출력됨
    
    SELECT ename,CEIL(SYSDATE - hiredate) +1 
    FROM emp;
    
    --문제_ 개강일로부터 현재 며칠째인가? *몇일이 지났는가?
    
    SELECT SYSDATE,TRUNC(SYSDATE) - TRUNC(TO_DATE('2024-07-01'))
    FROM dual;
    
    -- 근무 개월 수? 
    SELECT ename, hiredate, SYSDATE 
        , MONTHS_BETWEEN( SYSDATE, hiredate ) "근무 개월 수"
        , MONTHS_BETWEEN( SYSDATE, hiredate )/12 "근무 년수"
    FROM emp;
    
    SELECT SYSDATE
        ,SYSDATE +1
        ,ADD_MONTHS(SYSDATE,1) M -- year는 없다 12이용
        ,ADD_MONTHS(SYSDATE,-1) m2 -- 한달전 
        ,ADD_MONTHS(SYSDATE,-12) m3 -- 일년전 
    FROM dual;
    
    --LASTDAY
    SELECT SYSDATE
        ,LAST_DAY(SYSDATE)--24/8/31
        ,TO_CHAR(LAST_DAY(SYSDATE),'DD')
        ,TO_CHAR(TRUNC( SYSDATE , 'MONTH'), 'DAY')
        ,ADD_MONTHS(TRUNC(SYSDATE, 'MONTH'), 1) -- 1이 1달뒤였네
    FROM dual;
    
    SELECT SYSDATE
            ,NEXT_DAY(SYSDATE,'일') s -- 돌아오는 해당 날짜..
            ,NEXT_DAY(SYSDATE,'금')
            ,NEXT_DAY(NEXT_DAY(SYSDATE,'목'),'목') --돌아오는 목의 돌아오는 목 (2주뒤 ㅋ)
            ,NEXT_DAY(SYSDATE,'월')
    FROM dual;
    
    -- 문제) 10월 첫번째 월요일날 휴강하다면, 그 날이 며칠인지 알아보자
    
    SELECT NEXT_DAY(ADD_MONTHS(TRUNC(SYSDATE,'MONTH'),2),'월')
             , NEXT_DAY(TO_DATE('24/10/01'),'월')
    FROM dual;
    
    --커렌트데이트는 현재 session의 날짜 정보가 나옴 ,타임스탬프는 밀리세컨까지
    SELECT CURRENT_DATE , SYSDATE , CURRENT_TIMESTAMP
    FROM dual;
    
    
    -변환
    
    SELECT '1234'
        ,TO_NUMBER('1234') --숫자는 우측정렬
    FROM dual;
    
    --TO_CHAR(NUMBER)/ TO_CHAR(CHAR)/TO_CHAR(DATE) 문자로 변환하는 함수
    SELECT num, name
            ,basicpay, sudang
            ,basicpay + sudang PAY --세자리마다 컴마 찍고 싶다면?
            ,TO_CHAR(basicpay + sudang, 'L9G999G999D00') PAY_ --G나 (,)를 써도 되지만 섞어쓰면 안됨
    FROM insa;
    
    
    SELECT TO_CHAR(100, 'S9999')
            ,TO_CHAR(-100, '9999s')
            ,TO_CHAR(100, '9999MI')
            --신기한 것들 많네
            ,TO_CHAR(-100, '9999PR')
            ,TO_CHAR(100, '9999PR')
    FROM dual;
    
    
    SELECT sal + NVL(comm,0) PAY
        ,TO_CHAR( (sal + NVL(comm,0) ) *12 , '9,999,999L')
        ,TO_CHAR( (sal + NVL(comm,0) ) *12 , '9G999G999D00')
    FROM emp;
    
    SELECT name, TO_CHAR( ibsadate , 'YYYY"년" MM"월" DD"일 "DAY' ) --""로 문자열도 끼워넣을 수 있다
    FROM insa;
    
    SELECT *
    FROM insa
    WHERE TO_CHAR(ibsadate, 'YYYY') = 1998; --그냥 해봄
    
    
    -일반
    --NVL 시리즈
    
    -- COALESCE
    SELECT ename,sal,comm, sal+comm
        , sal + NVL(comm,0) pay
        , sal + NVL2(comm,comm,0) pay
        , COALESCE(sal+comm, sal, 0) ca -- 나열해놓은 값 중 널 아닌 값 출력 : PAY 뽑아보고 널나오면 sal만 뽑아보고 걔도 널이면 걍 0뽑기
    FROM emp;
    
    
    
    --제일 중요 DECODE, CASE ★★★
    
    SELECT name, ssn, SUBSTR(ssn,8,1) 성별,NVL2( NULLIF ( MOD(SUBSTR(ssn,-7,1),2) ,1 ), '여자', '남자') GENDER
    FROM insa; --이게 이제까지 배운대로 풀이고
    
    -- If 문 == DECODE()
    -- FROM 절 외에 사용 가능
    --비교 연산문 =만 가능하다 if (a==b) 이거밖에 안되는 느낌
    --a=b가 아니라면NULL
    --DECODE 함수의 확장 함수 : CASE ()
    SELECT name, ssn, DECODE(SUBSTR(ssn,8,1),1,'남자',2,'여자') GENDER --마지막은 else..(생략가능하지만)
        , DECODE(MOD(SUBSTR(ssn,8,1),2),0,'여','남')
    FROM insa;
    
    --문제 emp테이블에서 기본급을 PAY의 10%만큼 인상시키기
    -- 10번 부서원 15% , 20번 10%, 그외 20%
    SELECT deptno,ename,sal,comm,sal + NVL(comm,0) PAY, (sal + NVL(comm,0)) * 1.1 "10% 인상됨" 
        ,DECODE(deptno,10,(sal + NVL(comm,0)) * 1.15
                ,20,(sal + NVL(comm,0)) * 1.1
                ,(sal + NVL(comm,0)) * 1.2) "인상급여"
        , (sal+NVL(comm,0)) * DECODE(deptno, 10, 1.15, 20, 1.1, 1.2) "간략버전 ㄷㄷ"        
                
    FROM emp;
   
    -- CASE 는 DECODE의 확장. =뿐만 아닌 범위 비교도 가능,, ()는 없다
    -- 조건문 연결시 (WHEN) 컴마 사용하지 않는다
    -- CASE 문은 반드시 END로 끝내야 한다.!
    -- WHEN 끝에 결과값에는 NULL을 쓰지 않는다
    
    SELECT name, ssn, DECODE(SUBSTR(ssn,8,1),1,'남자',2,'여자') GENDER --마지막은 else..(생략가능하지만)
        , DECODE(MOD(SUBSTR(ssn,8,1),2),0,'여','남') "줄인 식"
        , CASE MOD(SUBSTR(ssn,8,1),2) WHEN 1 THEN '남성'
                                     -- WHEN 0 THEN '여성'
                                    ELSE '여성'
                                      
        END "GENDER(CASE)"
    FROM insa;
    
    
    SELECT deptno,ename,sal,comm,sal + NVL(comm,0) PAY, (sal + NVL(comm,0)) * 1.1 "10% 인상됨" 
        , CASE deptno WHEN 10 THEN ( sal + NVL(comm,0) ) * 1.15
                      WHEN 20 THEN ( sal + NVL(comm,0) ) * 1.1
                      ELSE ( sal + NVL(comm,0) ) * 1.2
        END "인상됨"
        ,( sal + NVL(comm,0) ) * CASE deptno WHEN 10 THEN 1.15                      
                                             WHEN 20 THEN 1.1
                                             ELSE 1.2
        END "인상됨2" --이 코드도 가능한 이유는 case가 함수이기 때문 
                
    FROM emp;
    
-- 2) 복수행 함수 (그룹함수)
-- 그룹 당 하나의 결과를 출력한다

-- * 카운트하면 NULL도 셈
    SELECT COUNT(*), COUNT(ename), COUNT(sal), COUNT(comm)
           --,sal 집계함수와 일반열을 같이 쓸 수 없다.
           ,SUM(sal)
           ,SUM(sal)/COUNT(*) AVG_SAL 
           ,SUM(comm)/COUNT(*) AVG_SAL 
           ,AVG(comm) 
           ,MAX(sal)
           ,MIN(sal)
           --다른 이유 : AVG는 평균 셀 때 NULL인 애들은 분모로 취급안함
    FROM emp;

    SELECT *
    FROM emp;

--총 사원수 조회
--각 부서별 사원수 조회

SELECT COUNT(
FROM emp;
WHERE deptno=10;
