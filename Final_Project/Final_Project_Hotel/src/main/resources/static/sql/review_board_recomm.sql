-- 리뷰글 추천 테이블
create table REVIEW_BOARD_RECOMM (
  RECOMM_ID	  number       primary key,
  REVIEW_NUM  number       references REVIEW_BOARD(REVIEW_NUM) on delete cascade,
  MEM_ID 	  VARCHAR2(30) references MEMBER(MEM_ID) on delete cascade
);

drop table REVIEW_BOARD_RECOMM