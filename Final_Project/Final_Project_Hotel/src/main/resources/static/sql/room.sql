create table room (
	ROOM_ID		NUMBER primary key,
	ROOM_TYPE	VARCHAR2(30),
	ROOM_PRICE	NUMBER,
	ROOM_IMG	VARCHAR2(300),
	ROOM_MAX	NUMBER,
	ROOM_DETAIL	VARCHAR2(1000),
	ROOM_STATE	VARCHAR2(10) check (ROOM_STATE in ('N', 'Y')) -- 없어도 됨 삭제하기
);


insert into room values(1, '싱글룸', 100000, '/hotel/resources/room/img/singleroom.jpg', 1, '혼자 머무는 편안한 객실','N');
insert into room values(2, '싱글룸', 100000, '/hotel/resources/room/img/singleroom.jpg', 1, '혼자 머무는 편안한 객실','N');
insert into room values(3, '싱글룸', 100000, '/hotel/resources/room/img/singleroom.jpg', 1, '혼자 머무는 편안한 객실','N');
insert into room values(4, '더블룸', 200000, '/hotel/resources/room/img/doubleroom.jpg', 2, '둘이 머무는 편안한 객실','N');
insert into room values(5, '더블룸', 200000, '/hotel/resources/room/img/doubleroom.jpg', 2, '둘이 머무는 편안한 객실','N');
insert into room values(6, '더블룸', 200000, '/hotel/resources/room/img/doubleroom.jpg', 2, '둘이 머무는 편안한 객실','N');
insert into room values(7, '트리플룸', 400000, '/hotel/resources/room/img/tripleroom.jpg', 3, '3인 침대 제공하는 고급 객실','N');
insert into room values(8, '패밀리룸', 700000, '/hotel/resources/room/img/familyroom.jpg', 4, '최대 4인 최고급 객실', 'N');




select * from room order by ROOM_ID;
drop table room CASCADE CONSTRAINTS;
delete from room;

alter table room modify ROOM_IMG VARCHAR2(300)


update room set ROOM_STATE = 'N'
