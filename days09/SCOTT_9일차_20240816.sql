-- �������� CONSTRAINT

SELECT *
FROM user_constraints  -- ��(view)
WHERE table_name = 'EMP';
-- ���������� **data integrity(������ ���Ἲ)�� ���Ͽ� �ַ� ���̺� ��(row)�� �Է�, ����, ������ �� 
-- ����Ǵ� ��Ģ���� ���Ǹ� ���̺� ���� �����ǰ� �ִ� ��� **���̺��� ���� ������ ���ؼ��� ���ȴ�. 

-- ������ ���Ἲ : �ŷ� ����, �ϰ��� ����, ��հ� �������� ������ �����ϴ� ��


-- ���������� �����ϴ� ���
-- 1) ���̺� ������ ���ÿ� ���������� ����
            -- ��. IN-LINE �������� ���� ��� (�÷� ����) : seq NUMBER PRIMARY KEY <= �̰���
            -- ��. OUT-OF-LINE (���̺� ����) : CREATE TABLE XX
                                                            -- (
                                                            --�÷� 1 -- ����� ���̸� �÷� ����
                                                            --�÷� 2 -- NOT NULL�� �÷����������� ����
                                                            -- )
                                                            --, �������� ���� -- ���̺� ���� ( ����Ű ����)
-- ����Ű ?  => ����� �޿� ���� ���̺� .
--�޿�������       �����ȣ        �޿�
-- 2024.7.15           1111        3,000,000
--                            :          
-- 2024.8.15           1111        3,000,000  
-- : ���� �ٲ���� �� �ߺ��� �����ȣ�� �� �����ϱ� => �����ȣ�� PK�ƴ� , ������ ������ = ����Ű( �޿������� + �����ȣ )
-- DB ���� ��� = ������ȭ (����Ű) �ȳ����� ����
    

-- �÷� ���� ������� �������� �����غ��� , ���̺� ������ ���ÿ� �������� �����ϱ�.

DROP TABLE tbl_costraints1;

CREATE TABLE tbl_constraints1
(
    --empno NUMBER(4) NOT NULL PRIMARY KEY
    empno NUMBER(4) NOT NULL CONSTRAINT pk_tblconstraints1_empno PRIMARY KEY
  , ename VARCHAR2(20) NOT NULL CONSTRAINT fk_tblconstraints1_deptno REFERENCES dept (deptno)
  , email VARCHAR2(150) CONSTRAINT uk_tblconstraints1_email UNIQUE
  , kor NUMBER(3) CONSTRAINT ck_tblconstraints1_kor CHECK (kor BETWEEN 0 AND 100 )  -- CHECK�� (WHERE ������ �ִ� ��ó�� �ָ� ��) 
  , city VARCHAR2(0) CONSTRAINT ck_tblconstraints1_city CHECK (city IN ('����' , '�λ�' , '�뱸') )
) ;



DROP TABLE tbl_constraint1; -- ������ �ִٸ� ��������.
CREATE TABLE tbl_constraint1
(
    -- empno NUMBER (4) PRIMARY KEY NOT NULL -> SYS_CXXXX
    empno NUMBER (4) NOT NULL CONSTRAINT pk_tblconstraint1_empno PRIMARY KEY
    , ename VARCHAR2(20) NOT NULL
    , deptno NUMBER(2) CONSTRAINT fk_tblconstraint1_deptno REFERENCES dept (deptno)
    , email VARCHAR2(150) CONSTRAINT uk_tblconstraint1_email UNIQUE -- email�� �ߺ��Ұ�
    , kor NUMBER(3) CONSTRAINT ck_tblconstraint1_kor CHECK (kor BETWEEN 0 AND 100) -- (WHERE������)
    , city VARCHAR2(20) CONSTRAINT ck_tblconstraint1_city CHECK (city IN ('����','�λ�','�뱸'))
);

SELECT *
FROM user_constraints -- ��
WHERE table_name LIKE 'TBL_C%';

ALTER TABLE tbl_constraint1
DISABLE CONSTRAINT ck_tblconstraint1_city -- ��Ȱ��ȭ
ENABLE CONSTRAINT ck_tblconstraint1_city; -- Ȱ��ȭ


-- 2) ���̺��� ���� (ALTER TABLE)�� �� ���������� ����(�߰�), ����


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
    
    , CONSTRAINT pk_tblconstraint1_empno PRIMARY KEY ( empno ) -- ����Ű �ַ��� (empno, ename ,...) 
    , CONSTRAINT fk_tblconstraint1_deptno FOREIGN KEY (deptno) REFERENCES dept (deptno)
    , CONSTRAINT uk_tblconstraint1_email UNIQUE (email)
    , CONSTRAINT ck_tblconstraint1_kor CHECK (kor BETWEEN 0 AND 100)
    , CONSTRAINT ck_tblconstraint1_city CHECK (city IN ('����','�λ�','�뱸'))
);


-- PK �������� ���� ?
-- primary key�� ���̺�� �ϳ��� �����ϹǷ� ������ constraint���� �������� �ʾƵ� primary key ���������� �����ȴ�.

ALTER TABLE tbl_constraint1
-- DROP PRIMARY KEY
DROP CONSTRAINT PK_TBLCONSTRAINT1_EMPNO;

ALTER TABLE tbl_constraint1
--DROP CHECK(kor) -> �̷��� ����
DROP CONSTRAINT CK_TBLCONSTRAINT1_KOR;

ALTER TABLE tbl_constraint1
DROP UNIQUE(email);


-- ���� ���̺� �������� �߰�
-- NN�� ADD CONSTRAINT�� �ƴ� MODIFY ���

CREATE TABLE tbl_constraint3
(
    empno NUMBER(4)
    , ename VARCHAR2(20)
    , deptno NUMBER(2)
);

-- 1) empno �÷��� PK �������� �߰�
ALTER TABLE tbl_constraint3
ADD CONSTRAINT empno_pk PRIMARY KEY (empno);

SELECT *
FROM user_constraints
WHERE table_name = 'TBL_CONSTRAINT3';

-- 2) deptno �� FK �������� �߰�
ALTER TABLE tbl_constraint3
ADD CONSTRAINT deptno_fk FOREIGN KEY (deptno) REFERENCES dept(deptno); 

DROP TABLE tbl_constraint3;

DELETE FROM dept
WHERE deptno = 10;
-- ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
--                   �� FK ������ �������� ���� : �����ϰ� �ִ� �ڽ��� �ִ�. => �μ�����
-- CASCADE�� ������ ������ (�ڽı���)


-- emp -> tbl_emp ���� ����
-- dept -> tbl_dept ����

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
WHERE table_name LIKE 'TBL%'; --���������� ���� �ȵ�

DESC tbl_dept; -- NN�� �ȵƳ�



-- ���������� �ο�
-- tbl_dept

-- DELETE CASCADE �������� ?

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

--�μ����� 30 �����µ� emp������ 30�� �ֵ� �� ������ (12 -> 6���)

ROLLBACK;


ALTER TABLE tbl_emp
ADD CONSTRAINT fk_tbldept_deptno FOREIGN KEY(deptno)
                REFERENCES tbl_dept (deptno)
                ON DELETE SET NULL; -- �����ȵ� ���������� �����ϰ� �ٽ� ������ ��

ALTER TABLE tbl_emp
DROP CONSTRAINT fk_tbldept_deptno;

ALTER TABLE tbl_emp
ADD CONSTRAINT fk_tbldept_deptno FOREIGN KEY(deptno)
                REFERENCES tbl_dept (deptno)
                ON DELETE SET NULL;

DELETE FROM tbl_dept
WHERE deptno= 30;
-- �̷��� 30�� �μ��� �ε� (�������� �ٲ�)


-- ��ü ���Ἲ : �⺻Ű �μ���ȣ 10 �̹� �ִµ� �� 10���� �μ�Ʈ? �Ұ�
-- ���� ���Ἲ : 10 �� �μ����� 60��(���ºμ�)�� ���� - ����
--������ ���Ἲ : �ڷ��� �ѹ��ε� 'aaa'�ָ� �ǰڳ�? 


---------------------------------------
--����.. JOIN


-- JOIN(����) --
CREATE TABLE book(
       b_id     VARCHAR2(10)    NOT NULL PRIMARY KEY   -- åID
      ,title      VARCHAR2(100) NOT NULL  -- å ����
      ,c_name  VARCHAR2(100)    NOT NULL     -- c �̸�
     -- ,  price  NUMBER(7) NOT NULL
 );
-- Table BOOK��(��) �����Ǿ����ϴ�.
INSERT INTO book (b_id, title, c_name) VALUES ('a-1', '�����ͺ��̽�', '����');
INSERT INTO book (b_id, title, c_name) VALUES ('a-2', '�����ͺ��̽�', '���');
INSERT INTO book (b_id, title, c_name) VALUES ('b-1', '�ü��', '�λ�');
INSERT INTO book (b_id, title, c_name) VALUES ('b-2', '�ü��', '��õ');
INSERT INTO book (b_id, title, c_name) VALUES ('c-1', '����', '���');
INSERT INTO book (b_id, title, c_name) VALUES ('d-1', '����', '�뱸');
INSERT INTO book (b_id, title, c_name) VALUES ('e-1', '�Ŀ�����Ʈ', '�λ�');
INSERT INTO book (b_id, title, c_name) VALUES ('f-1', '������', '��õ');
INSERT INTO book (b_id, title, c_name) VALUES ('f-2', '������', '����');

COMMIT;

SELECT *
FROM book;

-- �ܰ����̺�( å�� ���� )
CREATE TABLE danga(
       b_id  VARCHAR2(10)  NOT NULL  -- PK , FK   (�ĺ����� ***) : �θ����̺��� PK�� �ڽ����̺��� PK�� ����
      ,price  NUMBER(7) NOT NULL    -- å ����
      
      ,CONSTRAINT PK_dangga_id PRIMARY KEY(b_id)
      ,CONSTRAINT FK_dangga_id FOREIGN KEY (b_id)
              REFERENCES book(b_id)
              ON DELETE CASCADE --å ������� å ���ݵ� �ʿ����
);
-- Table DANGA��(��) �����Ǿ����ϴ�.
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

-- å�� ���� �������̺�
 CREATE TABLE au_book(
       id   number(5)  NOT NULL PRIMARY KEY
      ,b_id VARCHAR2(10)  NOT NULL  CONSTRAINT FK_AUBOOK_BID
            REFERENCES book(b_id) ON DELETE CASCADE
      ,name VARCHAR2(20)  NOT NULL
);

INSERT INTO au_book (id, b_id, name) VALUES (1, 'a-1', '���Ȱ�');
INSERT INTO au_book (id, b_id, name) VALUES (2, 'b-1', '�տ���');
INSERT INTO au_book (id, b_id, name) VALUES (3, 'a-1', '�����');
INSERT INTO au_book (id, b_id, name) VALUES (4, 'b-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (5, 'c-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (6, 'd-1', '���ϴ�');
INSERT INTO au_book (id, b_id, name) VALUES (7, 'a-1', '�ɽ���');
INSERT INTO au_book (id, b_id, name) VALUES (8, 'd-1', '��÷');
INSERT INTO au_book (id, b_id, name) VALUES (9, 'e-1', '���ѳ�');
INSERT INTO au_book (id, b_id, name) VALUES (10, 'f-1', '������');
INSERT INTO au_book (id, b_id, name) VALUES (11, 'f-2', '�̿���');

COMMIT;

SELECT * 
FROM au_book;

-- ��            
-- �Ǹ�            ���ǻ� <-> ����
 CREATE TABLE gogaek(
      g_id       NUMBER(5) NOT NULL PRIMARY KEY 
      ,g_name   VARCHAR2(20) NOT NULL
      ,g_tel      VARCHAR2(20)
);

 INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (1, '�츮����', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (2, '���ü���', '111-1111');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (3, '��������', '333-3333');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (4, '���Ｍ��', '444-4444');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (5, '��������', '555-5555');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (6, '��������', '666-6666');
INSERT INTO gogaek (g_id, g_name, g_tel) VALUES (7, '���ϼ���', '777-7777');

COMMIT;

SELECT *
FROM gogaek;

-- �Ǹ�
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


-- EQUI JOIN ���� ���� (= �������� ) : ���������� PK = FK

-- [����] åID, å����, ���ǻ�(c_name), �ܰ�  �÷� ���....

SELECT b.* ,d.price 
FROM book b JOIN danga d ON b.b_id = d.b_id;  --�ĺ�����

SELECT b.* ,d.price 
FROM book b , danga d 
WHERE b.b_id = d.b_id ;

SELECT b.* ,d.price 
FROM book b INNER JOIN danga d ON b.b_id = d.b_id;
--* INNER����: ���ʿ� �ִ� �� ���Ͷ�..

-- USING �� ��� ? ( ��ä��. X    ��Ī��. X  )

SELECT b_id, title, c_name, price
FROM book JOIN danga USING ( b_id ) ;

-- ���� ����..
SELECT b_id, title, c_name, price
FROM book NATURAL JOIN danga;

-- [����]  åID, å����, �Ǹż���, �ܰ�, ������, �Ǹűݾ�(=�Ǹż���*�ܰ�) ���

SELECT b.b_id, b.title, p.p_su, d.price, g.g_name, (p.p_su * d.price)
FROM book b, danga d, panmai p, gogaek g
WHERE b.b_id = d.b_id AND b.b_id = p.b_id AND p.g_id = g.g_id;

SELECT b.b_id, b.title, p.p_su, d.price, g.g_name, (p.p_su * d.price)
FROM book b JOIN danga d ON b.b_id = d.b_id JOIN panmai p ON b.b_id = p.b_id JOIN gogaek g ON p.g_id = g.g_id;

-- USING �� ��� ?

SELECT b_id, title, p_su, price, g_name, (p_su * price)
FROM book JOIN panmai USING (b_id) 
                JOIN gogaek USING (g_id)
                JOIN danga USING (b_id);

--? NON-EQUI JOIN :         ���������� -X    
-- emp / sal  �̶� salgrade ��Ī�� �� �����

SELECT empno, ename, sal, losal || ' ~ ' || hisal, grade
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;

-- OUTER JOIN :     ���� ������ �������� �ʴ� ���� ���� ���� �߰����� join ����    ������ (+) 
-- LEFT, RIGHT , FULL OUTER JOIN
-- KING ����� �μ���ȣ Ȯ�� -> �μ���ȣ�� NULL�� ������Ʈ ?

SELECT *
FROM emp
WHERE ename = 'KING';  

UPDATE emp
SET deptno = NULL
WHERE ename = 'KING';

COMMIT;
--���� KING�� �μ��� NULL


-- ��� emp ��������� ��� �ϵ�, �μ���ȣ ��ſ� �μ������� ��� (��ȸ) -- �ε� KING�� NULL �̶� �ȳ��� 
-- JOIN ��� emp ���̺��� ��� ������ dept ���̺�� JOIN �ؼ�
-- dname, ename, hiredate ���

SELECT dname, ename, hiredate
FROM dept d JOIN emp e ON d.deptno = e.deptno;
-- KING�� ���� �����̶� �ȳ��� (���ʿ� �־���ϴµ� .. NULL�̶� dept���� ����)

SELECT dname, ename, hiredate
FROM dept d RIGHT OUTER JOIN emp e ON d.deptno = e.deptno;
-- ������ emp�� �ϴ� ��� ���

SELECT dname, ename, hiredate
FROM dept d , emp e
WHERE d.deptno(+) = e.deptno; 
--�����ڷ� ǥ��

-- �� �μ��� ����� ��ȸ
-- �μ���, ����� ���

SELECT d.dname, COUNT(*) ����� -- * �� NULL�� ����
FROM  emp e LEFT OUTER JOIN dept d ON e.deptno =d.deptno
GROUP BY d.deptno, d.dname
ORDER BY d.deptno;


SELECT d.dname, COUNT(*)
FROM  emp e , dept d 
WHERE e.deptno = d.deptno(+)
GROUP BY d.deptno,d.dname
ORDER BY d.deptno;

--�׷���� �Ⱦ����� (���)���������� ī��Ʈ ������ ��..!

SELECT DISTINCT dname,  (SELECT COUNT(*) FROM emp WHERE deptno = d.deptno)
FROM dept d LEFT JOIN emp e ON d.deptno = e.deptno;
-- OUTER ����������..



SELECT d.deptno, dname, ename, hiredate
FROM  emp e FULL JOIN dept d ON e.deptno =d.deptno;
--���� �μ��� ������, ���� �μ� ����� ������ �Ϸ��� ? => Ǯ �ƿ��� ���� ( : ������ ���� )

-- SELF JOIN
-- �����ȣ, �����, �Ի�����, ���ӻ���� �̸�

SELECT a.empno,a.ename,a.hiredate, b.ename ����̸�
FROM emp a JOIN emp b ON a.mgr = b.empno ;

-- ���� ���� ����ϸ� : (��з�) (�ߺз� FK:��з� ��ȣ) (�Һз� FK:�ߺз���ȣ) ���ص� ��
-- MGRó�� � ��з��� �ߺз������� �������ָ� �� // ���� ����� ������ ��..

--CROSS JOIN �Ⱦ�
SELECT e.*, d.*
FROM emp e, dept d
ORDER BY ename;

-- ��Ƽ ���� : NOT IN ���°�
-- ���� ���� EXISTS ������ ���°�

--****
-- ����) ���ǵ� å���� ���� �� ����� �ǸŵǾ����� ��ȸ     
--      (    åID, å����, ���ǸűǼ�, �ܰ� �÷� ���   )


SELECT b.b_id, b.title, SUM(p_su) , d.price
FROM book b , danga d, panmai p
WHERE b.b_id = d.b_id AND b.b_id = p.b_id
GROUP BY b.b_id , title, price;


SELECT DISTINCT b.b_id, b.title, d.price ,(SELECT SUM(p_su) FROM panmai WHERE b_id = b.b_id)
FROM book b , danga d, panmai p
WHERE b.b_id = d.b_id AND b.b_id = p.b_id;


-- �ǸűǼ��� ���� ����å ��ȸ?

-- TOP N ���
SELECT ROWNUM , e.*
FROM(
SELECT b.b_id, b.title,  SUM(p_su) s , d.price
FROM book b , danga d, panmai p
WHERE b.b_id = d.b_id AND b.b_id = p.b_id
GROUP BY b.b_id , title, price
ORDER BY s DESC
) e
WHERE ROWNUM =1;

-- �� Ǯ��..
SELECT e.*
FROM (
SELECT b.b_id, b.title,  SUM(p_su) s , d.price
FROM book b , danga d, panmai p
WHERE b.b_id = d.b_id AND b.b_id = p.b_id
GROUP BY b.b_id , title, price
) e 
WHERE e.s = (SELECT MAX(SUM(p_su) ) FROM panmai GROUP BY b_id);

-- 2) ���� �Լ� 
WITH t 
AS (
    SeLECT  b.b_id, title, SUM(p_su) ���ǸűǼ�, price
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga d  ON b.b_id = d.b_id
    GROUP BY      b.b_id , title, price
), s AS (
  SELECT t.*
     , RANK() OVER(ORDER BY ���ǸűǼ� DESC) �Ǹż���
   FROM t
)
SELECT s.*
FROM s
WHERE s.�Ǹż��� = 1;

--3) 
SELECT t.*
FROM (
    SeLECT  b.b_id, title, SUM(p_su) ���ǸűǼ�, price, RANK() OVER(ORDER BY SUM(p_su) DESC) �Ǹż���
    FROM book b JOIN panmai p ON b.b_id = p.b_id
                JOIN danga d  ON b.b_id = d.b_id
    GROUP BY      b.b_id , title, price
) t
WHERE t.�Ǹż��� = 1;


-- ����: ���� �ǸűǼ��� ���� ���� å ���� ? (åid, ���� , �Ǹż���)

-- ��Ǯ��
SELECT e.*
FROM(
SELECT b.b_id, b.title, SUM(p.p_su) �Ǹż��� , RANK() OVER(ORDER BY SUM(p_su) DESC) �Ǹż���
FROM panmai p JOIN book b ON p.b_id = b.b_id
WHERE p.p_date BETWEEN '2024.01.01' AND LAST_DAY( TO_DATE('24-12-01' , 'yy-mm-dd') )
GROUP BY b.b_id , b.title
) e
WHERE e.�Ǹż��� =1;


-- ����) book ���� �ѹ��� �ǸŰ� �� ���� ���� å ? (åid, ����, ����)

SELECT *
FROM panmai;

SELECT *
FROM book;

--�� Ǯ��
SELECT e.*
FROM(
SELECT b.b_id, b.title, d.price , NVL(p_su,0) �Ǹż���
FROM panmai p RIGHT JOIN book b ON b.b_id = p.b_id JOIN danga d ON b.b_id = d.b_id
)e
WHERE e.�Ǹż��� = 0;

-- ���� Ǯ�� ) IS NULL�� ���ȸ� �ֵ鸸 �̱⵵ ���� .!
SELECT b.b_id, b.title, d.price --, p_su
FROM panmai p RIGHT JOIN book b ON b.b_id = p.b_id JOIN danga d ON b.b_id = d.b_id
WHERE p_su IS NULL;

-- �ٸ� Ǯ�� (��Ƽ���� ;; ������)

SELECT b.b_id, title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE b.b_id NOT IN (
    SELECT DISTINCT b_id
    FROM panmai
    );

-- �ǸŰ� �� ���� �ִ� å?

SELECT DISTINCT b.b_id, title, price
FROM panmai p JOIN book b ON p.b_id = b.b_id JOIN danga d ON b.b_id = d.b_id;

-- EXISTS �Ẹ��?

SELECT b.b_id,title, price
FROM book b JOIN danga d ON b.b_id = d.b_id
WHERE EXISTS ( SELECT b_id FROM panmai p WHERE b.b_id= p.b_id );

--����) ���� �Ǹ� �ݾ� ��� (���ڵ�, ����, �Ǹűݾ�)

SELECT *
FROM gogaek;
SELECT *
FROM panmai
ORDER BY g_id;
SELECT * 
FROM panmai p JOIN danga d ON p.b_id = d.b_id
ORDER BY p.g_id;


SELECT p.g_id, g_name, SUM(p_su * d.price) �Ǹűݾ� 
FROM panmai p JOIN danga d ON p.b_id = d.b_id JOIN gogaek g ON g.g_id = p.g_id
GROUP BY p.g_id, g.g_name
ORDER BY p.g_id;


-- ������ ���� �Ǹ���Ȳ, (���� �� �Ǹűݾ�)

SELECT SUBSTR(e.p_date,1,2) ������ , SUBSTR(e.p_date,4,2) ���� , e.s �Ǹűݾ� , e.s2 �Ǹż���
FROM (
SELECT p.p_date, SUM(p.p_su * d.price) s, SUM(p.p_su) s2
FROM panmai p JOIN danga d ON d.b_id = p.b_id 
GROUP BY p.p_date
)e
ORDER BY ������, ���� ASC;


-- ������ ������ �Ǹ���Ȳ ?? (���������ε�)

SELECT g.g_name, TO_CHAR(p_date, 'yyyy') ����, SUM(p_su) �Ǹż���
FROM panmai p JOIN gogaek g ON p.g_id = g.g_id
GROUP BY g_name, TO_CHAR(p_date, 'yyyy');
ORDER BY TO_CHAR(p_date, 'yyyy'); --����?


--å�� ���Ǹűݾ��� 15000�� �̻� �ȸ� å�� ������ ��ȸ
--      ( åID, ����, �ܰ�, ���ǸűǼ�, ���Ǹűݾ� )å�� ���Ǹűݾ��� 15000�� �̻� �ȸ� å�� ������ ��ȸ
--      ( åID, ����, �ܰ�, ���ǸűǼ�, ���Ǹűݾ� )

SELECT p.b_id ,title, SUM(p.p_su) �ǸűǼ�, SUM(p.p_su * d.price) �Ǹűݾ�
FROM panmai p JOIN book b ON p.b_id= b.b_id JOIN danga d ON d.b_id = b.b_id
--WHERE (SELECT SUM(p.p_su * d.price) FROM panmai p JOIN danga d ON p.b_id = d.b_id GROUP BY p.b_id ) >= 15000 
GROUP BY p.b_id, b.title
HAVING SUM(p.p_su * d.price) >= 15000;

--�� HAVING...!









-- ��Ƽ�� �ƿ��� ���� ?


             SELECT LEVEL month  -- ����(�ܰ�) 
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
-- SELECT LEVEL month  -- ����(�ܰ�) 
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




