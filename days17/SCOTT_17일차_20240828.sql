-- �۾������ٷ� 

--�����ͺ��̽� ���� ������ ���ν���, �Լ��鿡 ���� �����ͺ��̽� ���� �����췯�� ������ �ð��� �ڵ����� �۾��� ����� �� �ֵ��� �ϴ� ����̴�.

-- 1) DBMS_JOB ��Ű�� (***)
-- 2) DBMS_SCHEDULER ��Ű�� ( 10g ���� �߰��� )


-- 1�ܰ� ) �ڵ����� ����Ǿ�� �ϴ� ���ν��� , �Լ� �غ�
-- 2�ܰ� ) ������ ����
-- 3�ܰ� �� ����/����/���� ��� üũ

CREATE TABLE tbl_job
(
    seq NUMBER
    , insert_date DATE
    
)
--Table TBL_JOB��(��) �����Ǿ����ϴ�.

CREATE OR REPLACE PROCEDURE up_job
-- ()
IS
    vseq NUMBER;
BEGIN
    
    SELECT NVL( MAX(seq) , 0 ) +1 INTO vseq
    FROM tbl_job;

    INSERT INTO tbl_job VALUES ( vseq , sysdate );
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
    DBMS_OUTPUT.PUT_LINE ( SQLERRM );
END;
--Procedure UP_JOB��(��) �����ϵǾ����ϴ�.

-- �� ��� ? DBMS_JOB.SUBMIT ���ν��� ����ؼ� ..

SELECT *
FROM user_jobs;
--��ϵ� job ��ȸ ( ���� �ƹ��͵� ���� )

-- �͸� ���ν��� - �� ���
DECLARE
  vjob_no NUMBER;
BEGIN
    DBMS_JOB.SUBMIT(
         job => vjob_no
       , what => 'UP_JOB;'
       , next_date => SYSDATE
       -- , interval => 'SYSDATE + 1'  �Ϸ翡 �� ��  ���ڿ� ����
       -- , interval => 'SYSDATE + 1/24'
       -- , interval => 'NEXT_DAY(TRUNC(SYSDATE),'�Ͽ���') + 15/24'
       --    ���� �Ͽ��� ����3�� ����.
       -- , interval => 'LAST_DAY(TRUNC(SYSDATE)) + 18/24 + 30/60/24'
       --    �ſ� ������ ����   6�� 30�� ����..
       , interval => 'SYSDATE + 1/24/60' -- �� �� ����       
    );
    COMMIT;
     DBMS_OUTPUT.PUT_LINE( '�� ��ϵ� ��ȣ : ' || vjob_no );
END;

--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

SELECT *
FROM user_jobs;
-- �� ��ϵ�

SELECT seq, TO_CHAR( insert_date , 'DL TS' )
FROM tbl_job
ORDER BY seq;
-- 1�и��� ����

--�� ���� ? : DBMS_JOB_BROKEN

BEGIN
    DBMS_JOB.BROKEN( 1 , true ); -- ���ڴ� �� ��ȣ��
    COMMIT;
END;
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- �����?
BEGIN
    DBMS_JOB.BROKEN( 1 , false );
    COMMIT;
END;
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.


--���� ���� �ֱ�� ������� �� ���� ? ****
BEGIN
    DBMS_JOB.RUN(1);
    COMMIT;
END;
--2024�� 8�� 28�� ������ ���� 9:30:39 ���� 28�ʸ��� �����µ� 39�� ����


-- �� ����
BEGIN 
    DBMS_JOB.REMOVE(1);
    COMMIT;
END;

--�� �Ӽ� ����: DBMS_JOB.CHANGE
