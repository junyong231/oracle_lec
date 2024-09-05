-- ����
--���� ���� ���� �˻� -> ��� ������ ����ó��		
--��������	������ ���ν����� �����ϸ� (������, ���� ����� �ݾ� �����ǰ�, ���������� �Ķ���ͷ� �׳�..) �� ������ �ֹ��󼼿� ����		
--��ٱ��Ͽ��� üũ�ѰŸ� ���� , ���� ��뿩�� �÷� ���� ȯ���ϸ� ���� �����ְ�(��Ȱ) , ������ ��޸°� ���������ְ� 		
-- üũ���Ѱ� ����־�ߵ�


-- 1. ������ īƮ�� �Ѱ��� ���´� : ����
-- 2. īƮ���� üũ�� �͸� �����´�. : ����

--�ϴ� cart_prdt�� üũ�� �����
-- 

-- ��ٱ��� ����
-- ��ٱ��� ���� (üũ�� ���)
-- ��ٱ��� �ֱ� ( ���� ���)
-- 












ALTER TABLE oh_cart_prdt ADD cart_prdt;


CREATE OR REPLACE PROCEDURE uf_pay
(
    pusr_num oh_usr_num.usr_num%TYPE
    , pusr_
)
IS

BEGIN

END;



SELECT cp.cart_pd_num , p.pd_media , p.pd_name , SUM(cp.cart_pdcnt) spdc, p.pd_dc_rate ,p.pd_price, p.pd_dc_price
FROM oh_cart c JOIN oh_cart_prdt cp ON c.cart_num = cp.cart_num 
JOIN oh_product p ON cp.cart_pd_num = p.pd_num
--WHERE c.cart_num = cp.cart_num
GROUP BY cp.cart_pd_num , p.pd_media , p.pd_name, p.pd_dc_rate ,p.pd_price, p.pd_dc_price


CREATE OR REPLACE PROCEDURE up_see_cart
(
    pusr_num oh_usr.usr_num%TYPE
)
IS
    vusr_num oh_usr.usr_num%TYPE;
    v_tot_dc_price NUMBER  := 0 ; --�� ���ΰ�
    v_deli_cost NUMBER  := 0 ;--��ۺ�
    v_tot_dc_mprice NUMBER  := 0 ; -- ��ǰ���αݾ�
     v_tot_deli NUMBER := 0 ; --�� ��ǰ�ݾ��� 5���� �̸��϶� ��ۺ� ������ �Ѱ����ݾ�
    v_tot_price NUMBER  := 0 ; --�� ��ǰ�ݾ�
     
BEGIN
    
    FOR vcart_row IN (
        SELECT cp.cart_pd_num , p.pd_media , p.pd_name , SUM(cp.cart_pdcnt) spdc, p.pd_dc_rate ,p.pd_price, p.pd_dc_price
        FROM oh_cart c JOIN oh_cart_prdt cp ON c.cart_num = cp.cart_num 
        JOIN oh_product p ON cp.cart_pd_num = p.pd_num
        --WHERE c.cart_num = cp.cart_num
        GROUP BY cp.cart_pd_num , p.pd_media , p.pd_name, p.pd_dc_rate ,p.pd_price, p.pd_dc_price
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE ( vcart_row.pd_media ||' ' ||vcart_row.pd_name || ' '|| vcart_row.spdc );
        DBMS_OUTPUT.PUT_LINE ( vcart_row.pd_dc_rate || '% ' || vcart_row.pd_price || ' '|| vcart_row.pd_dc_price);
    END LOOP;
        SELECT sum(pd_price  * cp.cart_pdcnt ) , sum(pd_dc_price * cp.cart_pdcnt  ), sum((pd_price - pd_dc_price)* cp.cart_pdcnt ) INTO v_tot_price, v_tot_dc_price, v_tot_dc_mprice
        FROM oh_product p join oh_cart_prdt cp on p.pd_num = cp.cart_pd_num
                          JOIN oh_cart c ON c.cart_num = cp.cart_num     
        WHERE c.cart_num = cp.cart_num;
 
    DBMS_OUTPUT.PUT_LINE('�� ��ǰ�ݾ�        '|| TO_CHAR( v_tot_price, '999,999,999') );

    IF v_tot_dc_price>= 50000 THEN
        v_deli_cost :=0 ;
        DBMS_OUTPUT.PUT_LINE('�� ��ۺ�          '|| TO_CHAR( v_deli_cost, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE('��ǰ���αݾ�       '|| TO_CHAR( v_tot_dc_mprice, '999,999,999') );
        DBMS_OUTPUT.PUT_LINE(RPAD('-',70,'-'));
        DBMS_OUTPUT.PUT_LINE('�� �������� �ݾ�    '|| TO_CHAR( v_tot_dc_price, '999,999,999') );
    else v_deli_cost := 3000;
        DBMS_OUTPUT.PUT_LINE('�� ��ۺ�          '|| TO_CHAR( v_deli_cost, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE( TO_CHAR ( 50000-v_tot_dc_price, '999,999,999') || '�� �߰� ���Ž� ���� ���');
        DBMS_OUTPUT.PUT_LINE('��ǰ���αݾ�       '||  TO_CHAR( v_tot_dc_mprice, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE(RPAD('-',75,'-'));
        v_tot_deli := v_tot_dc_price+v_deli_cost;
        DBMS_OUTPUT.PUT_LINE('�� �������� �ݾ�    '|| TO_CHAR ( v_tot_deli, '999,999,999') );
    END IF ;
    DBMS_OUTPUT.PUT_LINE('���Ž� '|| TO_CHAR( TRUNC(v_tot_dc_price * 0.001), '999,999') ||'�� ��������');
END;

EXEC UP_SEE_CART(1);




SELECT *
FROM oh_usr;

SELECT *
FROM oh_product;

SELECT *
FROM oh_cart_prdt;

SELECT *
FROM oh_cart;

INSERT INTO oh_cart_prdt VALUES( 1, 1, 8 ) ;
INSERT INTO oh_cart_prdt VALUES( 1, 1, 2 ) ;





