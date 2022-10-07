create table REVIEW_BOARD_SEARCH (
	SEARCH_WORD  varchar2(30) primary key,
	SEARCH_COUNT number,
	SEARCH_DATE  date
)

select * from REVIEW_SEARCH_WORD
delete from REVIEW_SEARCH_WORD


select SEARCH_WORD
from ( select *
	   from     REVIEW_SEARCH_WORD
	   order by SEARCH_COUNT desc, SEARCH_DATE desc
	 )
WHERE ROWNUM <= 3;


