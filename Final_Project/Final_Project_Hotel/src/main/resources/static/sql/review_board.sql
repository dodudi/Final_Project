create table REVIEW_BOARD ( -- 파일 관련 컬럼 삭제
	REVIEW_NUM 		 NUMBER primary key,
	MEM_ID 			 VARCHAR2(30) references MEMBER(MEM_ID) on delete cascade,
	REVIEW_PASS 	 VARCHAR2(300),
	REVIEW_SUBJECT   VARCHAR2(300),
	REVIEW_CONTENT   VARCHAR2(3000), -- 크기 변경
	REVIEW_DATE 	 DATE default sysdate,
	REVIEW_READCOUNT NUMBER,
	REVIEW_RECOMM 	 NUMBER
)

select * from REVIEW_BOARD
where REVIEW_SUBJECT like '%조식%' or REVIEW_SUBJECT like '%후기%'
order by REVIEW_DATE desc


drop table REVIEW_COMMENT;
drop table REVIEW_BOARD;