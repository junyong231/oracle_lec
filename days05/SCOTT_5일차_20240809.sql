--emp ���̺��� job ����?

SELECT COUNT(DISTINCT job)
FROM emp;

SELECT COUNT(*)
FROM ( 
        SELECT DISTINCT job
        FROM emp
        ) e;

SELECT *
FROM emp;

-- emp�μ��� �����?

SELECT deptno, COUNT(*)  --�׷� ���� ���� �ִ� �÷��� �����Լ��͵� �� �� �ִ�.
FROM emp            
GROUP BY deptno --�׷캰�� ���ĸ�
ORDER BY deptno ASC;

--[����]  40�� �μ��� ���� ���µ�, 0�̶�� ������? 

SELECT COUNT(*)
           ,COUNT(DECODE (deptno, 10, sal)) "10"
           ,COUNT(DECODE (deptno, 20, sal)) "20"
           ,COUNT(DECODE (deptno, 30, sal)) "30"
           ,COUNT(DECODE (deptno, 40, sal)) "40"
FROM emp;
-- COUNT �� NULL�� ���� �ʰ�, DECODE�� ���ǿ� ���� ������ NULL�� ��ȯ�ϹǷ� COUNT�� ���ǿ� �����ϴ� ��츸�� ���� �ȴ�.
-- sal�� �ƹ� �ǹ̾��� �׳� NULL�� �ȳ������ (comm������) �׳� ��� 1������ �൵�� ���⸸ �ϸ� �Ǵϱ�

SELECT *
FROM emp;

 SELECT '10', COUNT(deptno) �μ����ο�
 FROM emp
 WHERE deptno=10
 UNION
 SELECT '20', COUNT(deptno)
 FROM emp
 WHERE deptno=20
 UNION
 SELECT '30', COUNT(deptno)
 FROM emp
 WHERE deptno=30
 UNION
 SELECT '40', COUNT(deptno)
 FROM emp
 WHERE deptno=40
 UNION
 SELECT '��ü�����' , COUNT(*)
 FROM emp;
 
 -- ����)  insa ���� �� �����, ���� �����, ���� ����� ��ȸ?

-- COUNT ,DECODE �̿� 
SELECT  COUNT(*) "�� �����"
            , COUNT(DECODE (SUBSTR(ssn,8,1) ,1 ,'o') ) "���� �����" 
            , COUNT(DECODE (SUBSTR(ssn,8,1) ,2 ,'o') ) "���� �����" 
FROM insa;

--GROUP BY �̿�
SELECT  CASE SUBSTR(ssn, 8, 1) WHEN '1' THEN '����' ELSE '����' END "����"
                            , COUNT(SUBSTR(ssn, 8, 1)) �ο���
FROM insa
GROUP BY SUBSTR(ssn,8,1);



SELECT CASE MOD(SUBSTR(ssn,8,1), 2) WHEN 0 THEN '����'
                                                      WHEN 1 THEN '����' END GENDER
         , COUNT(*)
FROM insa
GROUP BY MOD(SUBSTR(ssn,8,1),2); -- 0�̳� 1�̳� ���� ����



-- ROLL UP
SELECT CASE MOD(SUBSTR(ssn,8,1), 2) WHEN 0 THEN '����'
                                                      WHEN 1 THEN '����' 
                                                      ELSE '��ü' END GENDER
         , COUNT(*) �����
FROM insa
GROUP BY ROLLUP (MOD(SUBSTR(ssn,8,1),2) ); -- 0�̳� 1�̳� ���� ����


--emp���� �޿� ���� ���� �޴� ��� ���� ��ȸ
SELECT *
FROM emp
WHERE (sal + NVL (comm,0) ) = (
                                                SELECT MAX(sal + NVL(comm,0))
                                                FROM emp
                                            );

--SQL ������ (ALL,SUM,ANY,EXIST)
SELECT *
FROM emp
WHERE (sal+ NVL(comm,0)) <= ALL( SELECT sal+ NVL(comm,0) FROM emp) ; --��� �ֵ麸��..(������ ������� = ���� ���� �޴¾�)

--���� ) emp ���̺���  �� �μ��� �ְ� �޿����� ���� ��ȸ ?

SELECT *
FROM emp
WHERE  (sal+ NVL(comm,0)) = ANY  (
                                                SELECT MAX(sal + NVL(comm,0))
                                                FROM emp
                                                GROUP BY deptno  
                                                    ); --�� �ڵ� Ʋ��: �ٸ� �μ��ε� �츮 �μ� ¯�̶� ������ �°� ���� �� ����

SELECT deptno �μ���ȣ, MAX( sal + NVL(comm,0) ) �޿�
FROM emp
GROUP BY deptno
ORDER BY deptno ASC; -- ��������� ��ȸ�� ���� ����


SELECT *
FROM emp m
WHERE sal+NVL(comm,0) = (
                                            SELECT MAX(sal+NVL(comm,0)) 
                                            FROM emp s
                                            WHERE deptno = m.deptno --��ȣ ���� ���� ����
                                        );

--emp ���̺��� pay ���� ���

SELECT *
FROM (
        SELECT m.*
        , (SELECT COUNT(*)+1 FROM emp WHERE sal > m.sal ) RANK
        , (SELECT COUNT(*)+1 FROM emp WHERE sal > m.sal AND deptno =m.deptno ) "�μ��� ���"
        FROM emp m
         ) e
WHERE e."�μ��� ���" <= 2
ORDER BY deptno ASC , "�μ��� ���";

--���� ) insa���� �μ��� �ο����� 10�� �̻��� �μ��� ��ȸ ?

SELECT *
FROM insa;

SELECT *
FROM (
            SELECT buseo ,COUNT(*) "�ο���"
            FROM insa
            GROUP BY buseo
        ) m
WHERE  m."�ο���" >= 10;


-- HAVING 
SELECT buseo ,COUNT(*) "�ο���"
FROM insa
GROUP BY buseo
HAVING COUNT(*) >= 10; -- �׷���� �ѰͿ� ���� ����. ���� �Ȱ��� �ڵ��



--����) insa���� ���ڻ������ 5�� �̻��� �μ� ?

SELECT buseo ,COUNT( DECODE( MOD(SUBSTR(ssn,8,1),2) ,0 ,'����' ) ) ���������
FROM insa
GROUP BY buseo
HAVING COUNT( DECODE( MOD(SUBSTR(ssn,8,1),2) ,0 ,'����' ) )>=5;


SELECT name,buseo,SUBSTR(ssn,8,1)
FROM insa
ORDER BY buseo;


--�Ϳ�!
SELECT buseo, COUNT(*)
FROM insa
WHERE MOD(SUBSTR(ssn,8,1),2) = 0 --ó�� ������ �ƴϱ� ���ڸ� ����� ����� ����...!!
GROUP BY buseo
HAVING COUNT(*) >= 5; 


-- [����] emp ���̺���
--       ��� ��ü ��ձ޿�(pay)�� ����� ��
--       �� ������� �޿��� ��ձ޿����� ���� ��� "����" ���
--                                "   ���� ��� "����" ���.
-- 2260.416666666666666666666666666666666667
SELECT AVG( sal + NVL(comm, 0) )  avg_pay
FROM emp;
--
SELECT empno, ename, pay , ROUND( avg_pay, 2) avg_pay
     , CASE 
          WHEN pay > avg_pay   THEN '����'
          WHEN pay < avg_pay THEN '����'
          ELSE '����'
       END
FROM (
        SELECT emp.*
              , sal + NVL(comm,0) pay
              , (SELECT AVG( sal + NVL(comm, 0) )  FROM emp) avg_pay
        FROM emp
    ) e;
    
    
SELECT e.*,
        CASE WHEN pay > avg_pay THEN '����' 
                WHEN pay < avg_pay THEN '����' 
                END

FROM (SELECT emp.*
              , sal + NVL(comm,0) pay
              , (SELECT AVG( sal + NVL(comm, 0) )  FROM emp) avg_pay
              FROM emp
              ) e ;


    
    

    
    
-- [����] emp ���̺���
--       ��� ��ü ��ձ޿�(pay)�� ����� ��
--       �� ������� �޿��� ��ձ޿����� ���� ��� "����" ���
--                                "   ���� ��� "����" ���.
-- 2260.416666666666666666666666666666666667
SELECT AVG( sal + NVL(comm, 0) )  avg_pay
FROM emp;
--
SELECT empno, ename, pay , ROUND( avg_pay, 2) avg_pay
     , CASE 
          WHEN pay > avg_pay   THEN '����'
          WHEN pay < avg_pay THEN '����'
          ELSE '����'
       END
FROM (
        SELECT emp.*
              , sal + NVL(comm,0) pay
              , (SELECT AVG( sal + NVL(comm, 0) )  FROM emp) avg_pay
        FROM emp
    ) e;

SELECT e.*
    ,CASE 
        WHEN sal+NVL(comm,0) <(SELECT AVG(sal+NVL(comm,0))FROM emp) THEN '����'
        ELSE '����'
    END p
FROM emp e;



--NULLIF ���
SELECT ename, pay, avg_pay
     , NVL2( NULLIF( SIGN( pay - avg_pay ), 1 ), '����' , '����') 
FROM (
        SELECT ename, sal+NVL(comm,0) pay 
            , (SELECT AVG( sal + NVL(comm,0 )) avg_pay FROM emp) avg_pay
        FROM emp
      );



-- emp ���̺��� �ְ�޿� �����޿� ��� ���
-- �� Ǯ�� �ٿ��־����..

SELECT e.*
FROM (
            SELECT emp.*
            FROM emp
            WHERE  (sal + NVL(comm, 0)) =  (SELECT MAX(sal + NVL(comm, 0)) FROM emp)
            OR (sal + NVL(comm, 0)) = (SELECT MIN(sal + NVL(comm, 0)) FROM emp)
        ) e;

SELECT e.*
FROM emp e
WHERE (sal + NVL(comm, 0)) = (SELECT MAX(sal + NVL(comm, 0)) FROM emp)
      OR (sal + NVL(comm, 0)) = (SELECT MIN(sal + NVL(comm, 0)) FROM emp);

-- ����) insa���� ������ �� �μ��� ����,���� ��� ��, �μ��� ���� �޿� ����, ���� �޿� ���� ��� ?

SELECT *
FROM insa;

SELECT e.*
FROM (
            SELECT buseo �μ���, COUNT( DECODE( MOD(SUBSTR(ssn,8,1),2) ,0 ,'��' ) ) ��������
                                , COUNT( DECODE( MOD(SUBSTR(ssn,8,1),2) ,1 ,'��' ) ) ��������
                                , SUM( DECODE( MOD(SUBSTR(ssn,8,1),2) ,1 ,basicpay ) ) "�������޿�"
                                , SUM( DECODE( MOD(SUBSTR(ssn,8,1),2) ,0 ,basicpay ) ) "�������޿�"
                                , SUM(basicpay) "�μ��� �ѱ޿�"
            FROM insa
            WHERE city = '����'
            GROUP BY buseo
            ) e;
--�䱸���� �ϳ��� �ذ��ϴٺ��� �� ����.

--�ٸ� Ǯ�̿� ����(2���׷�)

SELECT buseo, COUNT(*), jikwi, SUM(basicpay), AVG(basicpay)
FROM insa
GROUP BY ROLLUP (buseo, jikwi ) --�Ѿ��ϴ� ��ü �μ� ��յ� ������
ORDER BY buseo, jikwi ; 
-- �׷���� �ι�: �μ��� ������� �ɰ���

--�ٸ� Ǯ��

SELECT buseo
         , DECODE( MOD(SUBSTR(ssn,8,1),2) ,1 ,'����' , 0 , '����' ) ����
         , COUNT(*) �����
         , SUM( basicpay ) "�ѱ޿���"
         , SUM( DECODE( MOD(SUBSTR(ssn,8,1),2) ,1 ,basicpay, 0 ) ) "�������޿�"
FROM insa
WHERE city = '����'
GROUP BY buseo, MOD(SUBSTR(ssn, 8, 1), 2) -- �μ��� ������ ��/��� �� ���� �� ���� �� �ִ� �μ��� 2�� ����
ORDER BY buseo, MOD(SUBSTR(ssn, 8, 1), 2);



-- ROWNUM (�ǻ��÷�? - ���������� ���)


--�����ġ� TOP_N �м�
	SELECT �÷���,..., ROWNUM
	FROM (
                SELECT �÷���,... from ���̺��
                ORDER BY top_n_�÷���
              )
    WHERE ROWNUM <= n ;
--ž 3�̸� n=3

--�������� �켱���� ��� �ۼ� -> �ζ������� �ٲٱ� -> �γ� ��� WHERE�� TOP ���� ���� ����ָ�� (**�߰������� ����� ��� ���� BETWEEN ��)
--TOP_N �м�
SELECT ROWNUM, e.*
FROM (
    SELECT *
    FROM emp
    ORDER BY sal DESC
        ) e 
WHERE ROWNUM <= 3 ;

--��� �ѹ� �� �ζ��κ�(�Ǵ� WITH)�� ���θ� ��
SELECT *
FROM(
        SELECT ROWNUM "row" , e.*
        FROM (
            SELECT *
            FROM emp
            ORDER BY sal DESC
                ) e 
        )
WHERE "row" BETWEEN 3AND 5;



--ORDER BY ���� �ִ� �������� ROWNUM  ��������. ������ ����
--TOP_N �м��� �������� �ϰ� -> �γ� �ٿ����� ������� �������� (�����ϰ� ���ĵ� ������ ���ڸ� �ο��� ����)
SELECT ROWNUM, emp.*
FROM emp
ORDER BY sal DESC;

-- ROLLUP, CUBE
--�Ѿ�: �׷�ȭ�ϰ� �׷쿡 ���� �κ���


SELECT deptno, COUNT(*)
FROM emp
GROUP BY deptno
ORDER BY deptno ASC;
--deptno���� ���� �μ��̸��� ������ �ϰ� �ʹ�? => ����


SELECT  dname, job,  COUNT(*) 
FROM emp e, dept d
WHERE e.deptno = d.deptno
--GROUP BY e.deptno, dname-- �μ���ȣ�� ���ĸ��̰�, �μ��̸����� �� ���ĸ��̴���� ��� �����Ƿ� ����� ����
--GROUP BY dname, job
--GROUP BY ROLLUP ( dname  ) --�Ѿ�: �׷�ȭ�ϰ� �׷쿡 ���� �κ���
GROUP BY ROLLUP ( dname , job  ) --�κ��� ����
--ORDER BY e.deptno ASC;
ORDER BY dname ;



-- 2) CUBE: ROLLUP ����� GROUP BY ���ǿ� ���� ��� ������ �׷��� ���տ� ���� ��� ���
SELECT  dname, job,  COUNT(*) 
FROM emp e, dept d
WHERE e.deptno = d.deptno
GROUP BY CUBE ( dname , job  ) --job�� �����
ORDER BY dname ;


--����Rank�� ���õ� �Լ� 
-- ORDER BY�� �ʼ�(������ �ؾ� ������ �ű��)
--emp ���̺� �޿������� ��� �Űܺ���


SELECT ename, sal  ,sal +NVL(comm,0) pay
            ,RANK(  ) OVER ( ORDER BY sal +NVL(comm,0) DESC ) "RANK() ����"
            ,DENSE_RANK(  ) OVER ( ORDER BY sal +NVL(comm,0) DESC ) "DENSE_RANK() ����" --�ߺ� ī���� ���ؼ� 4���� ����
            ,ROW_NUMBER(  ) OVER ( ORDER BY sal +NVL(comm,0) DESC ) "ROW_NUMBER() ����" --�׳� ������� 1���� ���� PAY�� ��ҿ� ������� Ʃ���� ��ġ�� ������
            
FROM emp;

--JONES 2850���� �ٲ���

SELECT *
FROM emp
WHERE ename LIKE ('%JONES%') ; --jones�� ������� ���� �̷��� �˻���

UPDATE emp
SET sal = 2850
WHERE empno = 7566 ;

commit;


--���� �Լ� ��� ����
--emp���� �μ����� �޿� ������ �Űܺ���


SELECT e.*
FROM (
            SELECT emp.*
        --,  RANK() OVER( ���� ��Ƽ�� �� �����ڸ� ORDER BY sal+NVL(comm,0) DESC )
         ,  RANK() OVER( PARTITION BY deptno ORDER BY sal+NVL(comm,0) DESC ) ���� -- �μ��� ������
         ,  RANK() OVER(ORDER BY sal+NVL(comm,0) DESC ) ��ü���� 
            FROM emp
            ) e
ORDER BY "��ü����";

WHERE "����" BETWEEN 2 AND 3;
--�̷��� �����ϰ� �Ǵ°ſ���

--insa ������� 14�� ��...¥����

SELECT CEIL(COUNT(*)/14) "�� ��"
FROM insa;


--����) insa ���̺��� ������� ���� ���� �μ��� �μ���� ��� ���� ����
SELECT buseo, COUNT(*)
FROM insa
WHERE SUBSTR(ssn,8,1) = 2
GROUP BY buseo
ORDER BY buseo;

SELECT e.*
FROM(
            SELECT buseo, RANK() OVER( ORDER BY COUNT(*) ) br ,COUNT(*) �����
            FROM insa
            GROUP BY buseo
         ) e
WHERE br = 1;
--���ϰڵ�
SELECT e.*
FROM (
            SELECT buseo, COUNT(*)
                        , RANK() OVER( ORDER BY COUNT(*) DESC ) �μ�����
            FROM insa
            GROUP BY buseo
--HAVING RANK() OVER( ORDER BY COUNT(*) DESC ) =1 ; --ORA-30483: window  functions are not allowed here
        ) e
WHERE "�μ�����" =1;


-- ����:insa���� ���ڻ������ ���� ���� �μ��� �� ����� ���

SELECT e.*
FROM (
            SELECT buseo, COUNT(DECODE(MOD(SUBSTR(ssn,8,1),2),0,'��' )) ���ڻ����
                        , RANK() OVER( ORDER BY COUNT( DECODE(MOD(SUBSTR(ssn,8,1),2),0,'��' )) DESC  ) �μ�����
            FROM insa
            GROUP BY buseo
        ) e
WHERE "�μ�����" =1;

--�����ϰ� �� �� �ֵ�
SELECT e.*
FROM (
            SELECT buseo, COUNT(*)
                        , RANK() OVER( ORDER BY COUNT(*) DESC ) �μ�����
            FROM insa
            WHERE MOD(SUBSTR(ssn,8,1),2) = 0
            GROUP BY buseo
--HAVING RANK() OVER( ORDER BY COUNT(*) DESC ) =1 ; --ORA-30483: window  functions are not allowed here
        ) e
WHERE "�μ�����" =1;

--���� ) insa���� basicpay �� ���� 10%�� ����� �̸��� basicpay ���

SELECT e.name,e.basicpay
FROM (
            SELECT name, basicpay
                        ,RANK() OVER( ORDER BY basicpay ) pay
            FROM insa
            
          )  e
WHERE pay <= (SELECT COUNT(*) * 0.1 FROM insa) ;           
--���������� ���̴�...

-- �ۼ�Ʈ ��ũ �Լ�?!
SELECT e.name,e.basicpay
FROM (
            SELECT name, basicpay
                        ,PERCENT_RANK() OVER( ORDER BY basicpay DESC ) pay -- �Ҽ������� �ۼ�Ƽ�� ���Ǿ�����
            FROM insa
            
          )  e
WHERE pay <= 0.1 ;

-- �ָ� ���� ���α׷��ӽ� JOIN ���� Ǯ���..?








