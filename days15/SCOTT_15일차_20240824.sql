--트랜잭션

-- 계좌이체 과정
-- A -> B 로 이체할 때
-- 1) A의 계좌에서 금액 인출 작업 (UPDATE문)
-- 2) B의 계좌에 인출한 금액만큼 입금 (UPDATE문)

-- (1 , 2) 작업은 전부 성공(커밋)하던지, 전부 취소(롤백)해야함. 

--DDL 명령이나, DCL 명령은 그 명령 자체가 트랜젝션을 기능까지 포함되고 있다. (오토커밋)
-- 커밋 안하면 프로젝트 문제 생김

--SAVEPOINT
-- SAVEPOINT 명령어는 transaction 내의 한 시점을 표시한다.
-- ROLLBACK TO SAVEPOINT 명령어로 표시 지점까지 ROLLBACK하는데 쓰인다. 긴 작업을 수행하다가 한나의 실수로 인하여 rollback을 한다면 그 동안의 모든 작업이 없어지기 때문에 중간중간에 savepoint로 특정 시점을 표시하는 것이 좋다.
-- savepoint 키워드는 생략 가능하다.
-- savepoint 명령어는 oracle에서만 사용하는 명령어로 다른 DBMS에서는 지원하지 않는다.

CREATE TABLE tbl_dept 
AS ( 
    SELECT *
    FROM dept
);

SELECT *
FROM tbl_DEPT;

--INSERT
insert into tbl_dept values(50,'development','COREA');

SAVEPOINT A;
--Savepoint이(가) 생성되었습니다.

-- 2) UPDATE 
UPDATE tbl_dept
SET loc='ROK'
WHERE deptno = 50;

--ROLLBACK 
ROLLBACK TO A;
-- ROK에서 COREA로 롤백됨

ROLLBACK;
--최근 커밋까지..

--세션A

SELECT *
FROM tbl_dept;
--B에서 업뎃한거 확인 안되는 중

DELETE FROM tbl_dept
WHERE deptno = 40;
-- 한무 로딩.. 화장실 앞에서 ㄱㄷ리는중 ㅋㅋ
-- 옆에서 커밋하자마자 끝남;;

--1 행 이(가) 삭제되었습니다.

COMMIT;

--[패키지]
CREATE OR REPLACE PROCEDURE 계좌이체
()
IS
    예외객체
BEGIN
     
    SELECT (A잔고 확인)
    UPDATE ( A계좌 돈 꺼내기)
    UPDATE ( B계좌 입금)
    :
    :
    COMMIT;

EXCEPTION
    ROLLBACK;
    RAISE 예외발생(-20001, '잔액부족');
END;


CREATE OR REPLACE PACKAGE employee_pkg 
AS
--서브프로그램 (저장 프로시저 2개) 들어가 있는 상황
procedure print_ename(p_empno number); 
procedure print_sal(p_empno number); 
--함수도 추가
FUNCTION uf_age
(
    pssn IN VARCHAR2
    , ptype IN NUMBER
)
RETURN NUMBER;
END employee_pkg; 
--Package EMPLOYEE_PKG이(가) 컴파일되었습니다.
-- 명세서 부분.


--패키지 몸체 부분

-- 패키지 몸체 부분
CREATE OR REPLACE PACKAGE BODY employee_pkg 
AS 
   
      procedure print_ename(p_empno number) 
      is 
         l_ename emp.ename%type; 
       begin 
         select ename 
           into l_ename 
           from emp 
           where empno = p_empno; 
       dbms_output.put_line(l_ename); 
      exception 
        when NO_DATA_FOUND then 
         dbms_output.put_line('Invalid employee number'); 
     end print_ename; 
   
   procedure print_sal(p_empno number) is 
      l_sal emp.sal%type; 
    begin 
      select sal 
       into l_sal 
        from emp 
        where empno = p_empno; 
     dbms_output.put_line(l_sal); 
    exception 
      when NO_DATA_FOUND then 
        dbms_output.put_line('Invalid employee number'); 
   end print_sal;  
   
   FUNCTION uf_age
(
   pssn IN VARCHAR2 
  ,ptype IN NUMBER --  1(세는 나이)  0(만나이)
)
RETURN NUMBER
IS
   ㄱ NUMBER(4);  -- 올해년도
   ㄴ NUMBER(4);  -- 생일년도
   ㄷ NUMBER(1);  -- 생일 지남 여부    -1 , 0 , 1
   vcounting_age NUMBER(3); -- 세는 나이 
   vamerican_age NUMBER(3); -- 만 나이 
BEGIN
   -- 만나이 = 올해년도 - 생일년도    생일지남여부X  -1 결정.
   --       =  세는나이 -1  
   -- 세는나이 = 올해년도 - 생일년도 +1 ;
   ㄱ := TO_CHAR(SYSDATE, 'YYYY');
   ㄴ := CASE 
          WHEN SUBSTR(pssn,8,1) IN (1,2,5,6) THEN 1900
          WHEN SUBSTR(pssn,8,1) IN (3,4,7,8) THEN 2000
          ELSE 1800
        END + SUBSTR(pssn,1,2);
   ㄷ :=  SIGN(TO_DATE(SUBSTR(pssn,3,4), 'MMDD') - TRUNC(SYSDATE));  -- 1 (생일X)

   vcounting_age := ㄱ - ㄴ +1 ;
   -- PLS-00204: function or pseudo-column 'DECODE' may be used inside a SQL statement only
   -- vamerican_age := vcounting_age - 1 + DECODE( ㄷ, 1, -1, 0 );
   vamerican_age := vcounting_age - 1 + CASE ㄷ
                                         WHEN 1 THEN -1
                                         ELSE 0
                                        END;

   IF ptype = 1 THEN
      RETURN vcounting_age;
   ELSE 
      RETURN (vamerican_age);
   END IF;
--EXCEPTION
END uf_age;
  
END employee_pkg; 


SELECT name, ssn, employee_pkg.uf_age( ssn, 1) age
from insa;








