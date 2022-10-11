--예약테스트에서 delete 필요
create table PAYMENT(
	PAYMENT_ID 		   VARCHAR(100) PRIMARY KEY, -- 자료형 number -> VARCHAR(100) 변경
	REZ_ID 			   NUMBER references REZ(REZ_ID) on delete cascade, -- on delete cascade 추가
	PAYMENT_PRICE 	   NUMBER,
	PAYMENT_DATE       DATE   default sysdate,
	COUPON_HISTORY_ID  NUMBER references COUPON_LIST(COUPON_HISTORY_ID),
	POINT_DISCOUNT 	   NUMBER
);

select * from PAYMENT;
delete from rez
where REZ_ID = 1;

drop table PAYMENT;


create table MEMBER(
    MEM_ID          varchar2(30) CONSTRAINT MEMBER_PK PRIMARY KEY,
	MEM_PASS        varchar2(30),
	MEM_NAME	    varchar2(60),	 
	MEM_EMAIL	    varchar2(1000),
    MEM_PHONE       NUMBER,
	MEM_ADDRESS	    varchar2(30),
    MEM_ADDRESS2   varchar2(30),
	MEM_POINT       NUMBER
);
drop table MEMBER;
SELECT * FROM MEMBER WHERE MEM_ID = 'user01';
SELECT * FROM MEMBER;
INSERT INTO MEMBER VALUES('user01', '1234', '김길동', 'user01@naver.com', 01011111111, 'ADDRESS1','ADDRESS2', 1000);
commit;

