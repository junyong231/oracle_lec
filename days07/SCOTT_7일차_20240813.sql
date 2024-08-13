s--[����] emp. dept ���̺��� ��� �������� �ʴ� �μ���ȣ �μ���


-- ��) �׷���̿� dname �־ ���� �� �ְ� ����
WITH d AS (
        SELECT DISTINCT deptno, dname
        FROM dept
)
SELECT e.*
FROM(
SELECT d.dname, d.deptno , COUNT(empno) em
FROM emp e PARTITION BY (deptno) RIGHT OUTER JOIN d ON e.deptno =d.deptno 
GROUP BY d.deptno, d.dname
ORDER BY d.deptno
) e
WHERE e.em=0 ;


--������ �̿�

SELECT deptno
FROM dept
MINUS
SELECT DISTINCT deptno
FROM emp;


SELECT t.deptno, d.dname
FROM (
    SELECT deptno
    FROM dept
    MINUS
    SELECT DISTINCT deptno
    FROM emp
    ) t JOIN dept d ON t.deptno = d.deptno;

--  ����������� 
SELECT m.deptno, m.dname
FROM dept m
WHERE ( SELECT COUNT(*) FROM emp WHERE deptno = m.deptno) =0;



--(����) �λ����̺��� ���μ��� �����ο��� �ľ��ؼ� 5�� �̻��� �μ� ���� ��� ?

SELECT buseo
         --   ,CASE WHEN SUBSTR(ssn,8,1) =2 THEN '����' END ����
            ,COUNT(SUBSTR(ssn,8,1) ) ��
            
FROM insa
WHERE SUBSTR(ssn,8,1) =2
GROUP BY buseo, SUBSTR(ssn,8,1)
HAVING COUNT(SUBSTR(ssn,8,1) ) > 5;

-- [����] insa ���̺�
--     [�ѻ����]      [���ڻ����]      [���ڻ����] [��������� �ѱ޿���]  [��������� �ѱ޿���] [����-max(�޿�)] [����-max(�޿�)]
------------ ---------- ---------- ---------- ---------- ---------- ----------
--        60                31              29           51961200                41430400                  2650000          2550000


SELECT   -- COUNT(*)
            (SELECT COUNT(*) FROM insa WHERE SUBSTR(ssn,8,1) IN (1,2) ) �ѻ����
            , (SELECT COUNT(*) FROM insa WHERE SUBSTR(ssn,8,1)=1 )  ���ڻ����
            , (SELECT COUNT(*) FROM insa WHERE SUBSTR(ssn,8,1)=2 )  ���ڻ����
            , (SELECT SUM(basicpay+sudang) FROM insa WHERE   SUBSTR(ssn,8,1)=1) �����ѱ޿�
             , (SELECT SUM(basicpay+sudang) FROM insa WHERE   SUBSTR(ssn,8,1)=2) �����ѱ޿�
             ,(SELECT MAX(basicpay+sudang) FROM insa WHERE   SUBSTR(ssn,8,1)=1) ���ڸƽ�
             ,(SELECT MAX(basicpay+sudang) FROM insa WHERE   SUBSTR(ssn,8,1)=2) ���ڸƽ�
FROM insa 
GROUP BY  SUBSTR(ssn,8,1);

-- �׳� COUNT( DECODE (MOD.....) �̷��� �ϳ����ؾ� ���ٳ���


SELECT 
        DECODE( MOD(SUBSTR(ssn,8,1),2) 1, '����', 0 , '����' , '��ü') || '�����'
          ,COUNT(*)
          ,SUM(basicpay)
          ,MIN(basicpay)
          ,MAX(basicpay)
FROM insa
GROUP BY MOD(SUBSTR(ssn,8,1),2);


-- [����] emp ���̺���~
--      �� �μ��� �����, �μ� �ѱ޿���, �μ� ��ձ޿�
���)
    DEPTNO       �μ�����       �ѱ޿���            ���
---------- ----------       ----------    ----------
        10          3          8750       2916.67
        20          3          6775       2258.33
        30          6         11600       1933.33 
        40          0         0             0
        
        
SELECT d.deptno, COUNT(e.empno) �μ����� , NVL(SUM(e.sal),0) �ѱ޿� , NVL ( ROUND ( AVG(e.sal) , 2), 0) ���
FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno
GROUP BY d.deptno;
        

-- ROLLUP /CUBE ����
--GROUP BY���� ��� (�׷캰 ��(�Ұ�)�� �߰��� �����ش�)

--�Ѿ� ���� �Ұ� ����
SELECT 
            CASE MOD( SUBSTR(ssn,8,1) , 2 )
            WHEN 1 THEN '����'
            ELSE '����' END ����
            , COUNT(*) �����
FROM insa
GROUP BY MOD(SUBSTR(ssn,8,1) , 2 )
UNION
SELECT '��ü' , COUNT(*)
FROM insa;

--�Ѿ� ���
SELECT 
            CASE MOD( SUBSTR(ssn,8,1) , 2 )
            WHEN 1 THEN '����'
            WHEN 0 THEN '����' 
            ELSE '��ü' END ����
            , COUNT(*) �����
FROM insa
GROUP BY ROLLUP ( MOD(SUBSTR(ssn,8,1) , 2 ) );

--ť�� ���
SELECT 
            CASE MOD( SUBSTR(ssn,8,1) , 2 )
            WHEN 1 THEN '����'
            WHEN 0 THEN '����' 
            ELSE '��ü' END ����
            , COUNT(*) �����
FROM insa
GROUP BY CUBE ( MOD(SUBSTR(ssn,8,1) , 2 ) );

--�Ѿ��� ť�� ������
--1�������� �μ��� �׷� ������, ���� �������� ����

SELECT buseo,jikwi,COUNT(*) �����
FROM insa i
GROUP BY buseo, ROLLUP ( jikwi ) 
ORDER BY buseo;

-- ���Ͽ�
SELECT buseo,jikwi,COUNT(*) �����
FROM insa i
GROUP BY CUBE (buseo, jikwi)
UNION ALL
SELECT buseo,NULL , COUNT(*) �����
FROM insa
GROUP BY buseo
UNION ALL
SELECT null, jikwi, COUNT(*) �����
FROM insa
GROUP BY jikwi;
--ORDER BY jikwi ;

--���� ROLLUP

SELECT buseo, jikwi, COUNT(*) �����
FROM insa 
GROUP BY buseo  , ROLLUP ( jikwi )
-- �������� �Ѿ�: �μ��� ���� ���� �̷�����
ORDER BY buseo, jikwi;

-- GROUPING SET �Լ�?
SELECT buseo, '', COUNT(*)
FROM insa
GROUP BY buseo;

SELECT '', buseo, COUNT(*)
FROM insa
GROUP BY buseo
UNION
SELECT '', jikwi, COUNT(*)
FROM insa
GROUP BY jikwi;

SELECT buseo, jikwi, COUNT(*)
FROM insa
GROUP BY GROUPING SETS ( buseo, jikwi ) --�׷����� ���� '��' ���� ������ 
ORDER BY buseo, jikwi;


--�ǹ� ����
-- 1. ���̺� ���� �߸��� ��Ȳ���� ���� �̻��ϴٰ� �����ߴ� ��Ȳ
-- DDL������ ���̺� ������

CREATE TABLE tbl_pivot
(
    no NUMBER PRIMARY KEY 
     ,name VARCHAR(20) NOT NULL 
    ,jumsu NUMBER(3) 
 );
SELECT *
FROM  tbl_pivot;

INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 1, '�ڿ���', 90 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 2, '�ڿ���', 89 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 3, '�ڿ���', 99 );  -- mat
 
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 4, '�Ƚ���', 56 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 5, '�Ƚ���', 45 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 6, '�Ƚ���', 12 );  -- mat 
 
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 7, '���', 99 );  -- kor
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 8, '���', 85 );  -- eng
INSERT INTO TBL_PIVOT ( no, name, jumsu ) VALUES ( 9, '���', 100 );  -- mat 

COMMIT; 

SELECT *
FROM  tbl_pivot;

--����   �̸� �� �� ��
            ���� 10 20 30 �̷��� ������??
SELECT *
FROM(            
    SELECT TRUNC( (no-1) /3 +1 ) no ,name, jumsu, DECODE( MOD(no,3) ,1,'����',2,'����',0,'����') subject
    FROM tbl_pivot
) 
PIVOT ( SUM(jumsu) FOR subject IN ('����', '����', '����'  ) )
ORDER BY no ASC;


--������
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

YEAR      MONTH          N
---- ---------- ----------
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

YEAR      MONTH          N
---- ---------- ----------
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

YEAR      MONTH          N
---- ---------- ----------
1982         10          0
1982         11          0
1982         12          0

-- �������� �Ի��� ����� ��� (emp) + ������ �߰��ؼ�?
1980 3
1981 6
1982 3 �̷� ������

 
SELECT TO_CHAR(hiredate, 'yyyy') hy
            ,COUNT(*)
FROM emp e PARTITION BY
GROUP BY TO_CHAR(hiredate, 'yyyy')
ORDER BY hy;

SELECT LEVEL --���� �Ǵ� �ܰ踦 ��Ÿ���� ��ȣ
FROM dual
CONNECT BY LEVEL <= 12;
-- ORA-01788: CONNECT BY clause required in this query block : Ŀ��Ʈ ���� �� �ʿ�

SELECT empno, TO_CHAR(hiredate, 'yyyy') hy
        ,TO_CHAR(hiredate, 'mm') hm
FROM emp;
--


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


-- insa���� �μ��� ������ �����

SELECT buseo, jikwi, COUNT(*)
FROM insa
GROUP BY buseo,jikwi
ORDER BY buseo,jikwi;
--�� �μ��� ������ �ּ� ��� ��, �ִ� �����
���ߺ� ���� 1 ��� 9 �̷�������


SELECT buseo
        ,(SELECT jikwi,COUNT(jikwi) FROM insa WHERE buseo = '���ߺ�' GROUP BY jikwi)
FROM insa i
GROUP BY buseo
ORDER BY buseo;




-- 2������ �˸� ����
-- 1) �м��Լ�  FIRST, LAST
--                    �����Լ��� ���� ����Ͽ�
--                    �־��� �׷쿡 ���� ���������� ������ �Ű� ����� �����ϴ� �Լ�

SELECT MAX(sal) 
            ,MAX(ename) KEEP(DENSE_RANK FIRST ORDER BY sal DESC) max_ename 
            ,MIN(sal)
            ,MAX(ename) KEEP(DENSE_RANK LAST ORDER BY sal DESC) max_ename 
FROM emp;

WITH a AS 
(
    SELECT d.deptno, dname, COUNT(empno) cnt
    FROM emp e RIGHT OUTER JOIN dept d ON d.deptno = e.deptno
    GROUP BY d.deptno, dname
)
SELECT MIN(cnt), MIN(dname) KEEP (DENSE_RANK LAST ORDER BY cnt DESC) min_dname
            ,MAX(cnt), MAX(dname) KEEP (DENSE_RANK FIRST ORDER BY cnt DESC) max_dname
            
FROM a;

-- 2)  SELF JOIN 

SELECT a.empno, a.ename, a.mgr , b.ename ����̸� --  ���� ���ӻ���� �̸� ��������?
FROM emp a JOIN emp b ON a.mgr = b.empno; --��������



--NON <EQUAL JOIN>  (���õ� �÷� ����)
SELECT empno, ename, sal, grade --grade ���ߵǴµ� ���������� ���� (���õ� �÷� ����)
FROM emp e JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal;


-- NON <EQUAL JOIN>  �Ⱦ���
SELECT ename, sal 
   ,  CASE
        WHEN  sal BETWEEN 700 AND 1200 THEN  1
        WHEN  sal BETWEEN 1201 AND 1400 THEN  2
        WHEN  sal BETWEEN 1401 AND 2000 THEN  3
        WHEN  sal BETWEEN 2001 AND 3000 THEN  4
        WHEN  sal BETWEEN 3001 AND 9999 THEN  5
      END grade
FROM emp;



--�� �μ��� ������ �ּ� ��� ��, �ִ� ����� 

���ߺ� ���� 1 ��� 9 �̷�������
WITH t1 AS (
    SELECT buseo, jikwi, COUNT(num) tot_count
    FROM insa
    GROUP BY buseo, jikwi
)
  , t2 AS (
     SELECT buseo, MIN(tot_count) buseo_min_count
                 , MAX(tot_count) buseo_max_count
     FROM t1
     GROUP BY buseo
  )
SELECT a.buseo, b.jikwi ����, b.tot_count �ּһ����
FROM t2 a , t1 b
WHERE a.buseo = b.buseo AND a.buseo_min_count= b. tot_count;


-- FIRST/LAST �м��Լ� ����ؼ� Ǯ��....
WITH t AS (
    SELECT buseo, jikwi, COUNT(num) tot_count
    FROM insa
    GROUP BY buseo, jikwi
)
SELECT t.buseo
            ,MIN(t.jikwi) KEEP (DENSE_RANK LAST ORDER BY t.tot_count ASC)  �ּ�����
            ,MAX(t.tot_count) �ִ�����
            ,MIN(t.jikwi) KEEP (DENSE_RANK FIRST ORDER BY t.tot_count ASC)  �ִ�����
            ,MIN(t.tot_count) �ּһ����
FROM t
GROUP BY t.buseo
ORDER BY t.buseo;



--(����) emp ���� ���� �Ի����ڰ� ���� ����� ���� ��� �Ի� ���� �� ��

SELECT MAX(hiredate)-MIN(hiredate)
FROM emp;

-- CUME_DIST() 

--PERCENT_RANK() 

-- NTILE() ��Ÿ�� �Լ�
-- ����Ƽ�� ���� expr�� ��õȸ�ŭ ������ ����� ��ȯ�ϴ� �Լ�
--  �����ϴ� ���� ��Ŷ�̶�� ��

SELECT deptno, ename, sal
        ,NTILE(4) OVER (ORDER BY sal ASC) ntiles
FROM emp;

SELECT deptno, ename, sal
        ,NTILE(2) OVER (PARTITION BY deptno ORDER BY sal ASC) ntiles --��Ŷ 2�� (2����) ��Ƽ��:�μ�����  : �μ����� ������ 2���� (Ȧ������ 1:2�� ��)
FROM emp;

--widthbuckets
-- WIDTH_BUCKET(expr,minvalue,maxvalue
SELECT deptno, ename, sal
        ,NTILE(4) OVER (ORDER BY sal ASC) ntiles
        ,WIDTH_BUCKET( sal, 1000, 4000, 4) widthbuckets -- 1000���� 4000 ���� 4�������� �����ٴ� �� (�� �丷 : 750)
FROM emp;


-- LAG( expr, offset, default_value)
-- ���־��� �׷�� ������ ���� �ٸ� �࿡ �ִ� ���� ������ �� ����ϴ� �Լ�
--          ������: ���� ��
-- LEAD( expr, offset, default_value)
-- ���־��� �׷�� ������ ���� �ٸ� �࿡ �ִ� ���� ������ �� ����ϴ� �Լ�
--          ������: ���� ��

SELECT deptno, ename, hiredate, sal
        ,LAG(sal, 1 , 0) OVER (ORDER BY hiredate ) pre_sal -- ���� ���� ���� ��. ������ �⺻�� 0
        ,LEAD(sal, 1 , -1) OVER (ORDER BY hiredate ) next_sal  -- ���� ���� ���� ��. ������ �⺻�� -1
        ,LAG(sal, 3 , 100) OVER (ORDER BY hiredate ) pre_sal -- 3ĭ ���� ��
FROM emp
WHERE deptno =30;


------------------------------------------------------------------------------------------------------------------
-- [����Ŭ�� �ڷ��� (Data Type) ]

 1) CHAR[ SIZE(BYTE)���� ] ���ڿ� �ڷ���
    
    CHAR = CHAR( 1 BYTE ) = CHAR( 1 ) -- ���� ǥ��
    CHAR( 3 BYTE ) = CHAR(3) -- ���ĺ��̸� 3����, �ѱ��̶�� 1���� ���� ����
    CHAR( 3 CHAR)  -- ���� 3�� ���� ���� 'abc' �� '������'�� ������ ���� ���� 
    ���� ������ ���ڿ� �ڷ���
    
    name CHAR ( 10 BYTE ) 
    --�ƽø� 2000 ����Ʈ���� ũ�� �Ҵ��� �� �ִ�
    --�������� �ֱ�**
    ��) �ֹε�Ϲ�ȣ (14), ��ȭ��ȣ�ѿ����ȣ,�й� ���
    
    
    --���̺� ���� �׽�Ʈ
    
    CREATE TABLE tbl_char
    (
        aa char --   char(1) == char(1 byte)
        , bb char(3) 
        , cc char(3 char) 
    );
    
    SELECT *
    FROM tbl_char;

    INSERT INTO tbl_char(aa,bb,cc) VALUES( 'a' , 'aaa', 'aaa'); -- �̻����
    INSERT INTO tbl_char(aa,bb,cc) VALUES( 'b' , '��', '�ѿ츮');-- �̻����
    INSERT INTO tbl_char(aa,bb,cc) VALUES( 'b' , '�ѿ츮', '�ѿ츮'); -- ��� �ѿ츮�� ������ 3*3 = 9����Ʈ �ʿ�

    2) NCHAR 
    N == UNICODE �����ڵ�
    NCHAR[ ( SIZE ) ]
    NCHAR(1) == NCHAR --�ƹ��͵� ���� �Ͱ� ����
    NCHAR(10) -- ���ĺ��̵� �ѱ��̵� 10���� ����
    --�������� ���ڿ� �ڷ���
    �ִ� 2000 BYTE
    
       
    CREATE TABLE tbl_nchar
    (
        aa char(3) 
        , bb char(3 char) 
        , cc nchar(3) 
    );
    SELECT *
    FROM tbl_nchar;
    
    INSERT INTO tbl_nchar (aa, bb, cc) VALUES ('ȫ', 'ȫ��', 'ȫ�浿'); --�̻����
    INSERT INTO tbl_nchar (aa, bb, cc) VALUES ('ȫ�浿', 'ȫ�浿', 'ȫ�浿'); --aa�� �ɷ��� ���� (�ѱ��� 3����Ʈ�� �ѱ���)
    
    COMMIT;
    
    
    3) VARCHAR2  ���� ���� ���ڿ� �ڷ��� (VARCHAR�� ���� �ǹ� .. 2�� ��Ī) 
    VAR: ���� ���� 
    �ִ� 4000 BYTE 
    VARCHAR2 (SIZE BYTE | CHAR)
    VARCHAR2 (1) = VARCHAR2 (1 BYTE) = VARCHAR2
    name VARCHAR2 (10)    ���ٰ� 'admin'�̶�� 5����Ʈ ��������� ���� 5����Ʈ �޸𸮿��� ���ŵ�
    
    4) NVARCHAR2   (�����ڵ� ���� ���� ���ڿ� �ڷ���)
    NVARCHAR2 (10) 
    �ڿ� ���� BYTE �ٴ� ������ ���� , �׳� ���ڿ� ���̸� ����
    �ִ� 4000 BYTE 
     
    5) NUMBER[ (p [,s] ) ]
    p: precision ��Ȯ�� => ��ü �ڸ��� ( 1 ~ 38 �ڸ� )
    s: scale �Ը� => 0�� ������ ..    �Ҽ��� ���� �ڸ��� ( -84 ~ 127�ڸ�)
    
    NUMBER = NUMBER( 38,127) 
    NUMBER(p) = NUMBER(p,0) : �Ҽ��� 0�ڸ�
    
    ��)
    CREATE TABLE tbl_number
    (
     no NUMBER(2,0) PRIMARY KEY -- �����̸Ӹ� Ű -> NN + UN �ڵ� �ο�
     , name VARCHAR2( 30 ) NOT NULL 
     , kor NUMBER(3)
     , eng NUMBER(3)
     , mat NUMBER(3) DEFAULT 0
   
    );
    
    SELECT *
    FROM tbl_NUMBER;
    
    COMMIT;
    
    INSERT INTO tbl_NUMBER (no,name,kor,eng,mat) VALUES (1, 'ȫ�浿', 90, 80,90);
    --INSERT INTO tbl_NUMBER (no,name,kor,eng,mat) VALUES (2, '������', 100, 100); --00947. 00000 -  "not enough values" 5���ε� 4���� (����Ʈ���)
    INSERT INTO tbl_NUMBER (no,name,kor,eng) VALUES (2, '������', 100, 100); -- �÷������� ������ߵ�
    INSERT INTO tbl_NUMBER VALUES (3, '�Ӳ���', 50, 50, 100); --not enough values mat�� �׳� ���� ��ߵ�
    INSERT INTO tbl_NUMBER (name,no,kor,eng,mat) VALUES ('�����', 4, 40, 50,10); --���� �����ָ� ��
    INSERT INTO tbl_NUMBER (no,name,kor,eng,mat) VALUES (4, '������', 110, -909, 60.23); --unique constraint (SCOTT.SYS_C007033) violated ���ϼ� �������� ����: no�� ����ũ����
    INSERT INTO tbl_NUMBER (no,name,kor,eng,mat) VALUES (5, '������', 110, -909, 56.934); -- ���� , 56.934�� �ݿø��Ǽ� 57��
    -- ���̺� ���� �� ������ ������ �ᱹ -999~999���� �� ���� �����ߵ� => üũ�� �ʿ�
    ROLLBACK;
 
6) FLOAT [ ( p ) ]  == ���������� NUMBER ó�� ó���� ( precision�� �ִ� NUMBER�� ����)

7) LONG     ��������(VAR) '���ڿ�' �ڷ���, 2GB

8) DATE ��¥, �ð�   (�ʱ���)
    TIMESTAMP [ ( n ) ]  n���ָ� n=6�̶� ���� (�� �� �ڸ��� ����.. n=6�� �� , 00:00:00.000000 �̷��� ��)
    

9) RAW( SIZE )  -�ִ� 2000����Ʈ , ���������� ����
    LONG RAW - 2GB                    ���������� ����
: ���������� ���������ͷ� �����ϴ°�? ���� ���� ������ �ּҸ� ������

10) LOB = ���� ������Ʈ
    CLOB = CHAR ���� ������Ʈ
    NCLOB =NCHAR ����..
    BLOB, BFILE...


----------------------------------------------------------------------------------------------------------------------

--FIRST_VALUE �м��Լ� : ���ĵ� �� �߿� ù��° �� ��Ÿ��


SELECT FIRST_VALUE(basicpay) OVER(ORDER BY basicpay DESC)
FROM insa;

SELECT FIRST_VALUE(basicpay) OVER(PARTITION BY buseo ORDER BY basicpay DESC)
FROM insa;

--insa ���� ���� ���� basicpay , �� ����� basicpay�� ����?
SELECT buseo, name, basicpay
            , FIRST_VALUE(basicpay) OVER(ORDER BY basicpay DESC) maxbp
            ,  FIRST_VALUE(basicpay) OVER(ORDER BY basicpay DESC) -basicpay "�ְ�޿��ڿ��� ����"
FROM insa;

--COUNT + OVER : ������ �࿡ ������ ��� ��ȯ

SELECT name, basicpay
    ,COUNT(*) OVER (ORDER BY basicpay ASC)
FROM insa;

SELECT buseo, name, basicpay
    ,COUNT(*) OVER (PARTITION BY buseo ORDER BY basicpay ASC)
FROM insa;

SELECT buseo, name, basicpay
    ,SUM(basicpay) OVER (ORDER BY buseo ASC)
FROM insa; --�μ��� �޿���..

SELECT buseo, name, basicpay
    ,SUM(basicpay) OVER (PARTITION BY buseo ORDER BY buseo ASC)
FROM insa; --�μ��� �޿���..



-- AVG + OVER : ������ �࿡ ������ ��� ��ȯ
SELECT buseo, name, basicpay
    ,AVG(basicpay) OVER (ORDER BY buseo ASC)
FROM insa; --�μ��� �޿� ���?

SELECT buseo, AVG(basicpay)
FROM insa
GROUP BY buseo
ORDER BY buseo;


----------------------------------------------------------------------
--���̺� ����,����,����

-- ���̺� : ������ �����

-- ���̵�   ���� 10
-- �̸�      ���� 20
-- ����       ���� 30
-- ��ȭ��ȣ ���� 20
-- ����       ��¥ 
-- ���       ���� 255

CREATE TABLE tbl_sample
(
    id VARCHAR2( 10 )
    ,name VARCHAR2 (20)
    ,age NUMBER(3)
    ,birth DATE
-- ���� ���� �ȸ���
);

SELECT *
FROM tbl_sample;

SELECT *
FROM tabs
--WHERE table_name LIKE 'TBL\_%' ESCAPE '\' ;
WHERE REGEXP_LIKE ( table_name , '^TBL_', 'i');

DESC tbl_sample;
-- ��ȭ��ȣ, ��� �÷� �߰� ? => ���̺� ����
-- ALTER
-- �ѹ��� ADD�� ������ �÷� �߰� ����...

ALTER TABLE tbl_sample
ADD ( 
        tel VARCHAR2(20) -- DEFAULT '000-0000-0000' �̷��� �ټ��� ����
        ,bigo VARCHAR2(255)
    ) ;

SELECT *
FROM tbl_sample;

DESC tbl_sample;

--��� �÷��� ũ��(Ȥ�� �ڷ���)�� �����ϰ� �ʹ� ? MODIFY => ����Ʈ Ÿ�� ������ ���� ����
-- 255 => 100
-- ������� �����Ͱ� ���ų� NULL���� �����ϸ� size ���� �� �ֵ�
-- �ڷ����� ���� :  CHAR <=> VARCHAR ��ȣ ���游 ����.. ���� ������ ����-����-��¥ �� ����
-- �÷����� �׳� ��Ī���� �ذ�

ALTER TABLE tbl_sample
MODIFY (

bigo  VARCHAR2(100) 

);

-- bigo �÷��� etc , memo�� �ٲٰ� �ʹ� ? 

ALTER TABLE tbl_sample RENAME COLUMN bigo TO memo;

--memo��� �÷��� ���̺��� �����غ��� 

ALTER TABLE tbl_sample DROP COLUMN memo;

-- ���̺���� �����ϰ� �ʹٸ�?
-- tbl_sample => tbl_example

RENAME tbl_sample TO tbl_example;
DESC tbl_example;









