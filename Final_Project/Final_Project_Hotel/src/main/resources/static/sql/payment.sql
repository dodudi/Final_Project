create table PAYMENT(
	PAYMENT_ID 		   VARCHAR(100) PRIMARY KEY, -- 자료형 number -> VARCHAR(100) 변경
	REZ_ID 			   NUMBER references REZ(REZ_ID),
	PAYMENT_PRICE 	   NUMBER,
	PAYMENT_DATE       DATE   default sysdate
	--COUPON_HISTORY_ID  NUMBER references COUPON_LIST(COUPON_HISTORY_ID),
	--POINT_DISCOUNT 	   NUMBER
);

select * from PAYMENT
delete from PAYMENT
drop table PAYMENT


create table MEMBER(
    MEM_ID VARCHAR2(30) PRIMARY,
	MEM_PASS			varchar2(30),
	MEM_NAME	varchar2(60),	 
	MEM_EMAIL		varchar2(15),
    MEM_PHONE       NUMBER,
	MEM_ADDRESS		varchar2(30),
    MEM_ADDRESS2, VARCHAR2(30),
	MEM_POINT   NUMBER
);
drop table MEMBER;

INSERT INTO MEMBER VALUES('user01', '1234', '김길동', '010-1111-1111', 'user01@naver.com', '1');
commit;

