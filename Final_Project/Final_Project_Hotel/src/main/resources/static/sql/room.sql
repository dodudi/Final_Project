create table room (
	ROOM_ID		NUMBER primary key,
	ROOM_TYPE	VARCHAR2(30),
	ROOM_PRICE	NUMBER,
	ROOM_IMG	VARCHAR2(30),
	ROOM_MAX	NUMBER,
	ROOM_DETAIL	VARCHAR2(1000),
	ROOM_STATE	VARCHAR2(10) check (ROOM_STATE in ('N', 'Y'))
)

select * from room order by ROOM_ID;
drop table room;
delete from room;

update room set ROOM_STATE = 'N'
