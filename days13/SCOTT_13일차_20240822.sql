--���� ���ν��� (STORED PROCEDURE)

--���� ����
CREATE OR REPLACE PROCEDURE ���ν�����
(
    �Ű����� ����
    -- ( , ) ���� ; �ƴ�  + Ÿ���� ũ��� ���� X
    , p�Ű������� (mode) �ڷ���
    -- IN �Է¿� �Ķ���� / OUT  ��¿� �Ķ���� / IN OUT ��,��¿� �Ķ����      �⺻: IN
    ,
    ,
    p~~
)
IS (DECLARE �ڸ�)  -- ����ٰ� ���� / ��� ����
    v~~
BEGIN
EXCEPTION
END;

DROP PROCEDURE ���ν����� ; (����)

-- ���� ���ν��� ������ (3����)

-- 1) EXECUTE ���� ���� ����
-- 2) �͸� ���ν������� ȣ���ؼ� ����
-- 3) �� �ٸ� ���� ���ν������� ȣ���ؼ� ����.


-- ���������� ����ؼ� ���̺� ����...

CREATE TABLE tbl_emp
AS (
    SELECT *
    FROM emp
    );

SELECT *
FROM tbl_emp;


-- tbl_emp���� �����ȣ�� �Է¹޾Ƽ� ����� �����ϴ� ���� -> ���� ���ν��� 
DELETE FROM tbl_emp
WHERE empno = 7499; 
-- �����Ͱ� ������ �̷� ���� ������ �����ɸ� => ���� ���ν��� ����
-- �������� ���� ���ν������ ������ up_�� ����. 

-- �Ẹ��
CREATE OR REPLACE PROCEDURE up_deltblemp
(
    -- pempno NUMBER(4) --�� ���̾ ( ; ) �Ⱦ� + ũ�� ������ ����
    pempno IN tbl_emp.empno%TYPE -- �̷��� �ڷ����� ���ؼ� �Ű� �� ���� �پ��  , �Ķ���� �뵵�� �⺻�� IN
    
)
IS
    -- ����, ��� ���� X �� �����
BEGIN
    DELETE FROM tbl_emp
    WHERE empno = pempno;  
    
    COMMIT;
    
--EXCEPTION
    --ROLLBACK;
END;
-- Procedure UP_DELTBLEMP��(��) �����ϵǾ����ϴ�.
-- SCOTT ���ν����� ��ϵǾ� ����
-- ���� �Ẹ��
-- 1) EXECUTE ���� ���� ����

EXECUTE up_deltblemp; --PLS-00306: wrong number or types of arguments in call to 'UP_DELTBLEMP'  �Ű����� �߾���� ���� ��
EXECUTE up_deltblemp('KING'); -- �Ű����� �ȸ°� �൵ ����ȵ� ������

EXECUTE up_deltblemp(7566); --PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�. JONES������
EXECUTE up_deltblemp(pempno=>7369); --PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�. SMITH ��

SELECT *
FROM tbl_emp; --Ȯ��. ����, ���̽� ����

-- 2) �͸� ���ν������� ȣ���ؼ� ����

DECLARE
BEGIN
    up_deltblemp(7499); --�˷� ����
    --PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
--EXCEPTION
END;


-- 3) �� �ٸ� ���� ���ν������� ȣ���ؼ� ����.

CREATE OR REPLACE PROCEDURE up_deltblemp_test
(
    pempno tbl_emp.empno%TYPE
)
IS
BEGIN
    up_deltblemp(7521); -- ward 
--EXCEPTION
END;
--Procedure UP_DELTBLEMP_TEST��(��) �����ϵǾ����ϴ�.

EXECUTE up_deltblemp_test(7521);
--PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

-- ����) dept �̿��ؼ� tbl_dept���̺� ����

CREATE TABLE tbl_dept
AS (
    SELECT *
    FROM dept
);

-- ����) tbl_dept ���̺� ���������� Ȯ�� �� deptno �÷��� PK �������� ����.

DESC tbl_dept;

SELECT *
FROM user_constraints
WHERE table_name LIKE 'TBL_D%';

ALTER TABLE tbl_dept ADD CONSTRAINT PK_tbl_dept PRIMARY KEY(deptno);

--����) tbl_dept ���̺� SELECT �� ... DBMS OUTPUT���� ����ϴ� ���� ���ν��� �����ϰ� ���ν������� up_seltbldept�� �϶�

-- ����� Ŀ��

CREATE OR REPLACE PROCEDURE up_seltbldept
IS 
    CURSOR vdcursor IS (
                                    SELECT deptno, dname, loc FROM tbl_dept 
                                    ); -- 1) ����� ����
    vdrow tbl_dept%ROWTYPE;
BEGIN
--2) ���� - ������ �ޱ� ���� (����)
OPEN vdcursor;

--3) FETCH
LOOP
    FETCH vdcursor INTO vdrow; -- vdcursor���� �޾ƿͼ� vdrow�� �ֱ�
    EXIT WHEN vdcursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE( vdcursor%ROWCOUNT || ' : ' );
    DBMS_OUTPUT.PUT_LINE(  vdrow.deptno || ', ' || vdrow.dname 
      || ', ' ||  vdrow.loc );

END LOOP;


-- 4) �ݱ�
CLOSE vdcursor;

--EXCEPTION
END;

--����
EXEC up_seltbldept;


-- �Ͻ��� Ŀ�� (FOR��)
CREATE OR REPLACE PROCEDURE up_seltbldept

IS 
--vdrow tbl_dept%ROWTYPE;

BEGIN
    FOR vdrow IN (SELECT deptno, dname,loc FROM tbl_dept ) 
    LOOP
    --DBMS_OUTPUT.PUT_LINE(' ')
    DBMS_OUTPUT.PUT_LINE( vdrow.deptno || ', ' || vdrow.dname 
      || ', ' ||  vdrow.loc );
    END LOOP;
    
    COMMIT;
--EXCEPTION
END;

EXEC up_seltbldept;


-- ���ο� �μ��� �߰��ϴ� ���� ���ν��� ? (�̸��� up_instbldept)
-- �� 10, 20, 30, 40 ������ ������ 50, 60... �̷��� ������ => ������ ( 50 ���� , ����ġ 10 )

SELECT *
FROM  user_sequences;
-- ������ ������ seq_tbldept
CREATE SEQUENCE seq_tbldept
INCREMENT BY 10 START WITH 50 NOCACHE  NOORDER  NOCYCLE ;
--Sequence SEQ_TBLDEPT��(��) �����Ǿ����ϴ�.

DESC tbl_dept;
-- Ȯ���غ��� �μ���, ������ NULL ������

CREATE OR REPLACE PROCEDURE up_instbldept
(
    pdname IN tbl_dept.dname%TYPE DEFAULT NULL,
    ploc IN tbl_dept.loc%TYPE := NULL
)
IS -- ���� deptno�� �ִ� ���� ���� �����ϰ� ��� +10�ϸ鼭 �ᵵ �� ������ �������� ��..
BEGIN
    INSERT INTO tbl_dept (deptno,dname,loc)
    VALUES ( seq_tbldept.NEXTVAL , pdname, ploc );
    
    COMMIT;
--EXCEPTION
    --ROLLBACK;
END;

EXEC up_instbldept;

SELECT * FROM tbl_dept;

EXEC up_instbldept('QC', 'SEOUL'); -- ���� ������ �������� ���������� ����

-- EXEC up_instbldept(pdname=>'QC', 'SEOUL'); �ϳ��� �ְ� �Ͱų� ���� �ٲ���� ������ Ȯ���ϰ� �� �� �ִ� ���
EXEC up_instbldept(pdname=>'RECRUIT');

-- [����] �μ���ȣ�� �Է¹޾Ƽ� �����ϴ� up_deltbldept ���� ���ν��� ?

CREATE OR REPLACE PROCEDURE up_deltbldept
(
    pdno tbl_dept.deptno%TYPE
)
IS

BEGIN

DELETE
FROM tbl_dept
WHERE deptno = pdno;

COMMIT;

--EXCEPTION
END;

EXEC up_deltbldept(50);
EXEC up_deltbldept(80);-- ���ܹ߻� ! (���� �μ� ����) �ε� ���ؼ� �� ������


SELECT *
FROM tbl_dept;


-- ����) �Ű������� (60, 'x' , 'y') �μ����� �����ǰ�
--EXEC up_updtbldept( 60, 'X', 'Y' );  -- dname, loc
--EXEC up_updtbldept( pdeptno=>60,  pdname=>'QC3' );  -- loc
--EXEC up_updtbldept( pdeptno=>60,  ploc=>'SEOUL' );  -- 

CREATE OR REPLACE PROCEDURE up_updtbldept
(
    pdno tbl_dept.deptno%TYPE
    ,pdname tbl_dept.dname%TYPE --DEFAULT tbl_dept.dname
    ,pdloc tbl_dept.loc%TYPE --DEFAULT tbl_dept.loc
)
IS
    original_dname tbl_dept.dname%TYPE;
    original_loc tbl_dept.loc%TYPE;
BEGIN

SELECT dname, loc INTO (original_dname, original_loc)
FROM tbl_dept
WHERE deptno = pdno;

   IF  pdname != original_dname
    THEN 
        original_dname := pdname;
    ELSE
        original_dname := original_dname;
    END IF;   

    IF  pdloc != original_loc
    THEN 
        original_loc := pdloc;
    ELSE
        original_loc := original_loc;
    END IF;


UPDATE tbl_dept
SET dname = original_dname
     ,loc =original_loc
WHERE deptno = pdno ;
--Ǯ�ٰ� ����

--EXCEPTION
END;

EXEC up_updtbldept( 60, 'X', 'Y' ); 
EXEC up_updtbldept( pdeptno=>60,  pdname=>'QC3' );

SELECT *
FROM tbl_dept;

-- ��Ǯ�� 1) -- Ʋ�� ������ �Է¾��ϸ� NULL�ΰ� �������� ��
CREATE OR REPLACE PROCEDURE up_updtbldept
(
    pdno tbl_dept.deptno%TYPE --PK (WHERE�� ��������) �� ���̸� �ȵ� �ʼ��׸��̶���
    ,pdname tbl_dept.dname%TYPE := NULL
    ,pdloc tbl_dept.loc%TYPE := NULL
)
IS 
    vdname tbl_dept.dname%TYPE ;
    vloc tbl_dept.loc%TYPE;
BEGIN

SELECT dname, loc INTO vdname, vloc
FROM tbl_dept
WHERE deptno = pdno;

IF pdname IS NULL AND ploc IS NULL THEN -- �ƹ��͵� �ȹٲٴ� ���
ELSIF pdname IS NULL THEN -- ���Ӹ� �ٲ� ���
    UPDATE tbl_dept
    SET loc = ploc
    WHERE deptno = pdno;
ELSE --�Ѵ� �ٲ�
    UPDATE tbl_dept
    SET loc = ploc, dname = pdname
    WHERE deptno = pdno;
END IF

--EXCEPTION
END;

-- 2)

CREATE OR REPLACE PROCEDURE up_updtbldept
(
    pdno tbl_dept.deptno%TYPE
    ,pdname tbl_dept.dname%TYPE := NULL
    ,pdloc tbl_dept.loc%TYPE := NULL
)
IS 
    vdname tbl_dept.dname%TYPE ;
    vloc tbl_dept.loc%TYPE;
BEGIN

UPDATE tbl_dept
SET dname = NVL(pdname, dname)
    , loc = CASE WHEN pdloc IS NULL THEN loc 
                ELSE pdloc
                END
WHERE deptno = pdno;            

COMMIT ;

--EXCEPTION
END;

EXEC up_updtbldept( pdno=>60,  pdname=>'QC3' );

SELECT *
FROM tbl_dept;

EXEC up_deltbldept(60);
-- ������ tbldept�� ��������
DROP SEQUENCE seq_tbldept;


-- ����) ����� Ŀ���� ����ؼ� ��� �μ����� ��ȸ
-- �μ���ȣ�� �Ķ���ͷ� �޾Ƽ� �ش� �μ����鸸 

CREATE OR REPLACE PROCEDURE up_seltblemp
(
    pdno tbl_emp.deptno%TYPE -- :=NULL �̸� �����(IS) ���� WHERE ���� NVL�ؾߵ�]
    -- �װͺ��� �� PK..
)
IS
      CURSOR vecursor IS (
        SELECT  * --deptno, empno, ename, sal, comm, job, hiredate, mgr --�̰� ���� �ٲٴϱ� �ǳ�;
        FROM tbl_emp
        WHERE deptno = pdno
        );
    verow tbl_emp%ROWTYPE;
BEGIN
    
    OPEN vecursor;
    
    LOOP 
        FETCH vecursor INTO verow;
        EXIT WHEN vecursor%NOTFOUND;
        
         DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.empno 
    || ', ' ||  verow.ename  || ', ' || verow.sal  ||
    ', ' ||  verow.comm || ', ' || verow.job || ', ' || verow.hiredate|| ', ' || verow.mgr);
    
    END LOOP;
    
    CLOSE vecursor;
    

END;

EXEC up_seltblemp (20);



-- Ŀ���� �Ķ���� ( ���������� �����ε� pdno , cpdno �� �� �ؾߵǳ�)
CREATE OR REPLACE PROCEDURE up_seltblemp
(
    pdno tbl_emp.deptno%TYPE -- :=NULL �̸� �����(IS) ���� WHERE ���� NVL�ؾߵ�
)
IS
      CURSOR vecursor(cpdno tbl_emp.deptno%TYPE) IS (  -- Ŀ�� �տ� ���� �Ķ���� '����'
        SELECT  * --deptno, empno, ename, sal, comm, job, hiredate, mgr
        FROM tbl_emp
        WHERE deptno = cpdno
        );
    verow tbl_emp%ROWTYPE;
BEGIN
    
    OPEN vecursor(pdno);
    
    LOOP 
        FETCH vecursor INTO verow;
        EXIT WHEN vecursor%NOTFOUND;
        
         DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.empno 
    || ', ' ||  verow.ename  || ', ' || verow.sal  ||
    ', ' ||  verow.comm || ', ' || verow.job || ', ' || verow.hiredate|| ', ' || verow.mgr);
    
    END LOOP;
    
    CLOSE vecursor;
    

END;




-- �Ͻ��� Ŀ�� (for) Ȯ���� �갡 ���� ������..
CREATE OR REPLACE PROCEDURE up_seltblemp
(
    pdno tbl_emp.deptno%TYPE
)
IS
BEGIN
    FOR verow IN (SELECT  * 
                  FROM tbl_emp
                  WHERE deptno = pdno ) LOOP
                  
                   DBMS_OUTPUT.PUT_LINE( verow.deptno || ', ' || verow.empno 
                                                          || ', ' ||  verow.ename  || ', ' || verow.sal  || ', ' ||  
                                                          verow.comm || ', ' || verow.job || ', ' || verow.hiredate|| ', ' || verow.mgr);
                  
                END LOOP;

END;



--���� ���ν���
-- �Ķ���� IN �Է� .. OUT ��� 

--�����ȣ(IN) => ����̸�, �ֹι�ȣ (OUT) ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE up_selinsa
(
    pnum IN insa.num%TYPE
    , pname OUT insa.name%TYPE
    , pssn OUT insa.ssn%TYPE
)
IS
    vname insa.name%TYPE;
    vssn insa.ssn%TYPE;
BEGIN
    SELECT name, ssn INTO vname, vssn
    FROM insa
    WHERE num = pnum;

    pname := vname;
    pssn := CONCAT( SUBSTR(vssn, 0, 8 ) , '******');
    

--EXCEPTION
END;

--�͸� ���ν������� ȣ���ؼ� ���� 

-- VARIABLE vname  ������������ ���� ��ü���� ����ϴ� ������ �ǹ���
DECLARE -- ���⼭�� ���Ŵϱ� �ȿ��� ����
    vname insa.name%TYPE;
    vssn insa.ssn%TYPE;
BEGIN
  up_selinsa ( 1001 ,vname, vssn); --�޴� ������ ��
  DBMS_OUTPUT.PUT_LINE( vname || ', ' || vssn); -- �޴� ������ ��Ƴ����� ��¤�
--EXCEPTION
END;


-- IN/OUT ����¿� �Ķ���� ���� ?! ( IN , OUT ���� ���� ���)
-- �ֹε�Ϲ�ȣ ssn  14�ڸ��� �Ķ���� IN
-- ��������� �ش�Ǵ� �ֹι�ȣ 6�ڸ��� �Ķ���� OUT


CREATE OR REPLACE PROCEDURE up_ssn
(
    pssn IN OUT VARCHAR2
)
IS
BEGIN
    pssn := SUBSTR(pssn, 0, 6);
    
--EXCEPTION
END;

DECLARE
    vssn VARCHAR2(14) := '111113-1111115' ;
BEGIN
    up_ssn(vssn);
    DBMS_OUTPUT.PUT_LINE( vssn ); -- IN OUT
END;

-- �����Լ� ,STORED FUNCTION 
-- �ֹε�Ϲ�ȣ => ���� üũ
--  ���� �ڷ���              ���ϰ� '����' '����'
--      VARCHAR2

CREATE OR REPLACE FUNCTION uf_gender
(
    pssn insa.ssn%TYPE
)
RETURN VARCHAR2

IS
    vgender VARCHAR2(6);
BEGIN
    IF MOD(SUBSTR(pssn, 8 , 1),2) =1 THEN vgender := '����';
    ELSE vgender := '����';
    END IF;

RETURN (vgender);

--EXCEPTION
END;
--Function UF_GENDER��(��) �����ϵǾ����ϴ�.

SELECT num,name, ssn, UF_GENDER(ssn) gender, uf_age(ssn,0) age
FROM insa;


-- uf_age ���� ssn ������ ���� ������ִ� �Լ� >?!

CREATE OR REPLACE FUNCTION uf_age
(
    pssn insa.ssn%TYPE
)
RETURN NUMBER

IS

    vsgi NUMBER;
    vbirth NUMBER;
    vage NUMBER;
    
BEGIN

IF SUBSTR(pssn,-7,1) IN (1,2,5,6) THEN vbirth := 1900+ SUBSTR(pssn,0,2);
ELSIF  SUBSTR(pssn,-7,1) IN (3,4,7,8) THEN vbirth:= 2000+ SUBSTR(pssn,0,2);
ELSE vbirth := 1800+ SUBSTR(pssn,0,2);
END IF;

IF  SIGN( TO_DATE(SUBSTR(pssn,3,4),'mmdd') - TRUNC( sysdate) ) = 0
    OR SIGN( TO_DATE(SUBSTR(pssn,3,4),'mmdd') - TRUNC( sysdate) ) = -1
    THEN vage :=  TO_CHAR(sysdate , 'yyyy') - vbirth -1;
    ELSE vage := TO_CHAR(sysdate , 'yyyy') - vbirth;
END IF;


    RETURN (vage);
        
END;

-- ��Ǯ��

CREATE OR REPLACE FUNCTION uf_age
(
   pssn IN VARCHAR2
   , ptype IN NUMBER -- ������ 0, ���� ���� 1
)
RETURN NUMBER
IS
    �� NUMBER(4);  -- ���س⵵
    �� NUMBER(4) ;  -- ���ϳ⵵
    �� NUMBER(1);  -- �������� ����      -1   0    1
    vcounting_age NUMBER(3); -- ���� ����
    vamerican_age NUMBER(3); -- �� ����
BEGIN
  -- ������ = ���س⵵ - ���ϳ⵵      ������������X -1
  --       =    ���³��� -1          ������������X -1 
  -- ���³��� = ���س⵵ - ���ϳ⵵ + 1
  �� := TO_CHAR(SYSDATE,'YYYY');
  �� := CASE 
           WHEN SUBSTR(pssn, -7,1) IN (1,2,5,6) THEN 1900
           WHEN SUBSTR(pssn, -7,1) IN (3,4,7,8) THEN 2000
           ELSE 1800
        END + SUBSTR(pssn,0,2);
  �� := SIGN( TO_DATE(SUBSTR(pssn,3,4), 'MMDD') - TRUNC(SYSDATE) ); --   -1 X     
  vcounting_age := �� - �� + 1;
  vamerican_age := vcounting_age -1 + CASE ��
                                         WHEN 1 THEN -1
                                         ELSE 0
                                      END;
  IF ptype = 1 THEN 
     RETURN vcounting_age;
  ELSE
     RETURN vamerican_age;
  END IF; 
--EXCEPTION
END;


-- ��) �ֹε�Ϲ�ȣ-> 1998.01.20(ȭ) ������ ���ڿ��� ��ȯ�ϴ� �����Լ� �ۼ�.�׽�Ʈ-- 
--��) �ֹε�Ϲ�ȣ-> 1998.01.20(ȭ) ������ ���ڿ��� ��ȯ�ϴ� �����Լ� �ۼ�.�׽�Ʈ
-- uf_birth



CREATE OR REPLACE FUNCTION uf_birth
(
    pssn insa.ssn%TYPE
)
RETURN VARCHAR2
IS

    vbdate DATE;

BEGIN

    vbdate := TO_DATE ( SUBSTR(pssn,0,6) );
    
    RETURN  TO_CHAR( vbdate, 'yyyy.mm.dd (dy)' ) ;

END;

SELECT name, uf_birth(ssn)
FROM insa;

-- ��Ǯ��

CREATE OR REPLACE FUNCTION uf_birth
(
    pssn insa.ssn%TYPE
)
RETURN VARCHAR2
IS
    
    vcentury NUMBER(2);
    vbdate DATE;

BEGIN

    vbdate := TO_DATE ( SUBSTR(pssn,0,6) );
    vcentury := CASE 
           WHEN SUBSTR(pssn, -7,1) IN (1,2,5,6) THEN 19
           WHEN SUBSTR(pssn, -7,1) IN (3,4,7,8) THEN 20
           ELSE 18
           END ;
    
    vbdate := vcentury || vbdate;
    
           
    RETURN  TO_CHAR( TO_DATE( vbdate )  , 'yyyy.mm.dd (dy)') ;

END;


--����

CREATE TABLE tbl_score
(
     num   NUMBER(4) PRIMARY KEY
   , name  VARCHAR2(20)
   , kor   NUMBER(3)  
   , eng   NUMBER(3)
   , mat   NUMBER(3)  
   , tot   NUMBER(3)
   , avg   NUMBER(5,2)
   , rank  NUMBER(4) 
   , grade CHAR(1 CHAR)
);

SELECT *
FROM tbl_score;

CREATE SEQUENCE seq_tblscore; -- 1���� 1�� �����ϴ� ������

SELECT *
FROM user_sequences;

-- ���� 1) �л��� �߰��ϴ� ���� ���ν��� �߰� ?

--EXEC up_insertscore(1001, 'ȫ�浿', 89,44,55 );
--EXEC up_insertscore(1002, '�����', 49,55,95 );
--EXEC up_insertscore(1003, '�赵��', 90,94,95 );
-- �й��� ��������..

CREATE OR REPLACE PROCEDURE up_insertscore
(
    pname tbl_score.name%TYPE
    ,pkor tbl_score.kor%TYPE
    ,peng tbl_score.kor%TYPE
    ,pmat tbl_score.kor%TYPE
    
)
IS
    vtot NUMBER(3) := 0;
    vavg NUMBER(5,2) ;
    vgrade tbl_score.grade%TYPE;
BEGIN
    
    vtot := pkor + peng + pmat;
    vavg := vtot / 3 ;
    
    IF vavg >= 90 THEN vgrade := 'A';
    ELSIF vavg >= 80 THEN vgrade := 'B';
    ELSIF vavg >= 70 THEN vgrade := 'C';
    ELSIF vavg >= 60 THEN vgrade := 'D';
    ELSE vgrade := 'F';
    END IF;
    
    INSERT INTO tbl_score (num, name, kor, eng, mat, tot, avg, grade, rank)
    VALUES (seq_tblscore.NEXTVAL, pname, pkor, peng, pmat, vtot, vavg, vgrade, 1);
    
    -- ��� �ٰŸ� �� �ڸ����� ������Ʈ�� ������ ��
     up_rankScore; -- ���� ���ν��� �ȿ� ���� ���ν��� �ֱ� ����
    
    COMMIT;
    

--EXCEPTION
END;

EXEC up_insertscore( 'ȫ�浿', 89,44,55 );
EXEC up_insertscore( '�����', 49,55,95 );
EXEC up_insertscore( '�赵��', 90,94,95 );
EXEC up_insertscore( '�̸���', 100,10,90 );


-- ����2) up_updateScore( 1, 100, 100, 100 ) ; ������Ʈ�ϴ� �������ν��� up_updateScore

--EXEC up_updateScore( 1, 100, 100, 100 );
--EXEC up_updateScore( 1, pkor =>34 );
--EXEC up_updateScore( 1, pkor =>34, pmat => 90 );
--EXEC up_updateScore( 1, peng =>45, pmat => 90 );


CREATE OR REPLACE PROCEDURE up_updateScore
(
    pnum tbl_score.num%TYPE
    ,pkor tbl_score.kor%TYPE := NULL
    ,peng tbl_score.eng%TYPE := NULL
    ,pmat tbl_score.mat%TYPE := NULL
)
IS
    vkor tbl_score.kor%TYPE;
    veng tbl_score.eng%TYPE;
    vmat tbl_score.mat%TYPE;
    
    vtot NUMBER(3) := 0;
    vavg NUMBER(5,2) ;
    vgrade tbl_score.grade%TYPE;

BEGIN
    SELECT kor, eng, mat INTO vkor,veng,vmat
    FROM tbl_score
    WHERE num = pnum;

    vtot := NVL(pkor, vkor) + NVL(peng, veng) + NVL(pmat, vmat);
    vavg := vtot / 3 ;
    
    IF vavg >= 90 THEN vgrade := 'A';
    ELSIF vavg >= 80 THEN vgrade := 'B';
    ELSIF vavg >= 70 THEN vgrade := 'C';
    ELSIF vavg >= 60 THEN vgrade := 'D';
    ELSE vgrade := 'F';
    END IF;
    
    
UPDATE tbl_score
SET kor = NVL(pkor, vkor)
    , eng = NVL(peng, veng)
    , mat = NVL(pmat, vmat)
    , tot =   vtot --NVL(pkor,kor) + NVL(peng,eng) + NVL(pmat,mat)
    , avg = vavg
    , grade = vgrade
    , rank = 1
WHERE num = pnum;

up_rankScore;
COMMIT;

END;

EXEC up_updateScore( 1, peng =>45, pmat => 90 ); -- �̰� �Ķ���Ͷ� peng���ߵ� eng�� �ƴ϶�..!
EXEC up_updateScore( 1, 100 , 100 );

SELECT *
FROM tbl_score;



ROLLBACK;


-- ����) tbl_score ���̺��� ��� �л��� ����� �ű�� ���ν��� ?!
-- up_rankScore

CREATE OR REPLACE up_rankScore

IS
    vavg NUMBER(5,2) ;
    
BEGIN
    SELECT avg INTO vavg
    FROM tbl_score;
    
    FOR num IN 1 .. MAX(num)
    LOOP
        IF 
    
    END LOOP;
    
    


END;




CREATE OR REPLACE PROCEDURE up_rankScore
IS
BEGIN
    UPDATE tbl_score p
    SET rank = ( SELECT COUNT(*)+1 FROM tbl_score c WHERE p.tot < c.tot  );
    COMMIT;
--EXCEPTION
END;

EXEC up_rankScore;


-- up_deleteScore  �л� 1�� �й� ���� ����

CREATE OR REPLACE PROCEDURE up_deleteScore
(
    pnum tbl_score.num%TYPE
)
IS
BEGIN
    
    DELETE
    FROM tbl_score
    WHERE num = pnum;
    up_rankScore;
    
    COMMIT;
END;

EXEC up_deleteScore(4);
SELECT *
FROM tbl_score;


-- up_selectScore ����л� ���� ��ȸ (Ŀ��)

CREATE OR REPLACE PROCEDURE up_selectScore
IS
BEGIN

FOR vsrow IN (SELECT * FROM tbl_score)
LOOP
    DBMS_OUTPUT.PUT_LINE ( vsrow.num ||', ' || vsrow.name|| ', ' || vsrow.kor ||', ' || vsrow.eng ||', ' || vsrow.mat ||', ' || vsrow.avg ||', ' || vsrow.rank ||', ' || vsrow.grade );
    
END LOOP;

END;

EXEC up_selectScore;



-- ����� .. 
CREATE OR REPLACE PROCEDURE up_selectScore
IS
    CURSOR vs_cur IS (SELECT * FROM tbl_score);

    vsrow tbl_score%ROWTYPE;

BEGIN
OPEN vs_cur;


LOOP
FETCH vs_cur INTO vsrow  ;
    EXIT WHEN vs_cur%NOTFOUND; -- ��ġ���� �̰� �;���
    DBMS_OUTPUT.PUT_LINE ( vsrow.num ||', ' || vsrow.name|| ', ' || vsrow.kor ||', ' || vsrow.eng ||', ' || vsrow.mat ||', ' || vsrow.avg ||', ' || vsrow.rank ||', ' || vsrow.grade );

END LOOP;

CLOSE vs_cur;

END;

EXEC up_selectScore;



CREATE OR REPLACE PROCEDURE up_selectScore
IS
  --1) Ŀ�� ����
  CURSOR vcursor IS (SELECT * FROM tbl_score);
  vrow tbl_score%ROWTYPE;
BEGIN
  --2) OPEN  Ŀ�� ���� ����..
  OPEN vcursor;
  --3) FETCH  Ŀ�� INTO 
  LOOP  
    FETCH vcursor INTO vrow;
    EXIT WHEN vcursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(  
           vrow.num || ', ' || vrow.name || ', ' || vrow.kor
           || vrow.eng || ', ' || vrow.mat || ', ' || vrow.tot
           || vrow.avg || ', ' || vrow.grade || ', ' || vrow.rank
        );
  END LOOP;
  --4) CLOSE
  CLOSE vcursor;
--EXCEPTION
  -- ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE up_selectinsa
(
    --Ŀ���� �Ķ���ͷ� ?
    pinsacursor SYS_REFCURSOR --����Ŭ 9i ������ REF CURSORS
    
)
IS
    vname insa.name%TYPE;
    vbasicpay insa.basicpay%TYPE;
    vcity insa.city%TYPE;
    
BEGIN
--���� �ʿ����
LOOP
    FETCH pinsacursor INTO vname, vcity, vbasicpay ;
    EXIT WHEN pinsacursor%NOTFOUND ;
    DBMS_OUTPUT.PUT_LINE(vname || ', ' || vcity || ', ' || vbasicpay);
END LOOP;

CLOSE pinsacursor;
--EXCEPTION
END;

CREATE OR REPLACE PROCEDURE up_insacursor_test
IS
    vinsacursor SYS_REFCURSOR;

BEGIN
    OPEN vinsacursor FOR SELECT name,city,basicpay FROM insa;
    up_selectinsa( vinsacursor );
END;

EXEC up_insacursor_test;

-- [ Ʈ���� ] --

CREATE TABLE tbl_exam1
(
   id NUMBER PRIMARY KEY
   , name VARCHAR2(20)
);

CREATE TABLE tbl_exam2
(
   memo VARCHAR2(100)
   , ilja DATE DEFAULT SYSDATE
);

-- TBL_exam1 ���̺� insert, update, delete �̺�Ʈ���� �߻��ϸ�
-- �ڵ����� tbl_exam2 ���̺� 1���� � �۾��� �Ͼ���� �α׷� ����ϴ� Ʈ����.
create or replace trigger ut_log
AFTER -- �α״ϱ� �� ���� ���� = ������
insert OR delete OR UPDATE ON tbl_exam1 --Ʈ���Ű� ���̺�1�� ���ǵǾ��� ������ :OLD.name �̷������� ��ȯ����
for each row -- �� �������ٸ��� --�̰� �־�� :OLD, :NEW ��� ����

--DECLARE
    -- ��������
BEGIN 
    IF INSERTING THEN
         INSERT INTO tbl_exam2 (memo) VALUES (:new.name || '�μ�Ʈ') ;   -- ���౸�� 
    ELSIF DELETING THEN
         INSERT INTO tbl_exam2 (memo) VALUES (:OLD.name || '����') ;
         ELSIF UPDATING THEN
         INSERT INTO tbl_exam2 (memo) VALUES (:OLD.name || '->' || :NEW.NAME || '����') ;
    END IF;
    
    
END;
--
UPDATE tbl_exam1
SET NAME = 'admin'
where id = 1;
--
select * FROM tbl_exam1;
select * FROM tbl_exam2;
insert into tbl_exam1 VALUES (1, 'hong');
insert into tbl_exam1 VALUES (2, 'kong');
--
delete from tbl_exam1
where id = 1;
rollback;
--
commit;

-- �Ʒ��� ���� ����
create or replace trigger ut_deletelog
AFTER
delete ON tbl_exam1
for each row 

BEGIN
    INSERT INTO tbl_exam2 (memo) VALUES (:OLD.name || '����.. �ϳ����𸣰ڴµ�') ;   -- ���౸��
END;

delete from tbl_exam1
where id = 1;

------- tbl_exam1 ��� ���̺�� DML���� �ٹ��ð�(9-17��) �� �Ǵ� �ָ����� ó�� �ȵǰ� Ʈ���� ����.
CREATE OR REPLACE TRIGGER UT_LOG_BEFORE
BEFORE
INSERT OR UPDATE OR DELETE ON tbl_exam1
--FOR EACH ROW
--DECLARE
    
BEGIN
    IF TO_CHAR(SYSDATE,'DY') IN ('��','��')
    OR TO_CHAR(SYSDATE,'HH24') < 9 
    OR TO_CHAR(SYSDATE,'HH24') > 16 THEN
    RAISE_APPLICATION_ERROR(-20001, '�ٹ��ð��� �ƴ�. DML ���� �� ���ÿ�');       -- ������ ���ܸ� �߻�
    END IF;
END;

INSERT INTO TBL_EXAM1 VALUES (2, 'PARK');
--
DROP TABLE TBL_DEPT;
DROP TABLE TBL_EMP;
DROP TABLE TBL_EXAM1;
DROP TABLE TBL_EXAM2;
DROP TABLE TBL_SCORE;
--
