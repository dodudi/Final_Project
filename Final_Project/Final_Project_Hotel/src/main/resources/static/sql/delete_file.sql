drop table delete_file purge;

create table delete_file(
	board_file varchar2(50),
	reg_date date default sysdate
);

select * from delete_file;

drop tigger save_delete_file;

select trigger_name from user_triggers;

--sts에서 실행하는 경우는 16~28번 라인(/미포함) 영역 설정 후 excute selected text as one statement 선택 
--cmd창에서 실행하는 경우는 16~29라인 복사해서 붙여넣기(/포함)
create or replace trigger save_delete_file
after update or delete
on board2
 for each row
 begin
   if(:old.board_file is not null) then
    if(:old.board_file != :new.board_file or :new.board_file is null ) then
	     insert into delete_file
	      (board_file)
	     values(:old.board_file);
     end if;
   end if;
 end;
/

