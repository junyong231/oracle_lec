SELECT * FROM t_member;
SELECT * FROM t_poll;
SELECT * FROM t_pollsub;
SELECT * FROM t_voter;

--��� ���̺� �����̸Ӹ� Ű Ȯ��
SELECT *  
FROM user_constraints  
WHERE table_name LIKE 'T_M%'  AND constraint_type = 'P';

-- ��� �߰�
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  1,         'admin', '1234',  '������', '010-1111-1111', '���� ������' );
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  2,         'hong', '1234',  'ȫ�浿', '010-1111-1112', '���� ���۱�' );
INSERT INTO   T_MEMBER (  MEMBERSEQ,MEMBERID,MEMBERPASSWD,MEMBERNAME,MEMBERPHONE,MEMBERADDRESS )
VALUES                 (  3,         'kim', '1234',  '���ؼ�', '010-1111-1341', '��� �����ֽ�' );
    COMMIT;

��. ȸ�� ���� ����
�α��� -> (ȫ�浿) -> [�� ����] -> �� ���� ���� -> [����] -> [�̸�][][][][][][] -> [����]
PL/SQL
UPDATE T_MEMBER
SET    MEMBERNAME = , MEMBERPHONE = 
WHERE MEMBERSEQ = 2;
��. ȸ�� Ż��
DELETE FROM T_MEMBER 
WHERE MEMBERSEQ = 2;

-- ���� ���
   INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
   VALUES             ( 1  ,'�����ϴ� �����?'
                          , TO_DATE( '2024-02-01 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , TO_DATE( '2024-02-15 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                          , 5
                          , 0
                          , TO_DATE( '2023-01-15 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , 1
                    );
-- �׸� �߰�
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (1 ,'�载��', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (2 ,'�����', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (3 ,'������', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (4 ,'�輱��', 0, 1 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (5 ,'ȫ�浿', 0, 1 );      
   COMMIT;

--���� �ϳ� �� (��ǥ ������)
INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
VALUES             ( 2  ,'�����ϴ� ����?'
                      , TO_DATE( '2024-08-12 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                      , TO_DATE( '2024-08-28 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                      , 4
                      , 0
                      , TO_DATE( '2024-02-20 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                      , 1
                );
--2�� �׸�
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (6 ,'�ڹ�', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (7 ,'����Ŭ', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (8 ,'HTML5', 0, 2 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (9 ,'JSP', 0, 2 );
   
   COMMIT;

-- ���� �߰� ( �����)

   INSERT INTO T_POLL (PollSeq,Question,SDate, EDAte , ItemCount,PollTotal, RegDate, MemberSEQ )
   VALUES             ( 3  ,'�����ϴ� ��?'
                          , TO_DATE( '2024-09-15 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , TO_DATE( '2024-09-20 18:00:00'   ,'YYYY-MM-DD HH24:MI:SS') 
                          , 3
                          , 0
                          , TO_DATE( '2024-03-01 00:00:00'   ,'YYYY-MM-DD HH24:MI:SS')
                          , 1
                    );
--3�� �׸��߰�
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (10 ,'����', 0, 3 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (11 ,'���', 0, 3 );
INSERT INTO T_PollSub (PollSubSeq          , Answer , ACount , PollSeq  ) 
VALUES                (12 ,'�Ķ�', 0, 3 ); 
   
   COMMIT;

-- ��ü ��ȸ�ϱ�
SELECT *
FROM (
    SELECT  pollseq ��ȣ, question ����, membername �ۼ���
         , sdate ������, edate ������, itemcount �׸��, polltotal �����ڼ�
         , CASE 
              WHEN  SYSDATE > edate THEN  '����'
              WHEN  SYSDATE BETWEEN  sdate AND edate THEN '���� ��'
              ELSE '���� ��'
           END ���� -- ����Ӽ�   ����, ���� ��, ���� ��
    FROM t_poll p JOIN  t_member m ON m.memberseq = p.memberseq
    ORDER BY ��ȣ DESC
) t 
WHERE ���� != '���� ��';  -- �������ΰ� �Ⱥ��̰� 

--���� �󼼺���
SELECT question, membername
               , TO_CHAR(regdate, 'YYYY-MM-DD AM hh:mi:ss')
               , TO_CHAR(sdate, 'YYYY-MM-DD')
               , TO_CHAR(edate, 'YYYY-MM-DD')
               , CASE 
                  WHEN  SYSDATE > edate THEN  '����'
                  WHEN  SYSDATE BETWEEN  sdate AND edate THEN '���� ��'
                  ELSE '���� ��'
               END ����
               , itemcount
           FROM t_poll p JOIN t_member m ON p.memberseq = m.memberseq
           WHERE pollseq = 2;
           
--��ǥâ (�׸�)
  SELECT answer
           FROM t_pollsub
           WHERE pollseq = 2;
-- �� ������ ��           
SELECT  polltotal  
    FROM t_poll
    WHERE pollseq = 2;
    
--�׷���
SELECT answer, acount
        , ( SELECT  polltotal      FROM t_poll    WHERE pollseq = 2 ) totalCount
        -- ,  ����׷���
        , ROUND (acount /  ( SELECT  polltotal      FROM t_poll    WHERE pollseq = 2 ) * 100) || '%'
     FROM t_pollsub
    WHERE pollseq = 2;
    
-- ��ǥ     
 INSERT INTO t_voter 
    ( vectorseq, username, regdate, pollseq, pollsubseq, memberseq )
    VALUES
    (      1   ,  '����'      , SYSDATE,   2  ,     7 ,        3 );
    COMMIT;   
 --��ǥ2
 INSERT INTO t_voter 
    ( vectorseq, username, regdate, pollseq, pollsubseq, memberseq )
    VALUES
    (      2   ,  'ȫ�浿'      , SYSDATE,   2  ,     6 ,        2 );
    COMMIT;       
    

-- ���߿� Ʈ���ŷ� �Ұ����� �������� �� �ø��� , �׸� ���ؼ� ��ǥ�� ����� �÷���
  -- 1)         2/3 �ڵ� UPDATE  [Ʈ����]
    -- (2) t_poll   totalCount = 1����
    UPDATE   t_poll
    SET polltotal = polltotal + 1
    WHERE pollseq = 2;
    
    -- (3)t_pollsub   account = 1����
    UPDATE   t_pollsub
    SET acount = acount + 1
    WHERE  pollsubseq = 6;
    
    commit;    
    
    
-------------------------------------------------------------------------------------------------------
-- PL/SQL

 /* ��Ƽ ���� �ּ� ���� (PL/SQL)*/   

DECLARE -- ���� ����
    --�����
BEGIN 
    --�����
    
    /*
    SELECT
    UPDATE
    SELECT
    INSERT
    :
    ����� ����
    */
    
EXCEPTION --���� ����
    --���� ó�� ��
END;
    
-- 1) Anonymous Procedure �͸� ���ν���

DECLARE

    -- ���� ��� �� �����ϴ� ���..
    vename VARCHAR2(10) ;    -- (  ;  ) ���..! �ĸ� �ƴ�.  v�� ����(var)�� ����
    vpay NUMBER;
    
    -- �ڹ� ��� final double PI = 3.141592; �̷��� �߾��µ�
    -- vpi CONSTRAINT NUMBER = 3.141592; -- sql �̷��� ��
    vpi CONSTANT NUMBER := 3.14;           -- ���Կ����ڰ� := �̰���.. =�� �ƴ϶�
BEGIN

SELECT ename, sal+NVL(comm,0) pay
            INTO vename, vpay           -- ������ ���� INTO..!
FROM emp;
--WHERE empno = 7369;

-- �ڹ� ��� System.out.printf("%s, %d\n" , vename, vpay);
/*
���� ���� -
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at line 12
01422. 00000 -  "exact fetch returns more than requested number of rows"
*Cause:    The number specified in exact fetch is less than the rows returned.
*Action:   Rewrite the query or change number of rows requested ���� ���Ƽ� �ܰ� ���ߴ�
*/

DBMS_OUTPUT.PUT_LINE( vename || ', ' || vpay );

--EXCEPTION
END;
    
-- PL/SQL ���� fetch returns more than requested number of rows �̸�
-- CURSOR ����ؾ��� (���� �ȹ��)
    
    
    
-- ����) dept ���̺��� 
-- 30�� �μ��� �μ����� ���ͼ� ����ϴ�  �͸����ν����� �ۼ�,�׽�Ʈ    

DECLARE
   -- vdname VARCHAR2(30) ;
   -- Ÿ���� �����ǵ��� %TYPE ������ ����
   
   vdname dept.dname%TYPE; -- �̷��� �ϴ°� ������� ������..
   
BEGIN

SELECT dname
        INTO vdname
FROM dept
WHERE deptno =30;


DBMS_OUTPUT.PUT_LINE( '������' || vdname);

--EXCEPTION
END;
    
--������ v �Ű������� p   ������

DESC dept;
    
    
-- ���� ) 30�� �μ��� �������� ���ͼ� 10�� �μ��� ���������� �����ϴ� �͸����ν����� �ۼ�, �׽�Ʈ

DECLARE

vloc dept.loc%TYPE;


BEGIN

SELECT loc INTO vloc
FROM dept
WHERE deptno = 30;

UPDATE dept
SET loc = vloc
WHERE deptno = 10;

-- COMMIT; �ѹ��ҰŶ�..

--EXCEPTION
-- ROLLBACK;

END;

-- Ȯ��    
SELECT *
FROM dept;
 
ROLLBACK;   
    
-- [����] 10�� �μ��� �߿� �ְ�޿�(sal)�� �޴� ����� ������ ���.(��ȸ)   
    
    SELECT ROWNUM, e.*
    FROM(
  SELECT *
  FROM emp
  WHERE deptno = 10
  ORDER BY sal DESC
    )e
    WHERE ROWNUM =1 ;
        
-- PL/SQL�ε� �غ���    
DECLARE
    vmax_sal_10  emp.sal%TYPE;
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vhiredate emp.hiredate%TYPE;
    vdeptno emp.deptno%TYPE;
    vsal emp.sal%TYPE;
    
BEGIN
    
    -- 1) �ְ�޿� ���ϱ�
    SELECT MAX(sal) INTO vmax_sal_10
    FROM emp
    WHERE deptno = 10;
    
    --2) 10���μ��̸鼭 �ְ�޿� �޴� ��� ���� �� ������ �־��ֱ�
    SELECT empno, ename, job, sal, hiredate, deptno INTO vempno, vename, vjob, vsal, vhiredate, vdeptno
    FROM emp
    WHERE sal = vmax_sal_10 AND deptno = 10;
    
    --3) ���
    DBMS_OUTPUT.PUT_LINE ( vdeptno || '�� �μ����� ' || vename || '�� �ְ�޿� ' || vsal || '�޴´�');
        
--EXCEPTION
END;
    
    
--PL/SQL (2) ROWTYPE���� �밡������ ����..!
DECLARE
    vmax_sal_10  emp.sal%TYPE;
--    vempno emp.empno%TYPE;
--    vename emp.ename%TYPE;
--    vjob emp.job%TYPE;
--    vhiredate emp.hiredate%TYPE;
--    vdeptno emp.deptno%TYPE;
--    vsal emp.sal%TYPE;
    vemprow emp%ROWTYPE;
BEGIN
    
    -- 1) �ְ�޿� ���ϱ�
    SELECT MAX(sal) INTO vmax_sal_10
    FROM emp
    WHERE deptno = 10;
    
    --2) 10���μ��̸鼭 �ְ�޿� �޴� ��� ���� �� ������ �־��ֱ�=> ROWTYPE�̹Ƿ� vemprow.�������̺��÷��� �ϸ� �˾Ƽ� Ÿ�� �����
    SELECT empno, ename, job, sal, hiredate, deptno INTO vemprow.empno, vemprow.ename, vemprow.job, vemprow.sal, vemprow.hiredate, vemprow.deptno
    FROM emp
    WHERE sal = vmax_sal_10 AND deptno = 10;
    
    --3) ���
    DBMS_OUTPUT.PUT_LINE ( vemprow.deptno || '�� �μ����� ' || vemprow.ename || '�� �ְ�޿� ' || vemprow.sal || '�޴´�');
        
--EXCEPTION
END;
    
    
-- := ���Կ����� ����

DECLARE
    va NUMBER := 1;
    vb NUMBER ;
    vc NUMBER := 0;
BEGIN
    vb := 100;
    vc := va + vb;
    
    DBMS_OUTPUT.PUT_LINE( vc );
--EXCEPTION
END;
    
    
-- PL/SQL������ ���
-- �ڹ�:  if(���ǽ�) {  } 

--���� ������ ���� �� 

IF  /*���ǽ� �ڸ�, () ���� ����*/
THEN -- �ڹٷ� ġ�� {

END IF; --�ڹٷ� ġ�� }
    
--else �߰�?
IF  /*���ǽ� �ڸ�, () ���� ����*/
THEN 

ELSE

END IF; 
    
    
    
-- �ڹ�:  if(���ǽ�) {  }  else if (���ǽ�) { }   
    
IF ���ǽ� THEN
ELSIF ���ǽ� THEN
ELSIF ���ǽ� THEN
ELSIF ���ǽ� THEN
ELSIF ���ǽ� THEN
ELSE
END IF;
    
--����) �ϳ��� ������ �Է¹޾Ƽ� Ȧ/¦ ���

DECLARE
    vnum NUMBER(4) := 0;
    vresult VARCHAR2(6) := 'Ȧ��';
BEGIN
    vnum := :bindNumber; -- ���ε� ����. ? (��ȭ���ڷ� �Է¹޴´� ?)
  
    IF  MOD(vnum, 2) = 0
    THEN 
        vresult := '¦��';
    ELSE
        vresult := 'Ȧ��';
    END IF;   
    
    DBMS_OUTPUT.PUT_LINE( vresult );

--EXCEPTION
END;
    
    
 -- [����] PL/SQL   IF�� ��������...
--  �������� �Է¹޾Ƽ� ����̾簡 ��� ���... ( �͸����ν��� )   
    
    
DECLARE
    vkor NUMBER(3);
    vrank VARCHAR2(3);
BEGIN
    vkor := :bindNumber;
    
    IF vkor >= 90 THEN vrank := '��';
    ELSIF vkor >= 80 THEN vrank := '��';
    ELSIF vkor >= 70 THEN vrank := '��';
    ELSIF vkor >= 60 THEN vrank := '��';
    ELSE vrank := '��';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE( vkor || '�� ' || vrank || ' �Դϴ�' );
--EXCEPTION
END;
    
---Ǯ��2

DECLARE
    vkor NUMBER(3);
    vrank VARCHAR2(3);
BEGIN
    vkor := :bindNumber;
    
    IF ( vkor BETWEEN 0 AND 100)  THEN 
    -- ��~ ��
    vrank := CASE TRUNC(vkor/10)
                    WHEN 10 THEN '��'
                    WHEN 9 THEN '��'
                    WHEN 8 THEN '��'
                    WHEN 7 THEN '��'
                    WHEN 6 THEN '��'
                    ELSE '��'
                END;
    DBMS_OUTPUT.PUT_LINE( vkor || '�� ' || vrank || ' �Դϴ�' );
    ELSE
    DBMS_OUTPUT.PUT_LINE(' ���� ���� 0 ~ 100 ���� �Է� ! ');
    END IF;
    
    
--EXCEPTION
END;
    
    
-- WHILE��.
--�ڹ�
while(���ǽ�) {
   // �ݺ�����
   
}
-- PL/SQL
WHILE(���ǽ�) LOOP -- {
END LOOP;-- }

--�ڹ�
while (true) {
    if(���ǽ�) break;
}

--PL/SQL
LOOP
    EXIT WHEN (���ǽ�);
END LOOP;
    
    
--���� 1~10���� �� ���

DECLARE
    vnum NUMBER := 1;
    vsum NUMBER := 0;
    
BEGIN
    
    WHILE (vnum<=10)  LOOP
    IF (vnum<=9)THEN
    DBMS_OUTPUT.PUT( vnum || '+' );
    ELSE
    DBMS_OUTPUT.PUT( vnum );
    END IF;
    
    vsum := vsum + vnum;
    vnum := vnum+1;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( '=' || vsum );
    
--EXCEPTION
END;
    
-- LOOP   END LOOP  
    
DECLARE
    vnum NUMBER := 1;
    vsum NUMBER := 0;
    
BEGIN
    
    LOOP
    EXIT WHEN (vnum= 11) ;
    
    IF (vnum<=9)THEN
    DBMS_OUTPUT.PUT( vnum || '+' );
    ELSE
    DBMS_OUTPUT.PUT( vnum );
    END IF;
    
    vsum := vsum + vnum;
    vnum := vnum+1;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE( '=' || vsum );
    
--EXCEPTION
END;    
    
    
 -- for��.
 --1~10���� �� 
 
 DECLARE
    --vi NUMBER ;           �ݺ������� ���⼭ ���� ���ϰ� ����ص� �ȴ�. ��¥ for�� i����
    vsum NUMBER := 0;
 
 BEGIN
 
-- FOR �ݺ����� IN [reverse] (���۰� .. ����)
-- LOOP
-- 
-- END LOOP;
    
 FOR vi IN 1 .. 10
 LOOP
 DBMS_OUTPUT.PUT_LINE( vi || '+' );
 vsum := vsum + vi;
 END LOOP;
 
 DBMS_OUTPUT.PUT_LINE( '=' || vsum );
 
 --EXCEPTION
 END;
    
-- GO TO   (������)

 declare 
      chk number := 0; 
    begin 
    <<restart>> 
      --dbms_output.enable; 
      chk := chk +1; 
      dbms_output.put_line(to_char(chk)); 
      if chk <> 5 then 
        goto restart; 
     end if; 
   end;     
    
    --GO TO  ����2
  --DECLARE
BEGIN
  --
  GOTO first_proc;
  --
  <<second_proc>>
  DBMS_OUTPUT.PUT_LINE('> 2 ó�� ');
  GOTO third_proc; 
  -- 
  --
  <<first_proc>>
  DBMS_OUTPUT.PUT_LINE('> 1 ó�� ');
  GOTO second_proc; 
  -- 
  --
  --
  <<third_proc>>
  DBMS_OUTPUT.PUT_LINE('> 3 ó�� '); 
--EXCEPTION
END;  
    
  
  -- ����) 1��: while�� �Ἥ ������
  
  DECLARE
    vdan NUMBER := 2;
    vi NUMBER := 1;
 
  BEGIN
  
  WHILE vdan <= 9 LOOP
    vi := 1;
        WHILE vi <= 9 LOOP
        DBMS_OUTPUT.PUT( vdan || 'x' || vi || '=' || RPAD ( vdan*vi , 4, ' ') );
        vi := vi+1;
        END LOOP;
  DBMS_OUTPUT.PUT_LINE('');
  vdan := vdan +1;
  END LOOP;
  --EXCEPTION
  END;
  

  
  
  -- ����) 2��: for�� �Ἥ ������
  
--DECLARE
--  vdan NUMBER:= 0;
--  vhang NUMBER:= 0;

BEGIN

FOR vdan IN 2 .. 9
LOOP
DBMS_OUTPUT.PUT_LINE( vdan || '��' );
         
         FOR vhang IN 1 .. 9
         LOOP
            DBMS_OUTPUT.PUT( vdan || 'x' || vhang || '=' || vdan*vhang );
            DBMS_OUTPUT.PUT_LINE( '' );
         END LOOP;
        
END LOOP;

  --EXCEPTION
  END;
    
 -- FOR���� ����� SELECT (���)

-- DECLARE
 BEGIN
 
 /*
 FOR �ݺ����� IN (��������) LOOP
 
 END LOOP;
 */

--���ڵ� ���� ������ : verow
 FOR verow IN (SELECT ename, hiredate, job FROM emp ) LOOP -- ���ڵ尡 ��������... �Ʊ� ��޵ƴ� Ŀ�� �ʿ� (�ڵ� ��� : �Ͻ��� Ŀ��)
    DBMS_OUTPUT.PUT_LINE( verow.ename || '/' || verow.hiredate || '/' || verow.job ); 
 END LOOP;
 
 --EXCEPTION
 END;
    
    
-- %TYPE , %ROWTYPE, RECORD ���� ����.    
    
 SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay
 FROM dept d JOIN emp e ON d.deptno = e.deptno
 WHERE empno = 7369;

-- %TYPE ����

DECLARE
    vdeptno dept.deptno%TYPE;
    vdname dept.dname%TYPE;
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vpay NUMBER;
BEGIN
    SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay
                INTO vdeptno , vdname, vempno, vename, vpay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
    
    DBMS_OUTPUT.PUT_LINE( vdeptno || ', ' || vdname || ', ' || vempno || ', ' || vename || ', ' || vpay );
--EXCEPTION
END;
    
-- %ROWTYPE �� ����
DECLARE
    verow emp%ROWTYPE;
    vdrow dept%ROWTYPE;
    vpay NUMBER;
BEGIN
    SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay
                INTO vdrow.deptno , vdrow.dname, verow.empno, verow.ename, vpay
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
    
    DBMS_OUTPUT.PUT_LINE( vdrow.deptno || ', ' || vdrow.dname || ', ' || verow.empno || ', ' || verow.ename || ', ' || vpay );
--EXCEPTION
END;
    
--RECORD�� ����

--SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay -- dept���̺� , emp���̺� ���������� RECORD�� �ϳ��� ���ڵ�� �ݿ� ����
--�̷� ������ �����͸� ������ ���ڵ� Ÿ�� ����
-- (����� ���� ����ü Ÿ�� ����)
DECLARE
TYPE EmpDeptType IS RECORD
(
        deptno dept.deptno%TYPE,
        dname dept.dname%TYPE, 
        empno emp.empno%TYPE,
        ename emp.ename%TYPE, 
        pay NUMBER 
);
vedrow EmpDeptType; --�ϳ��� ���ο� �ڷ��� �̸��� ��
BEGIN
    SELECT d.deptno , dname, empno, ename, sal + NVL(comm,0) pay
                --INTO vedrow.deptno , vedrow.dname, vedrow.empno, vedrow.ename, vedrow.pay �Ѵ� ��
                INTO vedrow
    FROM dept d JOIN emp e ON d.deptno = e.deptno
    WHERE empno = 7369;
    
    DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname || ', ' || vedrow.empno || ', ' || vedrow.ename || ', ' || vedrow.pay );
--EXCEPTION
END;
    
-- INSA���� basicpay+sudang =pay  ���̰� 200 ������ 0.02% ����, 250������ 0.025% ������

SELECT num, name, basicpay+sudang ����
FROM insa;
    
DECLARE
    --virow insa%ROWTYPE;
    vname insa.name%TYPE;
    vpay NUMBER;
    vtax NUMBER;
    vsil NUMBER;
    
BEGIN

SELECT name, basicpay+sudang
    INTO vname, vpay
FROM insa
WHERE num = 1001;

IF vpay > 2500000 THEN vtax := vpay * 0.025;
ELSIF vpay > 2000000 THEN vtax := vpay * 0.02;
ELSE vtax := 0;
END IF;

vsil := vpay - vtax;

DBMS_OUTPUT.PUT_LINE(vname || '   ' || vpay || ' ' || vtax || '   ' || vsil); 

--EXCEPTION
END;
    
    
----Ŀ�� == PL/SQL�� SELECT 
-- �ٱ��� ?

--�޿� 5����� �̱�: 12�� �𼾵�  �ϰ� ROWCOUNT 5�ɶ����� Ŀ�� �б�.. ?





 DECLARE
    TYPE EmpDeptType IS RECORD
    (
       deptno dept.deptno%TYPE,
       dname dept.dname%TYPE,
       empno emp.empno%TYPE,
       ename emp.ename%TYPE,
       pay NUMBER
    );
    vedrow EmpDeptType;
    -- 1) Ŀ�� ����
    -- CURSOR Ŀ���� IS (SELECT��) 
    CURSOR vdecursor IS (
        SELECT d.deptno, dname, empno, ename, sal + NVL(comm,0) pay
        FROM dept d JOIN emp e ON d.deptno = e.deptno
    );

BEGIN
    -- 2) Ŀ�� ���� SELECT�� ���� -- (��Ʈ�� F11ó��)
    OPEN vdecursor;
    
    -- 3) FETCH = ��������
    LOOP 
        FETCH vdecursor INTO vedrow;
        EXIT WHEN vdecursor%NOTFOUND;
         DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname 
    || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  ||
    ', ' ||  vedrow.pay );
    END LOOP;

    --4) Ŀ�� close
    CLOSE vdecursor;
    
 END;   

    
-----FOR���� ����ϴ� �Ͻ��� Ŀ��-----

DECLARE
BEGIN    
    FOR vedrow IN (SELECT d.deptno, dname, empno, ename, sal + NVL(comm,0) pay
        FROM dept d JOIN emp e ON d.deptno = e.deptno)
    LOOP
    DBMS_OUTPUT.PUT_LINE( vedrow.deptno || ', ' || vedrow.dname 
    || ', ' ||  vedrow.empno  || ', ' || vedrow.ename  ||
    ', ' ||  vedrow.pay );
    END LOOP;
 END;       
 
