-- 리뷰글 댓글
create table REVIEW_COMMENT (
  REVIEW_COMMENT_NUM	  number primary key, -- 댓글 번호
  REVIEW_NUM    		  number references REVIEW_BOARD(REVIEW_NUM) on delete cascade, -- 댓글 작성된 리뷰글
  MEM_ID 			      VARCHAR2(30) references MEMBER(MEM_ID), -- 작성자
  REVIEW_COMMENT_RE_REF       number, -- 답댓글 작성시 참조되는 댓글 번호 (원댓 번호)
  REVIEW_COMMENT_RE_LEV       number, --댓글의 깊이 (원댓:0, 답댓:1, 답댓의 답댓2, 답댓의 답댓의 답댓: 3)
  REVIEW_COMMENT_RE_SEQ       number, --답댓의 순서(원댓 기준으로 보여주는 순서) --새로운 답댓이 달리면 새로운 답댓이 기존 답댓의 SEQ가 되고, 기존 답댓은 1 증가된다.
  REVIEW_COMMENT_CONTENT  varchar2(200),
  REVIEW_COMMENT_DATE     date,
  REVIEW_COMMENT_REVISION VARCHAR2(10) check (REVIEW_COMMENT_REVISION in ('N', 'Y'))
);

select * from  REVIEW_COMMENT where MEM_ID = 'B1234' 
-- 댓글 조회
select *
from ( select rownum rnum, b.*
       from   ( select REVIEW_COMMENT.*
          		from REVIEW_COMMENT
          		where REVIEW_NUM = 16
          		order by REVIEW_COMMENT_RE_REF desc, REVIEW_COMMENT_RE_SEQ asc ) b
       where rownum <= 10) -- #{end}     
 where rnum >=1 and rnum <=10   -- #{start}  #{end}
 -----
 select * from 
  ( select rownum rnum, b.*
    from 
         (select * from board 
          order by BOARD_RE_REF desc, 
          BOARD_RE_SEQ asc) b
    where rownum &lt;=  #{end}      
   ) 
 where rnum &gt;= #{start} and rnum  &lt;=  #{end}
 
 
 

select count(*) from REVIEW_COMMENT where REVIEW_NUM = 1;
select * from REVIEW_COMMENT ;
delete from REVIEW_COMMENT
drop table REVIEW_COMMENT;

