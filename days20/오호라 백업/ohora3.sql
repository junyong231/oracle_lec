-- 결제
--결제 전에 재고수 검사 -> 재고 딸리면 예외처리		
--결제먼저	결제를 프로시저를 실행하면 (적립금, 쿠폰 적용된 금액 결제되고, 결제수단은 파라미터로 그냥..) 그 정보가 주문상세에 들어가고		
--장바구니에서 체크한거만 결제 , 쿠폰 사용여부 컬럼 만들어서 환불하면 쿠폰 돌려주게(부활) , 적립금 등급맞게 적립시켜주고 		
-- 체크안한건 살아있어야됨


-- 1. 유저는 카트를 한개만 갖는다 : 맞지
-- 2. 카트에서 체크한 것만 가져온다. : 맞음

--일단 cart_prdt에 체크드 만들고
-- 

-- 장바구니 보기
-- 장바구니 빼기 (체크드 고려)
-- 장바구니 넣기 ( 재고수 고려)
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
    v_tot_dc_price NUMBER  := 0 ; --총 할인가
    v_deli_cost NUMBER  := 0 ;--배송비
    v_tot_dc_mprice NUMBER  := 0 ; -- 상품할인금액
     v_tot_deli NUMBER := 0 ; --총 상품금액이 5만원 미만일때 배송비를 포함한 총결제금액
    v_tot_price NUMBER  := 0 ; --총 상품금액
     
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
 
    DBMS_OUTPUT.PUT_LINE('총 상품금액        '|| TO_CHAR( v_tot_price, '999,999,999') );

    IF v_tot_dc_price>= 50000 THEN
        v_deli_cost :=0 ;
        DBMS_OUTPUT.PUT_LINE('총 배송비          '|| TO_CHAR( v_deli_cost, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE('상품할인금액       '|| TO_CHAR( v_tot_dc_mprice, '999,999,999') );
        DBMS_OUTPUT.PUT_LINE(RPAD('-',70,'-'));
        DBMS_OUTPUT.PUT_LINE('총 결제예정 금액    '|| TO_CHAR( v_tot_dc_price, '999,999,999') );
    else v_deli_cost := 3000;
        DBMS_OUTPUT.PUT_LINE('총 배송비          '|| TO_CHAR( v_deli_cost, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE( TO_CHAR ( 50000-v_tot_dc_price, '999,999,999') || '원 추가 구매시 무료 배송');
        DBMS_OUTPUT.PUT_LINE('상품할인금액       '||  TO_CHAR( v_tot_dc_mprice, '999,999,999'));
        DBMS_OUTPUT.PUT_LINE(RPAD('-',75,'-'));
        v_tot_deli := v_tot_dc_price+v_deli_cost;
        DBMS_OUTPUT.PUT_LINE('총 결제예정 금액    '|| TO_CHAR ( v_tot_deli, '999,999,999') );
    END IF ;
    DBMS_OUTPUT.PUT_LINE('구매시 '|| TO_CHAR( TRUNC(v_tot_dc_price * 0.001), '999,999') ||'원 적립예정');
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





