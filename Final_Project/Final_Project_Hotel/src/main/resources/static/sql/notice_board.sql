drop table notice_board;
create table notice_board (
  NOTICE_NUM        NUMBER         PRIMARY KEY,
  NOTICE_SUBJECT    VARCHAR2(100)  NOT NULL,
  NOTICE_CONTENT    VARCHAR2(3000) NOT null,
  NOTICE_ORIGINAL   VARCHAR2(300),
  NOTICE_FILE       VARCHAR2(300),
  NOTICE_READCOUNT  NUMBER,
  NOTICE_DATE       DATE DEFAULT SYSDATE NOT NULL,
)

select * from notice_board;
create sequence NOTICE_SEQ start with 1 increment by 1;