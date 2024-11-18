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

create table application(
	appl_num number not null,
	field number(1) not null,
	appl_status number(1) default 1 not null, 
	appl_attachment varchar2(400),
	appl_regdate date default sysdate not null,
	appl_modifydate date,
	career number(1) not null,
	content varchar2(1500) not null,
	source varchar2(150),
	appl_center number(3) not null,
	user_num number not null,
	constraint application_pk primary key (appl_num),
	constraint application_fk foreign key (user_num) references suser (user_num)
);

create sequence appl_seq;