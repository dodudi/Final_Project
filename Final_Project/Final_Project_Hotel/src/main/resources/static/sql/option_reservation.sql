--예약 테스트시 delete 필요
create table OPTION_RESERVATION(
	OPTION_RESERVATION_ID   NUMBER primary key,
	REZ_ID 				    NUMBER references REZ(REZ_ID) on delete cascade, -- on delete cascade 추가
	OPTION_ID 			    NUMBER references OPTIONS(OPTION_ID),
	OPTION_RESERVATION_DATE date,
	ADULT 					NUMBER,
	CHILD 					NUMBER
);

/*
    1 조식
    2 디너
    3 수영
*/
select * from OPTION_RESERVATION order by OPTION_RESERVATION_DATE, OPTION_ID;
select * from OPTION_RESERVATION where REZ_ID = 1 order by OPTION_RESERVATION_DATE, OPTION_ID;
delete from OPTION_RESERVATION;



drop table OPTION_RESERVATION


SELECT * FROM OPTION_RESERVATION OPTREZ WHERE OPTREZ.REZ_ID =  (SELECT REZ_ID FROM REZ WHERE MEM_ID='user01');
