create table board(
	board_num number not null,
	board_category number(1) not null, --1:공지사항, 2:자유게시판, 3:오늘 운동 완료
	board_title varchar2(300) not null,
	board_content clob not null,
	board_attachment varchar2(400),
	board_regdate date default not null sysdate,
	board_modifydate date,
	board_count number(9) default 0 not null,	
	user_num number not null,
	constraint board_pk primary key (board_num),
	constraint board_fk foreign key (user_num) references suser (user_num)
);

create sequence board_seq;
