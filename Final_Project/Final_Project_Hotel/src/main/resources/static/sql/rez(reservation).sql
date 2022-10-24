--예약 테스트떄 delete 필요
create table REZ (
	REZ_ID 		 NUMBER 	  primary key,
	ROOM_ID 	 NUMBER 	  references ROOM(ROOM_ID),
	MEM_ID 		 VARCHAR2(30) references MEMBER(MEM_ID)  on delete cascade,
	REZ_CHECKIN  DATE,
	REZ_CHECKOUT DATE,
	REZ_ADULT 	 NUMBER,
	REZ_CHILD 	 NUMBER
);
drop table REZ

select * from rez;

commit;
delete from rez where MEM_ID = 'B1234'

delete from member
where MEM_ID = 'S1234'

select * from question_board

delete from OPTION_RESERVATION where REZ_ID = 4;



delete from rez;
