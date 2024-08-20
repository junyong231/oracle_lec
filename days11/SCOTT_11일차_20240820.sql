-- ���̺� 25 ~30�� ���� (������Ʈ)



--�ϴ�� �� �ܷ�Ű
-- �ٴ�� �� ���̺�

-- ����~ ������ ���� ��ȭ�̸� �� ���� => �ߺ� ������ ���� (����ȭ)







/* ���� */
CREATE TABLE SCOTT.ANSWERS (
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   memid VARCHAR2(15 CHAR) NOT NULL, /* ȸ�� ID */
   ans NUMBER, /* �亯 */
   list VARCHAR2(100 CHAR) NOT NULL
);

COMMENT ON TABLE SCOTT.ANSWERS IS '����';

COMMENT ON COLUMN SCOTT.ANSWERS.SUL_NO IS '������ȣ';

COMMENT ON COLUMN SCOTT.ANSWERS.memid IS 'ȸ�� ID';

COMMENT ON COLUMN SCOTT.ANSWERS.ans IS '�亯';

CREATE UNIQUE INDEX SCOTT.PK_ANSWERS
   ON SCOTT.ANSWERS (
      SUL_NO ASC,
      memid ASC
   );

ALTER TABLE SCOTT.ANSWERS
   ADD
      CONSTRAINT PK_ANSWERS
      PRIMARY KEY (
         SUL_NO,
         memid
      );

/* �ۼ��� */
CREATE TABLE SCOTT.TABLE2 (
   COL VARCHAR2(20) NOT NULL /* �ۼ��� ID */
);

COMMENT ON TABLE SCOTT.TABLE2 IS '�ۼ���';

COMMENT ON COLUMN SCOTT.TABLE2.COL IS '�ۼ��� ID';

CREATE UNIQUE INDEX SCOTT.PK_TABLE2
   ON SCOTT.TABLE2 (
      COL ASC
   );

ALTER TABLE SCOTT.TABLE2
   ADD
      CONSTRAINT PK_TABLE2
      PRIMARY KEY (
         COL
      );

/* ������ */
CREATE TABLE SCOTT.TABLE3 (
   COL <���� ���� ����> NOT NULL /* ������ ID */
);

COMMENT ON TABLE SCOTT.TABLE3 IS '������';

COMMENT ON COLUMN SCOTT.TABLE3.COL IS '������ ID';

CREATE UNIQUE INDEX SCOTT.PK_TABLE3
   ON SCOTT.TABLE3 (
      COL ASC
   );

ALTER TABLE SCOTT.TABLE3
   ADD
      CONSTRAINT PK_TABLE3
      PRIMARY KEY (
         COL
      );

/* �������� */
CREATE TABLE SCOTT.TABLE4 (
   COL8 <���� ���� ����> NOT NULL /* �������� */
);

COMMENT ON TABLE SCOTT.TABLE4 IS '��������';

COMMENT ON COLUMN SCOTT.TABLE4.COL8 IS '��������';

CREATE UNIQUE INDEX SCOTT.PK_TABLE4
   ON SCOTT.TABLE4 (
      COL8 ASC
   );

ALTER TABLE SCOTT.TABLE4
   ADD
      CONSTRAINT PK_TABLE4
      PRIMARY KEY (
         COL8
      );

/* ������ */
CREATE TABLE SCOTT.TABLE5 (
   COL <���� ���� ����> NOT NULL /* ������ ID */
);

COMMENT ON TABLE SCOTT.TABLE5 IS '������';

COMMENT ON COLUMN SCOTT.TABLE5.COL IS '������ ID';

CREATE UNIQUE INDEX SCOTT.PK_TABLE5
   ON SCOTT.TABLE5 (
      COL ASC
   );

ALTER TABLE SCOTT.TABLE5
   ADD
      CONSTRAINT PK_TABLE5
      PRIMARY KEY (
         COL
      );

/* ���� �׸�(����) */
CREATE TABLE SCOTT.TABLE6 (
   COL <���� ���� ����> /* �� �÷� */
);

COMMENT ON TABLE SCOTT.TABLE6 IS '���� �׸�(����)';

COMMENT ON COLUMN SCOTT.TABLE6.COL IS '�� �÷�';

/* ���� ��� */
CREATE TABLE SCOTT.TABLE7 (
   COL8 <���� ���� ����> NOT NULL, /* �������� */
   COL <���� ���� ����> /* ���� ��� */
);

COMMENT ON TABLE SCOTT.TABLE7 IS '���� ���';

COMMENT ON COLUMN SCOTT.TABLE7.COL8 IS '��������';

COMMENT ON COLUMN SCOTT.TABLE7.COL IS '���� ���';

/* ���� ���� */
CREATE TABLE SCOTT.SUL (
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   status VARCHAR2(3 CHAR), /* ���� ���� */
   title VARCHAR2(50 CHAR), /* ���� ���� */
   startd DATE, /* ������ */
   endd DATE, /* ������ */
   writed DATE, /* �ۼ��� */
   author VARCHAR2(10 CHAR) /* �ۼ��� */
);

COMMENT ON TABLE SCOTT.SUL IS '���� ����';

COMMENT ON COLUMN SCOTT.SUL.SUL_NO IS '������ȣ';

COMMENT ON COLUMN SCOTT.SUL.status IS '���� ����';

COMMENT ON COLUMN SCOTT.SUL.title IS '���� ����';

COMMENT ON COLUMN SCOTT.SUL.startd IS '������';

COMMENT ON COLUMN SCOTT.SUL.endd IS '������';

COMMENT ON COLUMN SCOTT.SUL.writed IS '�ۼ���';

COMMENT ON COLUMN SCOTT.SUL.author IS '�ۼ���';

CREATE UNIQUE INDEX SCOTT.PK_SUL
   ON SCOTT.SUL (
      SUL_NO ASC
   );

ALTER TABLE SCOTT.SUL
   ADD
      CONSTRAINT PK_SUL
      PRIMARY KEY (
         SUL_NO
      );

/* ȸ�� */
CREATE TABLE SCOTT.TABLE9 (
   COL3 VARCHAR2(20) NOT NULL, /* ȸ�� ID */
   COL <���� ���� ����> /* ���� */
);

COMMENT ON TABLE SCOTT.TABLE9 IS 'ȸ��';

COMMENT ON COLUMN SCOTT.TABLE9.COL3 IS 'ȸ�� ID';

COMMENT ON COLUMN SCOTT.TABLE9.COL IS '����';

CREATE UNIQUE INDEX SCOTT.PK_TABLE9
   ON SCOTT.TABLE9 (
      COL3 ASC
   );

ALTER TABLE SCOTT.TABLE9
   ADD
      CONSTRAINT PK_TABLE9
      PRIMARY KEY (
         COL3
      );

/* ���� */
CREATE TABLE SCOTT.TABLE10 (
   COL2 <���� ���� ����> /* �� �÷� */
);

COMMENT ON TABLE SCOTT.TABLE10 IS '����';

COMMENT ON COLUMN SCOTT.TABLE10.COL2 IS '�� �÷�';

/* �׸� */
CREATE TABLE SCOTT.HANGMOK (
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   list VARCHAR2(100 CHAR), /* ���� �׸� */
   listnum NUMBER /* ���� �׸� ��ȣ */
);

COMMENT ON TABLE SCOTT.HANGMOK IS '�׸�';

COMMENT ON COLUMN SCOTT.HANGMOK.SUL_NO IS '������ȣ';

COMMENT ON COLUMN SCOTT.HANGMOK.list IS '���� �׸�';

COMMENT ON COLUMN SCOTT.HANGMOK.listnum IS '���� �׸� ��ȣ';

--CREATE UNIQUE INDEX SCOTT.PK_HANGMOK
--   ON SCOTT.HANGMOK (
--      SUL_NO ASC
--   );

--ALTER TABLE SCOTT.HANGMOK
--   ADD
--      CONSTRAINT PK_HANGMOK
--      PRIMARY KEY (
--         SUL_NO
--      );

/* ȸ�� */
CREATE TABLE SCOTT.USERS (
   memid VARCHAR2(15 CHAR) NOT NULL, /* ȸ�� ID */
   pw VARCHAR2(20 CHAR), /* ��й�ȣ */
   nick VARCHAR2(15 CHAR) /* �г��� */
);

COMMENT ON TABLE SCOTT.USERS IS 'ȸ��';

COMMENT ON COLUMN SCOTT.USERS.memid IS 'ȸ�� ID';

COMMENT ON COLUMN SCOTT.USERS.pw IS '��й�ȣ';

COMMENT ON COLUMN SCOTT.USERS.nick IS '�г���';

CREATE UNIQUE INDEX SCOTT.PK_USERS
   ON SCOTT.USERS (
      memid ASC
   );

ALTER TABLE SCOTT.USERS
   ADD
      CONSTRAINT PK_USERS
      PRIMARY KEY (
         memid
      );

ALTER TABLE SCOTT.ANSWERS
   ADD
      CONSTRAINT FK_SUL_TO_ANSWERS
      FOREIGN KEY (
         SUL_NO
      )
      REFERENCES SCOTT.SUL (
         SUL_NO
      );

ALTER TABLE SCOTT.ANSWERS
   ADD
      CONSTRAINT FK_USERS_TO_ANSWERS
      FOREIGN KEY (
         memid
      )
      REFERENCES SCOTT.USERS (
         memid
      );

ALTER TABLE SCOTT.TABLE7
   ADD
      CONSTRAINT FK_TABLE4_TO_TABLE7
      FOREIGN KEY (
         COL8
      )
      REFERENCES SCOTT.TABLE4 (
         COL8
      );

ALTER TABLE SCOTT.TABLE9
   ADD
      CONSTRAINT FK_TABLE2_TO_TABLE9
      FOREIGN KEY (
         COL3
      )
      REFERENCES SCOTT.TABLE2 (
         COL
      );

ALTER TABLE SCOTT.HANGMOK
   ADD
      CONSTRAINT FK_SUL_TO_HANGMOK
      FOREIGN KEY (
         SUL_NO
      )
      REFERENCES SCOTT.SUL (
         SUL_NO
      );







    INSERT INTO sul VALUES (1,'������', '����', sysdate, sysdate, sysdate, 'JYP' );
    INSERT INTO sul VALUES (2,'������', '����2', sysdate, sysdate, sysdate, 'JYP' );
    INSERT INTO sul VALUES (3,'������', '����3',TO_DATE('2024-08-22', 'yyyy-mm-dd'), TO_DATE('2024-08-30', 'yyyy-mm-dd'), sysdate, 'JYP' );
    
     INSERT INTO users VALUES ('snail', '123a' , '������' ); 
     INSERT INTO users VALUES ('snail2', '1243a' , '������2' ); 
     INSERT INTO users VALUES ('snail3', '12333a' , '������3' ); 
     INSERT INTO users VALUES ('snail4', '12333a' , '������4' ); 
     INSERT INTO users VALUES ('snail5', '12333a' , '������5' ); 
     INSERT INTO users VALUES ('snail6', '12333a' , '������6' ); 
     INSERT INTO users VALUES ('snail7', '12333a' , '������7' ); 
     
    
    INSERT INTO answers VALUES (2,'snail3', 2 , ' ' );
    INSERT INTO answers VALUES (1,'snail2',1 , ' ');
    INSERT INTO answers VALUES (1,'snail3', 2, ' ' );
    INSERT INTO answers VALUES (1,'snail4', 2, ' ' );
    INSERT INTO answers VALUES (1,'snail', 2 , ' ' );
    
    INSERT INTO answers VALUES (2,'snail', 2, ' ' );
    INSERT INTO answers VALUES (2,'snail2',1, ' ' );
    
       INSERT INTO answers VALUES (2,'snail5',1, ' ' );
      INSERT INTO answers VALUES (2,'snail6',1, ' ' );
         INSERT INTO answers VALUES (2,'snail7',1, ' ' );
    
    UPDATE sul
    SET startd = TO_DATE('2024-08-01', 'yyyy-mm-dd')
        , endd = TO_DATE('2024-08-19', 'yyyy-mm-dd')
    WHERE sul_no = 1;
    
    UPDATE sul
    SET startd = sysdate
        , endd = sysdate +0.1
    WHERE sul_no = 2;
    
    SELECT *
    FROM users;
    
    SELECT *
    FROM answers
    ORDER BY sul_no;
    
    
    SELECT *
    FROM sul;
    
    ROLLBACK;
    
    
    
    INSERT INTO hangmok VALUES(1, 'aa', 1 );
    INSERT INTO hangmok VALUES(1, 'bb', 2 );
    INSERT INTO hangmok VALUES(2, 'cc', 1 );
    INSERT INTO hangmok VALUES(2, 'dd', 2 );
    INSERT INTO hangmok VALUES(3, '����', 1 );
    INSERT INTO hangmok VALUES(2, '����', 6 );
    INSERT INTO hangmok VALUES(3, '����', 3 );
     INSERT INTO hangmok VALUES(3, '����', 3 );
    
    UPDATE hangmok 
    SET ;
    
    SELECT *
    FROM hangmok;
    
    --1 2 / 1 1 ���;ߵ�

    SELECT  e.���� ,  lpad ( ' ' , e.����+1, '*')  �׷���,  ROUND( CAST(e.���� AS FLOAT) / SUM(CAST(e.���� AS FLOAT)) OVER (), 2 ) * 100 || '%'
    FROM (
    SELECT  COUNT(a.ans) "����"
    FROM answers a 
    WHERE a.sul_no = 2 --�̰͸� ������ �� ������ ? (ex. 2�� ���� �󼼺��� Ŭ���� ���Ⱑ 2�� �ǰ�)
    GROUP BY a.ans
    ORDER BY a.sul_no
    ) e
    GROUP BY e.����;

    
    
    SELECT a COUNT(a.ans) "����"
    FROM answers a 
    WHERE a.sul_no = 2
    GROUP BY a.ans
    ORDER BY a.sul_no;
    
    
    
    
    SELECT h.sul_no, h.list, COUNT(a.ans) "�׸� ��ǥ��"
    FROM answers a right JOIN hangmok h ON a.sul_no = h.sul_no
    WHERE h.sul_no = 1
    GROUP BY h.sul_no, h.list
    ORDER BY h.sul_no;
    
    
    SELECT *
    FROM answers a JOIN hangmok h ON a.sul_no = h.sul_no;

    SELECT *
    FROM answers;
    

    SELECT s.sul_no ������ȣ , s.title ����, s.author �ۼ���, s.startd ������, s.endd ������
            , (SELECT COUNT(listnum) FROM hangmok WHERE s.sul_no =sul_no) �׸��
            , (SELECT COUNT(memid) FROM answers WHERE s.sul_no =sul_no) �����ڼ�
            , CASE WHEN endd < sysdate THEN '����' WHEN startd > sysdate THEN '�����' ELSE '������' END ����
    FROM hangmok h JOIN sul s ON h.sul_no = s.sul_no
    GROUP BY s.sul_no , s.title, s.author, s.startd, s.endd
    ORDER BY ���� DESC;
    -- ���� ��� ����: ����ð�(sysdate)�� CASE������ ������ �ð��� ���� ���� ���� ���..


    DROP TABLE table2 CASCADE CONSTRAINTS; 
    DROP TABLE answers CASCADE CONSTRAINTS; 
    DROP TABLE users CASCADE CONSTRAINTS; 
    DROP TABLE sul CASCADE CONSTRAINTS; 
    DROP TABLE hangmok CASCADE CONSTRAINTS; 



-- ���� ���� ���̺�
CREATE TABLE SUL (
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   title VARCHAR2(50 CHAR), /* ���� ���� */
   startd DATE, /* ������ */
   endd DATE, /* ������ */
   writed DATE, /* �ۼ��� */
   author VARCHAR2(10 CHAR), /* �ۼ��� */
   
   CONSTRAINT PK_SUL PRIMARY KEY (SUL_NO)
);

-- ȸ�� ���̺�
CREATE TABLE USERS (
   memid VARCHAR2(15 CHAR) NOT NULL, /* ȸ�� ID */
   pw VARCHAR2(20 CHAR), /* ��й�ȣ */
   nick VARCHAR2(15 CHAR), /* �г��� */
   
   CONSTRAINT PK_USERS PRIMARY KEY (memid)
);

-- ���� �亯 ���̺�
CREATE TABLE ANSWERS (
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   memid VARCHAR2(15 CHAR) NOT NULL, /* ȸ�� ID */
   ans NUMBER, /* �亯 */
   list VARCHAR2(100 CHAR) NOT NULL
   
   CONSTRAINT FK_SUL_TO_ANSWERS FOREIGN KEY (SUL_NO) REFERENCES SUL(SUL_NO),
   CONSTRAINT FK_USERS_TO_ANSWERS FOREIGN KEY (memid) REFERENCES USERS(memid),
   CONSTRAINT PK_ANSWERS PRIMARY KEY (SUL_NO, memid),
);

-- ���� �׸� ���̺�
CREATE TABLE SCOTT.HANGMOK (
   list VARCHAR2(100 CHAR) NOT NULL, /* ���� �׸� */
   listnum NUMBER NOT NULL, /* ���� �׸� ��ȣ */
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   
   CONSTRAINT FK_SUL_TO_HANGMOK FOREIGN KEY (SUL_NO) REFERENCES SUL(SUL_NO)
);





















    DROP TABLE table2 CASCADE CONSTRAINTS; 
    DROP TABLE answers CASCADE CONSTRAINTS; 
    DROP TABLE users CASCADE CONSTRAINTS; 
    DROP TABLE sul CASCADE CONSTRAINTS; 
    DROP TABLE hangmok CASCADE CONSTRAINTS; 

--���̺� ����

/* ���� */
CREATE TABLE SCOTT.ANSWERS (
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   memid VARCHAR2(15 CHAR) NOT NULL, /* ȸ�� ID */
   ans NUMBER /* �亯 */
);

CREATE UNIQUE INDEX SCOTT.PK_ANSWERS
   ON SCOTT.ANSWERS (
      SUL_NO ASC,
      memid ASC
   );

ALTER TABLE SCOTT.ANSWERS
   ADD
      CONSTRAINT PK_ANSWERS
      PRIMARY KEY (
         SUL_NO,
         memid
      );

/* �ۼ��� */
CREATE TABLE SCOTT.TABLE2 (
   COL VARCHAR2(20) NOT NULL /* �ۼ��� ID */
);


CREATE UNIQUE INDEX SCOTT.PK_TABLE2
   ON SCOTT.TABLE2 (
      COL ASC
   );

ALTER TABLE SCOTT.TABLE2
   ADD
      CONSTRAINT PK_TABLE2
      PRIMARY KEY (
         COL
      );

/* ������ */
CREATE TABLE SCOTT.TABLE3 (
   COL <���� ���� ����> NOT NULL /* ������ ID */
);

CREATE UNIQUE INDEX SCOTT.PK_TABLE3
   ON SCOTT.TABLE3 (
      COL ASC
   );

ALTER TABLE SCOTT.TABLE3
   ADD
      CONSTRAINT PK_TABLE3
      PRIMARY KEY (
         COL
      );

/* �������� */
CREATE TABLE SCOTT.TABLE4 (
   COL8 <���� ���� ����> NOT NULL /* �������� */
);

CREATE UNIQUE INDEX SCOTT.PK_TABLE4
   ON SCOTT.TABLE4 (
      COL8 ASC
   );

ALTER TABLE SCOTT.TABLE4
   ADD
      CONSTRAINT PK_TABLE4
      PRIMARY KEY (
         COL8
      );

/* ������ */
CREATE TABLE SCOTT.TABLE5 (
   COL <���� ���� ����> NOT NULL /* ������ ID */
);

CREATE UNIQUE INDEX SCOTT.PK_TABLE5
   ON SCOTT.TABLE5 (
      COL ASC
   );

ALTER TABLE SCOTT.TABLE5
   ADD
      CONSTRAINT PK_TABLE5
      PRIMARY KEY (
         COL
      );

/* ���� �׸�(����) */
CREATE TABLE SCOTT.TABLE6 (
   COL <���� ���� ����> /* �� �÷� */
);

/* ���� ��� */
CREATE TABLE SCOTT.TABLE7 (
   COL8 <���� ���� ����> NOT NULL, /* �������� */
   COL <���� ���� ����> /* ���� ��� */
);

/* ���� ���� */
CREATE TABLE SCOTT.SUL (
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   title VARCHAR2(50 CHAR), /* ���� ���� */
   startd DATE, /* ������ */
   endd DATE, /* ������ */
   writed DATE, /* �ۼ��� */
   author VARCHAR2(10 CHAR) /* �ۼ��� */
);

CREATE UNIQUE INDEX SCOTT.PK_SUL
   ON SCOTT.SUL (
      SUL_NO ASC
   );

ALTER TABLE SCOTT.SUL
   ADD
      CONSTRAINT PK_SUL
      PRIMARY KEY (
         SUL_NO
      );

/* ȸ�� */
CREATE TABLE SCOTT.TABLE9 (
   COL3 VARCHAR2(20) NOT NULL, /* ȸ�� ID */
   COL <���� ���� ����> /* ���� */
);

CREATE UNIQUE INDEX SCOTT.PK_TABLE9
   ON SCOTT.TABLE9 (
      COL3 ASC
   );

ALTER TABLE SCOTT.TABLE9
   ADD
      CONSTRAINT PK_TABLE9
      PRIMARY KEY (
         COL3
      );

/* ���� */
CREATE TABLE SCOTT.TABLE10 (
   COL2 <���� ���� ����> /* �� �÷� */
);


/* �׸� */
CREATE TABLE SCOTT.HANGMOK (
   SUL_NO NUMBER NOT NULL, /* ������ȣ */
   list VARCHAR2(100 CHAR), /* ���� �׸� */
   listnum NUMBER /* ���� �׸� ��ȣ */
);


--CREATE UNIQUE INDEX SCOTT.PK_HANGMOK
--   ON SCOTT.HANGMOK (
--      SUL_NO ASC
--   );

--ALTER TABLE SCOTT.HANGMOK
--   ADD
--      CONSTRAINT PK_HANGMOK
--      PRIMARY KEY (
--         SUL_NO
--      );

/* ȸ�� */
CREATE TABLE SCOTT.USERS (
   memid VARCHAR2(15 CHAR) NOT NULL, /* ȸ�� ID */
   pw VARCHAR2(20 CHAR), /* ��й�ȣ */
   nick VARCHAR2(15 CHAR) /* �г��� */
);


CREATE UNIQUE INDEX SCOTT.PK_USERS
   ON SCOTT.USERS (
      memid ASC
   );

ALTER TABLE SCOTT.USERS
   ADD
      CONSTRAINT PK_USERS
      PRIMARY KEY (
         memid
      );

ALTER TABLE SCOTT.ANSWERS
   ADD
      CONSTRAINT FK_SUL_TO_ANSWERS
      FOREIGN KEY (
         SUL_NO
      )
      REFERENCES SCOTT.SUL (
         SUL_NO
      );

ALTER TABLE SCOTT.ANSWERS
   ADD
      CONSTRAINT FK_USERS_TO_ANSWERS
      FOREIGN KEY (
         memid
      )
      REFERENCES SCOTT.USERS (
         memid
      );

ALTER TABLE SCOTT.TABLE7
   ADD
      CONSTRAINT FK_TABLE4_TO_TABLE7
      FOREIGN KEY (
         COL8
      )
      REFERENCES SCOTT.TABLE4 (
         COL8
      );

ALTER TABLE SCOTT.TABLE9
   ADD
      CONSTRAINT FK_TABLE2_TO_TABLE9
      FOREIGN KEY (
         COL3
      )
      REFERENCES SCOTT.TABLE2 (
         COL
      );

ALTER TABLE SCOTT.HANGMOK
   ADD
      CONSTRAINT FK_SUL_TO_HANGMOK
      FOREIGN KEY (
         SUL_NO
      )
      REFERENCES SCOTT.SUL (
         SUL_NO
      );

--Ȯ��

SELECT *
FROM sul;


SELECT *
FROM hangmok;


SELECT *
FROM answers;


SELECT *
FROM users;


-- SUL(��������) �߰� �� �ð��� ������Ʈ
INSERT INTO sul VALUES (1, '����1', sysdate, sysdate, sysdate, 'JYP' );
INSERT INTO sul VALUES (2, '����2', sysdate, sysdate, sysdate, 'JYP' );
INSERT INTO sul VALUES (3, '����3', TO_DATE('2024-08-22', 'yyyy-mm-dd'), TO_DATE('2024-08-30', 'yyyy-mm-dd'), TO_DATE('2016-05-30', 'yyyy-mm-dd'), 'JYP' );
INSERT INTO sul VALUES (4, '����4', TO_DATE('2006-08-24', 'yyyy-mm-dd'), TO_DATE('2006-09-28', 'yyyy-mm-dd'), TO_DATE('2006-01-10', 'yyyy-mm-dd'), 'JYP' );

UPDATE sul
SET startd = TO_DATE('2024-08-01', 'yyyy-mm-dd')
, endd = TO_DATE('2024-08-19', 'yyyy-mm-dd')
WHERE sul_no = 1;

UPDATE sul
SET startd = sysdate
, endd = sysdate +0.1
WHERE sul_no = 2;
    
    
 --���� �߰�   
    
 INSERT INTO users VALUES ('snail', '123a' , '������' ); 
 INSERT INTO users VALUES ('snail2', '1243a' , '������2' ); 
 INSERT INTO users VALUES ('snail3', '12333a' , '������3' ); 
 INSERT INTO users VALUES ('snail4', '12333a' , '������4' ); 
 INSERT INTO users VALUES ('snail5', '12333a' , '������5' ); 
 INSERT INTO users VALUES ('snail6', '12333a' , '������6' ); 
 INSERT INTO users VALUES ('snail7', '12333a' , '������7' ); 
     
    
 --�׸� �߰�
INSERT INTO hangmok VALUES(1, '1������', 1 );
INSERT INTO hangmok VALUES(1, '2������', 2 );

INSERT INTO hangmok VALUES(2, '1������', 1 );
INSERT INTO hangmok VALUES(2, '2������', 2 );
INSERT INTO hangmok VALUES(2, '3������', 3 );

INSERT INTO hangmok VALUES(3, '1������', 1 );
INSERT INTO hangmok VALUES(3, '2������', 2 );
INSERT INTO hangmok VALUES(3, '3������', 3 );
    
INSERT INTO hangmok VALUES(4, '1������', 1 );    
INSERT INTO hangmok VALUES(4, '2������', 2 );       
       
-- ���� ���� (�亯 �߰�)   
    
INSERT INTO answers VALUES (2,'snail3', 2 );
INSERT INTO answers VALUES (1,'snail2',1 );
INSERT INTO answers VALUES (1,'snail3', 2 );
INSERT INTO answers VALUES (1,'snail4', 2 );
INSERT INTO answers VALUES (1,'snail', 2  );
INSERT INTO answers VALUES (2,'snail', 2 );
INSERT INTO answers VALUES (2,'snail2',1 );
INSERT INTO answers VALUES (2,'snail5',1 );
INSERT INTO answers VALUES (2,'snail6',1 );
INSERT INTO answers VALUES (2,'snail7',1 );
INSERT INTO answers VALUES (3,'snail7',1 );
    
--���� ��� Ȯ��
SELECT s.sul_no ������ȣ , s.title ����, s.author �ۼ���, s.startd ������, s.endd ������
        , (SELECT COUNT(listnum) FROM hangmok WHERE s.sul_no =sul_no) �׸��
        , (SELECT COUNT(memid) FROM answers WHERE s.sul_no =sul_no) �����ڼ�
        , CASE WHEN endd < sysdate THEN '����' WHEN startd > sysdate THEN '�����' ELSE '������' END ����
FROM hangmok h JOIN sul s ON h.sul_no = s.sul_no
GROUP BY s.sul_no , s.title, s.author, s.startd, s.endd
ORDER BY ���� DESC;
-- ���� ��� ����: ����ð�(sysdate)�� CASE������ ������ �ð��� ���� ���� ���� ���..
    

--�ϴ� �׷���

    SELECT  e.���� ,  lpad ( ' ' , e.����+1, '*')  �׷���,  ROUND( CAST(e.���� AS FLOAT) / SUM(CAST(e.���� AS FLOAT)) OVER (), 2 ) * 100 || '%'
    FROM (
    SELECT  COUNT(a.ans) "����"
    FROM answers a 
    WHERE a.sul_no = 3 --�̰͸� ������ �� ������ ? (ex. 2�� ���� �󼼺��� Ŭ���� ���Ⱑ 2�� �ǰ�)
    GROUP BY a.ans
    ORDER BY a.sul_no
    ) e
    GROUP BY e.����;
-- ������: 0�� �� �������� �ȳ���...

