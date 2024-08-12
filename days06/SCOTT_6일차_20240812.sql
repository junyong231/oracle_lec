--SCOTT
--����) emp ���� ename,pay, ��ձ޿�,  ���� , ���� (�Ҽ��� 3�ڸ�)
--ORA-00937: not a single-group group function �����Լ��� �Ϲ��÷� ������ => ���������� ������ �ȴ� ***************

WITH temp AS (
SELECT ename, sal+NVL(comm,0) pay
         ,(SELECT AVG(sal+NVL(comm,0)) FROM emp) avg_pay
         
FROM emp
)
SELECT t.*
            ,CEIL( ( t.pay - t.avg_pay) * 100) /100 "�� �ø�"
            ,ROUND  ( t.pay - t.avg_pay,2) "�� �ݿø�"
            ,TRUNC ( t.pay - t.avg_pay, 2) "�� ����"
FROM temp t;

-- ����2) pay avg_pay, ���� ���� ���� ���

WITH temp AS (
SELECT ename, sal+NVL(comm,0) pay
         ,(SELECT AVG(sal+NVL(comm,0)) FROM emp) avg_pay
         
FROM emp
)
SELECT t.*
            ,CASE WHEN PAY > avg_pay THEN '����'
            WHEN PAY < avg_pay THEN '����'
            ELSE '����' END ��մ��
FROM temp t ;

--[����] insa ���̺��� ������ �������� ������ ���� ���θ� ����ϴ� ������ �ۼ��ϼ��� . 
--      ( '������', '��������', '���� ' ó�� )   
-- 1) 1002 �̼��� �ֹι�ȣ ���ó�¥�� ��/�Ϸ� ���� (update)
-- 2) ���� ���� ����
UPDATE insa
SET ssn =SUBSTR(ssn,0,2) || TO_CHAR(sysdate, 'MMDD')||SUBSTR(ssn,7)
WHERE num = 1002;

ROLLBACK;
COMMIT;

SELECT *
FROM insa;



SELECT e.name,e.birth
        , CASE WHEN TO_CHAR(sysdate, 'mm-dd') > e.birth THEN '������'
             WHEN TO_CHAR(sysdate, 'mm-dd') < e.birth THEN '��������'
            ELSE '����' END ��������
FROM (
    SELECT name, TO_CHAR(TO_DATE(SUBSTR(ssn,3,4), 'MM-DD'), 'MM-DD') birth 
    FROM insa
) e;

--����) insa���� ssn�� ������  ������ ����ؼ� ���?
-- ������ : ���س⵵ - ���ϳ⵵  ������������ �״��, ���������� -1
-- �����ڸ���) 1,2 �� 1900  3,4 2000  0,9 1800��� ,, 56 �ܱ��� 1900 . 78 �ܱ��� 2000


SELECT  e.*
            ,CASE WHEN TO_CHAR(sysdate, 'mm-dd') > e.birth THEN TO_CHAR(sysdate, 'yyyy') - e.����
             ELSE TO_CHAR(sysdate, 'yyyy') - e.���� +1
            END ������
FROM (
            SELECT SUBSTR(ssn,8,1) �����ڵ� , TO_CHAR(TO_DATE(SUBSTR(ssn,3,4),'mmdd'),'mmdd') birth
            , CASE 
            WHEN  SUBSTR(ssn,8,1) = 1 OR SUBSTR(ssn,8,1) = 2 OR SUBSTR(ssn,8,1) = 5 OR SUBSTR(ssn,8,1) = 6 THEN '19' || TO_CHAR(TO_DATE(SUBSTR(ssn,1,2 ),'yy'),'yy')  
            WHEN  SUBSTR(ssn,8,1) = 3 OR SUBSTR(ssn,8,1) = 4 OR SUBSTR(ssn,8,1) = 7 OR SUBSTR(ssn,8,1) = 8 THEN '20' || TO_CHAR(TO_DATE(SUBSTR(ssn,1,2 ),'yy'),'yy')
            ELSE '18' || TO_CHAR(TO_DATE(SUBSTR(ssn,1,2 ),'yy'),'yy') END ����
    FROM insa
    ) e;

--�� Ǯ��

SELECT t.name, t.ssn, ����⵵, ���س⵵
    , ���س⵵ - ����⵵  + CASE bs
                               WHEN -1 THEN  -1                               
                               ELSE 0
                               END  ������  
FROM (
    SELECT name, ssn, TO_CHAR(sysdate , 'yyyy') ���س⵵, SUBSTR(ssn,-7,1) ����, SUBSTR(ssn,0,2) ���2�ڸ��⵵
            ,CASE 
            WHEN SUBSTR(ssn,-7,1) IN (1,2,5,6) THEN 1900
            WHEN SUBSTR(ssn,-7,1) IN (3,4,7,8) THEN 2000
            ELSE 1800 END + SUBSTR(ssn,0,2) ����⵵
            , SIGN( TO_DATE(SUBSTR(ssn,3,4),'mmdd') - TRUNC( sysdate) ) bs -- 0,-1 ���� ������, 1�̸� ���� ���������� ���� ����� �� -1 ���ֱ�
    FROM insa
        ) t;


SELECT TO_DATE(SUBSTR(ssn,3,4),'mmdd') birth
FROM insa;

-- �ڹٿ����� Math.random() ������ ��.. 
-- Random �̶�� Ŭ���� �ȿ� nextInt() ������ ��..
-- ����Ŭ���� �ִ�?

--�ڹٿ��� ��Ű���� ���� ���õ� Ŭ�������� ����
--����Ŭ���� ��Ű���� ���� ���õ� Ÿ�� ��ü �������α׷����� ���� ���� ��
--��� ������ �������� ���� ��  �ڹٿ� ����..

SELECT sys.dbms_random.value
FROM dual;
-- 0.0 <= �� < 1.0 ������

SELECT sys.dbms_random.value (0, 100)
FROM dual;
-- 0~100 ������ �Ǽ��� ����
SELECT sys.dbms_random.value(1,2)
FROM dual;

SELECT sys.dbms_random.string('U',3)
FROM dual;
--�빮�� 3�� ����

SELECT sys.dbms_random.string('X',5)
FROM dual;
-- ����, �빮�� ����

SELECT sys.dbms_random.string('L',3)
FROM dual;
-- �ҹ��� (LOWER)

SELECT sys.dbms_random.string('P',6)
FROM dual;
--��,��,����,Ư������ ����

SELECT sys.dbms_random.string('A',5)
FROM dual;
--���� ���ĺ� (��,��)

--����) ������ ���� ���� 1�� ���� -> ��� 
-- ������ �ζ� ��ȣ 1�� ���
-- ������ ���� 6�ڸ� �߻����Ѽ� ���

SELECT TRUNC(sys.dbms_random.value (0, 101) ) "���� ����"
FROM dual;

SELECT TRUNC(sys.dbms_random.value (1, 46) ) "�ζ� ��ȣ"
FROM dual;

SELECT  (TRUNC(sys.dbms_random.value (0,10)) || TRUNC(sys.dbms_random.value (0,10)) || TRUNC(sys.dbms_random.value (0,10))
            ||TRUNC(sys.dbms_random.value (0,10)) || TRUNC(sys.dbms_random.value (0,10)) || TRUNC(sys.dbms_random.value (0,10)) ) "���� 6"
FROM dual;

--�� Ǯ��
SELECT ROUND(sys.dbms_random.value (0, 100) ) ��������
           ,TRUNC( sys.dbms_random.value (0,1000000) ) --������ ��Ȯ���� ����
FROM dual;


-- ����) insa ���̺��� ���� �����, ���� �����
-- ���� �μ��� ���ڻ������ ���ڻ���� ���

--ù��° ��� (SET ���տ����� - UNION ALL)
SELECT '���ڻ����' "����", COUNT(*) "�����"
FROM insa
WHERE MOD( SUBSTR(ssn, 8, 1 ), 2 ) = 1
UNION ALL
SELECT '���ڻ����' "����", COUNT(*) "�����"
FROM insa
WHERE MOD( SUBSTR(ssn, 8, 1 ), 2 ) = 0;

-- �ι�° ��� GROUP BY
SELECT DECODE (  MOD( SUBSTR(ssn, 8, 1 ), 2 )  ,0, '����', 1,'����') ,COUNT(*)
FROM insa
GROUP BY  MOD( SUBSTR(ssn, 8, 1 ), 2 ) ;

SELECT buseo �μ��� ,DECODE (  MOD( SUBSTR(ssn, 8, 1 ), 2 )  ,0, '����', 1,'����') ���� ,COUNT(*) �����
FROM insa
GROUP BY  MOD( SUBSTR(ssn, 8, 1 ), 2 ), buseo
ORDER BY buseo; --���� �׷���� �ذɷ� �������� �ش�

SELECT buseo,
        COUNT ( CASE 
        WHEN SUBSTR(ssn,8,1) =1 THEN '����' END
         ) "���� �����"
         ,COUNT ( CASE 
        WHEN SUBSTR(ssn,8,1) =2 THEN '����' END
         ) "���� �����"
FROM insa
GROUP BY  buseo;

SELECT buseo, SUBSTR(ssn,8,1)
FROM insa
ORDER BY buseo, SUBSTR(ssn,8,1);

-- ����) emp���� �ְ� �޿���, ���� �޿���  ������� ��� 
-- ����) emp���� �μ��� �ְ� �޿���, ���� �޿���  ������� ��� 


SELECT *
FROM emp
WHERE sal IN ( (SELECT MAX(sal) FROM emp) , (SELECT MIN(sal) FROM emp) ) ;
--�̷��� �ǳ�

SELECT *
FROM emp m
WHERE sal IN ( (SELECT MAX(sal) FROM emp WHERE deptno = m.deptno) , (SELECT MIN(sal) FROM emp WHERE deptno = m.deptno) ) 
ORDER BY deptno;
--����?







SELECT e.*
FROM (
    SELECT emp.* , RANK () OVER (ORDER BY sal DESC) r
    FROM emp
       ) e
WHERE e.r= 1 OR e.r = (SELECT COUNT(*) FROM emp);



--���������� ���� (����) ó���� �ƽ��� �� ����
--WHERE e.rank =1 OR e.rank = 12;

SELECT e.*
FROM (
    SELECT emp.* , RANK () OVER (PARTITION BY deptno ORDER BY sal DESC) r
    , RANK () OVER (PARTITION BY deptno ORDER BY sal) ar
    FROM emp
       ) e
WHERE e.r= 1 OR e.ar =1
ORDER BY deptno;


-- ����  emp ���̺��� comm�� 400������ ��� ��ȸ ( comm�� NULL�̾ 400 ����)
SELECT e.*
FROM (
    SELECT emp.*, NVL(comm,0) comm2
    FROM emp
        ) e
WHERE e.comm2 <= 400;
--�ζ��κ� �ʿ����
SELECT *
FROM emp
WHERE NVL(comm,0) <= 400;

-- �̷��Ե� ����
SELECT *
FROM emp
WHERE comm<= 400 OR comm IS NULL;

--LNNVL �Լ� 
--�÷��� NULL�� ��� = TRUE
--�Լ� ���� ������ FALSE�� ��� = TRUE

SELECT *
FROM emp
WHERE LNNVL( comm >= 400); 
-- 400 �̻� �ֵ� -> ����, 400 ���� �ֵ� -> ��, NULL -> �� ,,


--���� �̹��� ������ ��¥�� ���ϱ��� �ִ��� Ȯ��?

SELECT TO_CHAR(LAST_DAY(sysdate), 'dd') ��������
FROM dual;

--����) emp���� sal�� ���� 20�ۼ�Ʈ �ش�Ǵ� ��� ����?
-- (���� �Լ� ���)
SELECT e.*
FROM (
    SELECT emp.*, PERCENT_RANK() OVER(ORDER BY sal) r
    FROM emp
        ) e
WHERE e.r <= 0.2;

--����) ���� �� �������� �ް��Դϴ� . ��¥ ��ȸ ?

SELECT TO_CHAR( sysdate, 'DS TS(DY)') ����
        ,NEXT_DAY(sysdate, '��')
FROM dual;

--���� emp���� �� ������� �Ի����ڸ� �������� 10�� 5���� 20��° �Ǵ� ��¥�� ����϶� ?

SELECT ename
        , ADD_MONTHS( hiredate, 125) + 20 
FROM emp;



--insa ���̺��� 
--[������]
--                                           �μ������/��ü����� == ��/�� ����
--                                           �μ��� �ش缺�������/��ü����� == �μ�/��%
--                                           �μ��� �ش缺�������/�μ������ == ��/��%
--                                           
--�μ���     �ѻ���� �μ������ ����  ���������  ��/��%   �μ�/��%   ��/��%
--���ߺ�       60       14         F       8       23.3%     13.3%       57.1%
--���ߺ�       60       14         M       6       23.3%     10%       42.9%
--��ȹ��       60       7         F       3       11.7%       5%       42.9%
--��ȹ��       60       7         M       4       11.7%   6.7%       57.1%
--������       60       16         F       8       26.7%   13.3%       50%
--������       60       16         M       8       26.7%   13.3%       50%
--�λ��       60       4         M       4       6.7%   6.7%       100%
--�����       60       6         F       4       10%       6.7%       66.7%
--�����       60       6         M       2       10%       3.3%       33.3%
--�ѹ���       60       7         F       3       11.7%   5%           42.9%
--�ѹ���       60       7         M    4       11.7%   6.7%       57.1%
--ȫ����       60       6         F       3       10%       5%           50%
--ȫ����       60       6         M       
SELECT COUNT(buseo) �μ������
FROM insa
GROUP BY buseo;

--Ǫ����


SELECT buseo, 
FROM insa ;










--��Ǯ��
SELECT s.*
  ,ROUND(   �μ������/�ѻ����*100, 2) || '%' "��/��%"
  ,ROUND(   ���������/�ѻ����*100, 2) || '%' "�μ�/��%"
  ,ROUND(   ���������/�μ������*100, 2) || '%'  "��/��%"
FROM (
    SELECT  buseo
    , ( SELECT COUNT(*) FROM insa ) �ѻ����
    , ( SELECT COUNT(*) FROM insa WHERE buseo = t.buseo ) �μ������
    , gender ����
    , COUNT(*) ���������
    FROM 
    (
        SELECT buseo, name, ssn
             , DECODE(  MOD(SUBSTR(ssn,-7,1),2), 1,'M','F' ) gender
        FROM insa
    ) t
    GROUP BY buseo, gender
    ORDER BY buseo, gender
) s;
SELECT s.*
  ,ROUND(   �μ������/�ѻ����*100, 2) || '%' "��/��%"
  ,ROUND(   ���������/�ѻ����*100, 2) || '%' "�μ�/��%"
  ,ROUND(   ���������/�μ������*100, 2) || '%'  "��/��%"
FROM (
    SELECT  buseo
    , ( SELECT COUNT(*) FROM insa ) �ѻ����
    , ( SELECT COUNT(*) FROM insa WHERE buseo = t.buseo ) �μ������
    , gender ����
    , COUNT(*) ���������
    FROM 
    (
        SELECT buseo, name, ssn
             , DECODE(  MOD(SUBSTR(ssn,-7,1),2), 1,'M','F' ) gender
        FROM insa
    ) t
    GROUP BY buseo, gender
    ORDER BY buseo, gender
) s;


--LISTAGG �Լ� (��� ó�� : Ư�� '��' �ȿ� ���� ����)
LISTAGG(ENAME , ' , ') WITHIN GROUP(ORDER BY ENAME DESC) AS ENAMES 

[������]
10   CLARK/MILLER/KING
20   FORD/JONES/SMITH
30   ALLEN/BLAKE/JAMES/MARTIN/TURNER/WARD
40  �������   

SELECT deptno, LISTAGG(ename, ', ') WITHIN GROUP(ORDER BY ename DESC) AS enames
FROM emp 
GROUP BY deptno;


--���� insa���̺��� TOP_N�м�������� �޿� ���� �޴� ž�� ��ȸ ? 

1) �޿� ������ ��������
2) �ο�ѹ� �ǻ�Į�� ����
3) ������ 1-10�� ����Ʈ

SELECT ROWNUM, e.*
FROM (    
    SELECT name,basicpay
    FROM insa
    ORDER BY basicpay DESC
) e
WHERE ROWNUM <= 10;

--���� ) 

SELECT TRUNC(sysdate, 'year') --24�� 1/1
           ,TRUNC(sysdate, 'month') -- 24�� 8�� 1
           ,TRUNC(sysdate, 'dd') --24�� 8�� 12��
           ,TRUNC(sysdate) --�ð����� ����
FROM dual;

--���� (emp���̺�) (���� ������� #�Ѱ� �� �׷���) (LPAD)
[������]
DEPTNO ENAME PAY BAR_LENGTH      
---------- ---------- ---------- ----------
30   BLAKE   2850   29    #############################
30   MARTIN   2650   27    ###########################
30   ALLEN   1900   19    ###################
30   WARD   1750   18    ##################
30   TURNER   1500   15    ###############
30   JAMES   950       10    ##########

SELECT e.* ,ROUND(e.pay/100), RPAD('#', ROUND(e.pay/100), '#') "BAR_LENGTH"
FROM(
SELECT deptno,ename,  (sal+NVL(comm,0)) pay
FROM emp
)e
WHERE e.deptno =30
ORDER BY e.pay DESC;

SELECT TO_CHAR( hiredate, 'WW') -- ���� ��°������  --WW�� 1~7���� ù°�ַ� ģ��
            , TO_CHAR(hiredate, 'IW')-- ���� ��°������    --IW�� ���ϱ���(��~��)
            , TO_CHAR(hiredate, 'W') --���� ���°��
            , hiredate
            ,TO_CHAR(hiredate , 'day')
FROM emp;
-- ����?

--����) emp���̺��� 
--������� ���帹���μ�,�����μ�,����� ���

SELECT *
FROM emp e , dept d
WHERE e.deptno=d.deptno;

SELECT *
FROM dept;



        SELECT d.deptno, d.dname, COUNT(e.empno) ���  --(NVL(COUNT(empno,0)) �̳� COUNT(empno) ����
        --FROM emp e JOIN dept d ON e.deptno =d.deptno  --�������� INNER JOIN �̾��� (������)
        FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno  --�ڵ� ���� �����ʿ�  dept�� �����ϱ� ����Ʈ�ƿ�������
        GROUP BY d.deptno, d.dname;

--
SELECT e.*
FROM(
        SELECT d.deptno, d.dname, COUNT(e.empno) ��� 
                    , RANK () OVER(ORDER BY COUNT(e.empno) DESC) rank
        FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno 
        GROUP BY d.deptno, d.dname
        ORDER BY rank
) e
WHERE e.rank =1 OR e.rank =4;
--
WITH temp AS (
        SELECT d.deptno, d.dname, COUNT(e.empno) ��� 
                    , RANK () OVER(ORDER BY COUNT(e.empno) DESC) rnk
        FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno 
        GROUP BY d.deptno, d.dname
        ORDER BY rnk
)
SELECT *
FROM temp
WHERE temp.rnk IN ( (SELECT MAX(rnk) FROM temp) ,(SELECT MIN(rnk) FROM temp) );
--

WITH a AS (
        SELECT d.deptno, d.dname, COUNT(e.empno) ��� 
        FROM emp e RIGHT OUTER JOIN dept d ON e.deptno =d.deptno 
        GROUP BY d.deptno, d.dname
    ),
        b AS (
        SELECT MAX(���) maxcnt , MIN(���) mincnt
        FROM a
    )
SELECT a.deptno,a.dname,a.���
FROM a,b
WHERE a.��� IN (b.maxcnt, b.mincnt);




--�ǹ� ���ǹ� �ϱ� (����� ���μ��� �� �ǹ�)
https://blog.naver.com/gurrms95/222697767118

--job�� �ÿ����� ���

SELECT 
            COUNT( DECODE(job, 'CLERK', 'o') ) CLERK
            ,COUNT( DECODE(job, 'SALESMAN', 'o') ) SALESMAN
            ,COUNT( DECODE(job, 'PRESIDENT', 'o') ) PRESIDENT
            ,COUNT( DECODE(job, 'MANAGER', 'o') ) "MANAGER"
            ,COUNT( DECODE(job, 'ANALYST', 'o') ) ANALYST
            --���� 2�� 5����
FROM emp;

--�ǹ� (���� �߽����� ȸ����Ű��..��� ��)
SELECT 
FROM (�ǹ� ��� ������)
PIVOT (�׷��Լ�(�����÷�)) FOR �ǹ��÷� IN (�ǹ��÷� AS ��Ī....);

SELECT *
FROM (
        SELECT job
        FROM emp
        )
PIVOT (COUNT(job) FOR job IN ('CLERK', 'SALESMAN', 'PRESIDENT', 'MANAGER', 'ANALYST') );

--��2 emp���� ���� �Ի��� ����� ��ȸ ?
-- 1��   2��  3�� .....
--   2      0    5  ....

SELECT TO_CHAR(hiredate , 'yyyy') year
        ,TO_CHAR(hiredate, 'mm' month
FROM emp;

SELECT *
FROM (
    SELECT TO_CHAR(hiredate , 'yyyy') year
            ,TO_CHAR(hiredate, 'mm') month
    FROM emp
)
PIVOT ( COUNT(month) FOR month IN ('01' AS "1��",'02','03','04','05','06','07','08','09','10','11','12') )
ORDER BY year;

--����) emp ���̺��� job�� ����� ��ȸ
 
 SELECT *
 FROM (
         SELECT job
         FROM emp
)
PIVOT ( COUNT(job) FOR job IN ('CLERK','SALESMAN','PRESIDENT','MANAGER','ANALYST' ) ) ;


--����) emp���� �μ���, �⺰ ����� ��ȸ

--DEPTNO DNAME                      'CLERK' 'SALESMAN' 'PRESIDENT'  'MANAGER'  'ANALYST'
------------ -------------- ---------- ---------- ----------- ---------- ---------- ---------- ---------- 
--        10 ACCOUNTING              1          0           1          1          0
--        20 RESEARCH                    1          0           0          1          1
--        30 SALES                        1          4           0          1          0
--        40 OPERATIONS                 0          0           0          0          0

SELECT *
FROM (
        SELECT d.deptno , d.dname , e.job
        FROM dept d LEFT OUTER JOIN emp e ON d.deptno =e.deptno
)
PIVOT ( COUNT(job) FOR job  IN ( 'CLERK', 'SALESMAN', 'PRESIDENT',  'MANAGER',  'ANALYST' ) );

---���� ) �� �μ��� �� �޿���?
SELECT *
FROM (
    SELECT deptno, sal+NVL(comm,0) pay
    FROM emp
)
PIVOT (   SUM(pay)  FOR deptno IN('10', '20', '30', '40' ) ) ;--���� �ٸ� ���


--���� (����)
SELECT *
FROM (
    SELECT job, deptno, sal, ename
    FROM emp
)
PIVOT ( SUM(sal) AS �հ�, MAX(sal) AS �ְ��, MAX(ename) AS �ְ���  FOR deptno IN( '10', '20', '30', '40' ) );


--����) ������ ���� ���  ���� ������ ���  ������ ������ ���
--                20                        30                      1
SELECT *
FROM (
        SELECT 
                    CASE 
                    WHEN SUBSTR(ssn, 3,4) < TO_CHAR(sysdate, 'mmdd') THEN '���� ���� ���' 
                    WHEN SUBSTR(ssn, 3,4) > TO_CHAR(sysdate, 'mmdd') THEN '���� ������ ���' 
                    ELSE '������ ������ ���' END �����Ǵ�
        FROM insa
            )
PIVOT ( COUNT(�����Ǵ�) FOR �����Ǵ� IN ('���� ���� ���', '���� ������ ���', '������ ������ ���' ) );
--�׷��� PIVOT�� GROUP BY�� ���� ����� �Ѵٰ� �Ѱű���


-- �μ���ȣ�� 4�ڸ��� ����ϰ� �ʹ�.

SELECT   '00' ||deptno -- ���� ������ ���
            , TO_CHAR(deptno, '0999') 
            , LPAD(deptno, 4, '0')
FROM dept;

--�ϱ�(������Ʈ ���) �� �μ��� / ���������. ����� ������� ���
SELECT city,buseo
FROM insa; --11���� ���ð� �ִ�


    SELECT buseo,city,COUNT(*) ����� --�̷��Ը� �ϸ� ����� ���� ������ �ȳ��� , ������ �Ϸ���?
    FROM insa
    GROUP BY buseo, city
    ORDER BY buseo, city;
-- ����Ŭ 10g���� �߰��� ��� : PARTITION BY OUT JOIN ..?































--����) emp ���� ename,pay, ��ձ޿�,  ���� , ���� (�Ҽ��� 3�ڸ�)

SELECT ename, sal+NVL(comm,0)
        , (SELECT ROUND(AVG(sal+NVL(comm,0))) FROM emp)
        , (SELECT  CEIL( AVG(sal+NVL(comm,0))* 100  )/100 FROM emp)
FROM emp;

-- ����2) pay avg_pay, ���� ���� ���� ���
SELECT e.*, CASE WHEN e.pay > e.avg_pay THEN '����'
                 WHEN e.pay < e.avg_pay THEN '����' END ��պ�
FROM(
SELECT ename, sal+NVL(comm,0) pay
        ,(SELECT ROUND(AVG(sal+NVL(comm,0))) FROM emp) avg_pay
FROM emp
)e;

--[����] insa ���̺��� ������ �������� ������ ���� ���θ� ����ϴ� ������ �ۼ��ϼ��� . 
--      ( '������', '��������', '���� ' ó�� )   
-- 1) 1002 �̼��� �ֹι�ȣ ���ó�¥�� ��/�Ϸ� ���� (update)
UPDATE insa
SET ssn = SUBSTR(ssn,1,2) || '0812' || SUBSTR(ssn,7)
WHERE name = '�̼���' ;
commit;
SELECT *
FROM insa;
-- 2) ���� ���� ����

SELECT name, ssn, CASE WHEN SUBSTR(ssn,3,4) > TO_CHAR(sysdate,'mmdd') THEN '������'
            WHEN SUBSTR(ssn,3,4) < TO_CHAR(sysdate,'mmdd') THEN '����'
            ELSE '������ �� ���� 'END ���� 
FROM insa;

--����) insa���� ssn�� ������  ������ ����ؼ� ���?
-- ������ : ���س⵵ - ���ϳ⵵  ������������ �״��, ���������� -1
-- �����ڸ���) 1,2 �� 1900  3,4 2000  0,9 1800��� ,, 56 �ܱ��� 1900 . 78 �ܱ��� 2000
-- ����) insa ���̺��� ���� �����, ���� �����



SELECT  CASE WHEN SUBSTR(ssn,8,1) = 1 THEN '����'
              WHEN SUBSTR(ssn,8,1) = 2 THEN '����'
              END sex
        ,COUNT ( SUBSTR(ssn,8,1) ) employee
FROM insa
GROUP BY SUBSTR(ssn,8,1);


-- ���� �μ��� ���ڻ������ ���ڻ���� ���

SELECT buseo
        ,CASE WHEN SUBSTR(ssn, 8, 1) =1 THEN '����'
              WHEN SUBSTR(ssn, 8, 1) =2 THEN '����'
              END ����
        ,COUNT(SUBSTR(ssn, 8, 1)) �����
FROM insa
GROUP BY buseo,SUBSTR(ssn, 8, 1)
ORDER BY buseo;

-- ����) emp���� �ְ� �޿���, ���� �޿���  ������� ��� 

SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal) FROM emp) OR sal = (SELECT MIN(sal) FROM emp) ;

-- ����) emp���� �μ��� �ְ� �޿���, ���� �޿���  ������� ��� 

SELECT *
FROM emp e
WHERE sal = (SELECT MAX(sal) FROM emp WHERE deptno = e.deptno)
;



-- ����  emp ���̺��� comm�� 400������ ��� ��ȸ ( comm�� NULL�̾ 400 ����)
--����) emp���� sal�� ���� 20�ۼ�Ʈ �ش�Ǵ� ��� ����?
-- (���� �Լ� ���)
--����) ���� �� �������� �ް��Դϴ� . ��¥ ��ȸ ?
--���� emp���� �� ������� �Ի����ڸ� �������� 10�� 5���� 20��° �Ǵ� ��¥�� ����϶� ?

--insa ���̺��� 
--[������]
--                                           �μ������/��ü����� == ��/�� ����
--                                           �μ��� �ش缺�������/��ü����� == �μ�/��%
--                                           �μ��� �ش缺�������/�μ������ == ��/��%
--                                           
--�μ���     �ѻ���� �μ������ ����  ���������  ��/��%   �μ�/��%   ��/��%
--���ߺ�       60       14         F       8       23.3%     13.3%       57.1%
--���ߺ�       60       14         M       6       23.3%     10%       42.9%
--��ȹ��       60       7         F       3       11.7%       5%       42.9%
--��ȹ��       60       7         M       4       11.7%   6.7%       57.1%
--������       60       16         F       8       26.7%   13.3%       50%
--������       60       16         M       8       26.7%   13.3%       50%
--�λ��       60       4         M       4       6.7%   6.7%       100%
--�����       60       6         F       4       10%       6.7%       66.7%
--�����       60       6         M       2       10%       3.3%       33.3%
--�ѹ���       60       7         F       3       11.7%   5%           42.9%
--�ѹ���       60       7         M    4       11.7%   6.7%       57.1%
--ȫ����       60       6         F       3       10%       5%           50%
--ȫ����       60       6         M       

SELECT e.*
        , ROUND(e.�μ��������/e.��ü , 3)* 100 || '%' "��/�� ����"
        , ROUND(e.�����/e.��ü , 3)* 100 || '%' "��/�� ����"
        , ROUND(e.�����/e.�μ�������� , 3)* 100 || '%' "��/�� ����"
FROM(
    SELECT  buseo �μ���
            , (SELECT COUNT(*) FROM insa) ��ü
            , (SELECT COUNT(buseo) FROM insa WHERE buseo=i.buseo) �μ��������
            , DECODE(SUBSTR(SSN,8,1),1,'����',2,'����') ����
            , COUNT(*) �����
    FROM insa i
    GROUP BY buseo,SUBSTR(SSN,8,1)
    ORDER BY buseo,���� DESC
)e;








--���� insa���̺��� TOP_N�м�������� �޿� ���� �޴� ž�� ��ȸ ? 
--���� (emp���̺�) (���� ������� #�Ѱ� �� �׷���) (LPAD)
--����) emp���̺��� 
--������� ���帹���μ�,�����μ�,����� ���

--��2 emp���� ���� �Ի��� ����� ��ȸ ?
-- 1��   2��  3�� .....
--   2      0    5  ....

--����) emp ���̺��� job�� ����� ��ȸ

--����) emp���� �μ���, �⺰ ����� ��ȸ




