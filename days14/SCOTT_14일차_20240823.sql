-- Ʈ���� �ǽ� 

-- �԰����̺� �ڷ����� 30�� ���� -> ��ǰ���̺� ������ Ʈ���ŷ� �ֽ�ȭ ?
-- �Ǹ����̺� ��������

--��ǰ ���̺�
PK                   ������
1       �����          10
2      �ڷ�����         5
3       ������          20

-- �԰� ���̺�

PK
�԰��ȣ        �԰�¥        �԰��ǰ��ȣ(FK)      �԰����            

1000                ??                  2                           30


--�Ǹ� ���̺�
PK
�ǸŹ�ȣ        �Ǹų�¥        �ǸŻ�ǰ��ȣ(FK)      �Ǹż���

1000                ???                     2                        15


-- ��ǰ ���̺� �ۼ�
CREATE TABLE ��ǰ (
   ��ǰ�ڵ�      VARCHAR2(6) NOT NULL PRIMARY KEY
  ,��ǰ��        VARCHAR2(30)  NOT NULL
  ,������        VARCHAR2(30)  NOT NULL
  ,�Һ��ڰ���     NUMBER
  ,������       NUMBER DEFAULT 0
);

-- �԰� ���̺� �ۼ�
CREATE TABLE �԰� (
   �԰��ȣ      NUMBER PRIMARY KEY
  ,��ǰ�ڵ�      VARCHAR2(6) NOT NULL CONSTRAINT FK_ibgo_no
                 REFERENCES ��ǰ(��ǰ�ڵ�)
  ,�԰�����     DATE
  ,�԰����      NUMBER
  ,�԰�ܰ�      NUMBER
);

-- �Ǹ� ���̺� �ۼ�
CREATE TABLE �Ǹ� (
   �ǸŹ�ȣ      NUMBER  PRIMARY KEY
  ,��ǰ�ڵ�      VARCHAR2(6) NOT NULL CONSTRAINT FK_pan_no
                 REFERENCES ��ǰ(��ǰ�ڵ�)
  ,�Ǹ�����      DATE
  ,�Ǹż���      NUMBER
  ,�ǸŴܰ�      NUMBER
);


-- ��ǰ ���̺� �ڷ� �߰�
INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
        ('AAAAAA', '��ī', '���', 100000);
INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
        ('BBBBBB', '��ǻ��', '����', 1500000);
INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
        ('CCCCCC', '�����', '���', 600000);
INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
        ('DDDDDD', '�ڵ���', '�ٿ�', 500000);
INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
         ('EEEEEE', '������', '���', 200000);
COMMIT;

SELECT * FROM ��ǰ;
SELECT * FROM �԰�;

--����1) �԰� ���̺� ��ǰ�� �԰� �Ǹ� �ڵ����� ��ǰ ���̺��� ��������  update �Ǵ� Ʈ���� ���� + Ȯ��
-- �԰� ���̺� ������ �Է�  
 --  ut_insIpgo

CREATE OR REPLACE TRIGGER ut_insIpgo
AFTER --insert(�԰�) �Ŀ� ������Ʈ�ؾ��ϴϱ�(���)
INSERT ON �԰�
FOR EACH ROW -- �� ���� Ʈ����.. INSERT (�԰�) ���ڵ� ����ŭ Ʈ���� �ߵ�..!
BEGIN
    -- :NEW.��ǰ�ڵ� :NEW.�԰����
    
    UPDATE ��ǰ
    SET ������ = ������ + :NEW.�԰����
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
-- COMMIT ;     Ʈ���Ŵ� X

--EXCEPTION
END;
--Trigger UT_INSIPGO��(��) �����ϵǾ����ϴ�.


--�ؿ� �����ؼ� �ݿ� Ȯ��

-- �ϴ� �ٿ��� �ΰ� ���� �̵��� (Ʈ���� �ɰ�)--
INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
              VALUES (1, 'AAAAAA', '2023-10-10', 5,   50000);
INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
              VALUES (2, 'BBBBBB', '2023-10-10', 15, 700000);
INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
              VALUES (3, 'AAAAAA', '2023-10-11', 15, 52000);
INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
              VALUES (4, 'CCCCCC', '2023-10-14', 15,  250000);
INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
              VALUES (5, 'BBBBBB', '2023-10-16', 25, 700000);
COMMIT;

SELECT * FROM �԰�;
SELECT * FROM ��ǰ;



-- ����2) �԰� ���̺��� �԰� �����Ǵ� ��� (���� 25���ε� 30���� �����ؾ��ϴ� ��Ȳ )
--��ǰ���̺��� ������ ���� ?


CREATE OR REPLACE TRIGGER ut_updIpgo
AFTER 
UPDATE ON �԰� -- �԰� ���̺� ������Ʈ�� �߻��� �� �ߵ�(Ʈ����) �ؾ� �ϴϱ�
FOR EACH ROW 
BEGIN
    
    UPDATE ��ǰ
    SET ������ = ������ + :NEW.�԰���� -:OLD.�԰���� 
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
-- COMMIT ;     Ʈ���Ŵ� X

--EXCEPTION
END;

--Ʈ���� ���� �� �׽�Ʈ
UPDATE �԰� 
SET �԰���� = 30 
WHERE �԰��ȣ = 5;
COMMIT;






--�԰� ���̺��� �԰� ��ҵǾ �԰� ����.    ��ǰ���̺��� ������ ���� ?

CREATE OR REPLACE TRIGGER ut_delIpgo
AFTER 
DELETE ON �԰� -- �԰� ���̺� ������ �߻��� �� �ߵ�(Ʈ����) 
FOR EACH ROW 
BEGIN
    -- DEL�̶� :NEW�� �� �� ���� (���ο� ������ X)
    UPDATE ��ǰ
    SET ������ = ������ - :OLD.�԰���� 
    WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�; --�׷��� ���⵵ OLD�� ��
-- COMMIT ;     Ʈ���Ŵ� X

--EXCEPTION
END;




--Ʈ���� ���� �� �׽�Ʈ

DELETE FROM �԰� 
WHERE �԰��ȣ = 5;
COMMIT;

SELECT * FROM �԰�;
SELECT * FROM ��ǰ; --���� ��ǻŸ 15�� �ƴ� ����
SELECT * FROM �Ǹ�;


---------------------
--����
-- ����4) �Ǹ����̺� �ǸŰ� �Ǹ� (INSERT) 
--       ��ǰ���̺��� �������� ����
-- ut_inspan

CREATE OR REPLACE TRIGGER ut_inspan
BEFORE 
INSERT ON �Ǹ�
FOR EACH ROW
DECLARE -- ���⼭�� �ǿ�
    jaego ��ǰ.������%TYPE;
BEGIN
    
    SELECT ������ INTO jaego
    FROM ��ǰ
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    
    IF :NEW.�Ǹż��� > jaego
    THEN  RAISE_APPLICATION_ERROR(-20008, '��������'); 
    ELSE
    UPDATE ��ǰ
    SET ������ = ������ - :NEW.�Ǹż���
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;

--EXCEPTION
END;



-- Ʈ���� ����� �׽�Ʈ
INSERT INTO �Ǹ� (�ǸŹ�ȣ, ��ǰ�ڵ�, �Ǹ�����, �Ǹż���, �ǸŴܰ�) VALUES
               (2, 'AAAAAA', '2023-11-10', 7, 1000000);
 
INSERT INTO �Ǹ� (�ǸŹ�ȣ, ��ǰ�ڵ�, �Ǹ�����, �Ǹż���, �ǸŴܰ�) VALUES
               (2, 'AAAAAA', '2023-11-12', 50, 1000000);
COMMIT; 

-- ����5) �ǸŹ�ȣ 1  20     �Ǹż��� 5 -> 10 
-- ut_updPan

CREATE OR REPLACE TRIGGER ut_updpan
BEFORE
UPDATE ON �Ǹ�
FOR EACH ROW
DECLARE
    jaego ��ǰ.������%TYPE;
BEGIN
    
    SELECT ������ INTO jaego
    FROM ��ǰ
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;

    IF :NEW.�Ǹż��� > ( jaego + :OLD.�Ǹż��� )
    THEN  RAISE_APPLICATION_ERROR(-20008, '��������, ���� ������ŭ�� �����մϴ�'); 
    ELSE
    UPDATE ��ǰ
    SET ������ = ������ +:OLD.�Ǹż���  - :NEW.�Ǹż���
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    END IF;

--EXCEPTION
END;



UPDATE �Ǹ� 
SET �Ǹż��� = 10
WHERE �ǸŹ�ȣ = 1;

SELECT * FROM �԰�;
SELECT * FROM ��ǰ;
SELECT * FROM �Ǹ�;




-- ����6)�ǸŹ�ȣ 1   (AAAAA  10)   �Ǹ� ��� (DELETE)
--      ��ǰ���̺� ������ ����
--      ut_delPan

CREATE OR REPLACE TRIGGER ut_delpan
AFTER
DELETE ON �Ǹ�
FOR EACH ROW
BEGIN

    UPDATE ��ǰ
    SET ������ = ������ + :OLD.�Ǹż���
    WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
  

END;

--���� ���
DELETE FROM �Ǹ� 
WHERE �ǸŹ�ȣ=1;


SELECT * FROM �԰�;
SELECT * FROM ��ǰ;
SELECT * FROM �Ǹ�;






----------------����ó��---------------

INSERT INTO emp (empno, ename, deptno)
VALUES ( 9999, 'admin', 90) ;

--����� 284 �࿡�� �����ϴ� �� ���� �߻� -
--INSERT INTO emp (empno, ename, deptno)
--VALUES ( 9999, 'admin', 90)
--���� ���� -
--ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
-- FK ���� : 90�� �μ��� ����

CREATE OR REPLACE PROCEDURE up_exceptiontest
(
    psal emp.sal%TYPE
)
IS 
    vename emp.ename%TYPE;
BEGIN
    SELECT ename INTO vename
    FROM emp
    WHERE sal = psal;
    
    DBMS_OUTPUT.PUT_LINE( ' > vename ' || vename );
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001 , '�����Ͱ� ���µ��� ?');
    WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20002 , '������ �ִµ��� ?');
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001 , '���� ������..??');
END;




EXEC up_exceptiontest( 800 );
--�������

EXEC up_exceptiontest( 9000 );
--ORA-01403: no data found
--9000�޴� ����� ����

EXEC up_exceptiontest( 2850 );
--ORA-01422: exact fetch returns more than requested number of rows
-- ������ �ִµ�



SELECT *
FROM emp;

-------------�̸� ���ǵ��� ���� ���� ó��---------------

CREATE OR REPLACE PROCEDURE up_insertemp
(
    pempno emp.empno%TYPE
    , pename emp.ename%TYPE
    , pdeptno emp.deptno%TYPE

)
IS

    PARENT_KEY_UPDDA EXCEPTION;
    PRAGMA EXCEPTION_INIT (PARENT_KEY_UPDDA, -02291);
    -- ���� ���� ����ó���� ���� ��Ȳ�� ����
    
BEGIN
    INSERT INTO emp (empno, ename, deptno)
    VALUES ( pempno, pename, pdeptno );
    COMMIT;

EXCEPTION
    WHEN PARENT_KEY_UPDDA THEN RAISE_APPLICATION_ERROR(-20031 , 'FK ����...'); --���� ���� ����ó�� ?
    
    WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001 , '�����Ͱ� ���µ��� ?');
    WHEN TOO_MANY_ROWS THEN RAISE_APPLICATION_ERROR(-20002 , '������ �ִµ��� ?');
    WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001 , '���� ������..??'); --�̹� �ִ� ����ó�� �� ������
    
END;


EXEC up_insertemp(9999, 'admin' , 90); --���� ���� ����ó�� ��.


-----����ڰ� ������ ����ó��----------------

--sal ������ a-b�� ��    �����     ī����
--                                                0         --> ���� ���� ���� ����

EXEC up_myexception(800, 1200);
EXEC up_myexception(7000, 7200); --����


CREATE OR REPLACE PROCEDURE up_myexception
(
     plosal NUMBER
   , phisal NUMBER
)
IS 
  vcount NUMBER;
  
  -- 1) ����� ���� ���� ��ü(����) ����
  ZERO_ENP_COUNT EXCEPTION;
BEGIN
  SELECT COUNT(*) INTO vcount
  FROM emp
  WHERE sal BETWEEN plosal AND phisal;
  
  IF vcount = 0 THEN
     -- 2) ������ ����� ������ ���� �߻�
     RAISE ZERO_ENP_COUNT;
  ELSE
    DBMS_OUTPUT.PUT_LINE( '> ����� : ' || vcount ); 
  END IF;
  
EXCEPTION
  WHEN ZERO_ENP_COUNT THEN
    RAISE_APPLICATION_ERROR(-20022, '> QUERY ������� 0�̴�.'); 
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, '> QUERY NO DATA FOUND.');
  WHEN TOO_MANY_ROWS THEN
    RAISE_APPLICATION_ERROR(-20002, '> QUERY DATA TOO_MANY_ROWS FOUND.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20009, '> QUERY OTHERS EXCEPTION FOUND.');
END;





--(��)Ʈ����� 1~2�ð�/��Ű��
--(ȭ)�������� 1~2�ð�
--(��)�۾������ٷ� 1~2�ð�
--(��)��ȣȭ 1~2�ð� 
--(��)�ε���  1~2�ð�









