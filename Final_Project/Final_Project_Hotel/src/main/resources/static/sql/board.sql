drop table board3 cascade constraints;
--1. index.jsp에서 시작 합니다.
--2. 관리자 계정 admin, 비번 1234를 만듭니다.
--3. 사용자 계정을 3개 만듭니다.

create table BOARD3(
	board_num		number,				--글번호 
	board_name		varchar2(30),		--작성자 
	board_pass		varchar2(30),		--비밀번호 
	board_subject	varchar2(300),		--제목 
	board_content	varchar2(4000),		--내용 
	board_file		varchar2(50),		--첨부파일명(가공)
	board_original	varchar2(50),		--첨부파일명 
	board_re_ref	number,				--답변 글 작성시 참조되는 글 번호 
	board_re_lev	number,				--답변 글의 깊이 
	board_re_seq	number,				--답변 글의 순서 
	board_readcount	number,				--글의 조회수 
	board_date date,					--글의 작성 날짜 
	PRIMARY	KEY(board_num)
);

CREATE TABLE BOARD(
	BOARD_NUM       NUMBER,         --글 번호
	BOARD_NAME      VARCHAR2(30),   --작성자
	BOARD_PASS      VARCHAR2(30),   --비밀번호
	BOARD_SUBJECT   VARCHAR2(300),  --제목
	BOARD_CONTENT   VARCHAR2(4000), --내용
	BOARD_FILE      VARCHAR2(50),   --첨부 파일 명(가공)
	BOARD_ORIGINAL  VARCHAR2(50),   --첨부 파일 명
	BOARD_RE_REF    NUMBER,    --답변 글 작성시 참조되는 글의 번호
	BOARD_RE_LEV    NUMBER,    --답변 글의 깊이
	BOARD_RE_SEQ    NUMBER,    --답변 글의 순서
	BOARD_READCOUNT NUMBER,    --글의 조회수
	BOARD_DATE DATE,           --글의 작성 날짜
	PRIMARY KEY(BOARD_NUM)
);

select * from board3;

select nvl(max(board_num),0)+1 from board3;

alter table board3 drop column memberfile;

delete board3 where board_num=7;

delete from board3;