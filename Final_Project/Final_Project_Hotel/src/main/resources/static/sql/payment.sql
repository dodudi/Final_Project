create table PAYMENT(
	PAYMENT_ID 		   VARCHAR(100) PRIMARY KEY, -- 자료형 number -> VARCHAR(100) 변경
	REZ_ID 			   NUMBER references REZ(REZ_ID),
	PAYMENT_PRICE 	   NUMBER,
	PAYMENT_DATE       DATE   default sysdate,
	COUPON_HISTORY_ID  NUMBER references COUPON_LIST(COUPON_HISTORY_ID),
	POINT_DISCOUNT 	   NUMBER
)

select * from PAYMENT
delete from PAYMENT
drop table PAYMENT


