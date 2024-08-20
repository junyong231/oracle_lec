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
   status VARCHAR2(3 CHAR), /* ���� ���� */
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

/* ȸ�� */
CREATE TABLE SCOTT.USERS (
   memid VARCHAR2(15 CHAR) NOT NULL, /* ȸ�� ID */
   pw VARCHAR2(20 CHAR), /* ��й�ȣ */
   nick VARCHAR2(15 CHAR) /* �г��� */
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













      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      