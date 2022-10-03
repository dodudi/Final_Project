create table options (
	OPTION_ID 		 	  NUMBER primary key,
	OPTION_NAME 		  VARCHAR(20),
	OPTION_DEFAULT_PRICE  NUMBER,
	OPTION_CHILD_PRICE 	  NUMBER
)

select * from options;



insert into options values (1, '조식', 29000, 19000);
insert into options values (2, '디너', 39000, 29000);
insert into options values (3, '수영장', 20000, 10000);
