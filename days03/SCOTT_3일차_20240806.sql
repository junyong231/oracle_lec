-- LIKE �������� ESCAPE �ɼ� ?

SELECT deptno, dname, loc
FROM dept;
--dept ���̺� ���ο� �μ����� �߰��ϱ� ..?

INSERT INTO dept (deptno,dname,loc) VALUES (60, '�ѱ�_����', 'COREA');
--����: ORA-00001: unique constraint (SCOTT.PK_DEPT) violated
-- ���ϼ� ���� ���ǿ� ����ȴ�..!
-- deptno�� primary key����. 
-- primary key �ָ� NOT NULL + UK ����,����ũ ���� �ɸ�

--�ѹ��� ��Ű�� ( �ѱ۳��� ������)
ROLLBACK;
INSERT INTO dept VALUES (60, '�ѱ�_����', 'COREA'); 
--������� �˲� ä������ �÷��� ���� ����
COMMIT;

-- �μ��� % ���ڰ� ���Ե� �μ� ������ ��ȸ ?
SELECT dname
FROM dept
WHERE dname LIKE '%3%%' ESCAPE '3';

--DML 
DELETE FROM dept
--������ �ϸ� ����:integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
--���Ἲ ���� ���ǿ� �����. ���� ��� ���ڵ� �������ߵǴµ� emp���̺��� �����ϴ� �ֵ�(�ܷ�Ű) ���� ��Ҵ�
WHERE deptno = 60;
--WHERE �������� ������ �� ������ ����!
DELETE FROM emp;
SELECT *
FROM emp;

SELECT *
FROM dept; 
--60 ������

--����
UPDATE dept 
SET dname = SUBSTR(dname, 1,2) , loc = 'COREA'
--��������� �ϸ��� ���δ� QC�� �ٲ� WHERE �ʿ� ,, dname||'XX' �̷��͵� ��
WHERE deptno =50;

-- ����) 40�� �μ��� �μ���� �������� ���ͼ� 50�� �μ����� �ο�???

UPDATE dept
SET dname = (SELECT dname 
            FROM dept
            WHERE deptno =40)
    ,loc = ( SELECT loc
            FROM dept
            WHERE deptno=40)
WHERE deptno = 50;
--�̰� �ǳ� + ���������� �׻� ��ȣ�ȿ�!
ROLLBACK;

UPDATE dept
SET (dname,loc) = (SELECT dname,loc FROM dept WHERE deptno =40)
WHERE deptno =50;
--�̷��� �ѹ����� �ȴ�..

--����) �μ���ȣ 50,60,70 �μ� �ѹ��� ����

DELETE FROM dept
WHERE deptno =50 OR deptno =60 OR deptno =70;

COMMIT;
--�ٽ� ���� 4�� �μ��� ���ƿԴ�

--����) �⺻��(sal)�� pay�� 10% �λ��Ű�� 

UPDATE emp
SET sal = sal+(TRUNC((sal+ NVL(comm,0))/10));
        

SELECT ename,sal,comm,sal+NVL(comm,0)
FROM emp;

ROLLBACK;
          
--�ۺ� synonym  ������
CREATE PUBLIC SYNONYM arirang
FOR scott.emp;
--ORA-01031: insufficient privileges ���Ѿ���
        
--sys���� �ó�� ��������� �Ẹ��
SELECT *
FROM arirang;
        
GRANT SELECT ON emp TO hr;
--���� �ο�(����Ʈ)

REVOKE SELECT
	ON emp
	FROM hr;
	[CASCADE CONSTRAINTS];
--���� ����

--�ó�� (�Ƹ���) ����? �굵sys�����ڳ�

------------------------------------------------

-- ����Ŭ�� ������.. (Operator) ����
1) �񱳿����� : = != > < >= <= ^= <> 
            WHERE ������ ���.. (����, ����, ��¥���� ��)
            ANY,SOME,ALL = �񱳿�����, SQL ������..
2) �������� : AND OR NOT //�ڹٶ� �ٸ��� ��Ȯ�ΰ����� ó���κ��� �� ���� (������ ����ϸ� ��.. �� Ʈ���ε� �����̶� and? ������ false������ �𸣴� false���

3)SQL ������ : sql ���� ���� ... NOT, IN, BETWEEN, LIKE , IS NULL,   ( ANY, SOME, ALL , EXIST(t/f) ) ��״� ���������� ���̾�


5)��������� : ��������. �켱���� �ִ� (�ڹٶ� ����)
SELECT 5+3,5-3,5*3,5/3,MOD(5,3),FLOOR(5/3)
FROM dual;