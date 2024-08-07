-- SCOTT
-- SCOTT�� ������ ���̺� ��� ��ȸ
SELECT *
FROM tabs;
-- == FROM user_tables;
-- FROM all_tables; 
-- FROM dba_tables; ������ �˱�

--insa ���̺� ���� �ľ�

DESC insa;

--insa ��� ���� ��ȸ?
SELECT *
FROM emp;
--IBSADATE �� ǥ�� 98/10/11 => RR/MM/DD �� ǥ��������
-- YY�� RR�� ����??

--���� - ȯ�漳�� - DB -NLS �� ���� ���� ��µ�
SELECT *
FROM v$nls_parameters;

--emp���̺��� ��� ���� ��ȸ (��� ����, �����, �Ի�����) ��ȸ
-- SELECT �� FROM ���� ���� ����
--WITH 
--SELECT 
--FROM 
--WHERE 
--GROUP BY 
--HAVING 
--ORDER BY ;

--���� = �⺻��sal + ����comm ���� ����غ���
SELECT empno,ename,hiredate
--       , NVL(comm, 0) --NULL�̸� comm�״��, �ƴϸ� 0���� ���
--       , NVL2(comm ,comm, 0) --���� ���� ��¦ ���׿����ڰ���
--       , sal , comm
--       ,sal+comm AS ���� --�ּ����� ���� ���� �����ؼ� ���� ����
        ,sal + NVL(comm, 0) pay --��Ī�� �빮�ڷ� �ڵ���ȯ��
       
FROM emp;

-- ����Ŭ���� NULL ?
-- ��Ȯ�ΰ�

--���� ? emp ���̺��� �����ȣ, �����, ���ӻ��(mgr) ��ȸ
SELECT empno, ename, mgr
        ,NVL(TO_CHAR(mgr), 'CEO') string
        ,NVL (mgr || '', 'CEO') --���ļ� ���ڿ��� ����� �ٲ������ ����
FROM emp;

SELECT '�̸��� ''' || ename || '''�̰�, ������ ' || job || '�̴�.'
FROM emp;

--emp ���̺��� �μ���ȣ�� 10���� ����鸸 ��ȸ ?
-- 1) dept(�μ�) ���̺� �������� ����
SELECT *
FROM dept;

-- emp���̺��� �� ����� �����ִ� �μ���ȣ�� ��ȸ
--SELECT DISTINCT deptno

SELECT *
FROM emp
WHERE deptno = 10;

--���� ? emp ���̺��� 10�� �μ����� �����ϰ� ������ ����� ��ȸ ?

SELECT *
FROM emp
WHERE deptno != 10; -- ^= �̳� <>  �ᵵ ���� 
--WHERE deptno =20 OR deptno =30 OR deptno =40;
--WHERE NOT ( deptno =10 ) ; �� �ȴ�

SELECT *
FROM emp
-- WHERE deptno =20 OR deptno =30 OR deptno =40;
WHERE deptno IN (20,30,40); --���� ������ ���� (���� ������ ��)

--���� ? emp ���̺��� ������� FORD�� ����� ��� ���� ��� ?
SELECT *
FROM emp
WHERE ENAME = UPPER('ford');  --�빮�� ��ȯ �Լ� 

SELECT LOWER(ename) , INITCAP( job) --�̸� �ҹ��� ��µ�, ���� ù���� �빮�ڵ�
FROM emp;

--���� ? emp���̺��� comm�� NULL�� ����� ���� ��� ?
SELECT *
FROM emp
WHERE comm IS NULL ;

--���� ? emp���̺��� ������ 2000�̻� 4000���� �޴� ����� ��ȸ , sal + comm �� ����

SELECT ���.* , NVL(comm,0) + sal ����
FROM emp ��� -- ���⵵ ��Ī �� �� �ֵ�
WHERE NVL(comm,0) + sal BETWEEN 2000 AND 4000; 
--WHERE ���� >= 2000 AND ����<=4000; ���� ��� : FROM - WHERE - SELECT ������ ����Ǵ�, WHERE�ܰ迡�� ������ ����.

SELECT ���.* , NVL(comm,0) + sal ����2
FROM emp ��� -- ���⵵ ��Ī �� �� �ֵ�
WHERE NVL(comm,0) + sal >= 2000 AND NVL(comm,0) + sal<=4000; 

--WITH �� ����غ���
WITH temp AS ( 
               SELECT ���.* , NVL(comm,0) + sal ����3
               FROM emp ��� 
             ) --�������� ���� ����
SELECT *
FROM temp
WHERE ����3 >= 2000 AND ����3 <=4000;

-- �ζ��κ�( inline view ) �����
SELECT *
FROM ( 
        SELECT ���.* , NVL(comm,0) + sal ����3
        FROM emp ��� 
      ) e 
WHERE e.����3 >= 2000 AND e.����3 <= 4000;
-- BETWEEN �Ẹ��
SELECT *
FROM ( 
        SELECT ���.* , NVL(comm,0) + sal ����3
        FROM emp ��� 
      ) e 
WHERE e.����3 BETWEEN 2000 AND 4000;

--���� insa ���̺��� 70������ ����� ������ ���
SELECT *
FROM insa
--WHERE REGEXP_LIKE(SSN, '^7');
WHERE ssn LIKE '%7%';

SELECT name, ssn
       ,SUBSTR(ssn,0,1)�ֹι�ȣ_ù����
       ,INSTR(ssn,7) 
       -- 7�� �� ��ġ�� 1�� �ֵ鸸 �̾Ƴ����� �ְڳ�
FROM insa  
WHERE TO_NUMBER( SUBSTR(ssn,0,2) ) BETWEEN 70 AND 79; --TO_NUMBER���ص� �ڵ�����ȯ���ֳ�
--WHERE SUBSTR(ssn,0,1) = 7;
--WHERE INSTR(ssn, 7) = 1;

--SUBSTR--
SELECT name
       ,SUBSTR(ssn,0,8)||'******' RRN
FROM insa ;

SELECT name
       ,CONCAT(SUBSTR(ssn,0,8),'******') RRN 
FROM insa ;

--�̷��͵� �ֳ� 
SELECT name
       ,RPAD( SUBSTR(ssn,0,8),14,'*' ) RRN
FROM insa ;

SELECT name
       ,REPLACE(ssn, SUBSTR(ssn,9,14),'******') RRN
FROM insa ; --�̰� �ǳ� ����


SELECT name
       ,REGEXP_REPLACE(ssn, '(\d{6}-\d)\d{6}', '\1******')RRN
    --                      (��6�ڸ�-��ù�ڸ� ����)\�������ڸ� �� ����(\1) ���ΰ� �� *��
FROM insa ; 



SELECT name, ssn
    ,SUBSTR(ssn,0,6) ���ڸ�
    ,SUBSTR(ssn,0,2) YEAR
    ,SUBSTR(ssn,3,2) MONTH
    ,SUBSTR(ssn,5,2) "DATE" 
    --����Ʈ ������ ���� �ȵ�, �� ��������� " " ���̱�
    -- '771212' �� ��¥�� ����ȯ ?
    ,TO_DATE(SUBSTR(ssn,0,6))BIRTH
    --��¥���� ������ �̾ƿ��� (���ڸ��� �������⵵ ����)
    ,TO_CHAR(TO_DATE(SUBSTR(ssn,0,6)),'YYYY') y
FROM insa
--WHERE TO_DATE(SUBSTR(ssn,0,6)) BETWEEN '70/01/01' AND '79/12/31';
--�̰� �ǳ� ������
WHERE TO_CHAR(TO_DATE(SUBSTR(ssn,0,6)),'YY') BETWEEN 70 AND 79;
--�̷��� �񱳵� �����ϱ�

SELECT ename, hiredate --DATEŸ���ε��� SUBSTR�� �߶�����
    ,SUBSTR(hiredate, 0,2) year
    ,SUBSTR(hiredate, 4,2) month
    ,SUBSTR(hiredate, -2,2) "DATE"
FROM emp;

SELECT ename, hiredate
    --,TO_CHAR(hiredate, 'format')
    ,TO_CHAR(hiredate, 'YYYY') YEAR --���ڿ�
    ,TO_CHAR(hiredate, 'MM') MONTH --���ڿ�
    ,TO_CHAR(hiredate, 'DD') "DATE" --���ڿ�
    ,TO_CHAR(hiredate, 'DAY') EE --���ڿ�
    
    --EXTRACT() �Լ� ? .. ����
    
    ,EXTRACT( YEAR FROM hiredate) --����(������ ����)
    ,EXTRACT( MONTH FROM hiredate)
    ,EXTRACT( DAY FROM hiredate)
    
FROM emp;

--���� ��¥ ������ ���

SELECT SYSDATE
    ,TO_CHAR(SYSDATE , 'DS    TS')
    ,CURRENT_TIMESTAMP --���뼼������� ���͹���
    
FROM dept; --FROM���� �ʼ��� ����

--insa ���̺��� 70��� ��� ��� ���� ��ȸ.
-- LIKE     SQL ������ ����غ���
-- �达 ��� ã��
SELECT *
FROM insa
--WHERE name LIKE '��%';
--�� ���� �ƹ��ų� ��� ��.

--WHERE name LIKE '%��%';
--���� ������� �̸��� '��'�� ���ԵǾ��ִٸ�

--WHERE name LIKE '%��';
--�տ��� ���� ��������� �� �ڿ��� '��'�� �;��� 

--WHERE ssn LIKE '%-1%';
--WHERE ssn LIKE '______-1______';
--���� ��� ��������

WHERE ssn LIKE '7_12%';
--70��� 12���� 

--REGEXP_LIKE �Լ� 
SELECT *
FROM insa
--WHERE REGEXP_LIKE (ssn, '^7.12'); --�̰� ���� �ƴϾ �Ǵ� �״���
--WHERE REGEXP_LIKE (ssn, '^7[0-9]12');
WHERE REGEXP_LIKE (ssn, '^7\d12');

--�达 ���� ��� ��� ��� ?
SELECT *
FROM insa
WHERE name NOT LIKE '��%';
--WHERE REGEXP_LIKE( name, '^[^����]'); --�̷��� �ϸ� ���� ���� ���ܵ� �԰���
--���ȣ �ȿ� ^�� ������.. �ۿ� �ִ°� ù����

-- [����]��ŵ��� ����, �λ�, �뱸 �̸鼭 ��ȭ��ȣ�� 5 �Ǵ� 7�� ���Ե� �ڷ� ����ϵ�
--      �μ����� ������ �δ� ��µ��� �ʵ�����. 
--      (�̸�, ��ŵ�, �μ���, ��ȭ��ȣ)

--�μ����� �α��� �ʰ��ϸ� ��¿�ǵ�...
SELECT name,city,SUBSTR(buseo,1,2)buseo
        ,tel
FROM insa
WHERE (city = '����' OR city = '�λ�' OR city = '�뱸')
    AND (tel LIKE '%5%' OR tel LIKE '%7%');

--����ǥ���� �԰��� 
SELECT name,city,SUBSTR(buseo,1,LENGTH(buseo)-1)buseo 
        ,tel
FROM insa
WHERE REGEXP_LIKE(city, '����|�λ�|�뱸')
    AND REGEXP_LIKE(tel, '[57]' );


