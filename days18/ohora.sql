--0829

--���̺� ����
/* ȸ�� */
CREATE TABLE ohora.oh_usr (
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   usr_id VARCHAR2(16 CHAR) NOT NULL, /* ȸ��ID */
   usr_tel VARCHAR2(14 CHAR), /* �Ϲ���ȭ */
   usr_phone VARCHAR2(14 CHAR), /* �޴���ȭ */
   usr_name VARCHAR2(20 CHAR) NOT NULL, /* �̸� */
   usr_email VARCHAR2(50) NOT NULL, /* �̸��� */
   usr_email_yn CHAR(1 CHAR), /* �̸��� ���� ���� */
   usr_sms_yn CHAR(1 CHAR), /* SMS ���� ���� */
   usr_level VARCHAR2(6), /* ��޸� */
   usr_birth DATE, /* ������� */
   usr_pw VARCHAR2(16 CHAR) NOT NULL /* ��й�ȣ */
);

COMMENT ON TABLE ohora.oh_usr IS 'ȸ��';

COMMENT ON COLUMN ohora.oh_usr.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_usr.usr_id IS 'ȸ��ID';

COMMENT ON COLUMN ohora.oh_usr.usr_tel IS '�Ϲ���ȭ';

COMMENT ON COLUMN ohora.oh_usr.usr_phone IS '�޴���ȭ';

COMMENT ON COLUMN ohora.oh_usr.usr_name IS '�̸�';

COMMENT ON COLUMN ohora.oh_usr.usr_email IS '�̸���';

COMMENT ON COLUMN ohora.oh_usr.usr_email_yn IS '�̸��� ���� ����';

COMMENT ON COLUMN ohora.oh_usr.usr_sms_yn IS 'SMS ���� ����';

COMMENT ON COLUMN ohora.oh_usr.usr_level IS '��޸�';

COMMENT ON COLUMN ohora.oh_usr.usr_birth IS '�������';

COMMENT ON COLUMN ohora.oh_usr.usr_pw IS '��й�ȣ';

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

/* ��� */
CREATE TABLE ohora.oh_level (
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   usr_level NVARCHAR2(6) NOT NULL, /* ��޸� */
   point_rate NUMBER NOT NULL /* ������ */
);

COMMENT ON TABLE ohora.oh_level IS '���';

COMMENT ON COLUMN ohora.oh_level.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_level.usr_level IS '��޸�';

COMMENT ON COLUMN ohora.oh_level.point_rate IS '������';

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

/* ����ּҷ� */
CREATE TABLE ohora.oh_delivery_list (
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   dl_addr VARCHAR2(50 CHAR) NOT NULL, /* ����ּ� */
   dl_phone VARCHAR2(14 CHAR) NOT NULL, /* �޴���ȭ */
   dl_tel VARCHAR2(14 CHAR), /* �Ϲ���ȭ */
   dl_name VARCHAR2(20 CHAR) NOT NULL, /* ������ */
   dl_nick VARCHAR2(10 CHAR) NOT NULL, /* ������� */
   dl_dyn CHAR(1 CHAR) /* �⺻ ����� ���� */
);

COMMENT ON TABLE ohora.oh_delivery_list IS '����ּҷ�';

COMMENT ON COLUMN ohora.oh_delivery_list.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_addr IS '����ּ�';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_phone IS '�޴���ȭ';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_tel IS '�Ϲ���ȭ';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_name IS '������';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_nick IS '�������';

COMMENT ON COLUMN ohora.oh_delivery_list.dl_dyn IS '�⺻ ����� ����';

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

/* �Խ��� */
CREATE TABLE ohora.oh_board (
   brd_num NUMBER NOT NULL, /* �� ��ȣ */
   brd_theme VARCHAR2(20 CHAR), /* �Խ��� �̸� */
   brd_title VARCHAR2(20 CHAR), /* ���� */
   brd_content VARCHAR2(500 CHAR), /* ���� */
   brd_date DATE, /* �ۼ��� */
   brd_media VARCHAR2(100 CHAR), /* ÷������ */
   brd_view NUMBER, /* ��ȸ�� */
   usr_num NUMBER NOT NULL /* ȸ����ȣ */
);

COMMENT ON TABLE ohora.oh_board IS '�Խ���';

COMMENT ON COLUMN ohora.oh_board.brd_num IS '�� ��ȣ';

COMMENT ON COLUMN ohora.oh_board.brd_theme IS '�Խ��� �̸�';

COMMENT ON COLUMN ohora.oh_board.brd_title IS '����';

COMMENT ON COLUMN ohora.oh_board.brd_content IS '����';

COMMENT ON COLUMN ohora.oh_board.brd_date IS '�ۼ���';

COMMENT ON COLUMN ohora.oh_board.brd_media IS '÷������';

COMMENT ON COLUMN ohora.oh_board.brd_view IS '��ȸ��';

COMMENT ON COLUMN ohora.oh_board.usr_num IS 'ȸ����ȣ';

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

/* ��� */
CREATE TABLE ohora.oh_comments (
   co_num NUMBER NOT NULL, /* ��� ��ȣ */
   co_content VARCHAR2(100 CHAR), /* ���� */
   usr_num NUMBER NOT NULL /* ȸ����ȣ */
);

COMMENT ON TABLE ohora.oh_comments IS '���';

COMMENT ON COLUMN ohora.oh_comments.co_num IS '��� ��ȣ';

COMMENT ON COLUMN ohora.oh_comments.co_content IS '����';

COMMENT ON COLUMN ohora.oh_comments.usr_num IS 'ȸ����ȣ';

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

/* ���� */
CREATE TABLE ohora.oh_review (
   rv_num NUMBER NOT NULL, /* ���� ��ȣ */
   rv_title VARCHAR2(20 CHAR) NOT NULL, /* ���� */
   rv_content VARCHAR2(100 CHAR) NOT NULL, /* ���� */
   rv_media VARCHAR2(100 CHAR), /* �̹���/���� */
   rv_date DATE, /* �ۼ����� */
   rv_score NUMBER, /* ����(����) */
   rv_like NUMBER, /* ��õ(����ſ�) */
   rv_rank NUMBER NOT NULL, /* ���� */
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   od_num NUMBER, /* �ֹ���ȣ */
   pd_num NUMBER NOT NULL /* ��ǰ��ȣ */
);

COMMENT ON TABLE ohora.oh_review IS '����';

COMMENT ON COLUMN ohora.oh_review.rv_num IS '���� ��ȣ';

COMMENT ON COLUMN ohora.oh_review.rv_title IS '����';

COMMENT ON COLUMN ohora.oh_review.rv_content IS '����';

COMMENT ON COLUMN ohora.oh_review.rv_media IS '�̹���/����';

COMMENT ON COLUMN ohora.oh_review.rv_date IS '�ۼ�����';

COMMENT ON COLUMN ohora.oh_review.rv_score IS '����(����)';

COMMENT ON COLUMN ohora.oh_review.rv_like IS '��õ(����ſ�)';

COMMENT ON COLUMN ohora.oh_review.rv_rank IS '����';

COMMENT ON COLUMN ohora.oh_review.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_review.od_num IS '�ֹ���ȣ';

COMMENT ON COLUMN ohora.oh_review.pd_num IS '��ǰ��ȣ';

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

/* ������ */
CREATE TABLE ohora.oh_point (
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   pt_date DATE NOT NULL, /* ������ */
   pt_point NUMBER, /* ������ */
   usr_level VARCHAR2(6), /* ��޸� */
   rv_num NUMBER /* ���� ��ȣ */
);

COMMENT ON TABLE ohora.oh_point IS '������';

COMMENT ON COLUMN ohora.oh_point.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_point.pt_date IS '������';

COMMENT ON COLUMN ohora.oh_point.pt_point IS '������';

COMMENT ON COLUMN ohora.oh_point.usr_level IS '��޸�';

COMMENT ON COLUMN ohora.oh_point.rv_num IS '���� ��ȣ';

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

/* ���� */
CREATE TABLE ohora.oh_coupon (
   cp_num NUMBER NOT NULL, /* ������ȣ */
   cp_name VARCHAR2(50 CHAR) NOT NULL, /* ���� �̸� */
   cp_rate NUMBER, /* ���� ������ */
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   cr_num NUMBER NOT NULL /* �������ǹ�ȣ */
);

COMMENT ON TABLE ohora.oh_coupon IS '����';

COMMENT ON COLUMN ohora.oh_coupon.cp_num IS '������ȣ';

COMMENT ON COLUMN ohora.oh_coupon.cp_name IS '���� �̸�';

COMMENT ON COLUMN ohora.oh_coupon.cp_rate IS '���� ������';

COMMENT ON COLUMN ohora.oh_coupon.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_coupon.cr_num IS '�������ǹ�ȣ';

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

/* �������� */
CREATE TABLE ohora.oh_cpn_req (
   cr_num NUMBER NOT NULL, /* �������ǹ�ȣ */
   cr_date DATE NOT NULL, /* ��ȿ�Ⱓ */
   cr_ratio NUMBER, /* ���� ������ */
   cr_price NUMBER, /* �ݾ� ���� */
   cr_product VARCHAR2(50 CHAR), /* ���� ��� */
   od_num NUMBER NOT NULL, /* �ֹ���ȣ */
   pd_num NUMBER NOT NULL /* ��ǰ��ȣ */
);

COMMENT ON TABLE ohora.oh_cpn_req IS '��������';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_num IS '�������ǹ�ȣ';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_date IS '��ȿ�Ⱓ';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_ratio IS '���� ������';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_price IS '�ݾ� ����';

COMMENT ON COLUMN ohora.oh_cpn_req.cr_product IS '���� ���';

COMMENT ON COLUMN ohora.oh_cpn_req.od_num IS '�ֹ���ȣ';

COMMENT ON COLUMN ohora.oh_cpn_req.pd_num IS '��ǰ��ȣ';

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

/* �ֹ� */
CREATE TABLE ohora.oh_order (
   od_num NUMBER NOT NULL, /* �ֹ���ȣ */
   od_date DATE NOT NULL, /* �ֹ����� */
   od_price NUMBER, /* ��ǰ�ݾ� */
   od_status CHAR(1 CHAR) NOT NULL, /* �ֹ� ó������ */
   od_cancel VARCHAR2(2 CHAR), /* ���/��ȯ/��ǰ ó������ */
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   pd_num NUMBER NOT NULL, /* ��ǰ��ȣ */
   cart_num NUMBER /* ��ٱ��Ϲ�ȣ */
);

ALTER TABLE oh_order
   MODIFY od_status VARCHAR2(10 chAR);

COMMENT ON TABLE ohora.oh_order IS '�ֹ�';

COMMENT ON COLUMN ohora.oh_order.od_num IS '�ֹ���ȣ';

COMMENT ON COLUMN ohora.oh_order.od_date IS '�ֹ�����';

COMMENT ON COLUMN ohora.oh_order.od_price IS '��ǰ�ݾ�';

COMMENT ON COLUMN ohora.oh_order.od_status IS '�ֹ� ó������';

COMMENT ON COLUMN ohora.oh_order.od_cancel IS '���/��ȯ/��ǰ ó������';

COMMENT ON COLUMN ohora.oh_order.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_order.pd_num IS '��ǰ��ȣ';

COMMENT ON COLUMN ohora.oh_order.cart_num IS '��ٱ��Ϲ�ȣ';

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

/* ����ǰ ���� */
CREATE TABLE ohora.oh_gift (
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   pd_num NUMBER NOT NULL, /* ��ǰ��ȣ */
   od_num NUMBER NOT NULL, /* �ֹ���ȣ */
   gift_price NUMBER /* ����ǰ ���� */
);

COMMENT ON TABLE ohora.oh_gift IS '����ǰ ����';

COMMENT ON COLUMN ohora.oh_gift.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_gift.pd_num IS '��ǰ��ȣ';

COMMENT ON COLUMN ohora.oh_gift.od_num IS '�ֹ���ȣ';

COMMENT ON COLUMN ohora.oh_gift.gift_price IS '����ǰ ����';

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

/* ��ٱ��� */
CREATE TABLE ohora.oh_cart (
   cart_num NUMBER NOT NULL, /* ��ٱ��Ϲ�ȣ */
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   pd_num NUMBER, /* ��ǰ��ȣ */
   cart_pdcnt NUMBER /* ��ǰ���� */
);

COMMENT ON TABLE ohora.oh_cart IS '��ٱ���';

COMMENT ON COLUMN ohora.oh_cart.cart_num IS '��ٱ��Ϲ�ȣ';

COMMENT ON COLUMN ohora.oh_cart.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_cart.pd_num IS '��ǰ��ȣ';

COMMENT ON COLUMN ohora.oh_cart.cart_pdcnt IS '��ǰ����';

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

/* ��ǰ */
CREATE TABLE ohora.oh_product (
   pd_num NUMBER NOT NULL, /* ��ǰ��ȣ */
   pd_name VARCHAR2(50 CHAR) NOT NULL, /* ��ǰ�� */
   pd_date DATE, /* ����� */
   pd_stock NUMBER, /* ���� */
   pd_price NUMBER, /* ���� */
   pd_dc_price NUMBER, /* ���ΰ� */
   pd_view NUMBER, /* ��ȸ�� */
   pd_media VARCHAR2(100 CHAR), /* ����� */
   pd_dc_rate NUMBER, /* ��ü ������ */
   pd_tot_buy NUMBER /* �� ���ż�(��ǰ �α⵵) */
);

COMMENT ON TABLE ohora.oh_product IS '��ǰ';

COMMENT ON COLUMN ohora.oh_product.pd_num IS '��ǰ��ȣ';

COMMENT ON COLUMN ohora.oh_product.pd_name IS '��ǰ��';

COMMENT ON COLUMN ohora.oh_product.pd_date IS '�����';

COMMENT ON COLUMN ohora.oh_product.pd_stock IS '����';

COMMENT ON COLUMN ohora.oh_product.pd_price IS '����';

COMMENT ON COLUMN ohora.oh_product.pd_dc_price IS '���ΰ�';

COMMENT ON COLUMN ohora.oh_product.pd_view IS '��ȸ��';

COMMENT ON COLUMN ohora.oh_product.pd_media IS '�����';

COMMENT ON COLUMN ohora.oh_product.pd_dc_rate IS '��ü ������';

COMMENT ON COLUMN ohora.oh_product.pd_tot_buy IS '�� ���ż�(��ǰ �α⵵)';

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

/* ������ */
CREATE TABLE ohora.oh_mydesign (
   pd_num NUMBER NOT NULL, /* ��ǰ��ȣ */
   pmd_hashtag VARCHAR2(10 CHAR) NOT NULL, /* �ؽ��±� */
   pmd_lineup VARCHAR2(10 CHAR), /* ���ξ� */
   pmd_color VARCHAR2(10 CHAR), /* �÷� */
   pmd_design VARCHAR2(10 CHAR) /* ������ */
);

ALTER TABLE oh_mydesign
DROP PRIMARY KEY;

ALTER TABLE oh_mydesign MODIFY pmd_hashtag NULL;

ALTER TABLE oh_mydesign
MODIFY od_status VARCHAR2(10);

COMMENT ON TABLE ohora.oh_mydesign IS '������';

COMMENT ON COLUMN ohora.oh_mydesign.pmd_hashtag IS '�ؽ��±�';

COMMENT ON COLUMN ohora.oh_mydesign.pd_num IS '��ǰ��ȣ';

COMMENT ON COLUMN ohora.oh_mydesign.pmd_lineup IS '���ξ�';

COMMENT ON COLUMN ohora.oh_mydesign.pmd_color IS '�÷�';

COMMENT ON COLUMN ohora.oh_mydesign.pmd_design IS '������';

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

/* ī�װ� */
CREATE TABLE ohora.oh_category (
   pd_num NUMBER NOT NULL, /* ��ǰ��ȣ */
   pc_fir VARCHAR2(20 CHAR) NOT NULL, /* ��з� */
   pc_sec VARCHAR2(20 CHAR), /* �ߺз� */
   pc_thd VARCHAR2(20 CHAR) /* �Һз� */
);

COMMENT ON TABLE ohora.oh_category IS 'ī�װ�';

COMMENT ON COLUMN ohora.oh_category.pd_num IS '��ǰ��ȣ';

COMMENT ON COLUMN ohora.oh_category.pc_fir IS '��з�';

COMMENT ON COLUMN ohora.oh_category.pc_sec IS '�ߺз�';

COMMENT ON COLUMN ohora.oh_category.pc_thd IS '�Һз�';

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

/* �ֹ� �� */
CREATE TABLE ohora.oh_order_sub (
   os_num NUMBER NOT NULL, /* �ֹ� �� ��ȣ */
   od_num NUMBER, /* �ֹ���ȣ */
   os_price NUMBER, /* ��ǰ�ݾ� */
   os_pay_delivery NUMBER, /* ��ۺ� */
   os_name VARCHAR2(50 CHAR) /* ��ǰ �̸� */
);

COMMENT ON TABLE ohora.oh_order_sub IS '�ֹ� ��';

COMMENT ON COLUMN ohora.oh_order_sub.os_num IS '�ֹ� �� ��ȣ';

COMMENT ON COLUMN ohora.oh_order_sub.od_num IS '�ֹ���ȣ';

COMMENT ON COLUMN ohora.oh_order_sub.os_price IS '��ǰ�ݾ�';

COMMENT ON COLUMN ohora.oh_order_sub.os_pay_delivery IS '��ۺ�';

COMMENT ON COLUMN ohora.oh_order_sub.os_name IS '��ǰ �̸�';

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

/* ���� */
CREATE TABLE ohora.oh_pay (
   pay_num NUMBER NOT NULL, /* ������ȣ */
   od_num NUMBER NOT NULL, /* �ֹ���ȣ */
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   cp_num NUMBER NOT NULL, /* ������ȣ */
   pay_way VARCHAR2(20 CHAR), /* ���������̸� */
   pay_date DATE, /* �������� */
   pay_delivery NUMBER /* ��ۺ� */
);

COMMENT ON TABLE ohora.oh_pay IS '����';

COMMENT ON COLUMN ohora.oh_pay.pay_num IS '������ȣ';

COMMENT ON COLUMN ohora.oh_pay.od_num IS '�ֹ���ȣ';

COMMENT ON COLUMN ohora.oh_pay.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_pay.cp_num IS '������ȣ';

COMMENT ON COLUMN ohora.oh_pay.pay_way IS '���������̸�';

COMMENT ON COLUMN ohora.oh_pay.pay_date IS '��������';

COMMENT ON COLUMN ohora.oh_pay.pay_delivery IS '��ۺ�';

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

/* ��� */
CREATE TABLE ohora.oh_delivery (
   d_num NUMBER NOT NULL, /* ����� ��ȣ */
   d_finish DATE, /* ��� �Ϸ��� */
   d_start DATE, /* ��� ������ */
   d_status VARCHAR2(20 CHAR), /* ��� ���� */
   usr_num NUMBER NOT NULL /* ȸ����ȣ */
);

COMMENT ON TABLE ohora.oh_delivery IS '���';

COMMENT ON COLUMN ohora.oh_delivery.d_num IS '����� ��ȣ';

COMMENT ON COLUMN ohora.oh_delivery.d_finish IS '��� �Ϸ���';

COMMENT ON COLUMN ohora.oh_delivery.d_start IS '��� ������';

COMMENT ON COLUMN ohora.oh_delivery.d_status IS '��� ����';

COMMENT ON COLUMN ohora.oh_delivery.usr_num IS 'ȸ����ȣ';

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

/* ���/��ȯ/��ǰ */
CREATE TABLE ohora.oh_order_cncl (
   od_num NUMBER NOT NULL, /* �ֹ���ȣ */
   pd_num NUMBER NOT NULL, /* ��ǰ��ȣ */
   oc_reason VARCHAR2(20 CHAR), /* �� ���� */
   oc_check VARCHAR2(20 CHAR) NOT NULL, /* ���� ���� */
   oc_status VARCHAR2(20 CHAR), /* ���� ���� */
   oc_cnt NUMBER /* ��� ���� */
);

COMMENT ON TABLE ohora.oh_order_cncl IS '���/��ȯ/��ǰ';

COMMENT ON COLUMN ohora.oh_order_cncl.od_num IS '�ֹ���ȣ';

COMMENT ON COLUMN ohora.oh_order_cncl.pd_num IS '��ǰ��ȣ';

COMMENT ON COLUMN ohora.oh_order_cncl.oc_reason IS '�� ����';

COMMENT ON COLUMN ohora.oh_order_cncl.oc_check IS '���� ����';

COMMENT ON COLUMN ohora.oh_order_cncl.oc_status IS '���� ����';

COMMENT ON COLUMN ohora.oh_order_cncl.oc_cnt IS '��� ����';

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

/* ���� */
CREATE TABLE ohora.oh_roles (
   usr_num NUMBER NOT NULL, /* ȸ����ȣ */
   role_name VARCHAR2(10 CHAR) /* �����̸� */
);

COMMENT ON TABLE ohora.oh_roles IS '����';

COMMENT ON COLUMN ohora.oh_roles.usr_num IS 'ȸ����ȣ';

COMMENT ON COLUMN ohora.oh_roles.role_name IS '�����̸�';

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

/* �������� */
CREATE TABLE ohora.oh_pay_type (
   pay_way VARCHAR2(20 CHAR) NOT NULL, /* ���������̸� */
   od_num NUMBER /* �ֹ���ȣ */
);

COMMENT ON TABLE ohora.oh_pay_type IS '��������';

COMMENT ON COLUMN ohora.oh_pay_type.pay_way IS '���������̸�';

COMMENT ON COLUMN ohora.oh_pay_type.od_num IS '�ֹ���ȣ';

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
--���̵�����
INSERT INTO oh_usr (USR_NUM, USR_ID, USR_TEL, USR_PHONE, USR_NAME, USR_EMAIL, USR_EMAIL_YN, USR_SMS_YN, USR_LEVEL, USR_BIRTH, USR_PW)
VALUES (1, 'asdf', '1234', '1234', '�ֻ��', 'emailass', 'y', 'n', 'CREW', '1998-02-05', 'AApass'); 

INSERT INTO oh_usr (USR_NUM, USR_ID, USR_TEL, USR_PHONE, USR_NAME, USR_EMAIL, USR_EMAIL_YN, USR_SMS_YN, USR_LEVEL, USR_BIRTH, USR_PW)
VALUES (2, 'qwer', '5678', '5678', '���ؼ�', 'testemail', 'n', 'y', 'FRIEND', '2000-02-25', 'PWPW'); 

--

INSERT INTO OH_PRODUCT (PD_NUM, PD_NAME, PD_DATE, PD_STOCK, PD_PRICE, PD_DC_PRICE, PD_VIEW, PD_MEDIA, PD_DC_RATE, PD_TOT_BUY)
VALUES (1, '�������������', '2024-01-01', 99, 12000, 9600, 15000, 'IMAGE' , 20, 100);

INSERT INTO OH_PRODUCT (PD_NUM, PD_NAME, PD_DATE, PD_STOCK, PD_PRICE, PD_DC_PRICE, PD_VIEW, PD_MEDIA, PD_DC_RATE, PD_TOT_BUY)
VALUES (2, '�Ҳ��е�ť��', '2024-02-01', 88, 10000, 9000, 20000, 'IMAGE' , 10, 50);

INSERT INTO OH_PRODUCT (PD_NUM, PD_NAME, PD_DATE, PD_STOCK, PD_PRICE, PD_DC_PRICE, PD_VIEW, PD_MEDIA, PD_DC_RATE, PD_TOT_BUY)
VALUES (3, '��������', '2024-02-14', 5, 200000, 180000, 50000, 'IMAGE' , 10, 3);

--

INSERT INTO OH_CART (CART_NUM, USR_NUM) VALUES (1, 1);

INSERT INTO OH_CART (CART_NUM, USR_NUM, PD_NUM, CART_PDCNT) VALUES (2, 2, 3, 1);

INSERT INTO OH_CART (CART_NUM, USR_NUM, PD_NUM, CART_PDCNT) VALUES (3, 1, 3, 1);

--

INSERT INTO OH_ORDER (OD_NUM, OD_DATE, OD_PRICE, OD_STATUS, OD_CANCEL, USR_NUM, PD_NUM, CART_NUM) 
VALUES (4, '2024-08-25', 9600, '�����', 'X', 1, 1, 1); 
-- ( �Ƹ� ��ñ��� ��Ȳ���� ? ) �� �ڵ� �߰���
INSERT INTO OH_CART_PRDT (cart_num, cart_pd_num, cart_pdcnt)
VALUES (1, 1, 1); 
--�̰ͱ��� �߰��Ǵ� ���ν����� ��������
INSERT INTO OH_CART_PRDT (cart_num, cart_pd_num, cart_pdcnt)
VALUES (1, 2, 2); 
--�̷��� �ϸ� ���� ��ٱ��Ͽ� �ٸ� ��ǰ�� ���� ��Ȳ ��������

INSERT INTO OH_ORDER (OD_NUM, OD_DATE, OD_PRICE, OD_STATUS, OD_CANCEL, USR_NUM, PD_NUM, CART_NUM) 
VALUES (2, '2024-08-28', 9000, '��ǰ�غ���', 'X', 2, 2, 2); 

INSERT INTO OH_ORDER (OD_NUM, OD_DATE, OD_PRICE, OD_STATUS, OD_CANCEL, USR_NUM, PD_NUM, CART_NUM) 
VALUES (3, '2024-08-28', 180000, '��ǰ�غ���', 'X', 1, 3, 3); 

--

INSERT INTO oh_product VALUES(4,'��Ű �Ǵ� ����',SYSDATE-30,312,16800,13440,5,'�̹���',20,123);
INSERT INTO oh_category VALUES(4,'����','��������','��');
INSERT INTO oh_mydesign VALUES('0531',4,'��Ʈ','�ڶ���ũ','�÷�');
INSERT INTO oh_product VALUES(5,'���� ��ġ ����',SYSDATE-50,98,16800,13440,6,'�̹���',20,54);
INSERT INTO oh_category VALUES(5,'����','����Ʈ��','���ϸ�');
INSERT INTO oh_mydesign VALUES('0531',5,'����','��','���ǵ�');
INSERT INTO oh_product VALUES(6,'�浥�� ����',SYSDATE-75,77,14800,11840,3,'�̹���',20,65);
INSERT INTO oh_category VALUES(6,'����','��������','Ǯ�÷�');
INSERT INTO oh_mydesign VALUES('����,�Ķ���,�ö��',6,'Ǯ�÷�','����','����ġ');
INSERT INTO oh_product VALUES(7,'Ƽ�� ����',SYSDATE-22,456,14800,11840,3,'�̹���',20,76);
INSERT INTO oh_category VALUES(7,'����','��������','�÷�');
INSERT INTO oh_mydesign VALUES('����,�Ķ���,�ö��',7,'��Ʈ','ȭ��Ʈ','�ڰ�');
INSERT INTO oh_product VALUES(8,'�۷ο� �� ���',SYSDATE-55,144,14800,11840,3,'�̹���',20,76);
INSERT INTO oh_category VALUES(8,'���','����Ʈ��','Űġ');
INSERT INTO oh_mydesign VALUES('��ȫ,ġũ',8,'����','���','����');
INSERT INTO oh_product VALUES(9,'�۸��� ���� ���',SYSDATE-88,654,12800,10840,3,'�̹���',15,22);
INSERT INTO oh_category VALUES(9,'���','����Ʈ��','����');
INSERT INTO oh_mydesign VALUES('������, ���',9,'��Ʈ','���ο�','����ġ');

--08/29
ALTER TABLE OH_REVIEW
MODIFY RV_CONTENT VARCHAR2(2000 CHAR);

ALTER TABLE OH_COMMENTS
MODIFY CO_CONTENT VARCHAR2(2000 CHAR);

ALTER TABLE OH_BOARD
MODIFY BRD_CONTENT VARCHAR2(2000 CHAR);

CREATE SEQUENCE rv_num_seq  --���� �ѹ� ������ ����
INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE;

ALTER TABLE oh_usr  --ȸ�� ���̵� ����ũ ���� �� �ְڽ��ϴ�
ADD CONSTRAINT unique_user_id UNIQUE (usr_id);


ALTER TABLE OH_ORDER
DROP CONSTRAINT FK_OH_USR_TO_OH_ORDER;
ALTER TABLE OH_ORDER
ADD CONSTRAINT FK_OH_USR_TO_OH_ORDER
FOREIGN KEY (USR_NUM) REFERENCES OH_USR (USR_NUM)
ON DELETE SET NULL; --�ϴ� ���� ���̺��� �����ѹ��� �� �����ϰ� �������


ALTER TABLE OH_ORDER
DROP CONSTRAINT FK_OH_CART_TO_OH_ORDER;
ALTER TABLE OH_ORDER
ADD CONSTRAINT FK_OH_CART_TO_OH_ORDER
FOREIGN KEY (CART_NUM) REFERENCES OH_CART (CART_NUM)
ON DELETE SET NULL; --īƮ���� ȸ����ȣ ����� ���� ���� �����°� �ƴ϶� ȸ����ȣ�� ��ó��

--�׷� ������ ȸ����ȣ�� �ε� ���� �� �־����
ALTER TABLE ohora.oh_order MODIFY usr_num NUMBER NULL;

--īƮ ǰ�� ���̺� ���� ����

CREATE TABLE oh_cart_prdt
(
    cart_num NUMBER ,
    cart_pd_num NUMBER ,
    cart_pdcnt NUMBER ,
    
    CONSTRAINT fk_oh_cart_to_oh_cart_prdt FOREIGN KEY(cart_num) REFERENCES oh_cart (cart_num)
    ON DELETE CASCADE --īƮ��ȣ �������� ǰ��� �ڵ� ����
);

ALTER TABLE oh_cart DROP COLUMN pd_num;
ALTER TABLE oh_cart DROP COLUMN cart_pdcnt;

--------------------------------------------------------------------------------
-- ȸ������ 

CREATE SEQUENCE usr_num_seq --ȸ����ȣ
    INCREMENT BY 1
    START WITH 1
    MINVALUE 1
    MAXVALUE 1000
    NOCYCLE
    ORDER
    NOCACHE;


CREATE OR REPLACE PROCEDURE usr_sign_up --ȸ������
(
    pusr_id oh_usr.usr_id%TYPE --nn ���� ID
    , pusr_pw oh_usr.usr_pw%TYPE -- ���� ��й�ȣ
    , pusr_pw_ck oh_usr.usr_pw%TYPE -- ���� ��й�ȣ Ȯ��
    , pusr_name oh_usr.usr_name%TYPE --nn ���� �̸�
    , pusr_phone oh_usr.usr_name%TYPE -- ���� ����ȣ
    , pusr_EMAIL oh_usr.usr_email%TYPE --nn ���� �̸��� �ּ�
    , pusr_EMAIL_YN oh_usr.usr_email_yn%TYPE -- ���� �̸��� ���� ����
    , pusr_SMS_YN oh_usr.usr_sms_yn%TYPE -- ���� ���ڼ��� ����

)
IS
    vusr_id oh_usr.usr_id%TYPE; --nn ���� ID
    vusr_pw oh_usr.usr_pw%TYPE; -- ���� ��й�ȣ
   -- vusr_pw_ck oh_usr.usr_pw%TYPE; -- ���� ��й�ȣ Ȯ��
    vusr_name oh_usr.usr_name%TYPE; --nn ���� �̸�
    vusr_phone oh_usr.usr_name%TYPE ;-- ���� ����ȣ
    vusr_SMS_YN oh_usr.usr_sms_yn%TYPE; -- ���� ���ڼ��� ����
    vusr_EMAIL oh_usr.usr_email%TYPE; --nn ���� �̸��� �ּ�
    vusr_EMAIL_YN oh_usr.usr_email_yn%TYPE; -- ���� �̸��� ���� ����
    
   -- vcheck_id oh_usr.usr_id%TYPE; --���̵� �ߺ� üũ��

    WRONG_ID_TYPE EXCEPTION;
    WRONG_PW_TYPE EXCEPTION;
    WRONG_PW_CK EXCEPTION;
    WRONG_PHONE EXCEPTION;
    WRONG_EMAIL EXCEPTION;
BEGIN


-- ID ���� üũ

IF REGEXP_LIKE( pusr_id , '^[a-z][0-9a-z]*$' )
AND LENGTH(pusr_id) >= 4 
AND LENGTH(pusr_id) <= 16
THEN vusr_id := pusr_id;
DBMS_OUTPUT.PUT_LINE ( vusr_id );

ELSE RAISE WRONG_ID_TYPE;

END IF;


-- ��й�ȣ �Է�
IF REGEXP_LIKE(pusr_pw, '\s+') THEN  RAISE WRONG_PW_TYPE; --��������
ELSIF LENGTH(pusr_pw) < 8 OR LENGTH(pusr_pw) > 16  THEN  RAISE WRONG_PW_TYPE; --���� �Ҹ���
ELSIF REGEXP_LIKE(pusr_pw, '^[a-zA-Z]+$')  THEN RAISE WRONG_PW_TYPE; --���ڸ�
ELSIF REGEXP_LIKE(pusr_pw, '^[0-9]+$')  THEN RAISE WRONG_PW_TYPE; --���ڸ�
ELSIF REGEXP_LIKE(pusr_pw, '^[@!#$%^&*()_+]+$')  THEN RAISE WRONG_PW_TYPE; --��ȣ��
ELSE vusr_pw := pusr_pw;

--DBMS_OUTPUT.PUT_LINE ( vusr_pw );

--ELSE RAISE WRONG_PW_TYPE;
END IF;


--��й�ȣ Ȯ��
IF pusr_pw_ck != pusr_pw THEN RAISE WRONG_PW_CK;
END IF;

--�̸� �Է�
vusr_name := pusr_name;
--DBMS_OUTPUT.PUT_LINE ( '�̸� : '|| vusr_name );

--����ȣ �Է�
IF REGEXP_LIKE(pusr_phone , '^(010|011)\d{7,8}') 
THEN vusr_phone := pusr_phone;
--DBMS_OUTPUT.PUT_LINE ( '���� : '|| vusr_phone );
ELSE RAISE WRONG_PHONE;
END IF;

--���� �Է�
IF REGEXP_LIKE(pusr_pw, '\s+') THEN  RAISE WRONG_EMAIL; --��������
ELSIF REGEXP_LIKE ( pusr_email , '\.\.' ) THEN  RAISE WRONG_EMAIL; --���� .
ELSIF REGEXP_LIKE ( pusr_email , '^[A-Za-z0-9._-]+@[A-Za-z0-9.]+\.[A-Za-z]{2,}' )
THEN vusr_email := pusr_email;
--DBMS_OUTPUT.PUT_LINE ('���� : ' || vusr_email);
ELSE RAISE WRONG_EMAIL;
END IF;

--���üũ
vusr_email_yn := pusr_email_yn;
--DBMS_OUTPUT.PUT_LINE ('���� ���� : ' || vusr_email_yn);
vusr_sms_yn := pusr_sms_yn;
--DBMS_OUTPUT.PUT_LINE ('SMS ���� : ' || vusr_sms_yn);

INSERT INTO oh_usr ( usr_num, usr_id, usr_pw, usr_name, usr_phone, usr_email ,usr_email_yn , usr_sms_yn) 
VALUES ( usr_num_seq.NEXTVAL ,  vusr_id , vusr_pw , vusr_name, vusr_phone, vusr_email, vusr_email_yn, vusr_sms_yn);


EXCEPTION

WHEN WRONG_ID_TYPE THEN
    RAISE_APPLICATION_ERROR(-20001, '> ���̵�� ���� �ҹ��ڷ� �����ؾ��ϸ�, 4~16���� ����� �ҹ��ڷθ� �����Ǿ�� �մϴ�.');
WHEN WRONG_PW_TYPE THEN
    RAISE_APPLICATION_ERROR(-20002, '> ��й�ȣ�� ���� ��ҹ���/����/Ư������ �� 2���� �̻� ����, 8��~16�ڷ� �����Ǿ�� �մϴ�.');
WHEN WRONG_PW_CK THEN
    RAISE_APPLICATION_ERROR(-20002, '> ��й�ȣ�� ��ġ���� �ʽ��ϴ�');
WHEN WRONG_PHONE THEN
    RAISE_APPLICATION_ERROR(-20002, '> ��ȭ��ȣ ������ Ȯ���ϼ���');
WHEN WRONG_EMAIL THEN
    RAISE_APPLICATION_ERROR(-20002, '> �Է��Ͻ� �̸����� ����� �� �����ϴ�');

COMMIT;

END;

EXEC USR_SIGN_UP ( 'as2ds2' ,'aaaa3ssssdeef', 'aaaa3ssssdeef', '�軧��^^dd', '01030197133' , 'aaa__a3vv@nav.er.Am', 'Y' ,'Y' );
-- ���̵�/ ���/ ���Ȯ��/ �̸� / ����ȣ / �̸��� / �̸��ϼ���/ ���ڼ���
EXEC USR_SIGN_UP ( 'as22ds2' ,'aaaa3ssssdeef', 'aaaa3ssssdeef', '�軧��2ȣ^^dd', '01030197133' , 'aaa__a3vv@nav.er.Am', 'Y' ,'Y' );
EXEC USR_SIGN_UP ( 'asd123' ,'aaaa1234', 'aaaa1234', '�軧��3ȣ', '01030197133' , 'aaa__a3vv@nav.er.Am', 'Y' ,'Y' );
    

SELECT *
FROM oh_usr;




-----���� ����

CREATE OR REPLACE PROCEDURE usr_level_set
(
    pusr_num oh_usr.usr_num%TYPE --�����ų ȸ�� ��ȣ
    , pusr_role oh_roles.role_name%TYPE --������ ��޸�
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
WHEN WRONG_role_name THEN RAISE_APPLICATION_ERROR(-20002, '> �������� �ʴ� ��޸��Դϴ�.');

END;

EXEC usr_level_set ( 1, 'admin' );


SELECT *
FROM oh_roles;















CREATE OR REPLACE PROCEDURE usr_leave
(
    pusr_id oh_usr.usr_id%TYPE
)
IS
    vusr_num oh_usr.usr_num%TYPE; --ȸ��Ż���� ���̵�
    vusr_login_check NUMBER; -- id �߸��Է� üũ
    
    WRONG_id EXCEPTION;

BEGIN
    --�����ϴ� ���̵����� Ȯ��
    SELECT COUNT(usr_id) INTO vusr_login_check 
    FROM oh_usr
    WHERE usr_id =pusr_id;

    IF vusr_login_check <> 1 THEN RAISE WRONG_id;
    END IF;

    SELECT usr_num INTO vusr_num
    FROM oh_usr
    WHERE usr_id = pusr_id;

    DELETE FROM oh_roles WHERE usr_num = vusr_num; -- ���� ����

    DELETE FROM oh_level WHERE usr_num = vusr_num; --����� ���� 
    
    DELETE FROM oh_cart WHERE usr_num = vusr_num; --�����ִ� īƮ ����

    DELETE FROM oh_usr WHERE usr_num = vusr_num; --ȸ�� ����

EXCEPTION

WHEN WRONG_id 
THEN RAISE_APPLICATION_ERROR(-20002, '> �������� �ʴ� ȸ���Դϴ�.');

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