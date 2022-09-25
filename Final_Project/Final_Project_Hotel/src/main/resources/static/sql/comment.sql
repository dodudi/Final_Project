drop table comments3 cascade constraints;
--1. index.jsp에서 시작 합니다.
--2. 관리자 계정 admin, 비번 1234를 만듭니다.
--3. 사용자 계정을 3개 만듭니다.

create table comments3(
  num          number       primary key,
  id           varchar2(30) references member3(id),
  content      varchar2(200),
  reg_date     date,
  board_num    number references board3(board_num) 
               on delete cascade 
  );

drop sequence com_seq3;
create sequence com_seq3;