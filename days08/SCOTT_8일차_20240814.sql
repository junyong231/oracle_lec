--게시판을 만들기 위한 테이블 생성 ?
--테이블명: tbl_board
--컬럼 : 글번호, 작성자, 비밀번호, 글제목, 글내용, 작성일, 조회수 등등..
   
    -- CREATE [GLOBAL TEMPORARY ] => 임시 테이블
CREATE TABLE SCOTT.tbl_board
(
    seq NUMBER(38) NOT NULL PRIMARY KEY
    ,writer VARCHAR2( 20) NOT NULL
    ,password VARCHAR2(20) NOT NULL
    ,title VARCHAR2(100) NOT NULL
    ,content CLOB
    ,regdate DATE DEFAULT sysdate

); 

DROP SEQUENCE  seq_tblboard;

CREATE SEQUENCE  seq_tblboard
    INCREMENT BY 1 --1씩 증가
    START WITH 1 --1부터 시작
    --MAX,MIN VALUE, CYCLE생략
    -- MIN 밸류 뜻: 사이클 돌면 시작하는 값
    NOCACHE;
    
    SELECT *
    FROM user_sequences;
    -- user_tables 같이 시퀀스 확인 가능
    
    SELECT *
    FROM user_tables
    WHERE table_name LIKE 'TBL_B%';
    --테이블 확인
    
    --테이블 생성 수정 삭제 <CREATE ALTER DROP> 
    
    DROP TABLE tbl_board CASCADE CONSTRAINTS;
    
    DESC tbl_board;
    
    --게시글 쓰기 (작성) 쿼리
    INSERT INTO tbl_board ( seq,writer, password,title,content) VALUES (seq_tblboard.NEXTVAL, '홍길동', '1234', '우하하', '나는 홍길동이다'); 
    INSERT INTO tbl_board ( seq,writer, password,title,content) VALUES (seq_tblboard.NEXTVAL, '성춘향', '1234', '우하하', '나는 성춘향이다'); 
     INSERT INTO tbl_board VALUES (seq_tblboard.NEXTVAL, '일지매', '1234', '우하하', '나는 일지매이다', sysdate); 
    -- 시퀀스 만들었으니 번호표 뽑기로 게시글번호 대체함
    
    ROLLBACK;
    
    SELECT *
    FROM tbl_board;
    
    SELECT seq_tblboard.CURRVAL
    FROM dual;
    -- NEXTVAL =  다음번호표 ,  CURRVAL = 현재까지 '뽑힌' 번호표 
 
    COMMIT;
    
    SELECT seq, subject, writer, TO_CHAR( regdate, 'yyyy-mm-dd') regdate , readed, lastRegdate
    FROM tbl_board
    ORDER BY seq DESC;
    --최신순부터 나오게
    
    SELECT *
    FROM user_constraints
    WHERE table_name = UPPER('tbl_board');
    --제약조건의 이름을 주지 않으면 자동으로 SYS_XXXXXX 자동 부여됨
    --제약조건 타입 ?? P 는 프라이머리 키 , C는 NOT NULL
    
    --조회수 컬럼 추가하기 ?
    ALTER TABLE tbl_board
    ADD readed NUMBER DEFAULT 0;
    -- 컬럼 한 개 추가할거라서 ( ) 생략

--    UPDATE tbl_board
--    SET title = '우하하4'
--    WHERE writer='임꺽정';

    INSERT INTO tbl_board ( seq,writer, password,title) VALUES (seq_tblboard.NEXTVAL, '임꺽정', '1234', '우하하'); 
    --내용없는것
    
    -- 2번컬럼) INSERT INTO tbl_board ( seq,writer, password,title,content) VALUES (seq_tblboard.NEXTVAL, '성춘향', '1234', '우하하', '나는 성춘향이다'); 
    --클릭했다면 ?
    -- 1) 조회수 ++
    -- 2) 게시글(seq)의 정보를 조회
    
    --      게시글 (상세) 보기
            UPDATE tbl_board
            SET readed = readed +1
            WHERE seq = 2;
            
            SELECT *
            FROM tbl_board
            WHERE seq =2;
    
    --게시판의 작성자 (writer) 컬럼  20 -> 40 사이즈로 크기 변경??
    
    ALTER TABLE tbl_board
    MODIFY (
     writer VARCHAR(40)
    );
    -- 제약조건 NOT NULL은 그대로 유지됨 => 제약조건은 수정할 수 없다
    -- 바꾸고 싶다면 지웠다 다시 만들기 뿐.
    
    -- 컬럼명 수정 ( title -> subject)   
    --사실 별칭주면 되니까 굳이 수정할 것은 없지만 ㄱㄱ
    ALTER TABLE tbl_board RENAME COLUMN title TO subject;
    
    --수정할 때의 날짜 정보를 저장할 컬럼 추가 ? ( lastRegdate )
    ALTER TABLE tbl_board
    ADD (
     lastRegdate DATE
    );
    
    SELECT seq, subject, writer, TO_CHAR( regdate, 'yyyy-mm-dd') regdate , readed, lastRegdate
    FROM tbl_board
    ORDER BY seq DESC;
    --최신순부터 나오게
    
    -- 3번 게시글 수정
    
    UPDATE tbl_board
    SET subject = '3번글 제목수정' , content = '3번 내용수정', lastRegdate = sysdate
    WHERE seq =3;
    
    COMMIT;
    
    SELECT *
    FROM tbl_board;
    
    -- lastRegdate 삭제하기
    
    ALTER TABLE tbl_board
    DROP COLUMN lastRegdate;
    
    --테이블명도 tbl_myboard로
    
    RENAME tbl_board TO tbl_myboard;
    
    
    -- [ 테이블 생성하는 방법 ]
    -- DDL 도 있지만
    -- 서브쿼리를 이용해서도 만들 수 있다 ?!
    -- ㄴ 기존 이미 존재하는 테이블을 이용해서 새로운 테이블 생성 ( + 레코드 추가)
    -- CREATE TABLE 테이블명 (컬럼명,.....)
    -- AS (서브쿼리);  
    -- 컬럼명의 수와 서브쿼리 컬럼명의 수는 같아야함*
    
    --예) emp 테이블로부터 30번 부서원들만 들어있는 새로운 테이블 만들기 ?
    
    CREATE TABLE tbl_emp30 ( eno, ename, hiredate, job, pay )
    AS ( --서브쿼리
    SELECT empno, ename, hiredate, job, sal+NVL(comm,0) pay
    FROM emp
    WHERE deptno = 30
    );
    --Table TBL_EMP30이(가) 생성되었습니다.
    DESC tbl_emp30;
    -- 원래 테이블에 없던 pay 빼고는 자료형(크기)까지 맞춰서 잡힘

    -- 제약조건은 복사 안됨.
    SELECT *
    FROM user_constraints
    WHERE table_name IN ('EMP' , 'TBL_EMP30') ;

    -- emp 테이블을 그대로 복사해서 새로운 테이블 생성 ?
    -- 대신 데이터는 복사하지 않길 원함
    
    DROP TABLE tbl_emp30;
    
    CREATE TABLE tbl_empcopy
    AS (
        SELECT *
        FROM emp
    );
    
    SELECT *
    FROM tbl_empcopy; --데이터 다 복사됨
    
    DROP TABLE tbl_empcopy;
    
        CREATE TABLE tbl_empcopy
    AS (
        SELECT *
        FROM emp
        WHERE 1 = 0 --항상 false
    );
    SELECT *
    FROM tbl_empcopy; --이번엔 레코드 없음
    
    
    --tbl붙은 테이블 전부 삭제 -> PL/SQL 배우면 for문 돌려서 tbl붙은거 삭제도 가능
    
    -- [문제] emp, dept, salgrade 테이블을 이용해서 deptno, dname, empno, ename, hiredate, pay, grade 컬럼을
    -- 가진 새로운 테이블 생성 (tbl_empgrade)
    
    SELECT *
    FROM salgrade;
    
    CREATE TABLE tbl_empgrade
    AS (
    SELECT t.*, s.grade
    FROM (
        SELECT d.deptno,d.dname,e.empno,e.ename,e.hiredate,sal+NVL(comm,0) pay
        FROM emp e JOIN dept d ON e.deptno = d.deptno
        ) t JOIN salgrade s ON t.pay BETWEEN s.losal AND s.hisal
    ); --인라인뷰 조인 ㄴㄴ ㅋㅋ
    
    SELECT *
    FROM tbl_empgrade;
    
    --쌤풀이
    
    
    CREATE TABLE tbl_empgrade2 
    AS (
    SELECT d.deptno, d.dname, e.empno, e.hiredate, sal+NVL(comm,0) pay , s.grade
    FROM emp e, dept d, salgrade s
    WHERE d.deptno = e.deptno AND e.sal BETWEEN s.losal AND s.hisal 
    ) ;
    
    SELECT *
    FROM tbl_empgrade;
    --테이블 세개 조인 ㅇㅋ
    
    DROP TABLE tbl_emp; --유료버전은 바로 삭제 안되고 휴지통 감 (복구/비우기) 가능
    PURGE RECYCLEBIN; -- 휴지통 비우기
    DROP TABLE tbl_empgrade PURGE ; --바로 완전삭제..
    
   ------ JOIN ON 구문으로 수정 ?
      --?
    CREATE TABLE tbl_empgrade
    AS (
    SELECT d.deptno, d.dname, e.empno, e.hiredate, e.sal+NVL(e.comm,0) pay , s.losal || ' ~ ' || s.hisal sal_range, s.grade
    FROM emp e JOIN dept d ON d.deptno = e.deptno JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal 
    ) ;
    
    
    
    -- emp 테이블 구조만 복사해서 새로운 tbl_emp 만들기
    
    CREATE TABLE tbl_emp
    AS (
    SELECT *
    FROM emp
    WHERE 1 = 0
    );
    SELECT *
    FROM tbl_emp;
    -- emp 테이블의 10번 부서원들을 옮겨오고 싶다 ?
    -- 하나씩 하는 방법 말고도 있다
    
    INSERT INTO tbl_emp SELECT * FROM emp WHERE deptno =10 ;
    -- 3개 행 이(가) 삽입되었습니다.
    INSERT INTO tbl_emp ( empno, ename ) SELECT empno, ename FROM emp WHERE deptno =10 ;
    --INSERT도 서브쿼리먹음, ( ) 안씀
    
    COMMIT;
    
    -- 다중 INSERT문 
    --1) unconditional insert all - 조건이 없는 INSERT ALL
    CREATE TABLE tbl_emp10 AS (SELECT * FROM emp WHERE 1 = 0);
    CREATE TABLE tbl_emp20 AS (SELECT * FROM emp WHERE 1 = 0);
    CREATE TABLE tbl_emp30 AS (SELECT * FROM emp WHERE 1 = 0);
    CREATE TABLE tbl_emp40 AS (SELECT * FROM emp WHERE 1 = 0);
    
    INSERT INTO tbl_emp10 SELECT * FROM emp;
    INSERT INTO tbl_emp20 SELECT * FROM emp;
    INSERT INTO tbl_emp30 SELECT * FROM emp;
    INSERT INTO tbl_emp40 SELECT * FROM emp;
    --한번의 쿼리로 한번에 처리 ?
    
    
    SELECT *
    FROM tbl_emp20;
    
    ROLLBACK;
    
    INSERT ALL 
        INTO tbl_emp10 VALUES ( empno, ename, job, mgr, hiredate,sal,comm,deptno)                                                                                                                                                                                                                                                 
        INTO tbl_emp20 VALUES ( empno, ename, job, mgr, hiredate,sal,comm,deptno) 
        INTO tbl_emp30 VALUES ( empno, ename, job, mgr, hiredate,sal,comm,deptno)                                                                                                                                                                                                                                                 
        INTO tbl_emp40 VALUES ( empno, ename, job, mgr, hiredate,sal,comm,deptno)  
    SELECT *
    FROM emp;
    --한번의 쿼리로 한번에 처리 ?
    --조건없이 서브쿼리 결과물 집어넣음)
    
 -- 2) Conditional INSERT ALL : 조건이 있는 INSERT ALL문 => 조건에 맞는 요소만 들어감.
    INSERT ALL 
        WHEN deptno = 10 THEN 
            INTO tbl_emp10 VALUES ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
        WHEN deptno = 20 THEN
            INTO tbl_emp20 VALUES ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
        WHEN deptno = 30 THEN
            INTO tbl_emp30 VALUES ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
        ELSE
            INTO tbl_emp40 VALUES ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
    SELECT *
    FROM emp;

-- 3) conditional first insert : 조건을 만족하는 첫번째 쿼리에만 들어감 / 나머지가 같더라도./ ALL과 FIRST여부만 다름
    INSERT FIRST
        WHEN deptno = 10 THEN 
            INTO tbl_emp10 VALUES ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
        WHEN sal >= 2500 THEN
            INTO tbl_emp20 VALUES ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
        WHEN deptno = 30 THEN
            INTO tbl_emp30 VALUES ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
        ELSE
            INTO tbl_emp40 VALUES ( empno, ename, job, mgr, hiredate, sal, comm, deptno )
    SELECT *
    FROM emp;

-- 4) Pivoting insert

    CREATE TABLE tbl_sales(
    employee_id       number(6),
    week_id            number(2),
    sales_mon          number(8,2),
    sales_tue          number(8,2),
    sales_wed          number(8,2),
    sales_thu          number(8,2),
    sales_fri          number(8,2));
    
    SELECT * 
    FROM tbl_sales;
    
    INSERT INTO tbl_sales VALUES(1101,4,100,150,80,60,120);
    INSERT INTO tbl_sales VALUES(1102,5,300,300,230,120,150);
    COMMIT;
    
    CREATE TABLE tbl_salesdata(
    employee_id        number(6),
    week_id            number(2),
    sales              number(8,2));
    
    SELECT * 
    FROM tbl_salesdata;
    
    INSERT ALL
    INTO tbl_salesdata VALUES(employee_id, week_id, sales_mon)
    INTO tbl_salesdata VALUES(employee_id, week_id, sales_tue)
    INTO tbl_salesdata VALUES(employee_id, week_id, sales_wed)
    INTO tbl_salesdata VALUES(employee_id, week_id, sales_thu)
    INTO tbl_salesdata VALUES(employee_id, week_id, sales_fri)
    SELECT employee_id, week_id, sales_mon, sales_tue, sales_wed,   --서브쿼리
           sales_thu, sales_fri
    FROM tbl_sales;
    -- id, 주차, 요일별판매량 으로 나뉘어져 들어감 , 피벗됨
    
    
    
-- DELETE 문, DROP TABLE 문, TRUNCATE 문 차이점 ?
-- 1) DELETE : 레코드 삭제  DML
-- 2) DROP : 테이블 삭제 DDL
-- 3) TRUNCATE : 레코드를 모두 삭제  DML
-- DELETE FROM 테이블명;   <= 이것도 WHERE 없으면 전체 삭제임
-- DELETE FROM 테이블명; 은 커밋/롤백 
-- TRUNCATE FROM 테이블명; 은 자동커밋..

-- [문제] insa에서 num, name 만을 데이터까지 복사해서 tbl_score 테이블 생성 // num <= 1005 인 애들만

CREATE TABLE tbl_score
AS (
SELECT num, name
FROM insa
WHERE num <= 1005
);

SELECT *
FROM tbl_score;

-- [문제] 새로 생긴 tbl_score에 국 영 수 총점 평균 등급 (수~가) 저장할 컬럼 추가 

ALTER TABLE tbl_score
ADD (
    kor NUMBER(3) DEFAULT 0
    ,eng NUMBER(3) DEFAULT 0
    ,mat NUMBER(3) DEFAULT 0
    ,sum NUMBER(3) DEFAULT 0
    ,avg NUMBER(5,2) DEFAULT 0.00
    ,grade CHAR(3) DEFAULT '가'
    ,rank NUMBER(3) 
);

COMMIT;
DESC tbl_score;
ROLLBACK;
DROP TABLE tbl_score;

SELECT *
FROM tbl_score;

--[문제] 1001~ 1005 모든 학생에게 국영수 점수를 임의의 점수로 부여

    INSERT ALL 
        INTO tbl_score VALUES ( kor, eng, mat)  
    SELECT TRUNC( (sys.dbms_random.value) * 101)  sc
    FROM dual;

    UPDATE tbl_score
    SET kor =  ( FLOOR( (sys.dbms_random.value) * 101) )
        ,eng =  (  (DBMS_RANDOM.VALUE(0,101)) )
        ,mat =  ( FLOOR( (sys.dbms_random.value) * 101) ) ;

-- 1001번 학생의 국영수 값 -> 1005번 학생의 값으로 바꾸기

SELECT deptno, ename, hiredate, sal
        ,LAG(sal, 1 , 0) OVER (ORDER BY hiredate ) pre_sal -- 이전 행의 값을 줌. 없으면 기본값 0
        ,LEAD(sal, 1 , -1) OVER (ORDER BY hiredate ) next_sal  -- 다음 행의 값을 줌. 없으면 기본값 -1
        ,LAG(sal, 3 , 100) OVER (ORDER BY hiredate ) pre_sal -- 3칸 전의 값
FROM emp
WHERE deptno =30;

UPDATE tbl_score
SET kor = (SELECT LAG(kor,4,-1) OVER (ORDER BY num) FROM tbl_score WHERE num= 1005  )
WHERE num = 1005;

SELECT *
FROM tbl_score;

--1001번 점수 1005번으로 옮기기
UPDATE tbl_score
SET kor = ( SELECT prev_kor  FROM ( SELECT num, LAG(kor, 4,-1) OVER (ORDER BY num) AS prev_kor  FROM tbl_score ) WHERE num = 1005)
WHERE num = 1005;
-- 이렇게 하지마셈

UPDATE tbl_score
SET (kor,eng,mat) = (SELECT kor,eng,mat FROM tbl_score WHERE num = 1001)
WHERE num = 1005;
--이렇게 할 것


--총점 평균

UPDATE tbl_score
SET tot = (kor+eng+mat) 
    , avg =(kor+eng+mat)/3 ;
    
ALTER TABLE tbl_score RENAME COLUMN sum TO tot;

-- 등수 ?

UPDATE tbl_score
SET rank = (SELECT RANK() OVER (ORDER BY avg) FROM tbl_score) ;
--내가한거 : 안됨..

--이건 됨
UPDATE tbl_score p
-- SET  rank = ( SELECT COUNT(*)+1 FROM tbl_score c WHERE c.tot > p.tot );
SET rank = (
               SELECT t.r
               FROM (
                   SELECT num, tot, RANK() OVER(ORDER BY tot DESC ) r
                   FROM tbl_score
               ) t
               WHERE t.num =p.num
           );


-- 나보다 높은 사람 찾기
UPDATE tbl_score m
SET rank = (SELECT COUNT(*) +1 FROM tbl_score WHERE tot > m.tot ) ;



--[문제] 수우미양가 부여 90, 80 70 60  그외

UPDATE  tbl_score m
SET grade =           CASE WHEN avg >= 90 THEN '수' 
                                    WHEN avg >= 80 THEN '우' 
                                    WHEN avg >= 70 THEN '미' 
                                    WHEN avg >= 60 THEN '양' 
                                    ELSE '가' END  ;
                                    
UPDATE  tbl_score m
SET grade = DECODE( TRUNC(avg/10), 9, '수', 8,'우', 7,'미', 6,'양', '가');                            
                                  
COMMIT;

SELECT *
FROM tbl_score;

-- 조건이 있는 다중 INSERT
INSERT ALL
    WHEN avg >= 90 THEN
         INTO tbl_score (grade) VALUES( 'A' )
    WHEN avg >= 80 THEN
         INTO tbl_score (grade) VALUES( 'B' )
    WHEN avg >= 70 THEN
         INTO tbl_score (grade) VALUES( 'C' )
    WHEN avg >= 60 THEN
         INTO tbl_score (grade) VALUES( 'D' )
    ELSE
         INTO tbl_score (grade) VALUES( 'F' )
SELECT avg FROM tbl_score ; 
 
 
 -- 영어 점수 40점씩 증가 (100점 제한)
UPDATE tbl_score
SET eng = CASE WHEN (eng + 40) > 100 THEN 100
                        ELSE eng+40 END;

--[문제] 남학생의 국어 점수를 5점 감소 (음수 주의)

UPDATE tbl_score 
SET kor = CASE WHEN (kor -5) < 0  THEN 0
                        ELSE kor -5 END
WHERE num IN (SELECT num FROM insa WHERE MOD(SUBSTR(ssn,8,1) , 2) =1) ;

-- num = 안되는 이유: 서브쿼리가 여러개 뱉음. IN으로 해결가능
-- num = ANY ( 서브쿼리 ) 가능

-- 상관서브쿼리도 가능 .. (num을 가져가서 남자인지 판별 ) 
--UPDATE tbl_score  t
--SET kor = CASE WHEN (kor -5) < 0  THEN 0
--                        ELSE kor -5 END
--where t.num = (
--                select num 
--                from insa 
--                where MOD(substr(ssn,8,1), 2)=1 and t.num =num
--            );           

-- [문제] result라는 컬럼 추가, 합격(과락x, 60이상) 불합격 과락(하나라도 40미만)

ALTER TABLE tbl_score
ADD ( result VARCHAR2(20) );

SELECT *
FROM tbl_score;

UPDATE tbl_score
SET result = CASE WHEN avg >= 60 AND kor >= 40 AND eng >= 40 AND mat >= 40 THEN '합격' 
                            WHEN kor < 40 OR eng < 40 OR mat < 40 THEN '과락' 
                            ELSE '불합격' END;
                            
COMMIT;
DROP TABLE tbl_score PURGE;

-- merge ?? ( 지점데이터 본사로 종합 ? )
 
 CREATE TABLE tbl_emp(
  id NUMBER PRIMARY KEY, 
  name VARCHAR2(10) NOT NULL,
  SALARY  NUMBER,
  bonus NUMBER DEFAULT 100 );

insert into tbl_emp(id,name,salary) values(1001,'jijoe',150);
insert into tbl_emp(id,name,salary) values(1002,'cho',130);
insert into tbl_emp(id,name,salary) values(1003,'kim',140);
select * from tbl_emp;

CREATE TABLE tbl_bonus (
id number
,bonus NUMBER DEFAULT 100
);

insert into tbl_bonus(id)
     (select e.id from tbl_emp e);
COMMIT;

INSERT INTO tbl_bonus VALUES (1004, 50);

SELECT *
FROM tbl_bonus;
SELECT *
FROM tbl_emp;

--tbl_bonus로 머지merge

--미완
MERGE INTO tbl_bonus b
USING (SELECT id, salary FROM tbl_emp) e ; --(tbl_emp)
ON (b.id = e.id)
WHEN MATSHED THEN 
UPDATE SET b.bonus = b.bouns + e.salary * 0.01
WHEN NOT MATCHED THEN 
    INSERT(b.id,b.bonus) 



-- 병합 2) 
CREATE TABLE tbl_merge1
(
     id number primary key
   , name varchar2(20)
   , pay number
   , sudang number             
);
CREATE TABLE tbl_merge2
(
   id number primary key 
   , sudang number             
);
-- 
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (1, 'a', 100, 10);
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (2, 'b', 150, 20);
INSERT INTO tbl_merge1 (id, name, pay, sudang) VALUES (3, 'c', 130, 0);
    
INSERT INTO tbl_merge2 (id, sudang) VALUES (2,5);
INSERT INTO tbl_merge2 (id, sudang) VALUES (3,10);
INSERT INTO tbl_merge2 (id, sudang) VALUES (4,20);

COMMIT;

SELECT * 
FROM tbl_merge2;
FROM tbl_merge1;



-- 아래는 MERGE 문의 모든 절을 사용한 쿼리다.

-- MERGE UPDATE 절에 의해 T1, T2 테이블에 모두 존재하는 행 중 JOB이 CLERK인 행의 SAL이 갱신되고, 갱신된 SAL이 2000보다 작은 행이 삭제된다. MERGE INSERT 절에 의해 T2 테이블에만 존재하는 행 중 JOB이 CLERK인 행이 삽입된다.

 

MERGE

INTO T1 T        --합쳐질 테이블 (타겟 테이블) 

USING T2 S      -- 합칠 테이블명 or 서브쿼리

ON (T.EMPNO = S.EMPNO)  

WHEN MATCHED THEN

UPDATE

SET T.SAL = S.SAL - 500

WHERE T.JOB = 'CLERK' -- 업데이트의 WHERE 조건 CLERK만 업뎃

DELETE 

WHERE T.SAL < 2000      --DELETE 의 WHERE조건 .. '업뎃해도' 2000보다 작으면 삭제해라

WHEN NOT MATCHED THEN   

INSERT (T.EMPNO, T.ENAME, T.JOB)   

VALUES (S.EMPNO, S.ENAME, S.JOB)   -- S에만 있고 T에 없는 애들 인서트해주는데
                
WHERE S.JOB = 'CLERK';          -- CLERK인 애들만 인서트






