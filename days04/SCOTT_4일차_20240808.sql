--SCOTT
--������������ CHAR���� RR YY ���̺��� ����
--����Ŭ ������ Ư_ WHERE�������� ����
--����) ��������� ������������ .. MOD(10,3) = 1
--�� ���ϱ� : ���� FLOOR(10/3)
SELECT FLOOR(10/3) ��
FROM dual;
--6) SET(����) ������
���� ������ ����� �Ǵ� �� �÷��� ���� ���� �����Ǵ� �÷����� ������Ÿ�� ���ƾ� ��



    1) UNION     ������
    
    SELECT COUNT(*)
    FROM (
    SELECT name, city, buseo
        --,COUNT() -- �������� ORA-00937: not a single-group group function
    FROM insa
    WHERE city = '��õ' AND buseo ='���ߺ�'
    ) i ;
    
    --UNION
    --�μ� ���ߺ��̰� ����� ��õ�� ����� ������?
    SELECT name, city, buseo
    FROM insa
    WHERE city = '��õ'
    UNION --������ �ι� �ɸ��� �ֵ�(��õ+���ߺ� 6��) �� �� ����
    SELECT name, city, buseo
    FROM insa
    WHERE buseo ='���ߺ�';
    
    2) UNION ALL ������
    --�μ� ���ߺ��̰� ����� ��õ�� ����� ������?
    SELECT name, city, buseo
    FROM insa
    WHERE city = '��õ'
    -- ORDER BY buseo --ORA-00933: SQL command not properly ended ��ɹ��� ���� �ȵ�..? �׷� �����Ϸ���?
    UNION ALL --������ �ߺ� ��� (23�� ����) 
    SELECT name, city, buseo
    FROM insa
    WHERE buseo ='���ߺ�'
    ORDER BY buseo; -- ��� �������� ���� �� ����
    
    SELECT ename,hiredate, dname      --TO_CHAR(deptno) dept     --deptno || ' '
    FROM emp, dept
    WHERE emp.deptno = dept.deptno
    UNION
    SELECT name,ibsadate,buseo
    FROM insa;
    
    --JOIN ����
    ����̸�, �����, �Ի�����, �μ��� -> ��ȸ�Ϸ��µ�
    emp���� ����̸�, �����, �Ի�����
    dept���� �μ���
    --> ���� ���������� = ��ġ�� -> �μ����� 
    
    ������̺�(�ڽ����̺�)
    �����ȣ/�����/�Ի�����/��/�⺻��/Ŀ�̼�/�μ���ȣ(FK) --/�μ���/�μ���/������ȣ
    
    �μ����̺� ->����(�θ����̺�)�����
    �μ���ȣ(PK)/�μ���/�μ���/������ȣ
    
    => �̷��� �ɰ��� �ִ� = ����ȭ
    => �ٽ� ���ļ� �������°� ����? FROM emp, dept; �̰͸����� ������
    
    SELECT empno, ename, hiredate, dname , dept.deptno -- deptno������ ����: ORA-00918: column ambiguously defined �÷��� �ָ��ϰ� ����Ǿ��ִ�.emp,dept ���� deptno�����ִ�
    FROM emp, dept      --����
    WHERE emp.deptno = dept.deptno; -- ��������
    
   --�˸��ƽ�(��Ī)�ο��� �� �����ϰ� �� �� �ִ�
    SELECT empno, ename, hiredate, dname , d.deptno 
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    --���� ����. 
    SELECT empno, ename, hiredate, dname , d.deptno 
    FROM emp e JOIN dept d ON e.deptno = d.deptno;
    
    3) INTERSECT ������
    
    SELECT name, city, buseo
    FROM insa
    WHERE city = '��õ'
    INTERSECT
    SELECT name, city, buseo
    FROM insa
    WHERE buseo ='���ߺ�'
    ORDER BY buseo; 
   
    
    4) MINUS     ������
    
    SELECT name, city, buseo
    FROM insa
    WHERE buseo = '���ߺ�'
    MINUS
    SELECT name, city, buseo
    FROM insa
    WHERE city ='��õ'
    ORDER BY buseo; 


-- ���� city��� �÷��� ���� ����ε� ���Ͽ� �ؾ��Ѵٸ�?
    SELECT name, NULL city, buseo -- �׳� NULL�� ������ �����ָ�� 
    FROM insa
    WHERE buseo = '���ߺ�'
    UNION
    SELECT name, city, buseo
    FROM insa
    WHERE city ='��õ'
    ORDER BY buseo; 

��·�� �÷��� , Ÿ�Լ� �����ؾ����� ���.. (+�������̴� ������)

[������ ���� ������] PRIOR, CONNECT_BY_ROOT

IS [NOT] NAN  (NAN = NOT A NUMBER)
IS [NOT] INFINITE   ����

--
[����Ŭ���� �����ϴ� �Լ� function]
-- 1) ������ �Լ� : �� �ϳ� �� ����� ����.
    -����
    1) UPPER, LOWER, INITCAP
    SELECT UPPER(dname),LOWER(dname),INITCAP(dname)
    FROM dept;
    
    2) LENGTH ����
    SELECT dname, LENGTH(dname)
    FROM dept;
    
    3) CONCAT ���ڿ� ����
    4) SUBSTR �ڸ���
    SELECT SUBSTR(ssn,8,14) --���ڸ��� ��������
    FROM insa;
    
    5) INSTR ���ڿ����� ������ ���ڰ��� ��ġ�� ���ڷ� ����
    SELECT dname, INSTR(dname,'S',2) --2���� ���
    FROM dept;
    
    -- ������ȣ��,���ڸ��� ����
    SELECT TEL
        , SUBSTR(TEL,0,INSTR(TEL,')') -1 ) ������ȣ
        , SUBSTR(TEL,INSTR(TEL,')')+1,INSTR(TEL,'-')-INSTR(TEL,')')-1)  ���ڸ�
        , SUBSTR( TEL, INSTR(TEL,'-')+1 ) ���ڸ�
    FROM TBL_TEL;
    --������ �Ⱦ��� ������ ����
    
    6) RPAD LPAD
    SELECT RPAD('Corea',12,'*') RPAD -- 12�ڸ� Ȯ���ߴµ� corea 5�ڸ����� , ���� 7�ڸ� *�� ä�� 
    FROM dual;

    SELECT ename, sal + NVL(comm,0) pay
            ,LPAD(sal + NVL(comm,0),10, '*')
    FROM emp;
    
    7)RTRIM (LTRIM) 
    SELECT RTRIM('xyBROWINGyxXxy','xy') "RTRIM example"  --���ڿ� �ӿ��� �������� ã�Ƽ� xy ���� xyxyxy '�پ��־��ٸ�' ������
           , LTRIM('  zzz xxx xz', ' ') "no" 
           , '[' || TRIM(' XXXX  ') || ']' "TRIM"
    FROM dual;

    8) ASCII ,CHR
    SELECT ASCII('Korea'), CHR(65) CHR -- ù���� �ƽ�Ű, ���� �ƽ�Ű �ش��ϴ� ���ڷ�
    FROM dual;
    
    9) GREATEST, LEAST == MAX/MIN ������ �ֵ� �� �ִ��ּ� ��ȯ
    
    SELECT GREATEST(1,2,4,5) , LEAST(1,2,3,6), GREATEST('A','B') g -- �ƽ�Ű ����) ���ڵ� �Ǳ��ϳ�
    FROM dual;

    10) VSIZE ����Ʈ ũ��
    SELECT VSIZE(1),VSIZE('A'),VSIZE('��')
    FROM dual;
    

    -����
    1) ROUND(a,b)  �ݿø��Լ�..
    SELECT 3.141592 ��
            ,ROUND(3.141592,2) �� -- b+1 �ڸ����� �ݿø�
            ,ROUND(3.141592,3) �� -- 4��° �ڸ����� �ݿø�
            ,ROUND(12345.6789,-2) --  . ���� -2�ؼ� '4'���� �ݿø� 12300
            ,ROUND(sysdate)
            ,sysdate
    FROM dual;
    
    2)FLOOR () ������ �Ҽ� ù��°�ڸ����� ���� ,, ��¥�� �����
    SELECT FLOOR(3.141592)--3
           ,FLOOR(3.9303)--3
    FROM dual;
    
    3) TRUNC
    SELECT TRUNC(3.141592)
          ,TRUNC(3.941592)
          ,TRUNC(314.1592)
          ,TRUNC(3.141592, 3) -- Ư����ġ���� ����
    FROM dual;
    
    4) CEIL ����
    SELECT CEIL(3.14), CEIL(3.92)
    FROM dual;
    
    SELECT CEIL(161/10) --�Խ��� ������ �� ������ ������ �ʿ���
    FROM dual;
    
    5) ABS ����
    SELECT ABS(-10)
    FROM dual;
    
    6)SIGN() ��ȣ ���� 1 0 -1 
    SELECT SIGN(100), SIGN(0), SIGN(-203)
    FROM dual;
    
    7)POWER() ����
    SELECT POWER(2,3) --2�� 3��
    FROM dual; 
    
    -��¥
    1) SYSDATE
    SELECT SYSDATE "SYSDATE" --����� ������������ �ð�(��)���� �����Ѱ���
    FROM dual;
    
    2) ROUND(�ݿø�) ,TRUNC(����)
    SELECT ROUND(SYSDATE)  "���� ���� �ݿø�" , TRUNC(SYSDATE)
    FROM dual;
    
    SELECT ROUND(SYSDATE, 'DD') "�� ���� ���� = �⺻��"
         ,ROUND(SYSDATE, 'MONTH') "�� ���� 15�� ����"
         ,ROUND(SYSDATE, 'YEAR') "�� ���� 6����!"
    FROM dual;
    
    SELECT SYSDATE �⺻
--        , TO_CHAR(SYSDATE, 'ds ts')
--        , TRUNC( SYSDATE )
--        , TO_CHAR(TRUNC( SYSDATE ), 'ds ts')
--        , TRUNC(SYSDATE, 'DD') tr  -- �ð�/��/�� ����
--        , TO_CHAR(TRUNC(SYSDATE, 'DD'), 'ds ts') tr2  -- �ð�/��/�� ����
          , TO_CHAR( TRUNC( SYSDATE, 'MONTH'),'DS TS') "�� ���� ����"
          
    FROM dual;
    
    --��¥�� ��������� ��� ?
    SELECT SYSDATE -3 "DATE" -- '��'�� ����
    FROM dual;
    
    SELECT SYSDATE + ( 2/24) "DATE" -- �ð� �ٲٱ� (�νð� ��)
    FROM dual;
    
    --SELECT SYSDATE - ��¥ �ع����� �� ��¥ ������ ������ ��µ�
    
    SELECT ename,CEIL(SYSDATE - hiredate) +1 
    FROM emp;
    
    --����_ �����Ϸκ��� ���� ��ĥ°�ΰ�? *������ �����°�?
    
    SELECT SYSDATE,TRUNC(SYSDATE) - TRUNC(TO_DATE('2024-07-01'))
    FROM dual;
    
    -- �ٹ� ���� ��? 
    SELECT ename, hiredate, SYSDATE 
        , MONTHS_BETWEEN( SYSDATE, hiredate ) "�ٹ� ���� ��"
        , MONTHS_BETWEEN( SYSDATE, hiredate )/12 "�ٹ� ���"
    FROM emp;
    
    SELECT SYSDATE
        ,SYSDATE +1
        ,ADD_MONTHS(SYSDATE,1) M -- year�� ���� 12�̿�
        ,ADD_MONTHS(SYSDATE,-1) m2 -- �Ѵ��� 
        ,ADD_MONTHS(SYSDATE,-12) m3 -- �ϳ��� 
    FROM dual;
    
    --LASTDAY
    SELECT SYSDATE
        ,LAST_DAY(SYSDATE)--24/8/31
        ,TO_CHAR(LAST_DAY(SYSDATE),'DD')
        ,TO_CHAR(TRUNC( SYSDATE , 'MONTH'), 'DAY')
        ,ADD_MONTHS(TRUNC(SYSDATE, 'MONTH'), 1) -- 1�� 1�޵ڿ���
    FROM dual;
    
    SELECT SYSDATE
            ,NEXT_DAY(SYSDATE,'��') s -- ���ƿ��� �ش� ��¥..
            ,NEXT_DAY(SYSDATE,'��')
            ,NEXT_DAY(NEXT_DAY(SYSDATE,'��'),'��') --���ƿ��� ���� ���ƿ��� �� (2�ֵ� ��)
            ,NEXT_DAY(SYSDATE,'��')
    FROM dual;
    
    -- ����) 10�� ù��° �����ϳ� �ް��ϴٸ�, �� ���� ��ĥ���� �˾ƺ���
    
    SELECT NEXT_DAY(ADD_MONTHS(TRUNC(SYSDATE,'MONTH'),2),'��')
             , NEXT_DAY(TO_DATE('24/10/01'),'��')
    FROM dual;
    
    --Ŀ��Ʈ����Ʈ�� ���� session�� ��¥ ������ ���� ,Ÿ�ӽ������� �и���������
    SELECT CURRENT_DATE , SYSDATE , CURRENT_TIMESTAMP
    FROM dual;
    
    
    -��ȯ
    
    SELECT '1234'
        ,TO_NUMBER('1234') --���ڴ� ��������
    FROM dual;
    
    --TO_CHAR(NUMBER)/ TO_CHAR(CHAR)/TO_CHAR(DATE) ���ڷ� ��ȯ�ϴ� �Լ�
    SELECT num, name
            ,basicpay, sudang
            ,basicpay + sudang PAY --���ڸ����� �ĸ� ��� �ʹٸ�?
            ,TO_CHAR(basicpay + sudang, 'L9G999G999D00') PAY_ --G�� (,)�� �ᵵ ������ ����� �ȵ�
    FROM insa;
    
    
    SELECT TO_CHAR(100, 'S9999')
            ,TO_CHAR(-100, '9999s')
            ,TO_CHAR(100, '9999MI')
            --�ű��� �͵� ����
            ,TO_CHAR(-100, '9999PR')
            ,TO_CHAR(100, '9999PR')
    FROM dual;
    
    
    SELECT sal + NVL(comm,0) PAY
        ,TO_CHAR( (sal + NVL(comm,0) ) *12 , '9,999,999L')
        ,TO_CHAR( (sal + NVL(comm,0) ) *12 , '9G999G999D00')
    FROM emp;
    
    SELECT name, TO_CHAR( ibsadate , 'YYYY"��" MM"��" DD"�� "DAY' ) --""�� ���ڿ��� �������� �� �ִ�
    FROM insa;
    
    SELECT *
    FROM insa
    WHERE TO_CHAR(ibsadate, 'YYYY') = 1998; --�׳� �غ�
    
    
    -�Ϲ�
    --NVL �ø���
    
    -- COALESCE
    SELECT ename,sal,comm, sal+comm
        , sal + NVL(comm,0) pay
        , sal + NVL2(comm,comm,0) pay
        , COALESCE(sal+comm, sal, 0) ca -- �����س��� �� �� �� �ƴ� �� ��� : PAY �̾ƺ��� �γ����� sal�� �̾ƺ��� �µ� ���̸� �� 0�̱�
    FROM emp;
    
    
    
    --���� �߿� DECODE, CASE �ڡڡ�
    
    SELECT name, ssn, SUBSTR(ssn,8,1) ����,NVL2( NULLIF ( MOD(SUBSTR(ssn,-7,1),2) ,1 ), '����', '����') GENDER
    FROM insa; --�̰� �������� ����� Ǯ�̰�
    
    -- If �� == DECODE()
    -- FROM �� �ܿ� ��� ����
    --�� ���깮 =�� �����ϴ� if (a==b) �̰Źۿ� �ȵǴ� ����
    --a=b�� �ƴ϶��NULL
    --DECODE �Լ��� Ȯ�� �Լ� : CASE ()
    SELECT name, ssn, DECODE(SUBSTR(ssn,8,1),1,'����',2,'����') GENDER --�������� else..(��������������)
        , DECODE(MOD(SUBSTR(ssn,8,1),2),0,'��','��')
    FROM insa;
    
    --���� emp���̺��� �⺻���� PAY�� 10%��ŭ �λ��Ű��
    -- 10�� �μ��� 15% , 20�� 10%, �׿� 20%
    SELECT deptno,ename,sal,comm,sal + NVL(comm,0) PAY, (sal + NVL(comm,0)) * 1.1 "10% �λ��" 
        ,DECODE(deptno,10,(sal + NVL(comm,0)) * 1.15
                ,20,(sal + NVL(comm,0)) * 1.1
                ,(sal + NVL(comm,0)) * 1.2) "�λ�޿�"
        , (sal+NVL(comm,0)) * DECODE(deptno, 10, 1.15, 20, 1.1, 1.2) "�������� ����"        
                
    FROM emp;
   
    -- CASE �� DECODE�� Ȯ��. =�Ӹ� �ƴ� ���� �񱳵� ����,, ()�� ����
    -- ���ǹ� ����� (WHEN) �ĸ� ������� �ʴ´�
    -- CASE ���� �ݵ�� END�� ������ �Ѵ�.!
    -- WHEN ���� ��������� NULL�� ���� �ʴ´�
    
    SELECT name, ssn, DECODE(SUBSTR(ssn,8,1),1,'����',2,'����') GENDER --�������� else..(��������������)
        , DECODE(MOD(SUBSTR(ssn,8,1),2),0,'��','��') "���� ��"
        , CASE MOD(SUBSTR(ssn,8,1),2) WHEN 1 THEN '����'
                                     -- WHEN 0 THEN '����'
                                    ELSE '����'
                                      
        END "GENDER(CASE)"
    FROM insa;
    
    
    SELECT deptno,ename,sal,comm,sal + NVL(comm,0) PAY, (sal + NVL(comm,0)) * 1.1 "10% �λ��" 
        , CASE deptno WHEN 10 THEN ( sal + NVL(comm,0) ) * 1.15
                      WHEN 20 THEN ( sal + NVL(comm,0) ) * 1.1
                      ELSE ( sal + NVL(comm,0) ) * 1.2
        END "�λ��"
        ,( sal + NVL(comm,0) ) * CASE deptno WHEN 10 THEN 1.15                      
                                             WHEN 20 THEN 1.1
                                             ELSE 1.2
        END "�λ��2" --�� �ڵ嵵 ������ ������ case�� �Լ��̱� ���� 
                
    FROM emp;
    
-- 2) ������ �Լ� (�׷��Լ�)
-- �׷� �� �ϳ��� ����� ����Ѵ�

-- * ī��Ʈ�ϸ� NULL�� ��
    SELECT COUNT(*), COUNT(ename), COUNT(sal), COUNT(comm)
           --,sal �����Լ��� �Ϲݿ��� ���� �� �� ����.
           ,SUM(sal)
           ,SUM(sal)/COUNT(*) AVG_SAL 
           ,SUM(comm)/COUNT(*) AVG_SAL 
           ,AVG(comm) 
           ,MAX(sal)
           ,MIN(sal)
           --�ٸ� ���� : AVG�� ��� �� �� NULL�� �ֵ��� �и�� ��޾���
    FROM emp;

    SELECT *
    FROM emp;

--�� ����� ��ȸ
--�� �μ��� ����� ��ȸ

SELECT COUNT(
FROM emp;
WHERE deptno=10;
