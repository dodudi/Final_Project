create table REVIEW_BOARD ( -- 파일 관련 컬럼 삭제
	REVIEW_NUM 		 NUMBER primary key,
	MEM_ID 			 VARCHAR2(30) references MEMBER(MEM_ID),
	REVIEW_PASS 	 VARCHAR2(300),
	REVIEW_SUBJECT   VARCHAR2(300),
	REVIEW_CONTENT   VARCHAR2(3000), -- 크기 변경
	REVIEW_DATE 	 DATE default sysdate,
	REVIEW_READCOUNT NUMBER,
	REVIEW_RECOMM 	 NUMBER--없어도 될듯? 해보고지우기
)

select * from REVIEW_BOARD
where REVIEW_SUBJECT like '%조식%' or REVIEW_SUBJECT like '%후기%'
order by REVIEW_DATE desc


-- 리뷰글 추천 테이블
create table REVIEW_BOARD_RECOMM (
  RECOMM_ID	  number       primary key,
  REVIEW_NUM  number       references REVIEW_BOARD(REVIEW_NUM) on delete cascade,
  MEM_ID 	  VARCHAR2(30) references MEMBER(MEM_ID) on delete cascade
);


drop table REVIEW_COMMENT;
drop table REVIEW_BOARD;