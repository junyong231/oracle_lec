-- 테이블 25 ~30개 정도 (프로젝트)



--일대다 ㅣ 외래키
-- 다대다 ㅣ 테이블

-- 제목~ 개봉일 같은 영화이면 다 같음 => 중복 데이터 제거 (정규화)







/* 응답 */
CREATE TABLE SCOTT.ANSWERS (
   SUL_NO NUMBER NOT NULL, /* 설문번호 */
   memid VARCHAR2(15 CHAR) NOT NULL, /* 회원 ID */
   ans NUMBER, /* 답변 */
   list VARCHAR2(100 CHAR) NOT NULL
);

COMMENT ON TABLE SCOTT.ANSWERS IS '응답';

COMMENT ON COLUMN SCOTT.ANSWERS.SUL_NO IS '설문번호';

COMMENT ON COLUMN SCOTT.ANSWERS.memid IS '회원 ID';

COMMENT ON COLUMN SCOTT.ANSWERS.ans IS '답변';

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

COMMENT ON TABLE SCOTT.TABLE2 IS '작성자';

COMMENT ON COLUMN SCOTT.TABLE2.COL IS '작성자 ID';

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

COMMENT ON TABLE SCOTT.TABLE3 IS '관리자';

COMMENT ON COLUMN SCOTT.TABLE3.COL IS '관리자 ID';

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

COMMENT ON TABLE SCOTT.TABLE4 IS '설문상태';

COMMENT ON COLUMN SCOTT.TABLE4.COL8 IS '설문상태';

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

COMMENT ON TABLE SCOTT.TABLE5 IS '참여자';

COMMENT ON COLUMN SCOTT.TABLE5.COL IS '참여자 ID';

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

COMMENT ON TABLE SCOTT.TABLE6 IS '설문 항목(내용)';

COMMENT ON COLUMN SCOTT.TABLE6.COL IS '새 컬럼';

/* 설문 결과 */
CREATE TABLE SCOTT.TABLE7 (
   COL8 <지정 되지 않음> NOT NULL, /* 설문상태 */
   COL <지정 되지 않음> /* 설문 결과 */
);

COMMENT ON TABLE SCOTT.TABLE7 IS '설문 결과';

COMMENT ON COLUMN SCOTT.TABLE7.COL8 IS '설문상태';

COMMENT ON COLUMN SCOTT.TABLE7.COL IS '설문 결과';

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

COMMENT ON TABLE SCOTT.SUL IS '설문 질문';

COMMENT ON COLUMN SCOTT.SUL.SUL_NO IS '설문번호';

COMMENT ON COLUMN SCOTT.SUL.status IS '설문 상태';

COMMENT ON COLUMN SCOTT.SUL.title IS '설문 제목';

COMMENT ON COLUMN SCOTT.SUL.startd IS '시작일';

COMMENT ON COLUMN SCOTT.SUL.endd IS '종료일';

COMMENT ON COLUMN SCOTT.SUL.writed IS '작성일';

COMMENT ON COLUMN SCOTT.SUL.author IS '작성자';

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

COMMENT ON TABLE SCOTT.TABLE9 IS '회원';

COMMENT ON COLUMN SCOTT.TABLE9.COL3 IS '회원 ID';

COMMENT ON COLUMN SCOTT.TABLE9.COL IS '권한';

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

/* 권한 */
CREATE TABLE SCOTT.TABLE10 (
   COL2 <지정 되지 않음> /* 새 컬럼 */
);

COMMENT ON TABLE SCOTT.TABLE10 IS '권한';

COMMENT ON COLUMN SCOTT.TABLE10.COL2 IS '새 컬럼';

/* 항목 */
CREATE TABLE SCOTT.HANGMOK (
   SUL_NO NUMBER NOT NULL, /* 설문번호 */
   list VARCHAR2(100 CHAR), /* 질문 항목 */
   listnum NUMBER /* 질문 항목 번호 */
);

COMMENT ON TABLE SCOTT.HANGMOK IS '항목';

COMMENT ON COLUMN SCOTT.HANGMOK.SUL_NO IS '설문번호';

COMMENT ON COLUMN SCOTT.HANGMOK.list IS '질문 항목';

COMMENT ON COLUMN SCOTT.HANGMOK.listnum IS '질문 항목 번호';

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

/* 회원 */
CREATE TABLE SCOTT.USERS (
   memid VARCHAR2(15 CHAR) NOT NULL, /* 회원 ID */
   pw VARCHAR2(20 CHAR), /* 비밀번호 */
   nick VARCHAR2(15 CHAR) /* 닉네임 */
);

COMMENT ON TABLE SCOTT.USERS IS '회원';

COMMENT ON COLUMN SCOTT.USERS.memid IS '회원 ID';

COMMENT ON COLUMN SCOTT.USERS.pw IS '비밀번호';

COMMENT ON COLUMN SCOTT.USERS.nick IS '닉네임';

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







    INSERT INTO sul VALUES (1,'진행중', '제목', sysdate, sysdate, sysdate, 'JYP' );
    INSERT INTO sul VALUES (2,'진행중', '제목2', sysdate, sysdate, sysdate, 'JYP' );
    INSERT INTO sul VALUES (3,'진행중', '제목3',TO_DATE('2024-08-22', 'yyyy-mm-dd'), TO_DATE('2024-08-30', 'yyyy-mm-dd'), sysdate, 'JYP' );
    
     INSERT INTO users VALUES ('snail', '123a' , '달팽이' ); 
     INSERT INTO users VALUES ('snail2', '1243a' , '달팽이2' ); 
     INSERT INTO users VALUES ('snail3', '12333a' , '달팽이3' ); 
     INSERT INTO users VALUES ('snail4', '12333a' , '달팽이4' ); 
     INSERT INTO users VALUES ('snail5', '12333a' , '달팽이5' ); 
     INSERT INTO users VALUES ('snail6', '12333a' , '달팽이6' ); 
     INSERT INTO users VALUES ('snail7', '12333a' , '달팽이7' ); 
     
    
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
    INSERT INTO hangmok VALUES(3, 'ㄱㄱ', 1 );
    INSERT INTO hangmok VALUES(2, 'ㄴㄴ', 6 );
    INSERT INTO hangmok VALUES(3, 'ㄷㄷ', 3 );
     INSERT INTO hangmok VALUES(3, 'ㄷㄷ', 3 );
    
    UPDATE hangmok 
    SET ;
    
    SELECT *
    FROM hangmok;
    
    --1 2 / 1 1 나와야됨

    SELECT  e.고른수 ,  lpad ( ' ' , e.고른수+1, '*')  그래프,  ROUND( CAST(e.고른수 AS FLOAT) / SUM(CAST(e.고른수 AS FLOAT)) OVER (), 2 ) * 100 || '%'
    FROM (
    SELECT  COUNT(a.ans) "고른수"
    FROM answers a 
    WHERE a.sul_no = 2 --이것만 선택할 수 있으면 ? (ex. 2번 설문 상세보기 클릭시 여기가 2로 되게)
    GROUP BY a.ans
    ORDER BY a.sul_no
    ) e
    GROUP BY e.고른수;

    
    
    SELECT a COUNT(a.ans) "고른수"
    FROM answers a 
    WHERE a.sul_no = 2
    GROUP BY a.ans
    ORDER BY a.sul_no;
    
    
    
    
    SELECT h.sul_no, h.list, COUNT(a.ans) "항목별 투표수"
    FROM answers a right JOIN hangmok h ON a.sul_no = h.sul_no
    WHERE h.sul_no = 1
    GROUP BY h.sul_no, h.list
    ORDER BY h.sul_no;
    
    
    SELECT *
    FROM answers a JOIN hangmok h ON a.sul_no = h.sul_no;

    SELECT *
    FROM answers;
    

    SELECT s.sul_no 설문번호 , s.title 제목, s.author 작성자, s.startd 시작일, s.endd 종료일
            , (SELECT COUNT(listnum) FROM hangmok WHERE s.sul_no =sul_no) 항목수
            , (SELECT COUNT(memid) FROM answers WHERE s.sul_no =sul_no) 응답자수
            , CASE WHEN endd < sysdate THEN '종료' WHEN startd > sysdate THEN '대기중' ELSE '진행중' END 상태
    FROM hangmok h JOIN sul s ON h.sul_no = s.sul_no
    GROUP BY s.sul_no , s.title, s.author, s.startd, s.endd
    ORDER BY 상태 DESC;
    -- 설문 목록 쿼리: 현재시간(sysdate)를 CASE문으로 나눠서 시간에 따라서 설문 상태 출력..


    DROP TABLE table2 CASCADE CONSTRAINTS; 
    DROP TABLE answers CASCADE CONSTRAINTS; 
    DROP TABLE users CASCADE CONSTRAINTS; 
    DROP TABLE sul CASCADE CONSTRAINTS; 
    DROP TABLE hangmok CASCADE CONSTRAINTS; 



-- 설문 질문 테이블
CREATE TABLE SUL (
   SUL_NO NUMBER NOT NULL, /* 설문번호 */
   title VARCHAR2(50 CHAR), /* 설문 제목 */
   startd DATE, /* 시작일 */
   endd DATE, /* 종료일 */
   writed DATE, /* 작성일 */
   author VARCHAR2(10 CHAR), /* 작성자 */
   
   CONSTRAINT PK_SUL PRIMARY KEY (SUL_NO)
);

-- 회원 테이블
CREATE TABLE USERS (
   memid VARCHAR2(15 CHAR) NOT NULL, /* 회원 ID */
   pw VARCHAR2(20 CHAR), /* 비밀번호 */
   nick VARCHAR2(15 CHAR), /* 닉네임 */
   
   CONSTRAINT PK_USERS PRIMARY KEY (memid)
);

-- 설문 답변 테이블
CREATE TABLE ANSWERS (
   SUL_NO NUMBER NOT NULL, /* 설문번호 */
   memid VARCHAR2(15 CHAR) NOT NULL, /* 회원 ID */
   ans NUMBER, /* 답변 */
   list VARCHAR2(100 CHAR) NOT NULL
   
   CONSTRAINT FK_SUL_TO_ANSWERS FOREIGN KEY (SUL_NO) REFERENCES SUL(SUL_NO),
   CONSTRAINT FK_USERS_TO_ANSWERS FOREIGN KEY (memid) REFERENCES USERS(memid),
   CONSTRAINT PK_ANSWERS PRIMARY KEY (SUL_NO, memid),
);

-- 설문 항목 테이블
CREATE TABLE SCOTT.HANGMOK (
   list VARCHAR2(100 CHAR) NOT NULL, /* 질문 항목 */
   listnum NUMBER NOT NULL, /* 질문 항목 번호 */
   SUL_NO NUMBER NOT NULL, /* 설문번호 */
   
   CONSTRAINT FK_SUL_TO_HANGMOK FOREIGN KEY (SUL_NO) REFERENCES SUL(SUL_NO)
);





















    DROP TABLE table2 CASCADE CONSTRAINTS; 
    DROP TABLE answers CASCADE CONSTRAINTS; 
    DROP TABLE users CASCADE CONSTRAINTS; 
    DROP TABLE sul CASCADE CONSTRAINTS; 
    DROP TABLE hangmok CASCADE CONSTRAINTS; 

--테이블 생성

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

/* 회원 */
CREATE TABLE SCOTT.USERS (
   memid VARCHAR2(15 CHAR) NOT NULL, /* 회원 ID */
   pw VARCHAR2(20 CHAR), /* 비밀번호 */
   nick VARCHAR2(15 CHAR) /* 닉네임 */
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

--확인

SELECT *
FROM sul;


SELECT *
FROM hangmok;


SELECT *
FROM answers;


SELECT *
FROM users;


-- SUL(설문조사) 추가 및 시간들 업데이트
INSERT INTO sul VALUES (1, '제목1', sysdate, sysdate, sysdate, 'JYP' );
INSERT INTO sul VALUES (2, '제목2', sysdate, sysdate, sysdate, 'JYP' );
INSERT INTO sul VALUES (3, '제목3', TO_DATE('2024-08-22', 'yyyy-mm-dd'), TO_DATE('2024-08-30', 'yyyy-mm-dd'), TO_DATE('2016-05-30', 'yyyy-mm-dd'), 'JYP' );
INSERT INTO sul VALUES (4, '제목4', TO_DATE('2006-08-24', 'yyyy-mm-dd'), TO_DATE('2006-09-28', 'yyyy-mm-dd'), TO_DATE('2006-01-10', 'yyyy-mm-dd'), 'JYP' );

UPDATE sul
SET startd = TO_DATE('2024-08-01', 'yyyy-mm-dd')
, endd = TO_DATE('2024-08-19', 'yyyy-mm-dd')
WHERE sul_no = 1;

UPDATE sul
SET startd = sysdate
, endd = sysdate +0.1
WHERE sul_no = 2;
    
    
 --유저 추가   
    
 INSERT INTO users VALUES ('snail', '123a' , '달팽이' ); 
 INSERT INTO users VALUES ('snail2', '1243a' , '달팽이2' ); 
 INSERT INTO users VALUES ('snail3', '12333a' , '달팽이3' ); 
 INSERT INTO users VALUES ('snail4', '12333a' , '달팽이4' ); 
 INSERT INTO users VALUES ('snail5', '12333a' , '달팽이5' ); 
 INSERT INTO users VALUES ('snail6', '12333a' , '달팽이6' ); 
 INSERT INTO users VALUES ('snail7', '12333a' , '달팽이7' ); 
     
    
 --항목 추가
INSERT INTO hangmok VALUES(1, '1번선택', 1 );
INSERT INTO hangmok VALUES(1, '2번선택', 2 );

INSERT INTO hangmok VALUES(2, '1번선택', 1 );
INSERT INTO hangmok VALUES(2, '2번선택', 2 );
INSERT INTO hangmok VALUES(2, '3번선택', 3 );

INSERT INTO hangmok VALUES(3, '1번선택', 1 );
INSERT INTO hangmok VALUES(3, '2번선택', 2 );
INSERT INTO hangmok VALUES(3, '3번선택', 3 );
    
INSERT INTO hangmok VALUES(4, '1번선택', 1 );    
INSERT INTO hangmok VALUES(4, '2번선택', 2 );       
       
-- 설문 진행 (답변 추가)   
    
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
    
--설문 목록 확인
SELECT s.sul_no 설문번호 , s.title 제목, s.author 작성자, s.startd 시작일, s.endd 종료일
        , (SELECT COUNT(listnum) FROM hangmok WHERE s.sul_no =sul_no) 항목수
        , (SELECT COUNT(memid) FROM answers WHERE s.sul_no =sul_no) 응답자수
        , CASE WHEN endd < sysdate THEN '종료' WHEN startd > sysdate THEN '대기중' ELSE '진행중' END 상태
FROM hangmok h JOIN sul s ON h.sul_no = s.sul_no
GROUP BY s.sul_no , s.title, s.author, s.startd, s.endd
ORDER BY 상태 DESC;
-- 설문 목록 쿼리: 현재시간(sysdate)를 CASE문으로 나눠서 시간에 따라서 설문 상태 출력..
    

--일단 그래프

    SELECT  e.고른수 ,  lpad ( ' ' , e.고른수+1, '*')  그래프,  ROUND( CAST(e.고른수 AS FLOAT) / SUM(CAST(e.고른수 AS FLOAT)) OVER (), 2 ) * 100 || '%'
    FROM (
    SELECT  COUNT(a.ans) "고른수"
    FROM answers a 
    WHERE a.sul_no = 3 --이것만 선택할 수 있으면 ? (ex. 2번 설문 상세보기 클릭시 여기가 2로 되게)
    GROUP BY a.ans
    ORDER BY a.sul_no
    ) e
    GROUP BY e.고른수;
-- 문제점: 0명 고른 선택지는 안나옴...

