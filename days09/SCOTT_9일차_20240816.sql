-- 제약조건 CONSTRAINT

SELECT *
FROM user_constraints  -- 뷰(view)
WHERE table_name = 'EMP';
-- 제약조건은 **data integrity(데이터 무결성)을 위하여 주로 테이블에 행(row)을 입력, 수정, 삭제할 때 
-- 적용되는 규칙으로 사용되며 테이블에 의해 참조되고 있는 경우 **테이블의 삭제 방지를 위해서도 사용된다. 

-- 데이터 무결성 : 신뢰 가능, 일관성 유지, 결손과 부정합이 없음을 보증하는 것


-- 제약조건을 생성하는 방법
-- 1) 테이블 생성과 동시에 제약조건을 생성
            -- ㄱ. IN-LINE 제약조건 설정 방법 (컬럼 레벨) : seq NUMBER PRIMARY KEY <= 이거임
            -- ㄴ. OUT-OF-LINE (테이블 레벨) : CREATE TABLE XX
                                                            -- (
                                                            --컬럼 1 -- 여기다 붙이면 컬럼 레벨
                                                            --컬럼 2 -- NOT NULL은 컬럼레벨에서만 가능
                                                            -- )
                                                            --, 제약조건 설정 -- 테이블 레벨 ( 복합키 설정)
-- 복합키 ?  => 사원의 급여 지급 테이블 .
--급여지급일       사원번호        급여
-- 2024.7.15           1111        3,000,000
--                            :          
-- 2024.8.15           1111        3,000,000  
-- : 달이 바뀌었을 때 중복된 사원번호가 또 나오니까 => 사원번호는 PK아님 , 여러개 봐야함 = 복합키( 급여지급일 + 사원번호 )
-- DB 설계 고수 = 역정규화 (복합키) 안나오게 만듬
    

-- 컬럼 레벨 방식으로 제약조건 설정해보기 , 테이블 생성과 동시에 제약조건 설정하기.

DROP TABLE tbl_costraints1;

CREATE TABLE tbl_constraints1
(
    --empno NUMBER(4) NOT NULL PRIMARY KEY
    empno NUMBER(4) NOT NULL CONSTRAINT pk_tblconstraints1_empno PRIMARY KEY
  , ename VARCHAR2(20) NOT NULL CONSTRAINT fk_tblconstraints1_deptno REFERENCES dept (deptno)
  , email VARCHAR2(150) CONSTRAINT uk_tblconstraints1_email UNIQUE
  , kor NUMBER(3) CONSTRAINT ck_tblconstraints1_kor CHECK (kor BETWEEN 0 AND 100 )  -- CHECK는 (WHERE 조건절 주는 것처럼 주면 됨) 
  , city VARCHAR2(0) CONSTRAINT ck_tblconstraints1_city CHECK (city IN ('서울' , '부산' , '대구') )
) ;



DROP TABLE tbl_constraint1; -- 기존에 있다면 제거하자.
CREATE TABLE tbl_constraint1
(
    -- empno NUMBER (4) PRIMARY KEY NOT NULL -> SYS_CXXXX
    empno NUMBER (4) NOT NULL CONSTRAINT pk_tblconstraint1_empno PRIMARY KEY
    , ename VARCHAR2(20) NOT NULL
    , deptno NUMBER(2) CONSTRAINT fk_tblconstraint1_deptno REFERENCES dept (deptno)
    , email VARCHAR2(150) CONSTRAINT uk_tblconstraint1_email UNIQUE -- email은 중복불가
    , kor NUMBER(3) CONSTRAINT ck_tblconstraint1_kor CHECK (kor BETWEEN 0 AND 100) -- (WHERE조건절)
    , city VARCHAR2(20) CONSTRAINT ck_tblconstraint1_city CHECK (city IN ('서울','부산','대구'))
);

SELECT *
FROM user_constraints -- 뷰
WHERE table_name LIKE 'TBL_C%';

ALTER TABLE tbl_constraint1
DISABLE CONSTRAINT ck_tblconstraint1_city -- 비활성화
ENABLE CONSTRAINT ck_tblconstraint1_city; -- 활성화


-- 2) 테이블을 수정 (ALTER TABLE)할 때 제약조건을 생성(추가), 삭제


DROP TABLE tbl_constraint1;
CREATE TABLE tbl_constraint1
(
    -- empno NUMBER (4) PRIMARY KEY NOT NULL -> SYS_CXXXX
    empno NUMBER (4) NOT NULL
    , ename VARCHAR2(20) NOT NULL
    , deptno NUMBER(2) 
    , email VARCHAR2(150) 
    , kor NUMBER(3) 
    , city VARCHAR2(20) 
    
    , CONSTRAINT pk_tblconstraint1_empno PRIMARY KEY ( empno ) -- 복합키 주려면 (empno, ename ,...) 
    , CONSTRAINT fk_tblconstraint1_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)
    , CONSTRAINT uk_tblconstraint1_email UNIQUE (email)
    , CONSTRAINT ck_tblconstraint1_kor CHECK (kor BETWEEN 0 AND 100)
    , CONSTRAINT ck_tblconstraint1_city CHECK (city IN ('서울','부산','대구'))
);


-- PK 제약조건 제거 ?
-- primary key는 테이블당 하나만 존재하므로 삭제시 constraint명을 지정하지 않아도 primary key 제약조건이 삭제된다.

ALTER TABLE tbl_constraint1
-- DROP PRIMARY KEY
DROP CONSTRAINT PK_TBLCONSTRAINT1_EMPNO;

ALTER TABLE tbl_constraint1
--DROP CHECK(kor) -> 이런건 없다
DROP CONSTRAINT CK_TBLCONSTRAINT1_KOR;

ALTER TABLE tbl_constraint1
DROP UNIQUE(email);


-- 기존 테이블에 제약조건 추가
-- NN은 ADD CONSTRAINT가 아닌 MODIFY 사용

CREATE TABLE tbl_constraint3
(
    empno NUMBER(4)
    , ename VARCHAR2(20)
    , deptno NUMBER(2)
);

-- 1) empno 컬럼에 PK 제약조건 추가
ALTER TABLE tbl_constraint3
ADD CONSTRAINT empno_pk PRIMARY KEY (empno);

SELECT *
FROM user_constraints
WHERE table_name = 'TBL_CONSTRAINT3';

-- 2) deptno 에 FK 제약조건 추가
ALTER TABLE tbl_constraint3
ADD CONSTRAINT deptno_fk FOREIGN KEY (deptno) REFERENCES dept(deptno); 

DROP TABLE tbl_constraint3;

DELETE FROM dept
WHERE deptno = 10;
-- ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
--                   ㄴ FK 무결정 제약조건 위배 : 참조하고 있는 자식이 있다. => 부서원들
-- CASCADE로 지워야 지워짐 (자식까지)


-- emp -> tbl_emp 복사 생성
-- dept -> tbl_dept 생성

CREATE TABLE tbl_emp
AS (
    SELECT *
    FROM emp
);

CREATE TABLE tbl_dept
AS (
    SELECT *
    FROM dept
);

SELECT *
FROM user_constraints
WHERE table_name LIKE 'TBL%'; --제약조건은 복사 안됨

DESC tbl_dept; -- NN도 안됐네



-- 제약조건을 부여
-- tbl_dept

-- DELETE CASCADE 제약조건 ?

ALTER TABLE tbl_dept
ADD CONSTRAINT pk_tbldept_deptno PRIMARY KEY(deptno);

ALTER TABLE tbl_emp
ADD CONSTRAINT pk_tblemp_empno PRIMARY KEY(empno);

ALTER TABLE tbl_emp
ADD CONSTRAINT fk_tbldept_deptno FOREIGN KEY(deptno)
                REFERENCES tbl_dept (deptno)
                ON DELETE CASCADE;


SELECT *
FROM tbl_dept;

SELECT *
FROM tbl_emp;

DELETE FROM tbl_dept
WHERE deptno= 30;

--부서에서 30 지웠는데 emp에서도 30인 애들 다 지워짐 (12 -> 6명됨)

ROLLBACK;


ALTER TABLE tbl_emp
ADD CONSTRAINT fk_tbldept_deptno FOREIGN KEY(deptno)
                REFERENCES tbl_dept (deptno)
                ON DELETE SET NULL; -- 수정안됨 제약조건은 삭제하고 다시 만들어야 됨

ALTER TABLE tbl_emp
DROP CONSTRAINT fk_tbldept_deptno;

ALTER TABLE tbl_emp
ADD CONSTRAINT fk_tbldept_deptno FOREIGN KEY(deptno)
                REFERENCES tbl_dept (deptno)
                ON DELETE SET NULL;

DELETE FROM tbl_dept
WHERE deptno= 30;
-- 이러면 30번 부서는 널됨 (제약조건 바뀜)


-- 개체 무결성 : 기본키 부서번호 10 이미 있는데 또 10으로 인서트? 불가
-- 참조 무결성 : 10 번 부서원을 60번(없는부서)로 업뎃 - 오류
--도메인 무결성 : 자료형 넘버인데 'aaa'주면 되겠냐? 


---------------------------------------
--조인.. JOIN


-- JOIN(조인) --
CREATE TABLE book(
       b_id     VARCHAR2(10)    NOT NULL PRIMARY KEY   -- 책ID
      ,title      VARCHAR2(100) NOT NULL  -- 책 제목
      ,c_name  VARCHAR2(100)    NOT NULL     -- c 이름
     -- ,  price  NUMBER(7) NOT NULL
 );
-- Table BOOK이(가) 생성되었습니다.
INSERT INTO book (b_id, title, c_name) VALUES ('a-1', '데이터베이스', '서울');
INSERT INTO book (b_id, title, c_name) VALUES ('a-2', '데이터베이스', '경기');
INSERT INTO book (b_id, title, c_name) VALUES ('b-1', '운영체제', '부산');
INSERT INTO book (b_id, title, c_name) VALUES ('b-2', '운영체제', '인천');
INSERT INTO book (b_id, title, c_name) VALUES ('c-1', '워드', '경기');
INSERT INTO book (b_id, title, c_name) VALUES ('d-1', '엑셀', '대구');
INSERT INTO book (b_id, title, c_name) VALUES ('e-1', '파워포인트', '부산');
INSERT INTO book (b_id, title, c_name) VALUES ('f-1', '엑세스', '인천');
INSERT INTO book (b_id, title, c_name) VALUES ('f-2', '엑세스', '서울');

COMMIT;

SELECT *
FROM book;

-- 단가테이블( 책의 가격 )
CREATE TABLE danga(
       b_id  VARCHAR2(10)  NOT NULL  -- PK , FK   (식별관계 ***) : 부모테이블의 PK가 자식테이블의 PK로 전이
      ,price  NUMBER(7) NOT NULL    -- 책 가격
      
      ,CONSTRAINT PK_dangga_id PRIMARY KEY(b_id)
      ,CONSTRAINT FK_dangga_id FOREIGN KEY (b_id)
              REFERENCES book(b_id)
              ON DELETE CASCADE --책 사라지면 책 가격도 필요없다
);
-- Table DANGA이(가) 생성되었습니다.
-- book  - b_id(PK), title, c_name
-- danga - b_id(PK,FK), price 
 
INSERT INTO danga (b_id, price) VALUES ('a-1', 300);
INSERT INTO danga (b_id, price) VALUES ('a-2', 500);
INSERT INTO danga (b_id, price) VALUES ('b-1', 450);
INSERT INTO danga (b_id, price) VALUES ('b-2', 440);
INSERT INTO danga (b_id, price) VALUES ('c-1', 320);
INSERT INTO danga (b_id, price) VALUES ('d-1', 321);
INSERT INTO danga (b_id, price) VALUES ('e-1', 250);
INSERT INTO danga (b_id, price) VALUES ('f-1', 510);
INSERT INTO danga (b_id, price) VALUES ('f-2', 400);

COMMIT; 

SELECT *
FROM danga; 

-- 책을 지은 저자테이블
 CREATE TABLE au_book(
       id   number(5)  NOT NULL PRIMARY KEY
      ,b_id VARCHAR2(10)  NOT NULL  CONSTRAINT FK_AUBOOK_BID
            REFERENCES book(b_id) ON DELETE CASCADE
      ,name VARCHAR2(20)  NOT NULL
);

INSERT INTO au_book (id, b_id, name) VALUES (1, 'a-1', '저팔개');
INSERT INTO au_book (id, b_id, name) VALUES (2, 'b-1', '손오공');
INSERT INTO au_book (id, b_id, name) VALUES (3, 'a-1', '사오정');
INSERT INTO au_book (id, b_id, name) VALUES (4, 'b-1', '김유신');
INSERT INTO au_book (id, b_id, name) VALUES (5, 'c-1', '유관순');
INSERT INTO au_book (id, b_id, name) VALUES (6, 'd-1', '김하늘');
INSERT INTO au_book (id, b_id, name) VALUES (7, 'a-1', '심심해');
INSERT INTO au_book (id, b_id, name) VALUES (8, 'd-1', '허첨');
INSERT INTO au_book (id, b_id, name) VALUES (9, 'e-1', '이한나');
INSERT INTO au_book (id, b_id, name) VALUES (10, 'f-1', '정말자');
INSERT INTO au_book (id, b_id, name) VALUES (11, 'f-2', '이영애');

COMMIT;

SELECT * 
FROM au_book;

-- 고객            
-- 판매            출판사 <-> 서점
 CREATE TABLE gogaek(
      g_id       NUMBER(5) NOT NULL PRIMARY KEY 
      ,g_name   VARCHAR2(20) NOT NULL
      ,g_tel      VARCHAR2(20)
);

 INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (1, '우리서점', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (2, '도시서점', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (3, '지구서점', '333-3333');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (4, '서울서점', '444-4444');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (5, '수도서점', '555-5555');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (6, '강남서점', '666-6666');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (7, '강북서점', '777-7777');

COMMIT;

SELECT *
FROM gogaek;

-- 판매
 CREATE TABLE panmai(
       id         NUMBER(5) NOT NULL PRIMARY KEY
      ,g_id       NUMBER(5) NOT NULL CONSTRAINT FK_PANMAI_GID
                     REFERENCES gogaek(g_id) ON DELETE CASCADE
      ,b_id       VARCHAR2(10)  NOT NULL CONSTRAINT FK_PANMAI_BID
                     REFERENCES book(b_id) ON DELETE CASCADE
      ,p_date     DATE DEFAULT SYSDATE
      ,p_su       NUMBER(5)  NOT NULL
);

INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (1, 1, 'a-1', '2000-10-10', 10);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (2, 2, 'a-1', '2000-03-04', 20);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (3, 1, 'b-1', DEFAULT, 13);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (4, 4, 'c-1', '2000-07-07', 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (5, 4, 'd-1', DEFAULT, 31);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (6, 6, 'f-1', DEFAULT, 21);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (7, 7, 'a-1', DEFAULT, 26);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (8, 6, 'a-1', DEFAULT, 17);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (9, 6, 'b-1', DEFAULT, 5);
INSERT INTO panmai (id, g_id, b_id, p_date, p_su) VALUES (10, 7, 'a-2', '2000-10-10', 15);

COMMIT;

SELECT *
FROM panmai;   


-- EQUI JOIN 이퀄 조인 (= 내츄럴조인 ) : 조인조건절 PK = FK

-- [문제] 책ID, 책제목, 출판사(c_name), 단가  컬럼 출력....

SELECT b.* ,d.price 
FROM book b JOIN danga d ON b.b_id = d.b_id;  --식별관계

SELECT b.* ,d.price 
FROM book b , danga d 
WHERE b.b_id = d.b_id ;

SELECT b.* ,d.price 
FROM book b INNER JOIN danga d ON b.b_id = d.b_id;
--* INNER조인: 양쪽에 있는 놈만 나와라..

-- USING 절 사용 ? ( 객채명. X    별칭명. X  )

SELECT b_id, title, c_name, price
FROM book JOIN danga USING ( b_id ) ;

-- 내츄럴 조인..
SELECT b_id, title, c_name, price
FROM book NATURAL JOIN danga;

-- [문제]  책ID, 책제목, 판매수량, 단가, 서점명, 판매금액(=판매수량*단가) 출력

SELECT b.b_id, b.title, p.p_su, d.price, g.g_name, (p.p_su * d.price)
FROM book b, danga d, panmai p, gogaek g
WHERE b.b_id = d.b_id AND b.b_id = p.b_id AND p.g_id = g.g_id;

SELECT b.b_id, b.title, p.p_su, d.price, g.g_name, (p.p_su * d.price)
FROM book b JOIN danga d ON b.b_id = d.b_id JOIN panmai p ON b.b_id = p.b_id JOIN gogaek g ON p.g_id = g.g_id;

-- USING 절 사용 ?

SELECT b_id, title, p_su, price, g_name, (p_su * price)
FROM book JOIN panmai USING (b_id) 
                JOIN gogaek USING (g_id)
                JOIN danga USING (b_id);

--? NON-EQUI JOIN :         조인조건절 -X    
-- emp / sal  이랑 salgrade 매칭할 때 썼었음

SELECT empno, ename, sal, losal || ' ~ ' || hisal, grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- OUTER JOIN :     조인 조건을 만족하지 않는 행을 보기 위한 추가적인 join 형태    연산자 (+) 
-- LEFT, RIGHT , FULL OUTER JOIN
-- KING 사원의 부서번호 확인 -> 부서번호를 NULL로 업데이트 ?

SELECT *
FROM emp
WHERE ename = 'KING';  

UPDATE emp
SET deptno = NULL
WHERE ename = 'KING';

COMMIT;
--이제 KING의 부서는 NULL


-- 모든 emp 사원정보를 출력 하되, 부서번호 대신에 부서명으로 출력 (조회) -- 인데 KING은 NULL 이라서 안나옴 
-- JOIN 모든 emp 테이블의 사원 정보를 dept 테이블과 JOIN 해서
-- dname, ename, hiredate 출력

SELECT dname, ename, hiredate
FROM dept d JOIN emp e ON d.deptno = e.deptno;
-- KING은 이퀄 조인이라서 안나옴 (양쪽에 있어야하는데 .. NULL이라서 dept에는 없음)

SELECT dname, ename, hiredate
FROM dept d RIGHT OUTER JOIN emp e ON d.deptno = e.deptno;
-- 오른쪽 emp는 일단 모두 출력

SELECT dname, ename, hiredate
FROM dept d , emp e
WHERE d.deptno(+) = e.deptno; 
--연산자로 표현

-- 각 부서의 사원수 조회
-- 부서명, 사원수 출력

SELECT d.dname, COUNT(*) 사원수 -- * 은 NULL도 센다
FROM  emp e LEFT OUTER JOIN dept d ON e.deptno =d.deptno
GROUP BY d.deptno, d.dname
ORDER BY d.deptno;


SELECT d.dname, COUNT(*)
FROM  emp e , dept d 
WHERE e.deptno = d.deptno(+)
GROUP BY d.deptno,d.dname
ORDER BY d.deptno;

--그룹바이 안쓰려면 (상관)서브쿼리로 카운트 날리면 됨..!

SELECT DISTINCT dname,  (SELECT COUNT(*) FROM emp WHERE deptno = d.deptno)
FROM dept d LEFT JOIN emp e ON d.deptno = e.deptno;
-- OUTER 생략가능함..



SELECT d.deptno, dname, ename, hiredate
FROM  emp e FULL JOIN dept d ON e.deptno =d.deptno;
--없는 부서명도 나오고, 없는 부서 사원명도 나오게 하려면 ? => 풀 아우터 조인 ( : 연산자 없음 )

-- SELF JOIN
-- 사원번호, 사원명, 입사일자, 직속상사의 이름

SELECT a.empno,a.ename,a.hiredate, b.ename 상사이름
FROM emp a JOIN emp b ON a.mgr = b.empno ;

-- 셀프 조인 사용하면 : (대분류) (중분류 FK:대분류 번호) (소분류 FK:중분류번호) 안해도 됨
-- MGR처럼 어떤 대분류의 중분류인지만 구분해주면 됨 // 딱히 장단이 있지는 않..

--CROSS JOIN 안씀
SELECT e.*, d.*
FROM emp e, dept d
ORDER BY ename;

-- 안티 조인 : NOT IN 쓰는거
-- 세미 조인 EXISTS 연산자 쓰는거

--****
-- 문제) 출판된 책들이 각각 총 몇권이 판매되었는지 조회     
--      (    책ID, 책제목, 총판매권수, 단가 컬럼 출력   )


SELECT b.b_id, b.title, SUM(p_su) , d.price
FROM book b , danga d, panmai p
WHERE b.b_id = d.b_id AND b.b_id = p.b_id
GROUP BY b.b_id , title, price;


SELECT DISTINCT b.b_id, b.title, d.price ,(SELECT SUM(p_su) FROM panmai WHERE b_id = b.b_id)
FROM book b , danga d, panmai p
WHERE b.b_id = d.b_id AND b.b_id = p.b_id;


-- 판매권수가 가장 많은책 조회?

-- TOP N 방식
SELECT ROWNUM , e.*
FROM(
SELECT b.b_id, b.title,  SUM(p_su) s , d.price
FROM book b , danga d, panmai p
WHERE b.b_id = d.b_id AND b.b_id = p.b_id
GROUP BY b.b_id , title, price
ORDER BY s DESC
) e
WHERE ROWNUM =1;

-- 내 풀이..
SELECT e.*
FROM (
SELECT b.b_id, b.title,  SUM(p_su) s , d.price
FROM book b , danga d, panmai p
WHERE b.b_id = d.b_id AND b.b_id = p.b_id
GROUP BY b.b_id , title, price
) e 
WHERE e.s = (SELECT MAX(SUM(p_su) ) FROM panmai GROUP BY b_id);

-- 2) 순위 함수 
WITH t 
AS (
    SeLECT  b.b_id, title, SUM(p_su) 총판매권수, price
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga d  ON b.b_id = d.b_id
    GROUP BY      b.b_id , title, price
), s AS (
  SELECT t.*
     , RANK() OVER(ORDER BY 총판매권수 DESC) 판매순위
   FROM t
)
SELECT s.*
FROM s
WHERE s.판매순위 = 1;

--3) 
SELECT t.*
FROM (
    SeLECT  b.b_id, title, SUM(p_su) 총판매권수, price, RANK() OVER(ORDER BY SUM(p_su) DESC) 판매순위
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga d  ON b.b_id = d.b_id
    GROUP BY      b.b_id , title, price
) t
WHERE t.판매순위 = 1;


-- 문제: 올해 판매권수가 제일 많은 책 정보 ? (책id, 제목 , 판매수량)

-- 내풀이
SELECT e.*
FROM(
SELECT b.b_id, b.title, SUM(p.p_su) 판매수량 , RANK() OVER(ORDER BY SUM(p_su) DESC) 판매순위
FROM panmai p JOIN book b ON p.b_id = b.b_id
WHERE p.p_date BETWEEN '2024.01.01' AND LAST_DAY( TO_DATE('24-12-01' , 'yy-mm-dd') )
GROUP BY b.b_id , b.title
) e
WHERE e.판매순위 =1;


-- 문제) book 에서 한번도 판매가 된 적이 없는 책 ? (책id, 제목, 가격)

SELECT *
FROM panmai;

SELECT *
FROM book;

--내 풀이
SELECT e.*
FROM(
SELECT b.b_id, b.title, d.price , NVL(p_su,0) 판매수량
FROM panmai p RIGHT JOIN book b ON b.b_id = p.b_id JOIN danga d ON b.b_id = d.b_id
)e
WHERE e.판매수량 = 0;

-- 좋은 풀이 ) IS NULL로 안팔린 애들만 뽑기도 가능 .!
SELECT b.b_id, b.title, d.price --, p_su
FROM panmai p RIGHT JOIN book b ON b.b_id = p.b_id JOIN danga d ON b.b_id = d.b_id
WHERE p_su IS NULL;

-- 다른 풀이 (안티조인 ;; 차집합)

SELECT b.b_id, title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE b.b_id NOT IN (
    SELECT DISTINCT b_id
    FROM panmai
    );

-- 판매가 된 적이 있는 책?

SELECT DISTINCT b.b_id, title, price
FROM panmai p JOIN book b ON p.b_id = b.b_id JOIN danga d ON b.b_id = d.b_id;

-- EXISTS 써보기?

SELECT b.b_id,title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE EXISTS ( SELECT b_id FROM panmai p WHERE b.b_id= p.b_id );

--문제) 고객별 판매 금액 출력 (고객코드, 고객명, 판매금액)

SELECT *
FROM gogaek;
SELECT *
FROM panmai
ORDER BY g_id;
SELECT * 
FROM panmai p JOIN danga d ON p.b_id = d.b_id
ORDER BY p.g_id;


SELECT p.g_id, g_name, SUM(p_su * d.price) 판매금액 
FROM panmai p JOIN danga d ON p.b_id = d.b_id JOIN gogaek g ON g.g_id = p.g_id
GROUP BY p.g_id, g.g_name
ORDER BY p.g_id;


-- 연도별 월별 판매현황, (연도 월 판매금액)

SELECT SUBSTR(e.p_date,1,2) 연도별 , SUBSTR(e.p_date,4,2) 월별 , e.s 판매금액 , e.s2 판매수량
FROM (
SELECT p.p_date, SUM(p.p_su * d.price) s, SUM(p.p_su) s2
FROM panmai p JOIN danga d ON d.b_id = p.b_id 
GROUP BY p.p_date
)e
ORDER BY 연도별, 월별 ASC;


-- 서점별 연도별 판매현황 ?? (수량까지인듯)

SELECT g.g_name, TO_CHAR(p_date, 'yyyy') 연도, SUM(p_su) 판매수량
FROM panmai p JOIN gogaek g ON p.g_id = g.g_id
GROUP BY g_name, TO_CHAR(p_date, 'yyyy');
ORDER BY TO_CHAR(p_date, 'yyyy'); --정렬?


--책의 총판매금액이 15000원 이상 팔린 책의 정보를 조회
--      ( 책ID, 제목, 단가, 총판매권수, 총판매금액 )책의 총판매금액이 15000원 이상 팔린 책의 정보를 조회
--      ( 책ID, 제목, 단가, 총판매권수, 총판매금액 )

SELECT p.b_id ,title, SUM(p.p_su) 판매권수, SUM(p.p_su * d.price) 판매금액
FROM panmai p JOIN book b ON p.b_id= b.b_id JOIN danga d ON d.b_id = b.b_id
--WHERE (SELECT SUM(p.p_su * d.price) FROM panmai p JOIN danga d ON p.b_id = d.b_id GROUP BY p.b_id ) >= 15000 
GROUP BY p.b_id, b.title
HAVING SUM(p.p_su * d.price) >= 15000;

--아 HAVING...!









-- 파티션 아우터 조인 ?


             SELECT LEVEL month  -- 순번(단계) 
FROM dual
CONNECT BY LEVEL <= 12;
--
SELECT empno, TO_CHAR( hiredate, 'YYYY') year
            , TO_CHAR( hiredate, 'MM' ) month
FROM emp;
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
1982         10          0
1982         11          0
1982         12          0
-- SELECT LEVEL month  -- 순번(단계) 
FROM dual
CONNECT BY LEVEL <= 12;
--
SELECT empno, TO_CHAR( hiredate, 'YYYY') year
            , TO_CHAR( hiredate, 'MM' ) month
FROM emp;
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
1982         10          0
1982         11          0
1982         12          0
--        




