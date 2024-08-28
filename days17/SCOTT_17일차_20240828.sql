-- 작업스케줄러 

--데이터베이스 내에 생성한 프로시저, 함수들에 대해 데이터베이스 내의 스케쥴러에 지정한 시간에 자동으로 작업이 진행될 수 있도록 하는 기능이다.

-- 1) DBMS_JOB 패키지 (***)
-- 2) DBMS_SCHEDULER 패키지 ( 10g 이후 추가됨 )


-- 1단계 ) 자동으로 실행되어야 하는 프로시저 , 함수 준비
-- 2단계 ) 스케줄 설정
-- 3단계 잡 생성/삭제/중지 기능 체크

CREATE TABLE tbl_job
(
    seq NUMBER
    , insert_date DATE
    
)
--Table TBL_JOB이(가) 생성되었습니다.

CREATE OR REPLACE PROCEDURE up_job
-- ()
IS
    vseq NUMBER;
BEGIN
    
    SELECT NVL( MAX(seq) , 0 ) +1 INTO vseq
    FROM tbl_job;

    INSERT INTO tbl_job VALUES ( vseq , sysdate );
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
    DBMS_OUTPUT.PUT_LINE ( SQLERRM );
END;
--Procedure UP_JOB이(가) 컴파일되었습니다.

-- 잡 등록 ? DBMS_JOB.SUBMIT 프로시저 사용해서 ..

SELECT *
FROM user_jobs;
--등록된 job 조회 ( 아직 아무것도 없음 )

-- 익명 프로시저 - 잡 등록
DECLARE
  vjob_no NUMBER;
BEGIN
    DBMS_JOB.SUBMIT(
         job => vjob_no
       , what => 'UP_JOB;'
       , next_date => SYSDATE
       -- , interval => 'SYSDATE + 1'  하루에 한 번  문자열 설정
       -- , interval => 'SYSDATE + 1/24'
       -- , interval => 'NEXT_DAY(TRUNC(SYSDATE),'일요일') + 15/24'
       --    매주 일요일 오후3시 마다.
       -- , interval => 'LAST_DAY(TRUNC(SYSDATE)) + 18/24 + 30/60/24'
       --    매월 마지막 일의   6시 30분 마다..
       , interval => 'SYSDATE + 1/24/60' -- 매 분 마다       
    );
    COMMIT;
     DBMS_OUTPUT.PUT_LINE( '잡 등록된 번호 : ' || vjob_no );
END;

--PL/SQL 프로시저가 성공적으로 완료되었습니다.

SELECT *
FROM user_jobs;
-- 잡 등록됨

SELECT seq, TO_CHAR( insert_date , 'DL TS' )
FROM tbl_job
ORDER BY seq;
-- 1분마다 찍힘

--잡 중지 ? : DBMS_JOB_BROKEN

BEGIN
    DBMS_JOB.BROKEN( 1 , true ); -- 숫자는 잡 번호임
    COMMIT;
END;
--PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 재실행?
BEGIN
    DBMS_JOB.BROKEN( 1 , false );
    COMMIT;
END;
--PL/SQL 프로시저가 성공적으로 완료되었습니다.


--잡의 실행 주기와 상관없이 잡 실행 ? ****
BEGIN
    DBMS_JOB.RUN(1);
    COMMIT;
END;
--2024년 8월 28일 수요일 오전 9:30:39 원래 28초마다 찍혔는데 39도 찍힘


-- 잡 삭제
BEGIN 
    DBMS_JOB.REMOVE(1);
    COMMIT;
END;

--잡 속성 변경: DBMS_JOB.CHANGE
