--게시글 번호
CREATE SEQUENCE brd_num_seq --게시글 번호
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 1000
    NOCYCLE
    ORDER
    NOCACHE;

--SELECT *
--FROM oh_usr;


INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '첫번째 공지사항입니다' , '첫공지의 내용입니다', TO_DATE('2024-08-12 01:12:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크1', 10, 1);
-- 마지막 회원번호 그냥 작성자 번호라는 가정
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '두번째 공지사항입니다' , '두번째 공지의 내용입니다', TO_DATE('2024-08-12 03:12:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크2', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '세번째 공지사항입니다' , '3번째 공지의 내용입니다', TO_DATE('2024-08-14 03:12:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크2', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '네번째 공지사항입니다' , '4번째 공지의 내용입니다', TO_DATE('2024-08-14 04:12:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크2', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '다섯번째 공지사항입니다' , '5번째 공지의 내용입니다', TO_DATE('2024-08-14 05:12:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크2', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '여섯번째 공지사항입니다' , '6번째 공지의 내용입니다', TO_DATE('2024-08-16 04:12:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크4', 11, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '일곱번째 공지사항입니다' , '7번째 공지의 내용입니다', TO_DATE('2024-08-17 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '여덣번째 공지사항입니다' , '8번째 공지의 내용입니다', TO_DATE('2024-08-18 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '9번째 공지사항입니다' , '9번째 공지의 내용입니다', TO_DATE('2024-08-19 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크3', 18, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '10번째 공지사항입니다' , '10번째 공지의 내용입니다', TO_DATE('2024-08-20 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'notice' , '11번째 공지사항입니다' , '11번째 공지의 내용입니다', TO_DATE('2024-08-21 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크3', 17, 1);

INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'event' , '1번째 이벤트입니다' , '1번째 내용입니다', TO_DATE('2024-08-21 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'event' , '2번째 이벤트입니다' , '2번째 내용입니다', TO_DATE('2024-08-22 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크3', 17, 1);
INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'event' , '3번째 이벤트입니다' , '3번째 내용입니다', TO_DATE('2024-08-23 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크3', 17, 1);

INSERT INTO oh_board VALUES (brd_num_seq.NEXTVAL, 'magazine' , '1번째 매거진입니다' , '1번째 매거진 내용입니다', TO_DATE('2024-08-23 01:10:30', 'YYYY-MM-DD HH24:MI:SS') , '사진링크10', 17, 1);

SELECT *
FROM oh_board
ORDER BY brd_date DESC;

DELETE FROM oh_board WHERE brd_num BETWEEN 1 AND 30;

-- 공지사항 페이지(목록)을 보는 기능
CREATE OR REPLACE PROCEDURE see_notice_list
(
    psel_notice_page NUMBER --내가 볼 페이지
    , psel_brd_theme oh_board.brd_theme%TYPE --내가 볼 게시판
)

IS
    vtitle_all NUMBER; --모든 게시글 수 저장
    vsel_notice_page NUMBER; --내가 볼 페이지 저장

BEGIN
    
    SELECT COUNT(*) INTO vtitle_all
    FROM oh_board
    WHERE brd_theme = psel_brd_theme;
    
    IF TRUNC(vtitle_all/5) >= psel_notice_page THEN --풀방페이지
    
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
    )    WHERE rn BETWEEN ((psel_notice_page-1)*5 +1) AND  (psel_notice_page * 5)  -- 2넣으면 6~10 뽑아야함
    ORDER BY ROWNUM ASC
    )
    LOOP
    DBMS_OUTPUT.PUT_LINE( notice_title_row.brd_title );
    END LOOP;
    
    ELSE    -- 마지막 페이지
    
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
-- 게시글 상세 보기


CREATE OR REPLACE PROCEDURE see_board_detail --see_comment프로시저 선행
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


    
    DBMS_OUTPUT.PUT_LINE(   '제목    | ' || vbrd_title  );
    DBMS_OUTPUT.PUT_LINE(   '작성자 | ' || vbrd_author  );
    DBMS_OUTPUT.PUT_LINE(   '조회수 | ' || vbrd_view  );
    DBMS_OUTPUT.PUT_LINE(   '작성일 | ' || vbrd_date  );
    DBMS_OUTPUT.PUT_LINE(   vbrd_media  );
    DBMS_OUTPUT.PUT_LINE(   vbrd_content  );
     DBMS_OUTPUT.PUT_LINE( ''  );


    --여기 댓글보기 프로시저 있으면 됨
    DBMS_OUTPUT.PUT_LINE( '-----------댓글-----------'  );
    see_comment ( vbrd_num ) ;
    
    COMMIT;
END;

EXEC see_board_detail (15);

SELECT *
FROM oh_board;

--댓글 시퀀스
CREATE SEQUENCE comment_seq --댓글 번호
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 1000
    NOCYCLE
    ORDER
    NOCACHE;

--댓글 테이블 수정

--ALTER TABLE oh_comments ADD brd_num NUMBER; -- 댓글에 게시글 번호 추가
--ALTER TABLE oh_comments ADD co_name VARCHAR2(10 char); -- 댓글에 작성자 (직접 넣는 시스템임)
--ALTER TABLE oh_comments ADD co_date DATE; -- 댓글에 작성일
--
--ALTER TABLE oh_comments
--ADD CONSTRAINT fk_brd_num_to_comments FOREIGN KEY (brd_num) REFERENCES oh_board(brd_num);
-- 게시글 번호 외래키 추가


--더미데이터 (3번 게시글 존재해야함)
INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , '이벤트 짱이당' , 1, 3 , '회원123', '2024-08-11'); --3번 이벤트 댓글
INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , '이벤트 짱이당22' , 1, 3 , '고객은 왕이다','2024-08-12');--3번 이벤트 댓글
INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , '이벤트 짱이당33' , 1, 3 ,'사실 운영자','2024-08-12');--3번 이벤트 댓글

INSERT INTO oh_comments (co_num, co_content, usr_num , brd_num , co_name , co_date) VALUES ( comment_seq.NEXTVAL , '매거진1 예쁘다' , 1, 15 ,'사실은운영자','2024-08-12');--1번 매거진 댓글

DELETE FROM oh_comments WHERE co_num BETWEEN 1 AND 3; --더미 삭제용

--댓글보기 프로시저
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
    DBMS_OUTPUT.PUT_LINE( '작성자 : ' || comments_row.co_name );
    DBMS_OUTPUT.PUT_LINE( '작성일 : ' || comments_row.co_date  );
    DBMS_OUTPUT.PUT_LINE ('----------------------------');
    DBMS_OUTPUT.PUT_LINE( '> ' ||comments_row.co_content  );
    
    
    END LOOP;

END;

EXEC see_comment (15);


-- 댓글 작성

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

EXEC write_comment ( 15 , '닉ㅋ' , '써지나?' , 1);   --글번호에 닉네임(댓글 달 때마다 설정 가능), 내용, 회원번호(없는번호 넣으면 오류뜸 굳)

EXEC see_board_detail (15); --1번 게시글에 댓글 달렸나 확인 (O)










----
CREATE SEQUENCE rv_num_seq  --리뷰 넘버 시퀀스 생성
INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

CREATE SEQUENCE rv_cmt_num_seq  --리뷰 댓글 넘버 시퀀스 생성
INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

-- 리뷰 작성 (더미)

INSERT INTO oh_review VALUES ( rv_num_seq.NEXTVAL, '첫번째 리뷰입니다', '첫번째 리뷰 내용입니다', '리뷰사진링크2', '2024-08-11', 4 , 3, 4, 1,1,1);
-- 이건 이제 안되는 더미(미디어 컬럼 날림)

--더미 상품
INSERT INTO oh_product VALUES ( 1, '더미네일1호', '2024-08-23', 130, 10000, 8000 , 150 , '제품사진링크1', 20, 43);

--더미 장바구니
INSERT INTO oh_cart VALUES ( 1, 1 );

SELECT *
FROM oh_cart;

--그냥 결제 직접 넣어야겠네
INSERT INTO oh_order VALUES ( 1, '2023-11-28', 16000, '주문완' , 'x' , 1, 1 ,1);

-- 더미 리뷰
INSERT INTO oh_review VALUES ( rv_num_seq.NEXTVAL, '2번째 리뷰입니다', '2번째 리뷰 내용입니다', '2024-08-12', 5 , 3, 1, 1,1,56);


--리뷰에 댓글 달기
CREATE OR REPLACE PROCEDURE write_rv_comment
(
    prv_num oh_review.rv_num%TYPE --댓글 작성할 리뷰 번호
    , pusr_num oh_usr.usr_num%TYPE --리뷰 댓글 작성자 번호
    , pco_content oh_comments.co_content%TYPE --리뷰 댓글 내용
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

EXEC write_rv_comment ( 2 , 1, '2리뷰에 댓글써야징 ~1' );   -- 리뷰번호 회원번호 댓글내용

SELECT *
FROM oh_review;

SELECT *
FROM oh_review_comment;

SELECT *
FROM oh_usr

--DROP TABLE oh_review_comment;
--
--CREATE TABLE oh_review_comment -- 리뷰 코멘트 테이블 생성
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















-- 리뷰 댓글보기

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
    DBMS_OUTPUT.PUT_LINE( '작성자 : ' || comments_row.rvcm_usr_name );
    DBMS_OUTPUT.PUT_LINE ('----------------------------');
    DBMS_OUTPUT.PUT_LINE( '> ' ||comments_row.rv_comment_content  );
    
    
    END LOOP;

END;

EXEC see_rv_comment (2); --리뷰넘버 넣으면 됨























--실험실
SELECT *
FROM oh_usr;

SELECT *
FROM oh_order;

INSERT INTO OH_ORDER (OD_NUM, OD_DATE, OD_PRICE, OD_STATUS, OD_CANCEL, USR_NUM, PD_NUM, CART_NUM) 
VALUES (2, '2024-08-25', 960000, '배', 'X', 4, 1, 1); 


COMMIT;

SELECT *
FROM oh_cart;

INSERT INTO OH_CART (CART_NUM, USR_NUM, PD_NUM, CART_PDCNT) VALUES (1, 4, 1, 1);

SELECT *
FROM oh_product;

INSERT INTO oh_


INSERT INTO oh_product VALUES(1,'럭키 판다 네일',SYSDATE-30,312,16800,13440,5,'이미지',20,123);

DELETE FROM oh_cart WHERE cart_num = 1; -- 주문을 해버렸기 때문에 카트에서 빼는게 불가 (당연)
DELETE FROM oh_order WHERE od_num = 1; -- 1번 주문 취소 (환불)
DELETE FROM oh_order WHERE od_num = 2; --2번 주문 취소 (환불) : 이걸로 카트 1에서 시킨거 다 빠짐 
DELETE FROM oh_cart WHERE cart_num = 1;  -- 되야됨 - 됨 
 -- 잘 돌아간다



-----------------------
INSERT INTO oh_cpn_req VALUES ( 1, '2024-08-30' , 10 , 20000, 1 );
INSERT INTO oh_coupon VALUES ( 1, '모든상품 할인쿠폰' , 10 , 1, 1 );

-- 쿠폰내역 페이지
CREATE OR REPLACE PROCEDURE SEE_COUPON (
    pusr_num IN oh_coupon.usr_num%TYPE -- 회원의 쿠폰 받아오기
) 
IS
    -- 쿠폰 상세 정보 커서
    CURSOR coupon_cursor IS
        SELECT c.cp_name, r.cr_price, r.cr_product, r.cr_date
        FROM oh_coupon c
        JOIN oh_cpn_req r ON c.cr_num = r.cr_num
        WHERE c.usr_num = pusr_num;
    
    -- 커서 변수
    coupon_record coupon_cursor%ROWTYPE;
BEGIN
    -- 쿠폰 정보 출력
    DBMS_OUTPUT.PUT_LINE('=========== * COUPON * ============');
    
    -- 쿠폰 커서 열기 및 루프 처리
    FOR coupon_record IN coupon_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(' 쿠폰명 : ' || coupon_record.cp_name);
        DBMS_OUTPUT.PUT_LINE(' 할인품목 : ' || coupon_record.cr_product);
        DBMS_OUTPUT.PUT_LINE(' 적립 : -'); -- 적립금이 필요하면 추가할 수 있음
        DBMS_OUTPUT.PUT_LINE(' 구매금액조건: ' || coupon_record.cr_price);
        DBMS_OUTPUT.PUT_LINE(' 적용상품 : ' || coupon_record.cr_product);
        DBMS_OUTPUT.PUT_LINE(' 사용기간 : ' || coupon_record.cr_date);
        DBMS_OUTPUT.PUT_LINE('===================================');
    END LOOP;
    
    -- 데이터가 없는 경우 처리
    IF SQL%ROWCOUNT IS NULL THEN
        DBMS_OUTPUT.PUT_LINE(' 해당 회원의 쿠폰 정보가 없습니다.');
    END IF;
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류 발생: ' || SQLERRM);
END;
--
EXEC SEE_COUPON(1);

SELECT *
FROM oh_usr;
