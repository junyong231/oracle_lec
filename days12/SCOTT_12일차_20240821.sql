SELECT * FROM t_member;
SELECT * FROM t_poll;
SELECT * FROM t_pollsub;
SELECT * FROM t_voter;

--멤버 테이블 프라이머리 키 확인
SELECT *  
FROM user_constraints  
WHERE table_name LIKE 'T_M%'  AND constraint_type = 'P';

-- 멤버 추가
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  1,         'admin', '1234',  '관리자', '010-1111-1111', '서울 강남구' );
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  2,         'hong', '1234',  '홍길동', '010-1111-1112', '서울 동작구' );
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  3,         'kim', '1234',  '김준석', '010-1111-1341', '경기 남양주시' );
    COMMIT;

ㄹ. 회원 정보 수정
로그인 -> (홍길동) -> [내 정보] -> 내 정보 보기 -> [수정] -> [이름][][][][][][] -> [저장]
PL/SQL
UPDATE T_MEMBER
SET    MEMBERNAME = , MEMBERPHONE = 
WHERE MEMBERSEQ = 2;
ㅁ. 회원 탈퇴
DELETE FROM T_MEMBER 
WHERE MEMBERSEQ = 2;

-- 설문 등록
   INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
   VALUES             ( 1  ,'좋아하는 여배우?'
                          , TO_DATE( '2024-02-01 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , TO_DATE( '2024-02-15 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                          , 5
                          , 0
                          , TO_DATE( '2023-01-15 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , 1
                    );
-- 항목 추가
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (1 ,'배슬기', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (2 ,'김옥빈', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (3 ,'아이유', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (4 ,'김선아', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (5 ,'홍길동', 0, 1 );      
   COMMIT;

--설문 하나 더 (투표 진행중)
INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
VALUES             ( 2  ,'좋아하는 과목?'
                      , TO_DATE( '2024-08-12 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                      , TO_DATE( '2024-08-28 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                      , 4
                      , 0
                      , TO_DATE( '2024-02-20 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                      , 1
                );
--2번 항목
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (6 ,'자바', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (7 ,'오라클', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (8 ,'HTML5', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (9 ,'JSP', 0, 2 );
   
   COMMIT;

-- 설문 추가 ( 대기중)

   INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
   VALUES             ( 3  ,'좋아하는 색?'
                          , TO_DATE( '2024-09-15 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , TO_DATE( '2024-09-20 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                          , 3
                          , 0
                          , TO_DATE( '2024-03-01 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , 1
                    );
--3번 항목추가
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (10 ,'빨강', 0, 3 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (11 ,'녹색', 0, 3 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (12 ,'파랑', 0, 3 ); 
   
   COMMIT;

-- 전체 조회하기
SELECT *
FROM (
    SELECT  pollseq 번호, question 질문, membername 작성자
         , sdate 시작일, edate 종료일, itemcount 항목수, polltotal 참여자수
         , CASE 
              WHEN  SYSDATE > edate THEN  '종료'
              WHEN  SYSDATE BETWEEN  sdate AND edate THEN '진행 중'
              ELSE '시작 전'
           END 상태 -- 추출속성   종료, 진행 중, 시작 전
    FROM t_poll p JOIN  t_member m ON m.memberseq = p.memberseq
    ORDER BY 번호 DESC
) t 
WHERE 상태 != '시작 전';  -- 시작전인건 안보이게 

--설문 상세보기
SELECT question, membername
               , TO_CHAR(regdate, 'YYYY-MM-DD AM hh:mi:ss')
               , TO_CHAR(sdate, 'YYYY-MM-DD')
               , TO_CHAR(edate, 'YYYY-MM-DD')
               , CASE 
                  WHEN  SYSDATE > edate THEN  '종료'
                  WHEN  SYSDATE BETWEEN  sdate AND edate THEN '진행 중'
                  ELSE '시작 전'
               END 상태
               , itemcount
           FROM t_poll p JOIN t_member m ON p.memberseq = m.memberseq
           WHERE pollseq = 2;
           
--투표창 (항목)
  SELECT answer
           FROM t_pollsub
           WHERE pollseq = 2;
-- 총 참여자 수           
SELECT  polltotal  
    FROM t_poll
    WHERE pollseq = 2;
    
--그래프
SELECT answer, acount
        , ( SELECT  polltotal      FROM t_poll    WHERE pollseq = 2 ) totalCount
        -- ,  막대그래프
        , ROUND (acount /  ( SELECT  polltotal      FROM t_poll    WHERE pollseq = 2 ) * 100) || '%'
     FROM t_pollsub
    WHERE pollseq = 2;
    
-- 투표     
 INSERT INTO t_voter 
    ( vectorseq, username, regdate, pollseq, pollsubseq, memberseq )
    VALUES
    (      1   ,  '김기수'      , SYSDATE,   2  ,     7 ,        3 );
    COMMIT;   
 --투표2
 INSERT INTO t_voter 
    ( vectorseq, username, regdate, pollseq, pollsubseq, memberseq )
    VALUES
    (      2   ,  '홍길동'      , SYSDATE,   2  ,     6 ,        2 );
    COMMIT;       
    

-- 나중에 트리거로 할거지만 총참여자 수 늘리고 , 항목에 대해서 투표한 사람도 늘려줌
  -- 1)         2/3 자동 UPDATE  [트리거]
    -- (2) t_poll   totalCount = 1증가
    UPDATE   t_poll
    SET polltotal = polltotal + 1
    WHERE pollseq = 2;
    
    -- (3)t_pollsub   account = 1증가
    UPDATE   t_pollsub
    SET acount = acount + 1
    WHERE  pollsubseq = 6;
    
    commit;    
    
    
-------------------------------------------------------------------------------------------------------
-- PL/SQL

 /* 멀티 라인 주석 가능 (PL/SQL)*/   

DECLARE -- 생략 가능
    --선언블럭
BEGIN 
    --실행블럭
    
    /*
    SELECT
    UPDATE
    SELECT
    INSERT
    :
    맘대로 가능
    */
    
EXCEPTION --생략 가능
    --예외 처리 블럭
END;
    
-- 1) Anonymous Procedure 익명 프로시저

DECLARE

    -- 변수 상수 등 선언하는 블록..
    vename VARCHAR2(10) ;    -- (  ;  ) 기억..! 컴마 아님.  v는 변수(var)라서 붙임
    vpay NUMBER;
    
    -- 자바 상수 final double PI = 3.141592; 이렇게 했었는데
    -- vpi CONSTRAINT NUMBER = 3.141592; -- sql 이렇게 함
    vpi CONSTANT NUMBER := 3.14;           -- 대입연산자가 := 이거임.. =이 아니라
BEGIN

SELECT ename, sal+NVL(comm,0) pay
            INTO vename, vpay           -- 변수에 저장 INTO..!
FROM emp;
--WHERE empno = 7369;

-- 자바 출력 System.out.printf("%s, %d\n" , vename, vpay);
/*
오류 보고 -
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at line 12
01422. 00000 -  "exact fetch returns more than requested number of rows"
*Cause:    The number specified in exact fetch is less than the rows returned.
*Action:   Rewrite the query or change number of rows requested 여기 졸아서 쌤거 봐야댐
*/

DBMS_OUTPUT.PUT_LINE( vename || ', ' || vpay );

--EXCEPTION
END;
    
-- PL/SQL 에서 fetch returns more than requested number of rows 이면
-- CURSOR 사용해야함 (아직 안배움)
    
    
    
-- 문제) dept 테이블에서 
-- 30번 부서의 부서명을 얻어와서 출력하는  익명프로시저를 작성,테스트    

DECLARE
   -- vdname VARCHAR2(30) ;
   -- 타입이 연동되도록 %TYPE 변수를 쓰자
   
   vdname dept.dname%TYPE; -- 이렇게 하는게 여러모로 유리함..
   
BEGIN

SELECT dname
        INTO vdname
FROM dept
WHERE deptno =30;


DBMS_OUTPUT.PUT_LINE( '우하하' || vdname);

--EXCEPTION
END;
    
--변수는 v 매개변수는 p   붙이자

DESC dept;
    
    
-- 문제 ) 30번 부서의 지역명을 얻어와서 10번 부서의 지역명으로 설정하는 익명프로시저를 작성, 테스트

DECLARE

vloc dept.loc%TYPE;


BEGIN

SELECT loc INTO vloc
FROM dept
WHERE deptno = 30;

UPDATE dept
SET loc = vloc
WHERE deptno = 10;

-- COMMIT; 롤백할거라서..

--EXCEPTION
-- ROLLBACK;

END;

-- 확인    
SELECT *
FROM dept;
 
ROLLBACK;   
    
-- [문제] 10번 부서원 중에 최고급여(sal)를 받는 사원의 정보를 출력.(조회)   
    
    SELECT ROWNUM, e.*
    FROM(
  SELECT *
  FROM emp
  WHERE deptno = 10
  ORDER BY sal DESC
    )e
    WHERE ROWNUM =1 ;
        
-- PL/SQL로도 해보자    
DECLARE
    vmax_sal_10  emp.sal%TYPE;
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vhiredate emp.hiredate%TYPE;
    vdeptno emp.deptno%TYPE;
    vsal emp.sal%TYPE;
    
BEGIN
    
    -- 1) 최고급여 구하기
    SELECT MAX(sal) INTO vmax_sal_10
    FROM emp
    WHERE deptno = 10;
    
    --2) 10번부서이면서 최고급여 받는 사람 정보 각 변수에 넣어주기
    SELECT empno, ename, job, sal, hiredate, deptno INTO vempno, vename, vjob, vsal, vhiredate, vdeptno
    FROM emp
    WHERE sal = vmax_sal_10 AND deptno = 10;
    
    --3) 출력
    DBMS_OUTPUT.PUT_LINE ( vdeptno || '번 부서에서 ' || vename || '가 최고급여 ' || vsal || '받는다');
        
--EXCEPTION
END;
    
    
--PL/SQL (2) ROWTYPE으로 노가다하지 말자..!
DECLARE
    vmax_sal_10  emp.sal%TYPE;
--    vempno emp.empno%TYPE;
--    vename emp.ename%TYPE;
--    vjob emp.job%TYPE;
--    vhiredate emp.hiredate%TYPE;
--    vdeptno emp.deptno%TYPE;
--    vsal emp.sal%TYPE;
    vemprow emp%ROWTYPE;
BEGIN
    
    -- 1) 최고급여 구하기
    SELECT MAX(sal) INTO vmax_sal_10
    FROM emp
    WHERE deptno = 10;
    
    --2) 10번부서이면서 최고급여 받는 사람 정보 각 변수에 넣어주기=> ROWTYPE이므로 vemprow.원래테이블컬럼명 하면 알아서 타입 적용됨
    SELECT empno, ename, job, sal, hiredate, deptno INTO vemprow.empno, vemprow.ename, vemprow.job, vemprow.sal, vemprow.hiredate, vemprow.deptno
    FROM emp
    WHERE sal = vmax_sal_10 AND deptno = 10;
    
    --3) 출력
    DBMS_OUTPUT.PUT_LINE ( vemprow.deptno || '번 부서에서 ' || vemprow.ename || '가 최고급여 ' || vemprow.sal || '받는다');
        
--EXCEPTION
END;
    
    
-- := 대입연산자 사용법

DECLARE
    va NUMBER := 1;
    vb NUMBER ;
    vc NUMBER := 0;
BEGIN
    vb := 100;
    vc := va + vb;
    
    DBMS_OUTPUT.PUT_LINE( vc );
--EXCEPTION
END;
    
    
-- PL/SQL에서의 제어문
-- 자바:  if(조건식) {  } 

--위와 완전히 같은 식 

IF  /*조건식 자리, () 생략 가능*/
THEN -- 자바로 치면 {

END IF; --자바로 치면 }
    
--else 추가?
IF  /*조건식 자리, () 생략 가능*/
THEN 

ELSE

END IF; 
    
    
    
-- 자바:  if(조건식) {  }  else if (조건식) { }   
    
IF 조건식 THEN
ELSIF 조건식 THEN
ELSIF 조건식 THEN
ELSIF 조건식 THEN
ELSIF 조건식 THEN
ELSE
END IF;
    
--문제) 하나의 정수를 입력받아서 홀/짝 출력

DECLARE
    vnum NUMBER(4) := 0;
    vresult VARCHAR2(6) := '홀수';
BEGIN
    vnum := :bindNumber; -- 바인딩 변수. ? (대화상자로 입력받는다 ?)
  
    IF  MOD(vnum, 2) = 0
    THEN 
        vresult := '짝수';
    ELSE
        vresult := '홀수';
    END IF;   
    
    DBMS_OUTPUT.PUT_LINE( vresult );

--EXCEPTION
END;
    
    
 -- [문제] PL/SQL   IF문 연습문제...
--  국어점수 입력받아서 수우미양가 등급 출력... ( 익명프로시저 )   
    
    
DECLARE
    vkor NUMBER(3);
    vrank VARCHAR2(3);
BEGIN
    vkor := :bindNumber;
    
    IF vkor >= 90 THEN vrank := '수';
    ELSIF vkor >= 80 THEN vrank := '우';
    ELSIF vkor >= 70 THEN vrank := '미';
    ELSIF vkor >= 60 THEN vrank := '양';
    ELSE vrank := '가';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE( vkor || '점 ' || vrank || ' 입니다' );
--EXCEPTION
END;
    
---풀이2

DECLARE
    vkor NUMBER(3);
    vrank VARCHAR2(3);
BEGIN
    vkor := :bindNumber;
    
    IF ( vkor BETWEEN 0 AND 100)  THEN 
    -- 수~ 가
    vrank := CASE TRUNC(vkor/10)
                    WHEN 10 THEN '수'
                    WHEN 9 THEN '수'
                    WHEN 8 THEN '우'
                    WHEN 7 THEN '미'
                    WHEN 6 THEN '양'
                    ELSE '가'
                END;
    DBMS_OUTPUT.PUT_LINE( vkor || '점 ' || vrank || ' 입니다' );
    ELSE
    DBMS_OUTPUT.PUT_LINE(' 국어 점수 0 ~ 100 사이 입력 ! ');
    END IF;
    
    
--EXCEPTION
END;
    
    
-- WHILE문.
--자바
while(조건식) {
   // 반복구문
   
}
-- PL/SQL
WHILE(조건식) LOOP -- {
END LOOP;-- }

--자바
while (true) {
    if(조건식) break;
}

--PL/SQL
LOOP
    EXIT WHEN (조건식);
END LOOP;
    
    
--문제 1~10까지 합 출력

DECLARE
    vnum NUMBER := 1;
    vsum NUMBER := 0;
    
BEGIN
    
    WHILE (vnum<=10)  LOOP
    IF (vnum<=9)THEN
    DBMS_OUTPUT.PUT( vnum || '+' );
    ELSE
    DBMS_OUTPUT.PUT( vnum );
    END IF;
    
    vsum := vsum + vnum;
    vnum := vnum+1;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( '=' || vsum );
    
--EXCEPTION
END;
    
-- LOOP   END LOOP  
    
DECLARE
    vnum NUMBER := 1;
    vsum NUMBER := 0;
    
BEGIN
    
    LOOP
    EXIT WHEN (vnum= 11) ;
    
    IF (vnum<=9)THEN
    DBMS_OUTPUT.PUT( vnum || '+' );
    ELSE
    DBMS_OUTPUT.PUT( vnum );
    END IF;
    
    vsum := vsum + vnum;
    vnum := vnum+1;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( '=' || vsum );
    
--EXCEPTION
END;    
    
    
 -- for문.
 --1~10까지 합 
 
 DECLARE
    --vi NUMBER ;           반복변수는 여기서 선언 안하고 사용해도 된다. 진짜 for문 i같네
    vsum NUMBER := 0;
 
 BEGIN
 
-- FOR 반복변수 IN [reverse] (시작값 .. 끝값)
-- LOOP
-- 
-- END LOOP;
    
 FOR vi IN 1 .. 10
 LOOP
 DBMS_OUTPUT.PUT_LINE( vi || '+' );
 vsum := vsum + vi;
 END LOOP;
 
 DBMS_OUTPUT.PUT_LINE( '=' || vsum );
 
 --EXCEPTION
 END;
    
-- GO TO   (쓰지마)

 declare 
      chk number := 0; 
    begin 
    <<restart>> 
      --dbms_output.enable; 
      chk := chk +1; 
      dbms_output.put_line(to_char(chk)); 
      if chk <> 5 then 
        goto restart; 
     end if; 
   end;     
    
    --GO TO  샘플2
  --DECLARE
BEGIN
  --
  GOTO first_proc;
  --
  <<second_proc>>
  DBMS_OUTPUT.PUT_LINE('> 2 처리 ');
  GOTO third_proc; 
  -- 
  --
  <<first_proc>>
  DBMS_OUTPUT.PUT_LINE('> 1 처리 ');
  GOTO second_proc; 
  -- 
  --
  --
  <<third_proc>>
  DBMS_OUTPUT.PUT_LINE('> 3 처리 '); 
--EXCEPTION
END;  
    
  
  -- 문제) 1조: while만 써서 구구단
  
  DECLARE
    vdan NUMBER := 2;
    vi NUMBER := 1;
 
  BEGIN
  
  WHILE vdan <= 9 LOOP
    vi := 1;
        WHILE vi <= 9 LOOP
        DBMS_OUTPUT.PUT( vdan || 'x' || vi || '=' || RPAD ( vdan*vi , 4, ' ') );
        vi := vi+1;
        END LOOP;
  DBMS_OUTPUT.PUT_LINE('');
  vdan := vdan +1;
  END LOOP;
  --EXCEPTION
  END;
  

  
  
  -- 문제) 2조: for문 써서 구구단
  
--DECLARE
--  vdan NUMBER:= 0;
--  vhang NUMBER:= 0;

BEGIN

FOR vdan IN 2 .. 9
LOOP
DBMS_OUTPUT.PUT_LINE( vdan || '단' );
         
         FOR vhang IN 1 .. 9
         LOOP
            DBMS_OUTPUT.PUT( vdan || 'x' || vhang || '=' || vdan*vhang );
            DBMS_OUTPUT.PUT_LINE( '' );
         END LOOP;
        
END LOOP;

  --EXCEPTION
  END;
    
 -- FOR문을 사용한 SELECT (기억)

-- DECLARE
 BEGIN
 
 /*
 FOR 반복변수 IN (서브쿼리) LOOP
 
 END LOOP;
 */

--레코드 한줄 통으로 : verow
 FOR verow IN (SELECT ename, hiredate, job FROM emp ) LOOP -- 레코드가 여러줄임... 아까 언급됐던 커서 필요 (자동 사용 : 암시적 커서)
    DBMS_OUTPUT.PUT_LINE( verow.ename || '/' || verow.hiredate || '/' || verow.job ); 
 END LOOP;
 
 --EXCEPTION
 END;
    
    
-- %TYPE , %ROWTYPE, RECORD 변수 설명.    
    
 SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay
 FROM dept d JOIN emp e ON d.deptno = e.deptno
 WHERE empno = 7369;

-- %TYPE 변수

DECLARE
    vdeptno dept.deptno%TYPE;
    vdname dept.dname%TYPE;
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vpay NUMBER;
BEGIN
    SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay
                INTO vdeptno , vdname, vempno, vename, vpay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
    
    DBMS_OUTPUT.PUT_LINE( vdeptno || ', ' || vdname || ', ' || vempno || ', ' || vename || ', ' || vpay );
--EXCEPTION
END;
    
-- %ROWTYPE 형 변수
DECLARE
    verow emp%ROWTYPE;
    vdrow dept%ROWTYPE;
    vpay NUMBER;
BEGIN
    SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay
                INTO vdrow.deptno , vdrow.dname, verow.empno, verow.ename, vpay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
    
    DBMS_OUTPUT.PUT_LINE( vdrow.deptno || ', ' || vdrow.dname || ', ' || verow.empno || ', ' || verow.ename || ', ' || vpay );
--EXCEPTION
END;
    
--RECORD형 변수

--SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay -- dept테이블 , emp테이블 섞여있으나 RECORD로 하나의 레코드로 반영 가능
--이런 형태의 데이터를 저장할 레코드 타입 선언
-- (사용자 정의 구조체 타입 선언)
DECLARE
TYPE EmpDeptType IS RECORD
(
        deptno dept.deptno%TYPE,
        dname dept.dname%TYPE, 
        empno emp.empno%TYPE,
        ename emp.ename%TYPE, 
        pay NUMBER 
);
vedrow EmpDeptType; --하나의 새로운 자료형 이름이 됨
BEGIN
    SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay
                --INTO vedrow.deptno , vedrow.dname, vedrow.empno, vedrow.ename, vedrow.pay 둘다 됨
                INTO vedrow
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
    
    DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname || ', ' || vedrow.empno || ', ' || vedrow.ename || ', ' || vedrow.pay );
--EXCEPTION
END;
    
-- INSA에서 basicpay+sudang =pay  페이가 200 넘으면 0.02% 세금, 250넘으면 0.025% 물리기

SELECT num, name, basicpay+sudang 세전
FROM insa;
    
DECLARE
    --virow insa%ROWTYPE;
    vname insa.name%TYPE;
    vpay NUMBER;
    vtax NUMBER;
    vsil NUMBER;
    
BEGIN

SELECT name, basicpay+sudang
    INTO vname, vpay
FROM insa
WHERE num = 1001;

IF vpay > 2500000 THEN vtax := vpay * 0.025;
ELSIF vpay > 2000000 THEN vtax := vpay * 0.02;
ELSE vtax := 0;
END IF;

vsil := vpay - vtax;

DBMS_OUTPUT.PUT_LINE(vname || '   ' || vpay || ' ' || vtax || '   ' || vsil); 

--EXCEPTION
END;
    
    
----커서 == PL/SQL의 SELECT 
-- 바구니 ?

--급여 5등까지 뽑기: 12명 디센딩  하고 ROWCOUNT 5될때까지 커서 읽기.. ?





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
    -- 2) 커서 오픈 SELECT문 실행 -- (컨트롤 F11처럼)
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

    
-----FOR문을 사용하는 암시적 커서-----

DECLARE
BEGIN    
    FOR vedrow IN (SELECT d.deptno, dname, empno, ename, sal + NVL(comm,0) pay
        FROM dept d JOIN emp e ON d.deptno = e.deptno)
    LOOP
    DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname 
    || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  ||
    ', ' ||  vedrow.pay );
    END LOOP;
 END;       
 
