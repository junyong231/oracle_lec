--0829

--테이블 생성
/* 회원 */
CREATE TABLE ohora.oh_usr (
   usr_num NUMBER NOT NULL, /* 회원번호 */
   usr_id VARCHAR2(16 CHAR) NOT NULL, /* 회원ID */
   usr_tel VARCHAR2(14 CHAR), /* 일반전화 */
   usr_phone VARCHAR2(14 CHAR), /* 휴대전화 */
   usr_name VARCHAR2(20 CHAR) NOT NULL, /* 이름 */
   usr_email VARCHAR2(50) NOT NULL, /* 이메일 */
   usr_email_yn CHAR(1 CHAR), /* 이메일 수신 여부 */
   usr_sms_yn CHAR(1 CHAR), /* SMS 수신 여부 */
   usr_level VARCHAR2(6), /* 등급명 */
   usr_birth DATE, /* 생년월일 */
   usr_pw VARCHAR2(16 CHAR) NOT NULL /* 비밀번호 */
);

COMMENT ON TABLE ohora.oh_usr IS '회원';

COMMENT ON COLUMN ohora.oh_usr.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_usr.usr_id IS '회원ID';

COMMENT ON COLUMN ohora.oh_usr.usr_tel IS '일반전화';

COMMENT ON COLUMN ohora.oh_usr.usr_phone IS '휴대전화';

COMMENT ON COLUMN ohora.oh_usr.usr_name IS '이름';

COMMENT ON COLUMN ohora.oh_usr.usr_email IS '이메일';

COMMENT ON COLUMN ohora.oh_usr.usr_email_yn IS '이메일 수신 여부';

COMMENT ON COLUMN ohora.oh_usr.usr_sms_yn IS 'SMS 수신 여부';

COMMENT ON COLUMN ohora.oh_usr.usr_level IS '등급명';

COMMENT ON COLUMN ohora.oh_usr.usr_birth IS '생년월일';

COMMENT ON COLUMN ohora.oh_usr.usr_pw IS '비밀번호';

CREATE UNIQUE INDEX ohora.PK_oh_usr
   ON ohora.oh_usr (
      usr_num ASC
   );

ALTER TABLE ohora.oh_usr
   ADD
      CONSTRAINT PK_oh_usr
      PRIMARY KEY (
         usr_num
      );

/* 등급 */
CREATE TABLE ohora.oh_level (
   usr_num NUMBER NOT NULL, /* 회원번호 */
   usr_level NVARCHAR2(6) NOT NULL, /* 등급명 */
   point_rate NUMBER NOT NULL /* 적립율 */
);

COMMENT ON TABLE ohora.oh_level IS '등급';

COMMENT ON COLUMN ohora.oh_level.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_level.usr_level IS '등급명';

COMMENT ON COLUMN ohora.oh_level.point_rate IS '적립율';

CREATE UNIQUE INDEX ohora.PK_oh_level
   ON ohora.oh_level (
      usr_num ASC
   );

ALTER TABLE ohora.oh_level
   ADD
      CONSTRAINT PK_oh_level
      PRIMARY KEY (
         usr_num
      );

/* 배송주소록 */
CREATE TABLE ohora.oh_delivery_list (
   usr_num NUMBER NOT NULL, /* 회원번호 */
   dl_addr VARCHAR2(50 CHAR) NOT NULL, /* 배송주소 */
   dl_phone VARCHAR2(14 CHAR) NOT NULL, /* 휴대전화 */
   dl_tel VARCHAR2(14 CHAR), /* 일반전화 */
   dl_name VARCHAR2(20 CHAR) NOT NULL, /* 수령인 */
   dl_nick VARCHAR2(10 CHAR) NOT NULL, /* 배송지명 */
   dl_dyn CHAR(1 CHAR) /* 기본 배송지 여부 */
);

COMMENT ON TABLE ohora.oh_delivery_list IS '배송주소록';

COMMENT ON COLUMN ohora.oh_delivery_list.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_addr IS '배송주소';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_phone IS '휴대전화';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_tel IS '일반전화';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_name IS '수령인';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_nick IS '배송지명';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_dyn IS '기본 배송지 여부';

CREATE UNIQUE INDEX ohora.PK_oh_delivery_list
   ON ohora.oh_delivery_list (
      usr_num ASC
   );

ALTER TABLE ohora.oh_delivery_list
   ADD
      CONSTRAINT PK_oh_delivery_list
      PRIMARY KEY (
         usr_num
      );

/* 게시판 */
CREATE TABLE ohora.oh_board (
   brd_num NUMBER NOT NULL, /* 글 번호 */
   brd_theme VARCHAR2(20 CHAR), /* 게시판 이름 */
   brd_title VARCHAR2(20 CHAR), /* 제목 */
   brd_content VARCHAR2(500 CHAR), /* 내용 */
   brd_date DATE, /* 작성일 */
   brd_media VARCHAR2(100 CHAR), /* 첨부파일 */
   brd_view NUMBER, /* 조회수 */
   usr_num NUMBER NOT NULL /* 회원번호 */
);

COMMENT ON TABLE ohora.oh_board IS '게시판';

COMMENT ON COLUMN ohora.oh_board.brd_num IS '글 번호';

COMMENT ON COLUMN ohora.oh_board.brd_theme IS '게시판 이름';

COMMENT ON COLUMN ohora.oh_board.brd_title IS '제목';

COMMENT ON COLUMN ohora.oh_board.brd_content IS '내용';

COMMENT ON COLUMN ohora.oh_board.brd_date IS '작성일';

COMMENT ON COLUMN ohora.oh_board.brd_media IS '첨부파일';

COMMENT ON COLUMN ohora.oh_board.brd_view IS '조회수';

COMMENT ON COLUMN ohora.oh_board.usr_num IS '회원번호';

CREATE UNIQUE INDEX ohora.PK_oh_board
   ON ohora.oh_board (
      brd_num ASC
   );

ALTER TABLE ohora.oh_board
   ADD
      CONSTRAINT PK_oh_board
      PRIMARY KEY (
         brd_num
      );

/* 댓글 */
CREATE TABLE ohora.oh_comments (
   co_num NUMBER NOT NULL, /* 댓글 번호 */
   co_content VARCHAR2(100 CHAR), /* 내용 */
   usr_num NUMBER NOT NULL /* 회원번호 */
);

COMMENT ON TABLE ohora.oh_comments IS '댓글';

COMMENT ON COLUMN ohora.oh_comments.co_num IS '댓글 번호';

COMMENT ON COLUMN ohora.oh_comments.co_content IS '내용';

COMMENT ON COLUMN ohora.oh_comments.usr_num IS '회원번호';

CREATE UNIQUE INDEX ohora.PK_oh_comments
   ON ohora.oh_comments (
      co_num ASC
   );

ALTER TABLE ohora.oh_comments
   ADD
      CONSTRAINT PK_oh_comments
      PRIMARY KEY (
         co_num
      );

/* 리뷰 */
CREATE TABLE ohora.oh_review (
   rv_num NUMBER NOT NULL, /* 리뷰 번호 */
   rv_title VARCHAR2(20 CHAR) NOT NULL, /* 제목 */
   rv_content VARCHAR2(100 CHAR) NOT NULL, /* 내용 */
   rv_media VARCHAR2(100 CHAR), /* 이미지/영상 */
   rv_date DATE, /* 작성일자 */
   rv_score NUMBER, /* 평점(별점) */
   rv_like NUMBER, /* 추천(도움돼요) */
   rv_rank NUMBER NOT NULL, /* 순위 */
   usr_num NUMBER NOT NULL, /* 회원번호 */
   od_num NUMBER, /* 주문번호 */
   pd_num NUMBER NOT NULL /* 상품번호 */
);

COMMENT ON TABLE ohora.oh_review IS '리뷰';

COMMENT ON COLUMN ohora.oh_review.rv_num IS '리뷰 번호';

COMMENT ON COLUMN ohora.oh_review.rv_title IS '제목';

COMMENT ON COLUMN ohora.oh_review.rv_content IS '내용';

COMMENT ON COLUMN ohora.oh_review.rv_media IS '이미지/영상';

COMMENT ON COLUMN ohora.oh_review.rv_date IS '작성일자';

COMMENT ON COLUMN ohora.oh_review.rv_score IS '평점(별점)';

COMMENT ON COLUMN ohora.oh_review.rv_like IS '추천(도움돼요)';

COMMENT ON COLUMN ohora.oh_review.rv_rank IS '순위';

COMMENT ON COLUMN ohora.oh_review.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_review.od_num IS '주문번호';

COMMENT ON COLUMN ohora.oh_review.pd_num IS '상품번호';

CREATE UNIQUE INDEX ohora.PK_oh_review
   ON ohora.oh_review (
      rv_num ASC
   );

ALTER TABLE ohora.oh_review
   ADD
      CONSTRAINT PK_oh_review
      PRIMARY KEY (
         rv_num
      );

/* 적립금 */
CREATE TABLE ohora.oh_point (
   usr_num NUMBER NOT NULL, /* 회원번호 */
   pt_date DATE NOT NULL, /* 적립일 */
   pt_point NUMBER, /* 적립액 */
   usr_level VARCHAR2(6), /* 등급명 */
   rv_num NUMBER /* 리뷰 번호 */
);

COMMENT ON TABLE ohora.oh_point IS '적립금';

COMMENT ON COLUMN ohora.oh_point.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_point.pt_date IS '적립일';

COMMENT ON COLUMN ohora.oh_point.pt_point IS '적립액';

COMMENT ON COLUMN ohora.oh_point.usr_level IS '등급명';

COMMENT ON COLUMN ohora.oh_point.rv_num IS '리뷰 번호';

CREATE UNIQUE INDEX ohora.PK_oh_point
   ON ohora.oh_point (
      usr_num ASC
   );

ALTER TABLE ohora.oh_point
   ADD
      CONSTRAINT PK_oh_point
      PRIMARY KEY (
         usr_num
      );

/* 쿠폰 */
CREATE TABLE ohora.oh_coupon (
   cp_num NUMBER NOT NULL, /* 쿠폰번호 */
   cp_name VARCHAR2(50 CHAR) NOT NULL, /* 쿠폰 이름 */
   cp_rate NUMBER, /* 쿠폰 할인율 */
   usr_num NUMBER NOT NULL, /* 회원번호 */
   cr_num NUMBER NOT NULL /* 쿠폰조건번호 */
);

COMMENT ON TABLE ohora.oh_coupon IS '쿠폰';

COMMENT ON COLUMN ohora.oh_coupon.cp_num IS '쿠폰번호';

COMMENT ON COLUMN ohora.oh_coupon.cp_name IS '쿠폰 이름';

COMMENT ON COLUMN ohora.oh_coupon.cp_rate IS '쿠폰 할인율';

COMMENT ON COLUMN ohora.oh_coupon.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_coupon.cr_num IS '쿠폰조건번호';

CREATE UNIQUE INDEX ohora.PK_oh_coupon
   ON ohora.oh_coupon (
      cp_num ASC
   );

ALTER TABLE ohora.oh_coupon
   ADD
      CONSTRAINT PK_oh_coupon
      PRIMARY KEY (
         cp_num
      );

/* 쿠폰조건 */
CREATE TABLE ohora.oh_cpn_req (
   cr_num NUMBER NOT NULL, /* 쿠폰조건번호 */
   cr_date DATE NOT NULL, /* 유효기간 */
   cr_ratio NUMBER, /* 쿠폰 할인율 */
   cr_price NUMBER, /* 금액 조건 */
   cr_product VARCHAR2(50 CHAR), /* 적용 대상 */
   od_num NUMBER NOT NULL, /* 주문번호 */
   pd_num NUMBER NOT NULL /* 상품번호 */
);

COMMENT ON TABLE ohora.oh_cpn_req IS '쿠폰조건';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_num IS '쿠폰조건번호';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_date IS '유효기간';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_ratio IS '쿠폰 할인율';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_price IS '금액 조건';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_product IS '적용 대상';

COMMENT ON COLUMN ohora.oh_cpn_req.od_num IS '주문번호';

COMMENT ON COLUMN ohora.oh_cpn_req.pd_num IS '상품번호';

CREATE UNIQUE INDEX ohora.PK_oh_cpn_req
   ON ohora.oh_cpn_req (
      cr_num ASC
   );

ALTER TABLE ohora.oh_cpn_req
   ADD
      CONSTRAINT PK_oh_cpn_req
      PRIMARY KEY (
         cr_num
      );

/* 주문 */
CREATE TABLE ohora.oh_order (
   od_num NUMBER NOT NULL, /* 주문번호 */
   od_date DATE NOT NULL, /* 주문일자 */
   od_price NUMBER, /* 상품금액 */
   od_status CHAR(1 CHAR) NOT NULL, /* 주문 처리상태 */
   od_cancel VARCHAR2(2 CHAR), /* 취소/교환/반품 처리상태 */
   usr_num NUMBER NOT NULL, /* 회원번호 */
   pd_num NUMBER NOT NULL, /* 상품번호 */
   cart_num NUMBER /* 장바구니번호 */
);

ALTER TABLE oh_order
   MODIFY od_status VARCHAR2(10 chAR);

COMMENT ON TABLE ohora.oh_order IS '주문';

COMMENT ON COLUMN ohora.oh_order.od_num IS '주문번호';

COMMENT ON COLUMN ohora.oh_order.od_date IS '주문일자';

COMMENT ON COLUMN ohora.oh_order.od_price IS '상품금액';

COMMENT ON COLUMN ohora.oh_order.od_status IS '주문 처리상태';

COMMENT ON COLUMN ohora.oh_order.od_cancel IS '취소/교환/반품 처리상태';

COMMENT ON COLUMN ohora.oh_order.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_order.pd_num IS '상품번호';

COMMENT ON COLUMN ohora.oh_order.cart_num IS '장바구니번호';

CREATE UNIQUE INDEX ohora.PK_oh_order
   ON ohora.oh_order (
      od_num ASC
   );

ALTER TABLE ohora.oh_order
   ADD
      CONSTRAINT PK_oh_order
      PRIMARY KEY (
         od_num
      );

/* 사은품 조건 */
CREATE TABLE ohora.oh_gift (
   usr_num NUMBER NOT NULL, /* 회원번호 */
   pd_num NUMBER NOT NULL, /* 상품번호 */
   od_num NUMBER NOT NULL, /* 주문번호 */
   gift_price NUMBER /* 사은품 가격 */
);

COMMENT ON TABLE ohora.oh_gift IS '사은품 조건';

COMMENT ON COLUMN ohora.oh_gift.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_gift.pd_num IS '상품번호';

COMMENT ON COLUMN ohora.oh_gift.od_num IS '주문번호';

COMMENT ON COLUMN ohora.oh_gift.gift_price IS '사은품 가격';

CREATE UNIQUE INDEX ohora.PK_oh_gift
   ON ohora.oh_gift (
      usr_num ASC
   );

ALTER TABLE ohora.oh_gift
   ADD
      CONSTRAINT PK_oh_gift
      PRIMARY KEY (
         usr_num
      );

/* 장바구니 */
CREATE TABLE ohora.oh_cart (
   cart_num NUMBER NOT NULL, /* 장바구니번호 */
   usr_num NUMBER NOT NULL, /* 회원번호 */
   pd_num NUMBER, /* 상품번호 */
   cart_pdcnt NUMBER /* 상품수량 */
);

COMMENT ON TABLE ohora.oh_cart IS '장바구니';

COMMENT ON COLUMN ohora.oh_cart.cart_num IS '장바구니번호';

COMMENT ON COLUMN ohora.oh_cart.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_cart.pd_num IS '상품번호';

COMMENT ON COLUMN ohora.oh_cart.cart_pdcnt IS '상품수량';

CREATE UNIQUE INDEX ohora.PK_oh_cart
   ON ohora.oh_cart (
      cart_num ASC
   );

ALTER TABLE ohora.oh_cart
   ADD
      CONSTRAINT PK_oh_cart
      PRIMARY KEY (
         cart_num
      );

/* 상품 */
CREATE TABLE ohora.oh_product (
   pd_num NUMBER NOT NULL, /* 상품번호 */
   pd_name VARCHAR2(50 CHAR) NOT NULL, /* 상품명 */
   pd_date DATE, /* 출시일 */
   pd_stock NUMBER, /* 재고수 */
   pd_price NUMBER, /* 정가 */
   pd_dc_price NUMBER, /* 할인가 */
   pd_view NUMBER, /* 조회수 */
   pd_media VARCHAR2(100 CHAR), /* 썸네일 */
   pd_dc_rate NUMBER, /* 자체 할인율 */
   pd_tot_buy NUMBER /* 총 구매수(상품 인기도) */
);

COMMENT ON TABLE ohora.oh_product IS '상품';

COMMENT ON COLUMN ohora.oh_product.pd_num IS '상품번호';

COMMENT ON COLUMN ohora.oh_product.pd_name IS '상품명';

COMMENT ON COLUMN ohora.oh_product.pd_date IS '출시일';

COMMENT ON COLUMN ohora.oh_product.pd_stock IS '재고수';

COMMENT ON COLUMN ohora.oh_product.pd_price IS '정가';

COMMENT ON COLUMN ohora.oh_product.pd_dc_price IS '할인가';

COMMENT ON COLUMN ohora.oh_product.pd_view IS '조회수';

COMMENT ON COLUMN ohora.oh_product.pd_media IS '썸네일';

COMMENT ON COLUMN ohora.oh_product.pd_dc_rate IS '자체 할인율';

COMMENT ON COLUMN ohora.oh_product.pd_tot_buy IS '총 구매수(상품 인기도)';

CREATE UNIQUE INDEX ohora.PK_oh_product
   ON ohora.oh_product (
      pd_num ASC
   );

ALTER TABLE ohora.oh_product
   ADD
      CONSTRAINT PK_oh_product
      PRIMARY KEY (
         pd_num
      );

/* 디자인 */
CREATE TABLE ohora.oh_mydesign (
   pd_num NUMBER NOT NULL, /* 상품번호 */
   pmd_hashtag VARCHAR2(10 CHAR) NOT NULL, /* 해시태그 */
   pmd_lineup VARCHAR2(10 CHAR), /* 라인업 */
   pmd_color VARCHAR2(10 CHAR), /* 컬러 */
   pmd_design VARCHAR2(10 CHAR) /* 디자인 */
);

ALTER TABLE oh_mydesign
DROP PRIMARY KEY;

ALTER TABLE oh_mydesign MODIFY pmd_hashtag NULL;

ALTER TABLE oh_mydesign
MODIFY od_status VARCHAR2(10);

COMMENT ON TABLE ohora.oh_mydesign IS '디자인';

COMMENT ON COLUMN ohora.oh_mydesign.pmd_hashtag IS '해시태그';

COMMENT ON COLUMN ohora.oh_mydesign.pd_num IS '상품번호';

COMMENT ON COLUMN ohora.oh_mydesign.pmd_lineup IS '라인업';

COMMENT ON COLUMN ohora.oh_mydesign.pmd_color IS '컬러';

COMMENT ON COLUMN ohora.oh_mydesign.pmd_design IS '디자인';

CREATE UNIQUE INDEX ohora.PK_oh_mydesign
   ON ohora.oh_mydesign (
      pmd_hashtag ASC,
      pd_num ASC
   );

ALTER TABLE ohora.oh_mydesign
   ADD
      CONSTRAINT PK_oh_mydesign
      PRIMARY KEY (
         pmd_hashtag,
         pd_num
      );

/* 카테고리 */
CREATE TABLE ohora.oh_category (
   pd_num NUMBER NOT NULL, /* 상품번호 */
   pc_fir VARCHAR2(20 CHAR) NOT NULL, /* 대분류 */
   pc_sec VARCHAR2(20 CHAR), /* 중분류 */
   pc_thd VARCHAR2(20 CHAR) /* 소분류 */
);

COMMENT ON TABLE ohora.oh_category IS '카테고리';

COMMENT ON COLUMN ohora.oh_category.pd_num IS '상품번호';

COMMENT ON COLUMN ohora.oh_category.pc_fir IS '대분류';

COMMENT ON COLUMN ohora.oh_category.pc_sec IS '중분류';

COMMENT ON COLUMN ohora.oh_category.pc_thd IS '소분류';

CREATE UNIQUE INDEX ohora.PK_oh_category
   ON ohora.oh_category (
      pd_num ASC
   );

ALTER TABLE ohora.oh_category
   ADD
      CONSTRAINT PK_oh_category
      PRIMARY KEY (
         pd_num
      );

/* 주문 상세 */
CREATE TABLE ohora.oh_order_sub (
   os_num NUMBER NOT NULL, /* 주문 상세 번호 */
   od_num NUMBER, /* 주문번호 */
   os_price NUMBER, /* 상품금액 */
   os_pay_delivery NUMBER, /* 배송비 */
   os_name VARCHAR2(50 CHAR) /* 상품 이름 */
);

COMMENT ON TABLE ohora.oh_order_sub IS '주문 상세';

COMMENT ON COLUMN ohora.oh_order_sub.os_num IS '주문 상세 번호';

COMMENT ON COLUMN ohora.oh_order_sub.od_num IS '주문번호';

COMMENT ON COLUMN ohora.oh_order_sub.os_price IS '상품금액';

COMMENT ON COLUMN ohora.oh_order_sub.os_pay_delivery IS '배송비';

COMMENT ON COLUMN ohora.oh_order_sub.os_name IS '상품 이름';

CREATE UNIQUE INDEX ohora.PK_oh_order_sub
   ON ohora.oh_order_sub (
      os_num ASC
   );

ALTER TABLE ohora.oh_order_sub
   ADD
      CONSTRAINT PK_oh_order_sub
      PRIMARY KEY (
         os_num
      );

/* 결제 */
CREATE TABLE ohora.oh_pay (
   pay_num NUMBER NOT NULL, /* 결제번호 */
   od_num NUMBER NOT NULL, /* 주문번호 */
   usr_num NUMBER NOT NULL, /* 회원번호 */
   cp_num NUMBER NOT NULL, /* 쿠폰번호 */
   pay_way VARCHAR2(20 CHAR), /* 결제수단이름 */
   pay_date DATE, /* 결제일자 */
   pay_delivery NUMBER /* 배송비 */
);

COMMENT ON TABLE ohora.oh_pay IS '결제';

COMMENT ON COLUMN ohora.oh_pay.pay_num IS '결제번호';

COMMENT ON COLUMN ohora.oh_pay.od_num IS '주문번호';

COMMENT ON COLUMN ohora.oh_pay.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_pay.cp_num IS '쿠폰번호';

COMMENT ON COLUMN ohora.oh_pay.pay_way IS '결제수단이름';

COMMENT ON COLUMN ohora.oh_pay.pay_date IS '결제일자';

COMMENT ON COLUMN ohora.oh_pay.pay_delivery IS '배송비';

CREATE UNIQUE INDEX ohora.PK_oh_pay
   ON ohora.oh_pay (
      pay_num ASC
   );

ALTER TABLE ohora.oh_pay
   ADD
      CONSTRAINT PK_oh_pay
      PRIMARY KEY (
         pay_num
      );

/* 배송 */
CREATE TABLE ohora.oh_delivery (
   d_num NUMBER NOT NULL, /* 운송장 번호 */
   d_finish DATE, /* 배송 완료일 */
   d_start DATE, /* 배송 시작일 */
   d_status VARCHAR2(20 CHAR), /* 배송 상태 */
   usr_num NUMBER NOT NULL /* 회원번호 */
);

COMMENT ON TABLE ohora.oh_delivery IS '배송';

COMMENT ON COLUMN ohora.oh_delivery.d_num IS '운송장 번호';

COMMENT ON COLUMN ohora.oh_delivery.d_finish IS '배송 완료일';

COMMENT ON COLUMN ohora.oh_delivery.d_start IS '배송 시작일';

COMMENT ON COLUMN ohora.oh_delivery.d_status IS '배송 상태';

COMMENT ON COLUMN ohora.oh_delivery.usr_num IS '회원번호';

CREATE UNIQUE INDEX ohora.PK_oh_delivery
   ON ohora.oh_delivery (
      d_num ASC
   );

ALTER TABLE ohora.oh_delivery
   ADD
      CONSTRAINT PK_oh_delivery
      PRIMARY KEY (
         d_num
      );

/* 취소/교환/반품 */
CREATE TABLE ohora.oh_order_cncl (
   od_num NUMBER NOT NULL, /* 주문번호 */
   pd_num NUMBER NOT NULL, /* 상품번호 */
   oc_reason VARCHAR2(20 CHAR), /* 상세 사유 */
   oc_check VARCHAR2(20 CHAR) NOT NULL, /* 사유 선택 */
   oc_status VARCHAR2(20 CHAR), /* 진행 상태 */
   oc_cnt NUMBER /* 취소 수량 */
);

COMMENT ON TABLE ohora.oh_order_cncl IS '취소/교환/반품';

COMMENT ON COLUMN ohora.oh_order_cncl.od_num IS '주문번호';

COMMENT ON COLUMN ohora.oh_order_cncl.pd_num IS '상품번호';

COMMENT ON COLUMN ohora.oh_order_cncl.oc_reason IS '상세 사유';

COMMENT ON COLUMN ohora.oh_order_cncl.oc_check IS '사유 선택';

COMMENT ON COLUMN ohora.oh_order_cncl.oc_status IS '진행 상태';

COMMENT ON COLUMN ohora.oh_order_cncl.oc_cnt IS '취소 수량';

CREATE UNIQUE INDEX ohora.PK_oh_order_cncl
   ON ohora.oh_order_cncl (
      od_num ASC,
      pd_num ASC
   );

ALTER TABLE ohora.oh_order_cncl
   ADD
      CONSTRAINT PK_oh_order_cncl
      PRIMARY KEY (
         od_num,
         pd_num
      );

/* 권한 */
CREATE TABLE ohora.oh_roles (
   usr_num NUMBER NOT NULL, /* 회원번호 */
   role_name VARCHAR2(10 CHAR) /* 권한이름 */
);

COMMENT ON TABLE ohora.oh_roles IS '권한';

COMMENT ON COLUMN ohora.oh_roles.usr_num IS '회원번호';

COMMENT ON COLUMN ohora.oh_roles.role_name IS '권한이름';

CREATE UNIQUE INDEX ohora.PK_oh_roles
   ON ohora.oh_roles (
      usr_num ASC
   );

ALTER TABLE ohora.oh_roles
   ADD
      CONSTRAINT PK_oh_roles
      PRIMARY KEY (
         usr_num
      );

/* 결제수단 */
CREATE TABLE ohora.oh_pay_type (
   pay_way VARCHAR2(20 CHAR) NOT NULL, /* 결제수단이름 */
   od_num NUMBER /* 주문번호 */
);

COMMENT ON TABLE ohora.oh_pay_type IS '결제수단';

COMMENT ON COLUMN ohora.oh_pay_type.pay_way IS '결제수단이름';

COMMENT ON COLUMN ohora.oh_pay_type.od_num IS '주문번호';

CREATE UNIQUE INDEX ohora.PK_oh_pay_type
   ON ohora.oh_pay_type (
      pay_way ASC
   );

ALTER TABLE ohora.oh_pay_type
   ADD
      CONSTRAINT PK_oh_pay_type
      PRIMARY KEY (
         pay_way
      );

ALTER TABLE ohora.oh_level
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_level
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_delivery_list
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_delivery_list
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_board
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_board
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_comments
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_comments
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_review
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_review
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_review
   ADD
      CONSTRAINT FK_oh_order_TO_oh_review
      FOREIGN KEY (
         od_num
      )
      REFERENCES ohora.oh_order (
         od_num
      );

ALTER TABLE ohora.oh_review
   ADD
      CONSTRAINT FK_oh_product_TO_oh_review
      FOREIGN KEY (
         pd_num
      )
      REFERENCES ohora.oh_product (
         pd_num
      );

ALTER TABLE ohora.oh_point
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_point
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_point
   ADD
      CONSTRAINT FK_oh_review_TO_oh_point
      FOREIGN KEY (
         rv_num
      )
      REFERENCES ohora.oh_review (
         rv_num
      );

ALTER TABLE ohora.oh_coupon
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_coupon
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_coupon
   ADD
      CONSTRAINT FK_oh_cpn_req_TO_oh_coupon
      FOREIGN KEY (
         cr_num
      )
      REFERENCES ohora.oh_cpn_req (
         cr_num
      );

ALTER TABLE ohora.oh_cpn_req
   ADD
      CONSTRAINT FK_oh_order_TO_oh_cpn_req
      FOREIGN KEY (
         od_num
      )
      REFERENCES ohora.oh_order (
         od_num
      );

ALTER TABLE ohora.oh_cpn_req
   ADD
      CONSTRAINT FK_oh_product_TO_oh_cpn_req
      FOREIGN KEY (
         pd_num
      )
      REFERENCES ohora.oh_product (
         pd_num
      );

ALTER TABLE ohora.oh_order
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_order
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_order
   ADD
      CONSTRAINT FK_oh_product_TO_oh_order
      FOREIGN KEY (
         pd_num
      )
      REFERENCES ohora.oh_product (
         pd_num
      );

ALTER TABLE ohora.oh_order
   ADD
      CONSTRAINT FK_oh_cart_TO_oh_order
      FOREIGN KEY (
         cart_num
      )
      REFERENCES ohora.oh_cart (
         cart_num
      );

ALTER TABLE ohora.oh_gift
   ADD
      CONSTRAINT FK_oh_product_TO_oh_gift
      FOREIGN KEY (
         pd_num
      )
      REFERENCES ohora.oh_product (
         pd_num
      );

ALTER TABLE ohora.oh_gift
   ADD
      CONSTRAINT FK_oh_order_TO_oh_gift
      FOREIGN KEY (
         od_num
      )
      REFERENCES ohora.oh_order (
         od_num
      );

ALTER TABLE ohora.oh_gift
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_gift
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_cart
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_cart
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_cart
   ADD
      CONSTRAINT FK_oh_product_TO_oh_cart
      FOREIGN KEY (
         pd_num
      )
      REFERENCES ohora.oh_product (
         pd_num
      );

ALTER TABLE ohora.oh_mydesign
   ADD
      CONSTRAINT FK_oh_product_TO_oh_mydesign
      FOREIGN KEY (
         pd_num
      )
      REFERENCES ohora.oh_product (
         pd_num
      );

ALTER TABLE ohora.oh_category
   ADD
      CONSTRAINT FK_oh_product_TO_oh_category
      FOREIGN KEY (
         pd_num
      )
      REFERENCES ohora.oh_product (
         pd_num
      );

ALTER TABLE ohora.oh_order_sub
   ADD
      CONSTRAINT FK_oh_order_TO_oh_order_sub
      FOREIGN KEY (
         od_num
      )
      REFERENCES ohora.oh_order (
         od_num
      );

ALTER TABLE ohora.oh_pay
   ADD
      CONSTRAINT FK_oh_order_TO_oh_pay
      FOREIGN KEY (
         od_num
      )
      REFERENCES ohora.oh_order (
         od_num
      );

ALTER TABLE ohora.oh_pay
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_pay
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_pay
   ADD
      CONSTRAINT FK_oh_coupon_TO_oh_pay
      FOREIGN KEY (
         cp_num
      )
      REFERENCES ohora.oh_coupon (
         cp_num
      );

ALTER TABLE ohora.oh_pay
   ADD
      CONSTRAINT FK_oh_pay_type_TO_oh_pay
      FOREIGN KEY (
         pay_way
      )
      REFERENCES ohora.oh_pay_type (
         pay_way
      );

ALTER TABLE ohora.oh_delivery
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_delivery
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_order_cncl
   ADD
      CONSTRAINT FK_oh_order_TO_oh_order_cncl
      FOREIGN KEY (
         od_num
      )
      REFERENCES ohora.oh_order (
         od_num
      );

ALTER TABLE ohora.oh_order_cncl
   ADD
      CONSTRAINT FK_oh_product_TO_oh_order_cncl
      FOREIGN KEY (
         pd_num
      )
      REFERENCES ohora.oh_product (
         pd_num
      );

ALTER TABLE ohora.oh_roles
   ADD
      CONSTRAINT FK_oh_usr_TO_oh_roles
      FOREIGN KEY (
         usr_num
      )
      REFERENCES ohora.oh_usr (
         usr_num
      );

ALTER TABLE ohora.oh_pay_type
   ADD
      CONSTRAINT FK_oh_order_TO_oh_pay_type
      FOREIGN KEY (
         od_num
      )
      REFERENCES ohora.oh_order (
         od_num
      );
      
--------------------------------------------------------------------------------
--더미데이터
INSERT INTO oh_usr (USR_NUM, USR_ID, USR_TEL, USR_PHONE, USR_NAME, USR_EMAIL, USR_EMAIL_YN, USR_SMS_YN, USR_LEVEL, USR_BIRTH, USR_PW)
VALUES (1, 'asdf', '1234', '1234', '최사랑', 'emailass', 'y', 'n', 'CREW', '1998-02-05', 'AApass'); 

INSERT INTO oh_usr (USR_NUM, USR_ID, USR_TEL, USR_PHONE, USR_NAME, USR_EMAIL, USR_EMAIL_YN, USR_SMS_YN, USR_LEVEL, USR_BIRTH, USR_PW)
VALUES (2, 'qwer', '5678', '5678', '김준석', 'testemail', 'n', 'y', 'FRIEND', '2000-02-25', 'PWPW'); 

--

INSERT INTO OH_PRODUCT (PD_NUM, PD_NAME, PD_DATE, PD_STOCK, PD_PRICE, PD_DC_PRICE, PD_VIEW, PD_MEDIA, PD_DC_RATE, PD_TOT_BUY)
VALUES (1, '물방울젤네일팁', '2024-01-01', 99, 12000, 9600, 15000, 'IMAGE' , 20, 100);

INSERT INTO OH_PRODUCT (PD_NUM, PD_NAME, PD_DATE, PD_STOCK, PD_PRICE, PD_DC_PRICE, PD_VIEW, PD_MEDIA, PD_DC_RATE, PD_TOT_BUY)
VALUES (2, '불꽃패디큐어', '2024-02-01', 88, 10000, 9000, 20000, 'IMAGE' , 10, 50);

INSERT INTO OH_PRODUCT (PD_NUM, PD_NAME, PD_DATE, PD_STOCK, PD_PRICE, PD_DC_PRICE, PD_VIEW, PD_MEDIA, PD_DC_RATE, PD_TOT_BUY)
VALUES (3, '내집마련', '2024-02-14', 5, 200000, 180000, 50000, 'IMAGE' , 10, 3);

--

INSERT INTO OH_CART (CART_NUM, USR_NUM) VALUES (1, 1);

INSERT INTO OH_CART (CART_NUM, USR_NUM, PD_NUM, CART_PDCNT) VALUES (2, 2, 3, 1);

INSERT INTO OH_CART (CART_NUM, USR_NUM, PD_NUM, CART_PDCNT) VALUES (3, 1, 3, 1);

--

INSERT INTO OH_ORDER (OD_NUM, OD_DATE, OD_PRICE, OD_STATUS, OD_CANCEL, USR_NUM, PD_NUM, CART_NUM) 
VALUES (4, '2024-08-25', 9600, '배송중', 'X', 1, 1, 1); 
-- ( 아마 즉시구매 상황에서 ? ) 위 코드 추가시
INSERT INTO OH_CART_PRDT (cart_num, cart_pd_num, cart_pdcnt)
VALUES (1, 1, 1); 
--이것까지 추가되는 프로시저를 만들어야함
INSERT INTO OH_CART_PRDT (cart_num, cart_pd_num, cart_pdcnt)
VALUES (1, 2, 2); 
--이렇게 하면 같은 장바구니에 다른 상품을 담은 상황 가능해짐

INSERT INTO OH_ORDER (OD_NUM, OD_DATE, OD_PRICE, OD_STATUS, OD_CANCEL, USR_NUM, PD_NUM, CART_NUM) 
VALUES (2, '2024-08-28', 9000, '상품준비중', 'X', 2, 2, 2); 

INSERT INTO OH_ORDER (OD_NUM, OD_DATE, OD_PRICE, OD_STATUS, OD_CANCEL, USR_NUM, PD_NUM, CART_NUM) 
VALUES (3, '2024-08-28', 180000, '상품준비중', 'X', 1, 3, 3); 

--

INSERT INTO oh_product VALUES(4,'럭키 판다 네일',SYSDATE-30,312,16800,13440,5,'이미지',20,123);
INSERT INTO oh_category VALUES(4,'네일','젤네일팁','숏');
INSERT INTO oh_mydesign VALUES('0531',4,'아트','코랄핑크','시럽');
INSERT INTO oh_product VALUES(5,'젤리 피치 네일',SYSDATE-50,98,16800,13440,6,'이미지',20,54);
INSERT INTO oh_category VALUES(5,'네일','젤스트립','데일리');
INSERT INTO oh_mydesign VALUES('0531',5,'파츠','블랙','버건디');
INSERT INTO oh_product VALUES(6,'썸데이 네일',SYSDATE-75,77,14800,11840,3,'이미지',20,65);
INSERT INTO oh_category VALUES(6,'네일','젤네일팁','풀컬러');
INSERT INTO oh_mydesign VALUES('연말,파란색,플라워',6,'풀컬러','브라운','프렌치');
INSERT INTO oh_product VALUES(7,'티니 네일',SYSDATE-22,456,14800,11840,3,'이미지',20,76);
INSERT INTO oh_category VALUES(7,'네일','젤네일팁','시럽');
INSERT INTO oh_mydesign VALUES('웨딩,파란색,플라워',7,'아트','화이트','자개');
INSERT INTO oh_product VALUES(8,'글로우 빔 페디',SYSDATE-55,144,14800,11840,3,'이미지',20,76);
INSERT INTO oh_category VALUES(8,'페디','젤스트립','키치');
INSERT INTO oh_mydesign VALUES('분홍,치크',8,'파츠','골드','벨벳');
INSERT INTO oh_product VALUES(9,'글리터 샤워 페디',SYSDATE-88,654,12800,10840,3,'이미지',15,22);
INSERT INTO oh_category VALUES(9,'페디','젤스트립','웨딩');
INSERT INTO oh_mydesign VALUES('봄네일, 노랑',9,'아트','옐로우','프렌치');

--08/29
ALTER TABLE OH_REVIEW
MODIFY RV_CONTENT VARCHAR2(2000 CHAR);

ALTER TABLE OH_COMMENTS
MODIFY CO_CONTENT VARCHAR2(2000 CHAR);

ALTER TABLE OH_BOARD
MODIFY BRD_CONTENT VARCHAR2(2000 CHAR);

CREATE SEQUENCE rv_num_seq  --리뷰 넘버 시퀀스 생성
INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

ALTER TABLE oh_usr  --회원 아이디에 유니크 조건 좀 주겠습니다
ADD CONSTRAINT unique_user_id UNIQUE (usr_id);


ALTER TABLE OH_ORDER
DROP CONSTRAINT FK_OH_USR_TO_OH_ORDER;
ALTER TABLE OH_ORDER
ADD CONSTRAINT FK_OH_USR_TO_OH_ORDER
FOREIGN KEY (USR_NUM) REFERENCES OH_USR (USR_NUM)
ON DELETE SET NULL; --일단 오더 테이블의 유저넘버는 널 가능하게 만들어줌


ALTER TABLE OH_ORDER
DROP CONSTRAINT FK_OH_CART_TO_OH_ORDER;
ALTER TABLE OH_ORDER
ADD CONSTRAINT FK_OH_CART_TO_OH_ORDER
FOREIGN KEY (CART_NUM) REFERENCES OH_CART (CART_NUM)
ON DELETE SET NULL; --카트에서 회원번호 지우면 오더 전부 날리는게 아니라 회원번호만 널처리

--그럼 오더의 회원번호는 널도 받을 수 있어야함
ALTER TABLE ohora.oh_order MODIFY usr_num NUMBER NULL;

--카트 품목 테이블 따로 빼기

CREATE TABLE oh_cart_prdt
(
    cart_num NUMBER ,
    cart_pd_num NUMBER ,
    cart_pdcnt NUMBER ,
    
    CONSTRAINT fk_oh_cart_to_oh_cart_prdt FOREIGN KEY(cart_num) REFERENCES oh_cart (cart_num)
    ON DELETE CASCADE --카트번호 지워지면 품목들 자동 삭제
);

ALTER TABLE oh_cart DROP COLUMN pd_num;
ALTER TABLE oh_cart DROP COLUMN cart_pdcnt;

--------------------------------------------------------------------------------
-- 회원가입 

CREATE SEQUENCE usr_num_seq --회원번호
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 1000
    NOCYCLE
    ORDER
    NOCACHE;


CREATE OR REPLACE PROCEDURE usr_sign_up --회원가입
(
    pusr_id oh_usr.usr_id%TYPE --nn 유저 ID
    , pusr_pw oh_usr.usr_pw%TYPE -- 유저 비밀번호
    , pusr_pw_ck oh_usr.usr_pw%TYPE -- 유저 비밀번호 확인
    , pusr_name oh_usr.usr_name%TYPE --nn 유저 이름
    , pusr_phone oh_usr.usr_name%TYPE -- 유저 폰번호
    , pusr_EMAIL oh_usr.usr_email%TYPE --nn 유저 이메일 주소
    , pusr_EMAIL_YN oh_usr.usr_email_yn%TYPE -- 유저 이메일 수신 동의
    , pusr_SMS_YN oh_usr.usr_sms_yn%TYPE -- 유저 문자수신 동의

)
IS
    vusr_id oh_usr.usr_id%TYPE; --nn 유저 ID
    vusr_pw oh_usr.usr_pw%TYPE; -- 유저 비밀번호
   -- vusr_pw_ck oh_usr.usr_pw%TYPE; -- 유저 비밀번호 확인
    vusr_name oh_usr.usr_name%TYPE; --nn 유저 이름
    vusr_phone oh_usr.usr_name%TYPE ;-- 유저 폰번호
    vusr_SMS_YN oh_usr.usr_sms_yn%TYPE; -- 유저 문자수신 동의
    vusr_EMAIL oh_usr.usr_email%TYPE; --nn 유저 이메일 주소
    vusr_EMAIL_YN oh_usr.usr_email_yn%TYPE; -- 유저 이메일 수신 동의
    
   -- vcheck_id oh_usr.usr_id%TYPE; --아이디 중복 체크용

    WRONG_ID_TYPE EXCEPTION;
    WRONG_PW_TYPE EXCEPTION;
    WRONG_PW_CK EXCEPTION;
    WRONG_PHONE EXCEPTION;
    WRONG_EMAIL EXCEPTION;
BEGIN


-- ID 조건 체크

IF REGEXP_LIKE( pusr_id , '^[a-z][0-9a-z]*$' )
AND LENGTH(pusr_id) >= 4 
AND LENGTH(pusr_id) <= 16
THEN vusr_id := pusr_id;
DBMS_OUTPUT.PUT_LINE ( vusr_id );

ELSE RAISE WRONG_ID_TYPE;

END IF;


-- 비밀번호 입력
IF REGEXP_LIKE(pusr_pw, '\s+') THEN  RAISE WRONG_PW_TYPE; --공백포함
ELSIF LENGTH(pusr_pw) < 8 OR LENGTH(pusr_pw) > 16  THEN  RAISE WRONG_PW_TYPE; --길이 불만족
ELSIF REGEXP_LIKE(pusr_pw, '^[a-zA-Z]+$')  THEN RAISE WRONG_PW_TYPE; --문자만
ELSIF REGEXP_LIKE(pusr_pw, '^[0-9]+$')  THEN RAISE WRONG_PW_TYPE; --숫자만
ELSIF REGEXP_LIKE(pusr_pw, '^[@!#$%^&*()_+]+$')  THEN RAISE WRONG_PW_TYPE; --기호만
ELSE vusr_pw := pusr_pw;

--DBMS_OUTPUT.PUT_LINE ( vusr_pw );

--ELSE RAISE WRONG_PW_TYPE;
END IF;


--비밀번호 확인
IF pusr_pw_ck != pusr_pw THEN RAISE WRONG_PW_CK;
END IF;

--이름 입력
vusr_name := pusr_name;
--DBMS_OUTPUT.PUT_LINE ( '이름 : '|| vusr_name );

--폰번호 입력
IF REGEXP_LIKE(pusr_phone , '^(010|011)\d{7,8}') 
THEN vusr_phone := pusr_phone;
--DBMS_OUTPUT.PUT_LINE ( '폰번 : '|| vusr_phone );
ELSE RAISE WRONG_PHONE;
END IF;

--메일 입력
IF REGEXP_LIKE(pusr_pw, '\s+') THEN  RAISE WRONG_EMAIL; --공백포함
ELSIF REGEXP_LIKE ( pusr_email , '\.\.' ) THEN  RAISE WRONG_EMAIL; --연속 .
ELSIF REGEXP_LIKE ( pusr_email , '^[A-Za-z0-9._-]+@[A-Za-z0-9.]+\.[A-Za-z]{2,}' )
THEN vusr_email := pusr_email;
--DBMS_OUTPUT.PUT_LINE ('메일 : ' || vusr_email);
ELSE RAISE WRONG_EMAIL;
END IF;

--약관체크
vusr_email_yn := pusr_email_yn;
--DBMS_OUTPUT.PUT_LINE ('메일 수신 : ' || vusr_email_yn);
vusr_sms_yn := pusr_sms_yn;
--DBMS_OUTPUT.PUT_LINE ('SMS 수신 : ' || vusr_sms_yn);

INSERT INTO oh_usr ( usr_num, usr_id, usr_pw, usr_name, usr_phone, usr_email ,usr_email_yn , usr_sms_yn) 
VALUES ( usr_num_seq.NEXTVAL ,  vusr_id , vusr_pw , vusr_name, vusr_phone, vusr_email, vusr_email_yn, vusr_sms_yn);


EXCEPTION

WHEN WRONG_ID_TYPE THEN
    RAISE_APPLICATION_ERROR(-20001, '> 아이디는 영문 소문자로 시작해야하며, 4~16자의 영어와 소문자로만 구성되어야 합니다.');
WHEN WRONG_PW_TYPE THEN
    RAISE_APPLICATION_ERROR(-20002, '> 비밀번호는 영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자로 구성되어야 합니다.');
WHEN WRONG_PW_CK THEN
    RAISE_APPLICATION_ERROR(-20002, '> 비밀번호가 일치하지 않습니다');
WHEN WRONG_PHONE THEN
    RAISE_APPLICATION_ERROR(-20002, '> 전화번호 형식을 확인하세요');
WHEN WRONG_EMAIL THEN
    RAISE_APPLICATION_ERROR(-20002, '> 입력하신 이메일을 사용할 수 없습니다');

COMMIT;

END;

EXEC USR_SIGN_UP ( 'as2ds2' ,'aaaa3ssssdeef', 'aaaa3ssssdeef', '김빵긋^^dd', '01030197133' , 'aaa__a3vv@nav.er.Am', 'Y' ,'Y' );
-- 아이디/ 비번/ 비번확인/ 이름 / 폰번호 / 이메일 / 이메일수신/ 문자수신
EXEC USR_SIGN_UP ( 'as22ds2' ,'aaaa3ssssdeef', 'aaaa3ssssdeef', '김빵긋2호^^dd', '01030197133' , 'aaa__a3vv@nav.er.Am', 'Y' ,'Y' );
EXEC USR_SIGN_UP ( 'asd123' ,'aaaa1234', 'aaaa1234', '김빵긋3호', '01030197133' , 'aaa__a3vv@nav.er.Am', 'Y' ,'Y' );
    

SELECT *
FROM oh_usr;




-----권한 조정

CREATE OR REPLACE PROCEDURE usr_level_set
(
    pusr_num oh_usr.usr_num%TYPE --변경시킬 회원 번호
    , pusr_role oh_roles.role_name%TYPE --변경할 등급명
)
IS
      WRONG_role_name EXCEPTION;
BEGIN
    
    IF pusr_role NOT IN ( 'customer' , 'admin' ) THEN RAISE WRONG_role_name;
    END IF;
    
    UPDATE oh_roles
    SET role_name = pusr_role
    WHERE usr_num = pusr_num;
    
EXCEPTION 
WHEN WRONG_role_name THEN RAISE_APPLICATION_ERROR(-20002, '> 존재하지 않는 등급명입니다.');

END;

EXEC usr_level_set ( 1, 'admin' );


SELECT *
FROM oh_roles;















CREATE OR REPLACE PROCEDURE usr_leave
(
    pusr_id oh_usr.usr_id%TYPE
)
IS
    vusr_num oh_usr.usr_num%TYPE; --회원탈퇴할 아이디
    vusr_login_check NUMBER; -- id 잘못입력 체크
    
    WRONG_id EXCEPTION;

BEGIN
    --존재하는 아이디인지 확인
    SELECT COUNT(usr_id) INTO vusr_login_check 
    FROM oh_usr
    WHERE usr_id =pusr_id;

    IF vusr_login_check <> 1 THEN RAISE WRONG_id;
    END IF;

    SELECT usr_num INTO vusr_num
    FROM oh_usr
    WHERE usr_id = pusr_id;

    DELETE FROM oh_roles WHERE usr_num = vusr_num; -- 권한 삭제

    DELETE FROM oh_level WHERE usr_num = vusr_num; --멤버쉽 삭제 
    
    DELETE FROM oh_cart WHERE usr_num = vusr_num; --갖고있던 카트 삭제

    DELETE FROM oh_usr WHERE usr_num = vusr_num; --회원 삭제

EXCEPTION

WHEN WRONG_id 
THEN RAISE_APPLICATION_ERROR(-20002, '> 존재하지 않는 회원입니다.');

COMMIT;

END;


EXEC usr_leave ( 'asdf' );

SELECT *
FROM oh_usr;

SELECT *
FROM oh_cart;

INSERT INTO oh_cart_prdt VALUES ( 2 , 1, 3 );

DELETE FROM oh_cart_prdt WHERE cart_num =2 ;

DELETE FROM oh_cart WHERE cart_num = 1 ;

SELECT *
FROM oh_cart_prdt;

SELECT *
FROM oh_order;

DROP TABLE oh_cart_prdt;