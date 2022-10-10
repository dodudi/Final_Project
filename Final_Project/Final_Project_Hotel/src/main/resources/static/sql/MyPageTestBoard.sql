CREATE TABLE TBL_EVENT_BOARD(
    EVENT_NUM NUMBER PRIMARY KEY,
    EVENT_TITLE VARCHAR2(1000),
    EVENT_TEXT VARCHAR2(1000),  
    EVENT_DATE DATE DEFAULT SYSDATE,
    EVENT_START_DATE DATE,
    EVENT_END_DATE DATE,
    EVENT_READCOUNT NUMBER
)