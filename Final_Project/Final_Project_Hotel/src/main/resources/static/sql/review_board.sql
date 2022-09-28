create table REVIEW_BOARD ( -- 파일 관련 컬럼 삭제
	REVIEW_NUM 		 NUMBER primary key,
	MEM_ID 			 VARCHAR2(30) references MEMBER(MEM_ID),
	REVIEW_PASS 	 VARCHAR2(300),
	REVIEW_SUBJECT   VARCHAR2(300),
	REVIEW_CONTENT   VARCHAR2(1000),
	REVIEW_DATE 	 DATE default sysdate,
	REVIEW_READCOUNT NUMBER,
	REVIEW_RECOMM 	 NUMBER
)

-- 리뷰글 댓글
create table REVIEW_COMMENT (
  REVIEW_COMMENT_NUM	  number       primary key,
  REVIEW_NUM    		  number references REVIEW_BOARD(REVIEW_NUM) on delete cascade,
  MEM_ID 			      VARCHAR2(30) references MEMBER(MEM_ID),
  REVIEW_COMMENT_CONTENT  varchar2(200),
  REVIEW_COMMENT_DATE     date
);  