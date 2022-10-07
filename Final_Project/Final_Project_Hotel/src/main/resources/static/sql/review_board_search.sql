create table REVIEW_BOARD_SEARCH (
	SEARCH_WORD  varchar2(30) primary key,
	SEARCH_COUNT number,
	SEARCH_DATE  date
)

select * from REVIEW_BOARD_SEARCH

delete from REVIEW_BOARD_SEARCH where SEARCH_WORD = ''


select ROWNUM, SEARCH_WORD
from ( select *
	   from     REVIEW_BOARD_SEARCH
	   order by SEARCH_COUNT desc, SEARCH_DATE desc
	 )
WHERE ROWNUM <= 10;


