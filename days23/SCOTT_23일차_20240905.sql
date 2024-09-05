--MS-SQL
create table cstVSBoard (
  seq int identity (1, 1) not null primary key clustered,
  writer varchar (20) not null ,
  pwd varchar (20) not null ,
  email varchar (100) null ,
  title varchar (200) not null ,
  writedate smalldatetime not null default (getdate()),
  readed int not null default (0),
  mode tinyint not null ,
  content text null
)

--오라클로 수정
CREATE SEQUENCE seq_tblcstVSBoard
NOCACHE;

CREATE TABLE tbl_cstVSBoard (
  seq NUMBER  NOT NULL PRIMARY KEY, --글번호
  writer VARCHAR2 (20) NOT NULL ,                                    --작성자
  pwd VARCHAR2 (20) NOT NULL ,                                     -- 게시글 비번
  email VARCHAR2 (100) ,                                        -- 글쓴이 메일
  title VARCHAR2 (200) NOT NULL ,                                     -- 제목 
  writedate DATE DEFAULT sysdate,     -- 작성일
  readed NUMBER DEFAULT 0,                                  --조회수
  tag NUMBER(1) NOT NULL ,                                               --글의 형식  (html..) 0 = 텍스트, 1 = html
  content CLOB                                                    --내용
);

SELECT *
FROM tbl_cstVSBoard;


-- 더미데이터 생성 !!
BEGIN

    FOR i IN 1..150 LOOP
        INSERT INTO tbl_cstVSBoard (seq, writer, pwd, email, title, tag, content)
        VALUES ( seq_tblcstVSBoard.NEXTVAL, '홍길동' || MOD(i,10), '1234', '홍길동' || MOD(i,10) || '@sist.co.kr', '더미...' || i, 0 , '더미...' || i );
    END LOOP;
    COMMIT;

END;
--
BEGIN
    UPDATE tbl_cstVSBoard
    SET writer = '박준용'
    WHERE MOD(seq, 15) = 4;
    COMMIT;
END;
--
BEGIN
    UPDATE tbl_cstVSBoard
    SET title = '게시판 구현'
    WHERE MOD(seq, 15) IN ( 3, 5 , 8 );
    COMMIT;
END;
--

SELECT seq, title, writer, email, writedate, readed
FROM tbl_cstVSBoard 
ORDER BY seq DESC;

--현재 페이지 번호: 1
-- 한 페이지의 출력할 레코드(게시글) 수 : 10
-- (TOP N 방식)

SELECT *
FROM (
    SELECT ROWNUM no , t.*
    FROM(
    SELECT seq, title, writer, email, writedate, readed
    FROM tbl_cstVSBoard 
    ORDER BY seq DESC
    ) t
) b
WHERE no BETWEEN 1 AND 10;

SELECT TRUNC(COUNT(*)/10 )
FROM tbl_cstvsboard


DELETE 
FROM tbl_cstvsboard
WHERE seq = ?

UPDATE tbl_cstvsboard
SET  title = ?, content = ?
WHERE seq = ?;

--제목검색
SELECT *
FROM tbl_cstvsboard
WHERE REGEXP_LIKE ( title, 'z' , 'i' );



