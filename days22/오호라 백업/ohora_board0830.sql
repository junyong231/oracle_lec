--�Խñ� ��ȣ
CREATE SEQUENCE brd_num_seq --�Խñ� ��ȣ
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 1000
    NOCYCLE
    ORDER
    NOCACHE;

--SELECT *
--FROM oh_usr;


INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , 'ù��° ���������Դϴ�' , 'ù������ �����Դϴ�', TO_DATE('2024-08-12 01:12:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ1', 10, 1);
-- ������ ȸ����ȣ �׳� �ۼ��� ��ȣ��� ����
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '�ι�° ���������Դϴ�' , '�ι�° ������ �����Դϴ�', TO_DATE('2024-08-12 03:12:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ2', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '����° ���������Դϴ�' , '3��° ������ �����Դϴ�', TO_DATE('2024-08-14 03:12:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ2', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '�׹�° ���������Դϴ�' , '4��° ������ �����Դϴ�', TO_DATE('2024-08-14 04:12:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ2', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '�ټ���° ���������Դϴ�' , '5��° ������ �����Դϴ�', TO_DATE('2024-08-14 05:12:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ2', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '������° ���������Դϴ�' , '6��° ������ �����Դϴ�', TO_DATE('2024-08-16 04:12:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ4', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '�ϰ���° ���������Դϴ�' , '7��° ������ �����Դϴ�', TO_DATE('2024-08-17 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '������° ���������Դϴ�' , '8��° ������ �����Դϴ�', TO_DATE('2024-08-18 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '9��° ���������Դϴ�' , '9��° ������ �����Դϴ�', TO_DATE('2024-08-19 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ3', 18, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '10��° ���������Դϴ�' , '10��° ������ �����Դϴ�', TO_DATE('2024-08-20 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '11��° ���������Դϴ�' , '11��° ������ �����Դϴ�', TO_DATE('2024-08-21 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ3', 17, 1);

INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'event' , '1��° �̺�Ʈ�Դϴ�' , '1��° �����Դϴ�', TO_DATE('2024-08-21 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'event' , '2��° �̺�Ʈ�Դϴ�' , '2��° �����Դϴ�', TO_DATE('2024-08-22 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'event' , '3��° �̺�Ʈ�Դϴ�' , '3��° �����Դϴ�', TO_DATE('2024-08-23 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ3', 17, 1);

INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'magazine' , '1��° �Ű����Դϴ�' , '1��° �Ű��� �����Դϴ�', TO_DATE('2024-08-23 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '������ũ10', 17, 1);

SELECT *
FROM oh_board
ORDER BY brd_date DESC;

DELETE FROM oh_board WHERE brd_num BETWEEN 1 AND 30;

-- �������� ������(���)�� ���� ���
CREATE OR REPLACE PROCEDURE see_notice_list
(
    psel_notice_page NUMBER --���� �� ������
    , psel_brd_theme oh_board.brd_theme%TYPE --���� �� �Խ���
)

IS
    vtitle_all NUMBER; --��� �Խñ� �� ����
    vsel_notice_page NUMBER; --���� �� ������ ����

BEGIN
    
    SELECT COUNT(*) INTO vtitle_all
    FROM oh_board
    WHERE brd_theme = psel_brd_theme;
    
    IF TRUNC(vtitle_all/5) >= psel_notice_page THEN --Ǯ��������
    
    FOR notice_title_row IN 
    (
    SELECT rn, brd_title
        FROM (
            SELECT ROW_NUMBER() OVER (ORDER BY e.brd_date DESC) AS rn, e.brd_title
            FROM (
                SELECT brd_title, brd_date
                FROM oh_board
                WHERE brd_theme = psel_brd_theme
                ORDER BY brd_date DESC , brd_theme
            ) e
    )    WHERE rn BETWEEN ((psel_notice_page-1)*5 +1) AND  (psel_notice_page * 5)  -- 2������ 6~10 �̾ƾ���
    ORDER BY ROWNUM ASC
    )
    LOOP
    DBMS_OUTPUT.PUT_LINE( notice_title_row.brd_title );
    END LOOP;
    
    ELSE    -- ������ ������
    
    FOR notice_title_row IN 
    (
        SELECT rn, brd_title
        FROM (
            SELECT ROW_NUMBER() OVER (ORDER BY e.brd_date DESC) AS rn, e.brd_title
            FROM (
                SELECT brd_title, brd_date
                FROM oh_board
                WHERE brd_theme = psel_brd_theme
                ORDER BY brd_date DESC , brd_theme
            ) e
        )
        WHERE rn BETWEEN ((psel_notice_page-1)*5 +1) AND vtitle_all
    )    
    
    LOOP
    DBMS_OUTPUT.PUT_LINE( notice_title_row.brd_title );
    END LOOP;
    
    END IF;
    
    COMMIT;
END;

EXEC see_notice_list(1, 'notice');

EXEC see_notice_list(1, 'event');

----------------------------
-- �Խñ� �� ����


CREATE OR REPLACE PROCEDURE see_board_detail --see_comment���ν��� ����
(
    psel_brd_num NUMBER
)

IS

    vbrd_title oh_board.brd_title%TYPE;
    vusr_num oh_usr.usr_num%TYPE;
    vbrd_view oh_board.brd_view%TYPE;
    vbrd_date oh_board.brd_date%TYPE;
    vbrd_content oh_board.brd_content%TYPE;
    vbrd_media oh_board.brd_media%TYPE;
    vbrd_author oh_usr.usr_name%TYPE;
    vbrd_num oh_board.brd_num%TYPE;
    
BEGIN
   
   vbrd_num :=psel_brd_num ;
   
    UPDATE oh_board
    SET brd_view = brd_view+1
    WHERE brd_num = psel_brd_num;

    SELECT brd_title, usr_num, brd_view, brd_date , brd_content, brd_media
    INTO vbrd_title, vusr_num, vbrd_view, vbrd_date , vbrd_content, vbrd_media
    FROM oh_board
    WHERE brd_num =  psel_brd_num;
    
    SELECT usr_name INTO vbrd_author
    FROM oh_usr
    WHERE usr_num = vusr_num;


    
    DBMS_OUTPUT.PUT_LINE(   '����    | ' || vbrd_title  );
    DBMS_OUTPUT.PUT_LINE(   '�ۼ��� | ' || vbrd_author  );
    DBMS_OUTPUT.PUT_LINE(   '��ȸ�� | ' || vbrd_view  );
    DBMS_OUTPUT.PUT_LINE(   '�ۼ��� | ' || vbrd_date  );
    DBMS_OUTPUT.PUT_LINE(   vbrd_media  );
    DBMS_OUTPUT.PUT_LINE(   vbrd_content  );
     DBMS_OUTPUT.PUT_LINE( ''  );


    --���� ��ۺ��� ���ν��� ������ ��
    DBMS_OUTPUT.PUT_LINE( '-----------���-----------'  );
    see_comment ( vbrd_num ) ;
    
    COMMIT;
END;

EXEC see_board_detail (15);

SELECT *
FROM oh_board;

--��� ������
CREATE SEQUENCE comment_seq --��� ��ȣ
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 1000
    NOCYCLE
    ORDER
    NOCACHE;

--��� ���̺� ����

--ALTER TABLE oh_comments ADD brd_num NUMBER; -- ��ۿ� �Խñ� ��ȣ �߰�
--ALTER TABLE oh_comments ADD co_name VARCHAR2(10 char); -- ��ۿ� �ۼ��� (���� �ִ� �ý�����)
--ALTER TABLE oh_comments ADD co_date DATE; -- ��ۿ� �ۼ���
--
--ALTER TABLE oh_comments
--ADD CONSTRAINT fk_brd_num_to_comments FOREIGN KEY (brd_num) REFERENCES oh_board(brd_num);
-- �Խñ� ��ȣ �ܷ�Ű �߰�


--���̵����� (3�� �Խñ� �����ؾ���)
INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , '�̺�Ʈ ¯�̴�' , 1, 3 , 'ȸ��123', '2024-08-11'); --3�� �̺�Ʈ ���
INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , '�̺�Ʈ ¯�̴�22' , 1, 3 , '���� ���̴�','2024-08-12');--3�� �̺�Ʈ ���
INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , '�̺�Ʈ ¯�̴�33' , 1, 3 ,'��� ���','2024-08-12');--3�� �̺�Ʈ ���

INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , '�Ű���1 ���ڴ�' , 1, 15 ,'��������','2024-08-12');--1�� �Ű��� ���

DELETE FROM oh_comments WHERE co_num BETWEEN 1 AND 3; --���� ������

--��ۺ��� ���ν���
CREATE OR REPLACE PROCEDURE see_comment
(
    psel_brd_num oh_board.brd_num%TYPE
)

IS
    vco_content oh_comments.co_content%TYPE;
    vco_num oh_comments.co_num%TYPE;
    vusr_num oh_usr.usr_num%TYPE;
    vbrd_num oh_board.brd_num%TYPE;
    vco_name oh_comments.co_name%TYPE;
    vco_date oh_comments.co_date%TYPE;
    
BEGIN

    FOR comments_row IN 
    (
    
       
                SELECT co_num, co_content, usr_num , brd_num , co_name, co_date
                INTO vco_num, vco_content, vusr_num , vbrd_num , vco_name, vco_date
                FROM oh_comments
                WHERE brd_num = psel_brd_num
                ORDER BY co_num ASC
    

    )
    LOOP
    DBMS_OUTPUT.PUT_LINE ('----------------------------');
    DBMS_OUTPUT.PUT_LINE( '�ۼ��� : ' || comments_row.co_name );
    DBMS_OUTPUT.PUT_LINE( '�ۼ��� : ' || comments_row.co_date  );
    DBMS_OUTPUT.PUT_LINE ('----------------------------');
    DBMS_OUTPUT.PUT_LINE( '> ' ||comments_row.co_content  );
    
    
    END LOOP;

END;

EXEC see_comment (15);


-- ��� �ۼ�

CREATE OR REPLACE PROCEDURE write_comment
(
    pbrd_num oh_board.brd_num%TYPE
    , pco_name oh_comments.co_name%TYPE
    , pco_content oh_comments.co_content%TYPE
    , pco_usr_num oh_usr.usr_num%TYPE
)
IS
BEGIN

    INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , pco_content ,  pco_usr_num, pbrd_num , pco_name , sysdate ); 

END;

EXEC write_comment ( 15 , '�Ф�' , '������?' , 1);   --�۹�ȣ�� �г���(��� �� ������ ���� ����), ����, ȸ����ȣ(���¹�ȣ ������ ������ ��)

EXEC see_board_detail (15); --1�� �Խñۿ� ��� �޷ȳ� Ȯ�� (O)










----
CREATE SEQUENCE rv_num_seq  --���� �ѹ� ������ ����
INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

CREATE SEQUENCE rv_cmt_num_seq  --���� ��� �ѹ� ������ ����
INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

-- ���� �ۼ� (����)

INSERT INTO oh_review VALUES ( rv_num_seq.NEXTVAL, 'ù��° �����Դϴ�', 'ù��° ���� �����Դϴ�', '���������ũ2', '2024-08-11', 4 , 3, 4, 1,1,1);
-- �̰� ���� �ȵǴ� ����(�̵�� �÷� ����)

--���� ��ǰ
INSERT INTO oh_product VALUES ( 1, '���̳���1ȣ', '2024-08-23', 130, 10000, 8000 , 150 , '��ǰ������ũ1', 20, 43);

--���� ��ٱ���
INSERT INTO oh_cart VALUES ( 1, 1 );

SELECT *
FROM oh_cart;

--�׳� ���� ���� �־�߰ڳ�
INSERT INTO oh_order VALUES ( 1, '2023-11-28', 16000, '�ֹ���' , 'x' , 1, 1 ,1);

-- ���� ����
INSERT INTO oh_review VALUES ( rv_num_seq.NEXTVAL, '2��° �����Դϴ�', '2��° ���� �����Դϴ�', '2024-08-12', 5 , 3, 1, 1,1,56);


--���信 ��� �ޱ�
CREATE OR REPLACE PROCEDURE write_rv_comment
(
    prv_num oh_review.rv_num%TYPE --��� �ۼ��� ���� ��ȣ
    , pusr_num oh_usr.usr_num%TYPE --���� ��� �ۼ��� ��ȣ
    , pco_content oh_comments.co_content%TYPE --���� ��� ����
)
IS
    vusr_name oh_usr.usr_name%TYPE;
BEGIN
    
    SELECT usr_name INTO vusr_name
    FROM oh_usr
    WHERE usr_num = pusr_num;
    
    INSERT INTO oh_review_comment ( rv_num, rv_comment_num, rv_comment_content, rv_comment_date, rvcm_usr_name)
    VALUES (prv_num , RV_CMT_NUM_SEQ.NEXTVAL, pco_content , sysdate ,vusr_name); 
    
    
END;

EXEC write_rv_comment ( 2 , 1, '2���信 ��۽��¡ ~1' );   -- �����ȣ ȸ����ȣ ��۳���

SELECT *
FROM oh_review;

SELECT *
FROM oh_review_comment;

SELECT *
FROM oh_usr

--DROP TABLE oh_review_comment;
--
--CREATE TABLE oh_review_comment -- ���� �ڸ�Ʈ ���̺� ����
--(
--    rv_num NUMBER 
--    , rv_comment_num NUMBER PRIMARY KEY
--    , rv_comment_content VARCHAR2(200CHAR)
--    , rv_comment_date DATE
--    , usr_num NUMBER
--    , rvcm_usr_name VARCHAR2(50 CHAR)
--
--    ,CONSTRAINT fk_oh_rv_num_to_rvc FOREIGN KEY(rv_num) REFERENCES oh_review (rv_num)
--    ON DELETE CASCADE
--     ,CONSTRAINT fk_oh_usr_num_to_rvc FOREIGN KEY(usr_num) REFERENCES oh_usr (usr_num)
--    ON DELETE CASCADE
--);















-- ���� ��ۺ���

CREATE OR REPLACE PROCEDURE see_rv_comment
(
    psel_rv_num oh_review.rv_num%TYPE
)

IS
--   vrvcm_usr_name oh_review_comment.rvcm_usr_name%TYPE;
--   vrv_comment_content oh_review_comment.rv_comment_content%TYPE;
    
BEGIN

    FOR comments_row IN 
    (
    
       
                SELECT rvcm_usr_name , rv_comment_content
                FROM oh_review_comment
                WHERE rv_num = psel_rv_num
                ORDER BY rv_comment_num ASC
    

    )
    LOOP
    DBMS_OUTPUT.PUT_LINE ('----------------------------');
    DBMS_OUTPUT.PUT_LINE( '�ۼ��� : ' || comments_row.rvcm_usr_name );
    DBMS_OUTPUT.PUT_LINE ('----------------------------');
    DBMS_OUTPUT.PUT_LINE( '> ' ||comments_row.rv_comment_content  );
    
    
    END LOOP;

END;

EXEC see_rv_comment (2); --����ѹ� ������ ��























--�����
SELECT *
FROM oh_usr;

SELECT *
FROM oh_order;

INSERT INTO OH_ORDER (OD_NUM, OD_DATE, OD_PRICE, OD_STATUS, OD_CANCEL, USR_NUM, PD_NUM, CART_NUM) 
VALUES (2, '2024-08-25', 960000, '��', 'X', 4, 1, 1); 


COMMIT;

SELECT *
FROM oh_cart;

INSERT INTO OH_CART (CART_NUM, USR_NUM, PD_NUM, CART_PDCNT) VALUES (1, 4, 1, 1);

SELECT *
FROM oh_product;

INSERT INTO oh_


INSERT INTO oh_product VALUES(1,'��Ű �Ǵ� ����',SYSDATE-30,312,16800,13440,5,'�̹���',20,123);

DELETE FROM oh_cart WHERE cart_num = 1; -- �ֹ��� �ع��ȱ� ������ īƮ���� ���°� �Ұ� (�翬)
DELETE FROM oh_order WHERE od_num = 1; -- 1�� �ֹ� ��� (ȯ��)
DELETE FROM oh_order WHERE od_num = 2; --2�� �ֹ� ��� (ȯ��) : �̰ɷ� īƮ 1���� ��Ų�� �� ���� 
DELETE FROM oh_cart WHERE cart_num = 1;  -- �Ǿߵ� - �� 
 -- �� ���ư���



-----------------------
INSERT INTO oh_cpn_req VALUES ( 1, '2024-08-30' , 10 , 20000, 1 );
INSERT INTO oh_coupon VALUES ( 1, '����ǰ ��������' , 10 , 1, 1 );

-- �������� ������
CREATE OR REPLACE PROCEDURE SEE_COUPON (
    pusr_num IN oh_coupon.usr_num%TYPE -- ȸ���� ���� �޾ƿ���
) 
IS
    -- ���� �� ���� Ŀ��
    CURSOR coupon_cursor IS
        SELECT c.cp_name, r.cr_price, r.cr_product, r.cr_date
        FROM oh_coupon c
        JOIN oh_cpn_req r ON c.cr_num = r.cr_num
        WHERE c.usr_num = pusr_num;
    
    -- Ŀ�� ����
    coupon_record coupon_cursor%ROWTYPE;
BEGIN
    -- ���� ���� ���
    DBMS_OUTPUT.PUT_LINE('=========== * COUPON * ============');
    
    -- ���� Ŀ�� ���� �� ���� ó��
    FOR coupon_record IN coupon_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(' ������ : ' || coupon_record.cp_name);
        DBMS_OUTPUT.PUT_LINE(' ����ǰ�� : ' || coupon_record.cr_product);
        DBMS_OUTPUT.PUT_LINE(' ���� : -'); -- �������� �ʿ��ϸ� �߰��� �� ����
        DBMS_OUTPUT.PUT_LINE(' ���űݾ�����: ' || coupon_record.cr_price);
        DBMS_OUTPUT.PUT_LINE(' �����ǰ : ' || coupon_record.cr_product);
        DBMS_OUTPUT.PUT_LINE(' ���Ⱓ : ' || coupon_record.cr_date);
        DBMS_OUTPUT.PUT_LINE('===================================');
    END LOOP;
    
    -- �����Ͱ� ���� ��� ó��
    IF SQL%ROWCOUNT IS NULL THEN
        DBMS_OUTPUT.PUT_LINE(' �ش� ȸ���� ���� ������ �����ϴ�.');
    END IF;
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���� �߻�: ' || SQLERRM);
END;
--
EXEC SEE_COUPON(1);

SELECT *
FROM oh_usr;
