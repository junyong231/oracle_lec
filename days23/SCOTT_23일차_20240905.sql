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

--����Ŭ�� ����
CREATE SEQUENCE seq_tblcstVSBoard
NOCACHE;

CREATE TABLE tbl_cstVSBoard (
  seq NUMBER  NOT NULL PRIMARY KEY, --�۹�ȣ
  writer VARCHAR2 (20) NOT NULL ,                                    --�ۼ���
  pwd VARCHAR2 (20) NOT NULL ,                                     -- �Խñ� ���
  email VARCHAR2 (100) ,                                        -- �۾��� ����
  title VARCHAR2 (200) NOT NULL ,                                     -- ���� 
  writedate DATE DEFAULT sysdate,     -- �ۼ���
  readed NUMBER DEFAULT 0,                                  --��ȸ��
  tag NUMBER(1) NOT NULL ,                                               --���� ����  (html..) 0 = �ؽ�Ʈ, 1 = html
  content CLOB                                                    --����
);

SELECT *
FROM tbl_cstVSBoard;


-- ���̵����� ���� !!
BEGIN

    FOR i IN 1..150 LOOP
        INSERT INTO tbl_cstVSBoard (seq, writer, pwd, email, title, tag, content)
        VALUES ( seq_tblcstVSBoard.NEXTVAL, 'ȫ�浿' || MOD(i,10), '1234', 'ȫ�浿' || MOD(i,10) || '@sist.co.kr', '����...' || i, 0 , '����...' || i );
    END LOOP;
    COMMIT;

END;
--
BEGIN
    UPDATE tbl_cstVSBoard
    SET writer = '���ؿ�'
    WHERE MOD(seq, 15) = 4;
    COMMIT;
END;
--
BEGIN
    UPDATE tbl_cstVSBoard
    SET title = '�Խ��� ����'
    WHERE MOD(seq, 15) IN ( 3, 5 , 8 );
    COMMIT;
END;
--

SELECT seq, title, writer, email, writedate, readed
FROM tbl_cstVSBoard 
ORDER BY seq DESC;

--���� ������ ��ȣ: 1
-- �� �������� ����� ���ڵ�(�Խñ�) �� : 10
-- (TOP N ���)

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

--����˻�
SELECT *
FROM tbl_cstvsboard
WHERE REGEXP_LIKE ( title, 'z' , 'i' );



