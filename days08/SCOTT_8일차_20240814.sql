--�Խ����� ����� ���� ���̺� ���� ?
--���̺��: tbl_board
--�÷� : �۹�ȣ, �ۼ���, ��й�ȣ, ������, �۳���, �ۼ���, ��ȸ�� ���..
   
    -- CREATE [GLOBAL TEMPORARY ] => �ӽ� ���̺�
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
    INCREMENT BY 1 --1�� ����
    START WITH 1 --1���� ����
    --MAX,MIN VALUE, CYCLE����
    -- MIN ��� ��: ����Ŭ ���� �����ϴ� ��
    NOCACHE;
    
    SELECT *
    FROM user_sequences;
    -- user_tables ���� ������ Ȯ�� ����
    
    SELECT *
    FROM user_tables
    WHERE table_name LIKE 'TBL_B%';
    --���̺� Ȯ��
    
    --���̺� ���� ���� ���� <CREATE ALTER DROP> 
    
    DROP TABLE tbl_board CASCADE CONSTRAINTS;
    
    DESC tbl_board;
    
    --�Խñ� ���� (�ۼ�) ����
    INSERT INTO tbl_board ( seq,writer, password,title,content) VALUES (seq_tblboard.NEXTVAL, 'ȫ�浿', '1234', '������', '���� ȫ�浿�̴�'); 
    INSERT INTO tbl_board ( seq,writer, password,title,content) VALUES (seq_tblboard.NEXTVAL, '������', '1234', '������', '���� �������̴�'); 
     INSERT INTO tbl_board VALUES (seq_tblboard.NEXTVAL, '������', '1234', '������', '���� �������̴�', sysdate); 
    -- ������ ��������� ��ȣǥ �̱�� �Խñ۹�ȣ ��ü��
    
    ROLLBACK;
    
    SELECT *
    FROM tbl_board;
    
    SELECT seq_tblboard.CURRVAL
    FROM dual;
    -- NEXTVAL =  ������ȣǥ ,  CURRVAL = ������� '����' ��ȣǥ 
 
    COMMIT;
    
    SELECT seq, subject, writer, TO_CHAR( regdate, 'yyyy-mm-dd') regdate , readed, lastRegdate
    FROM tbl_board
    ORDER BY seq DESC;
    --�ֽż����� ������
    
    SELECT *
    FROM user_constraints
    WHERE table_name = UPPER('tbl_board');
    --���������� �̸��� ���� ������ �ڵ����� SYS_XXXXXX �ڵ� �ο���
    --�������� Ÿ�� ?? P �� �����̸Ӹ� Ű , C�� NOT NULL
    
    --��ȸ�� �÷� �߰��ϱ� ?
    ALTER TABLE tbl_board
    ADD readed NUMBER DEFAULT 0;
    -- �÷� �� �� �߰��ҰŶ� ( ) ����

--    UPDATE tbl_board
--    SET title = '������4'
--    WHERE writer='�Ӳ���';

    INSERT INTO tbl_board ( seq,writer, password,title) VALUES (seq_tblboard.NEXTVAL, '�Ӳ���', '1234', '������'); 
    --������°�
    
    -- 2���÷�) INSERT INTO tbl_board ( seq,writer, password,title,content) VALUES (seq_tblboard.NEXTVAL, '������', '1234', '������', '���� �������̴�'); 
    --Ŭ���ߴٸ� ?
    -- 1) ��ȸ�� ++
    -- 2) �Խñ�(seq)�� ������ ��ȸ
    
    --      �Խñ� (��) ����
            UPDATE tbl_board
            SET readed = readed +1
            WHERE seq = 2;
            
            SELECT *
            FROM tbl_board
            WHERE seq =2;
    
    --�Խ����� �ۼ��� (writer) �÷�  20 -> 40 ������� ũ�� ����??
    
    ALTER TABLE tbl_board
    MODIFY (
     writer VARCHAR(40)
    );
    -- �������� NOT NULL�� �״�� ������ => ���������� ������ �� ����
    -- �ٲٰ� �ʹٸ� ������ �ٽ� ����� ��.
    
    -- �÷��� ���� ( title -> subject)   
    --��� ��Ī�ָ� �Ǵϱ� ���� ������ ���� ������ ����
    ALTER TABLE tbl_board RENAME COLUMN title TO subject;
    
    --������ ���� ��¥ ������ ������ �÷� �߰� ? ( lastRegdate )
    ALTER TABLE tbl_board
    ADD (
     lastRegdate DATE
    );
    
    SELECT seq, subject, writer, TO_CHAR( regdate, 'yyyy-mm-dd') regdate , readed, lastRegdate
    FROM tbl_board
    ORDER BY seq DESC;
    --�ֽż����� ������
    
    -- 3�� �Խñ� ����
    
    UPDATE tbl_board
    SET subject = '3���� �������' , content = '3�� �������', lastRegdate = sysdate
    WHERE seq =3;
    
    COMMIT;
    
    SELECT *
    FROM tbl_board;
    
    -- lastRegdate �����ϱ�
    
    ALTER TABLE tbl_board
    DROP COLUMN lastRegdate;
    
    --���̺�� tbl_myboard��
    
    RENAME tbl_board TO tbl_myboard;
    
    
    -- [ ���̺� �����ϴ� ��� ]
    -- DDL �� ������
    -- ���������� �̿��ؼ��� ���� �� �ִ� ?!
    -- �� ���� �̹� �����ϴ� ���̺��� �̿��ؼ� ���ο� ���̺� ���� ( + ���ڵ� �߰�)
    -- CREATE TABLE ���̺�� (�÷���,.....)
    -- AS (��������);  
    -- �÷����� ���� �������� �÷����� ���� ���ƾ���*
    
    --��) emp ���̺�κ��� 30�� �μ����鸸 ����ִ� ���ο� ���̺� ����� ?
    
    CREATE TABLE tbl_emp30 ( eno, ename, hiredate, job, pay )
    AS ( --��������
    SELECT empno, ename, hiredate, job, sal+NVL(comm,0) pay
    FROM emp
    WHERE deptno = 30
    );
    --Table TBL_EMP30��(��) �����Ǿ����ϴ�.
    DESC tbl_emp30;
    -- ���� ���̺� ���� pay ����� �ڷ���(ũ��)���� ���缭 ����

    -- ���������� ���� �ȵ�.
    SELECT *
    FROM user_constraints
    WHERE table_name IN ('EMP' , 'TBL_EMP30') ;

    -- emp ���̺��� �״�� �����ؼ� ���ο� ���̺� ���� ?
    -- ��� �����ʹ� �������� �ʱ� ����
    
    DROP TABLE tbl_emp30;
    
    CREATE TABLE tbl_empcopy
    AS (
        SELECT *
        FROM emp
    );
    
    SELECT *
    FROM tbl_empcopy; --������ �� �����
    
    DROP TABLE tbl_empcopy;
    
        CREATE TABLE tbl_empcopy
    AS (
        SELECT *
        FROM emp
        WHERE 1 = 0 --�׻� false
    );
    SELECT *
    FROM tbl_empcopy; --�̹��� ���ڵ� ����
    
    
    --tbl���� ���̺� ���� ���� -> PL/SQL ���� for�� ������ tbl������ ������ ����
    
    -- [����] emp, dept, salgrade ���̺��� �̿��ؼ� deptno, dname, empno, ename, hiredate, pay, grade �÷���
    -- ���� ���ο� ���̺� ���� (tbl_empgrade)
    
    SELECT *
    FROM salgrade;
    
    CREATE TABLE tbl_empgrade
    AS (
    SELECT t.*, s.grade
    FROM (
        SELECT d.deptno,d.dname,e.empno,e.ename,e.hiredate,sal+NVL(comm,0) pay
        FROM emp e JOIN dept d ON e.deptno = d.deptno
        ) t JOIN salgrade s ON t.pay BETWEEN s.losal AND s.hisal
    ); --�ζ��κ� ���� ���� ����
    
    SELECT *
    FROM tbl_empgrade;
    
    --��Ǯ��
    
    
    CREATE TABLE tbl_empgrade2 
    AS (
    SELECT d.deptno, d.dname, e.empno, e.hiredate, sal+NVL(comm,0) pay , s.grade
    FROM emp e, dept d, salgrade s
    WHERE d.deptno = e.deptno AND e.sal BETWEEN s.losal AND s.hisal 
    ) ;
    
    SELECT *
    FROM tbl_empgrade;
    --���̺� ���� ���� ����
    
    DROP TABLE tbl_emp; --��������� �ٷ� ���� �ȵǰ� ������ �� (����/����) ����
    PURGE RECYCLEBIN; -- ������ ����
    DROP TABLE tbl_empgrade PURGE ; --�ٷ� ��������..
    
   ------ JOIN ON �������� ���� ?
      --?
    CREATE TABLE tbl_empgrade
    AS (
    SELECT d.deptno, d.dname, e.empno, e.hiredate, e.sal+NVL(e.comm,0) pay , s.losal || ' ~ ' || s.hisal sal_range, s.grade
    FROM emp e JOIN dept d ON d.deptno = e.deptno JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal 
    ) ;
    
    
    
    -- emp ���̺� ������ �����ؼ� ���ο� tbl_emp �����
    
    CREATE TABLE tbl_emp
    AS (
    SELECT *
    FROM emp
    WHERE 1 = 0
    );
    SELECT *
    FROM tbl_emp;
    -- emp ���̺��� 10�� �μ������� �Űܿ��� �ʹ� ?
    -- �ϳ��� �ϴ� ��� ���� �ִ�
    
    INSERT INTO tbl_emp SELECT * FROM emp WHERE deptno =10 ;
    -- 3�� �� ��(��) ���ԵǾ����ϴ�.
    INSERT INTO tbl_emp ( empno, ename ) SELECT empno, ename FROM emp WHERE deptno =10 ;
    --INSERT�� ������������, ( ) �Ⱦ�
    
    COMMIT;
    
    -- ���� INSERT�� 
    --1) unconditional insert all - ������ ���� INSERT ALL
    CREATE TABLE tbl_emp10 AS (SELECT * FROM emp WHERE 1 = 0);
    CREATE TABLE tbl_emp20 AS (SELECT * FROM emp WHERE 1 = 0);
    CREATE TABLE tbl_emp30 AS (SELECT * FROM emp WHERE 1 = 0);
    CREATE TABLE tbl_emp40 AS (SELECT * FROM emp WHERE 1 = 0);
    
    INSERT INTO tbl_emp10 SELECT * FROM emp;
    INSERT INTO tbl_emp20 SELECT * FROM emp;
    INSERT INTO tbl_emp30 SELECT * FROM emp;
    INSERT INTO tbl_emp40 SELECT * FROM emp;
    --�ѹ��� ������ �ѹ��� ó�� ?
    
    
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
    --�ѹ��� ������ �ѹ��� ó�� ?
    --���Ǿ��� �������� ����� �������)
    
 -- 2) Conditional INSERT ALL : ������ �ִ� INSERT ALL�� => ���ǿ� �´� ��Ҹ� ��.
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

-- 3) conditional first insert : ������ �����ϴ� ù��° �������� �� / �������� ������./ ALL�� FIRST���θ� �ٸ�
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
    SELECT employee_id, week_id, sales_mon, sales_tue, sales_wed,   --��������
           sales_thu, sales_fri
    FROM tbl_sales;
    -- id, ����, ���Ϻ��Ǹŷ� ���� �������� �� , �ǹ���
    
    
    
-- DELETE ��, DROP TABLE ��, TRUNCATE �� ������ ?
-- 1) DELETE : ���ڵ� ����  DML
-- 2) DROP : ���̺� ���� DDL
-- 3) TRUNCATE : ���ڵ带 ��� ����  DML
-- DELETE FROM ���̺��;   <= �̰͵� WHERE ������ ��ü ������
-- DELETE FROM ���̺��; �� Ŀ��/�ѹ� 
-- TRUNCATE FROM ���̺��; �� �ڵ�Ŀ��..

-- [����] insa���� num, name ���� �����ͱ��� �����ؼ� tbl_score ���̺� ���� // num <= 1005 �� �ֵ鸸

CREATE TABLE tbl_score
AS (
SELECT num, name
FROM insa
WHERE num <= 1005
);

SELECT *
FROM tbl_score;

-- [����] ���� ���� tbl_score�� �� �� �� ���� ��� ��� (��~��) ������ �÷� �߰� 

ALTER TABLE tbl_score
ADD (
    kor NUMBER(3) DEFAULT 0
    ,eng NUMBER(3) DEFAULT 0
    ,mat NUMBER(3) DEFAULT 0
    ,sum NUMBER(3) DEFAULT 0
    ,avg NUMBER(5,2) DEFAULT 0.00
    ,grade CHAR(3) DEFAULT '��'
    ,rank NUMBER(3) 
);

COMMIT;
DESC tbl_score;
ROLLBACK;
DROP TABLE tbl_score;

SELECT *
FROM tbl_score;

--[����] 1001~ 1005 ��� �л����� ������ ������ ������ ������ �ο�

    INSERT ALL 
        INTO tbl_score VALUES ( kor, eng, mat)  
    SELECT TRUNC( (sys.dbms_random.value) * 101)  sc
    FROM dual;

    UPDATE tbl_score
    SET kor =  ( FLOOR( (sys.dbms_random.value) * 101) )
        ,eng =  (  (DBMS_RANDOM.VALUE(0,101)) )
        ,mat =  ( FLOOR( (sys.dbms_random.value) * 101) ) ;

-- 1001�� �л��� ������ �� -> 1005�� �л��� ������ �ٲٱ�

SELECT deptno, ename, hiredate, sal
        ,LAG(sal, 1 , 0) OVER (ORDER BY hiredate ) pre_sal -- ���� ���� ���� ��. ������ �⺻�� 0
        ,LEAD(sal, 1 , -1) OVER (ORDER BY hiredate ) next_sal  -- ���� ���� ���� ��. ������ �⺻�� -1
        ,LAG(sal, 3 , 100) OVER (ORDER BY hiredate ) pre_sal -- 3ĭ ���� ��
FROM emp
WHERE deptno =30;

UPDATE tbl_score
SET kor = (SELECT LAG(kor,4,-1) OVER (ORDER BY num) FROM tbl_score WHERE num= 1005  )
WHERE num = 1005;

SELECT *
FROM tbl_score;

--1001�� ���� 1005������ �ű��
UPDATE tbl_score
SET kor = ( SELECT prev_kor  FROM ( SELECT num, LAG(kor, 4,-1) OVER (ORDER BY num) AS prev_kor  FROM tbl_score ) WHERE num = 1005)
WHERE num = 1005;
-- �̷��� ��������

UPDATE tbl_score
SET (kor,eng,mat) = (SELECT kor,eng,mat FROM tbl_score WHERE num = 1001)
WHERE num = 1005;
--�̷��� �� ��


--���� ���

UPDATE tbl_score
SET tot = (kor+eng+mat) 
    , avg =(kor+eng+mat)/3 ;
    
ALTER TABLE tbl_score RENAME COLUMN sum TO tot;

-- ��� ?

UPDATE tbl_score
SET rank = (SELECT RANK() OVER (ORDER BY avg) FROM tbl_score) ;
--�����Ѱ� : �ȵ�..

--�̰� ��
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


-- ������ ���� ��� ã��
UPDATE tbl_score m
SET rank = (SELECT COUNT(*) +1 FROM tbl_score WHERE tot > m.tot ) ;



--[����] ����̾簡 �ο� 90, 80 70 60  �׿�

UPDATE  tbl_score m
SET grade =           CASE WHEN avg >= 90 THEN '��' 
                                    WHEN avg >= 80 THEN '��' 
                                    WHEN avg >= 70 THEN '��' 
                                    WHEN avg >= 60 THEN '��' 
                                    ELSE '��' END  ;
                                    
UPDATE  tbl_score m
SET grade = DECODE( TRUNC(avg/10), 9, '��', 8,'��', 7,'��', 6,'��', '��');                            
                                  
COMMIT;

SELECT *
FROM tbl_score;

-- ������ �ִ� ���� INSERT
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
 
 
 -- ���� ���� 40���� ���� (100�� ����)
UPDATE tbl_score
SET eng = CASE WHEN (eng + 40) > 100 THEN 100
                        ELSE eng+40 END;

--[����] ���л��� ���� ������ 5�� ���� (���� ����)

UPDATE tbl_score 
SET kor = CASE WHEN (kor -5) < 0  THEN 0
                        ELSE kor -5 END
WHERE num IN (SELECT num FROM insa WHERE MOD(SUBSTR(ssn,8,1) , 2) =1) ;

-- num = �ȵǴ� ����: ���������� ������ ����. IN���� �ذᰡ��
-- num = ANY ( �������� ) ����

-- ������������� ���� .. (num�� �������� �������� �Ǻ� ) 
--UPDATE tbl_score  t
--SET kor = CASE WHEN (kor -5) < 0  THEN 0
--                        ELSE kor -5 END
--where t.num = (
--                select num 
--                from insa 
--                where MOD(substr(ssn,8,1), 2)=1 and t.num =num
--            );           

-- [����] result��� �÷� �߰�, �հ�(����x, 60�̻�) ���հ� ����(�ϳ��� 40�̸�)

ALTER TABLE tbl_score
ADD ( result VARCHAR2(20) );

SELECT *
FROM tbl_score;

UPDATE tbl_score
SET result = CASE WHEN avg >= 60 AND kor >= 40 AND eng >= 40 AND mat >= 40 THEN '�հ�' 
                            WHEN kor < 40 OR eng < 40 OR mat < 40 THEN '����' 
                            ELSE '���հ�' END;
                            
COMMIT;
DROP TABLE tbl_score PURGE;

-- merge ?? ( ���������� ����� ���� ? )
 
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

--tbl_bonus�� ����merge

--�̿�
MERGE INTO tbl_bonus b
USING (SELECT id, salary FROM tbl_emp) e ; --(tbl_emp)
ON (b.id = e.id)
WHEN MATSHED THEN 
UPDATE SET b.bonus = b.bouns + e.salary * 0.01
WHEN NOT MATCHED THEN 
    INSERT(b.id,b.bonus) 



-- ���� 2) 
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



-- �Ʒ��� MERGE ���� ��� ���� ����� ������.

-- MERGE UPDATE ���� ���� T1, T2 ���̺� ��� �����ϴ� �� �� JOB�� CLERK�� ���� SAL�� ���ŵǰ�, ���ŵ� SAL�� 2000���� ���� ���� �����ȴ�. MERGE INSERT ���� ���� T2 ���̺��� �����ϴ� �� �� JOB�� CLERK�� ���� ���Եȴ�.

 

MERGE

INTO T1 T        --������ ���̺� (Ÿ�� ���̺�) 

USING T2 S      -- ��ĥ ���̺�� or ��������

ON (T.EMPNO = S.EMPNO)  

WHEN MATCHED THEN

UPDATE

SET T.SAL = S.SAL - 500

WHERE T.JOB = 'CLERK' -- ������Ʈ�� WHERE ���� CLERK�� ����

DELETE 

WHERE T.SAL < 2000      --DELETE �� WHERE���� .. '�����ص�' 2000���� ������ �����ض�

WHEN NOT MATCHED THEN   

INSERT (T.EMPNO, T.ENAME, T.JOB)   

VALUES (S.EMPNO, S.ENAME, S.JOB)   -- S���� �ְ� T�� ���� �ֵ� �μ�Ʈ���ִµ�
                
WHERE S.JOB = 'CLERK';          -- CLERK�� �ֵ鸸 �μ�Ʈ






