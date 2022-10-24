--예약테스트에서 delete 필요
create table PAYMENT(
	PAYMENT_ID 		   VARCHAR(100) PRIMARY KEY, -- 자료형 number -> VARCHAR(100) 변경
	REZ_ID 			   NUMBER references REZ(REZ_ID) on delete cascade, -- on delete cascade 추가
	PAYMENT_PRICE 	   NUMBER,
	PAYMENT_DATE       DATE   default sysdate,
	POINT_DISCOUNT 	   NUMBER
);

select * from PAYMENT;
delete from rez
where REZ_ID = 1;

drop table PAYMENT;
drop table OPTION_RESERVATION;
drop table REZ;

delete from payment;
commit;