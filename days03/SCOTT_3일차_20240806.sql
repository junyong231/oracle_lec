-- LIKE 연산자의 ESCAPE 옵션 ?

SELECT deptno, dname, loc
FROM dept;
--dept 테이블에 새로운 부서정보 추가하기 ..?

INSERT INTO dept (deptno,dname,loc) VALUES (60, '한글_나라', 'COREA');
--오류: ORA-00001: unique constraint (SCOTT.PK_DEPT) violated
-- 유일성 제약 조건에 위배된다..!
-- deptno가 primary key였음. 
-- primary key 주면 NOT NULL + UK 낫널,유니크 같이 걸림

--롤백을 시키자 ( 한글나라 없애자)
ROLLBACK;
INSERT INTO dept VALUES (60, '한글_나라', 'COREA'); 
--순서대로 꽉꽉 채웠으니 컬럼명 빼도 ㅇㅋ
COMMIT;

-- 부서명에 % 문자가 포함된 부서 정보를 조회 ?
SELECT dname
FROM dept
WHERE dname LIKE '%3%%' ESCAPE '3';

--DML 
DELETE FROM dept
--위에만 하면 오류:integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
--무결성 제약 조건에 위배됨. 원래 모든 레코드 다지워야되는데 emp테이블에서 참조하는 애들(외래키) 덕에 살았다
WHERE deptno = 60;
--WHERE 조건절이 없으면 다 지워짐 ㄷㄷ!
DELETE FROM emp;
SELECT *
FROM emp;

SELECT *
FROM dept; 
--60 없어짐

--수정
UPDATE dept 
SET dname = SUBSTR(dname, 1,2) , loc = 'COREA'
--여기까지만 하면은 전부다 QC로 바뀜 WHERE 필요 ,, dname||'XX' 이런것도 됨
WHERE deptno =50;

-- 문제) 40번 부서의 부서명과 지역명을 얻어와서 50번 부서에게 부여???

UPDATE dept
SET dname = (SELECT dname 
            FROM dept
            WHERE deptno =40)
    ,loc = ( SELECT loc
            FROM dept
            WHERE deptno=40)
WHERE deptno = 50;
--이게 되네 + 서브쿼리는 항상 괄호안에!
ROLLBACK;

UPDATE dept
SET (dname,loc) = (SELECT dname,loc FROM dept WHERE deptno =40)
WHERE deptno =50;
--이렇게 한번에도 된다..

--문제) 부서번호 50,60,70 부서 한번에 삭제

DELETE FROM dept
WHERE deptno =50 OR deptno =60 OR deptno =70;

COMMIT;
--다시 원래 4개 부서로 돌아왔다

--문제) 기본급(sal)을 pay의 10% 인상시키자 

UPDATE emp
SET sal = sal+(TRUNC((sal+ NVL(comm,0))/10));
        

SELECT ename,sal,comm,sal+NVL(comm,0)
FROM emp;

ROLLBACK;
          
--퍼블릭 synonym  만들자
CREATE PUBLIC SYNONYM arirang
FOR scott.emp;
--ORA-01031: insufficient privileges 권한없대
        
--sys에서 시노님 만들었으니 써보자
SELECT *
FROM arirang;
        
GRANT SELECT ON emp TO hr;
--권한 부여(셀렉트)

REVOKE SELECT
	ON emp
	FROM hr;
	[CASCADE CONSTRAINTS];
--권한 해제

--시노님 (아리랑) 삭제? 얘도sys에서겠네

------------------------------------------------

-- 오라클의 연산자.. (Operator) 정리
1) 비교연산자 : = != > < >= <= ^= <> 
            WHERE 절에서 사용.. (숫자, 문자, 날짜끼리 비교)
            ANY,SOME,ALL = 비교연산자, SQL 연산자..
2) 논리연산자 : AND OR NOT //자바랑 다르게 미확인값과의 처리부분이 더 있음 (안전빵 계산하면 됨.. 나 트루인데 언노운이랑 and? 언노운이 false일지도 모르니 false출력

3)SQL 연산자 : sql 언어에만 존재 ... NOT, IN, BETWEEN, LIKE , IS NULL,   ( ANY, SOME, ALL , EXIST(t/f) ) 얘네는 서브쿼리랑 같이씀


5)산술연산자 : 가감승제. 우선순위 있다 (자바랑 같음)
SELECT 5+3,5-3,5*3,5/3,MOD(5,3),FLOOR(5/3)
FROM dual;