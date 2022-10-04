create table room (
	ROOM_ID		NUMBER primary key,
	ROOM_TYPE	VARCHAR2(30),
	ROOM_PRICE	NUMBER,
	ROOM_IMG	VARCHAR2(30),
	ROOM_MAX	NUMBER,
	ROOM_DETAIL	VARCHAR2(1000),
	ROOM_STATE	VARCHAR2(10) check (ROOM_STATE in ('N', 'Y'))
)

insert into room values(1, '싱글룸', 100000, '', 1, '혼자 머무는 편안한 객실','')
insert into room values(2, '싱글룸', 100000, '', 1, '혼자 머무는 편안한 객실','')
insert into room values(3, '싱글룸', 100000, '', 1, '혼자 머무는 편안한 객실','')
insert into room values(4, '더블룸', 200000, '', 2, '둘이 머무는 편안한 객실','')
insert into room values(5, '더블룸', 200000, '', 2, '둘이 머무는 편안한 객실','')
insert into room values(6, '더블룸', 200000, '', 2, '둘이 머무는 편안한 객실','')
insert into room values(7, '트리플룸', 400000, '', 3, '넓은 공간의 편안한 객실','')
insert into room values(8, '패밀리룸', 700000, '', 4, '최대 4인 최고급 객실', '')



select * from room order by ROOM_ID;
drop table room;
delete from room;