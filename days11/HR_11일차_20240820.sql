/* 응답 */
CREATE TABLE SCOTT.ANSWERS (
   SUL_NO NUMBER NOT NULL, /* 설문번호 */
   memid VARCHAR2(15 CHAR) NOT NULL, /* 회원 ID */
   ans NUMBER /* 답변 */
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

/* 작성자 */
CREATE TABLE SCOTT.TABLE2 (
   COL VARCHAR2(20) NOT NULL /* 작성자 ID */
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
      
    
/* 관리자 */
CREATE TABLE SCOTT.TABLE3 (
   COL <지정 되지 않음> NOT NULL /* 관리자 ID */
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
      
/* 설문상태 */
CREATE TABLE SCOTT.TABLE4 (
   COL8 <지정 되지 않음> NOT NULL /* 설문상태 */
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

/* 참여자 */
CREATE TABLE SCOTT.TABLE5 (
   COL <지정 되지 않음> NOT NULL /* 참여자 ID */
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
      
/* 설문 항목(내용) */
CREATE TABLE SCOTT.TABLE6 (
   COL <지정 되지 않음> /* 새 컬럼 */
);

/* 설문 결과 */
CREATE TABLE SCOTT.TABLE7 (
   COL8 <지정 되지 않음> NOT NULL, /* 설문상태 */
   COL <지정 되지 않음> /* 설문 결과 */
);

/* 설문 질문 */
CREATE TABLE SCOTT.SUL (
   SUL_NO NUMBER NOT NULL, /* 설문번호 */
   status VARCHAR2(3 CHAR), /* 설문 상태 */
   title VARCHAR2(50 CHAR), /* 설문 제목 */
   startd DATE, /* 시작일 */
   endd DATE, /* 종료일 */
   writed DATE, /* 작성일 */
   author VARCHAR2(10 CHAR) /* 작성자 */
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

/* 회원 */
CREATE TABLE SCOTT.TABLE9 (
   COL3 VARCHAR2(20) NOT NULL, /* 회원 ID */
   COL <지정 되지 않음> /* 권한 */
);
ALTER TABLE SCOTT.TABLE9
   ADD
      CONSTRAINT PK_TABLE9
      PRIMARY KEY (
         COL3
      );

/* 권한 */
CREATE TABLE SCOTT.TABLE10 (
   COL2 <지정 되지 않음> /* 새 컬럼 */
);

/* 항목 */
CREATE TABLE SCOTT.HANGMOK (
   SUL_NO NUMBER NOT NULL, /* 설문번호 */
   list VARCHAR2(100 CHAR), /* 질문 항목 */
   listnum NUMBER /* 질문 항목 번호 */
);

/* 회원 */
CREATE TABLE SCOTT.USERS (
   memid VARCHAR2(15 CHAR) NOT NULL, /* 회원 ID */
   pw VARCHAR2(20 CHAR), /* 비밀번호 */
   nick VARCHAR2(15 CHAR) /* 닉네임 */
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













      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      