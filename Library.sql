--Creating tables with refrence to schema diagram
create table publisher
(
name varchar(10),--Also can do name varchar(10) PRIMARY KEY,
address varchar(10),
phone int,
primary key(name)--Can also create a primary key in the table itself
);

create table library_branch
(
branch_id varchar(10) primary key,
branch_name varchar(10),
address varchar(20)
);

create table book
(
book_id varchar(5) PRIMARY KEY,
title varchar(20),
pub_name varchar(10),
pub_year int,
foreign key(pub_name) references publisher(name)
);

create table book_authors
(
	book_id varchar(5),
	author_name varchar(15),
	primary key(book_id,author_name),
	foreign key(book_id) references book(book_id) on delete cascade
);

create table book_copies
(
	book_id varchar(5),
	branch_id varchar(10),
	no_of_copies int,
	primary key(book_id,branch_id),
	foreign key(book_id) references book(book_id) on delete cascade,
	foreign key(branch_id) references library_branch(branch_id) on delete cascade,
);

create table book_lending
(
	book_id varchar(5),
	branch_id varchar(10),
	card_no varchar(20),
	primary key(book_id,branch_id,card_no),
	foreign key(book_id) references book(book_id) on delete cascade,
	foreign key(branch_id) references library_branch(branch_id) on delete cascade
);
--Forgot to add the date attributes cause im fockinh dumb so added here
alter table book_lending add date_out date;
alter table book_lending add due_date date;

--time to insert stuff baby(moists voice)
--I take it back its pretty shitty way of inserting

insert into publisher values('Rajesh','hobo',911);
insert into publisher values('mcgraw','hobo',108);
insert into publisher values('pearson','nagpur',911);
select *from publisher;

insert into book values('1539','Hugh Jazz','Rajesh',2016);
insert into book values('113','pythonBig','mcgraw',2010);
insert into book values('112','management','pearson',2006);
insert into book values('114','computer','pearson',2008);
select *from book;

insert into library_branch values('3456','WeLoveBall','Hobo');
insert into library_branch values('3457','BookLove','Usa');
select *from library_branch;

insert into book_authors values('1539','Rajesh');
insert into book_authors values('113','mcgraw');
insert into book_authors values('112','pearson');
insert into book_authors values('114','pearson');
select *from book_authors;

insert into book_copies values('113','3456',5);
insert into book_copies values('113','3457',5);
insert into book_copies values('114','3456',1);
select *from book_copies; 

insert into book_lending values('113','3456','99','2020-05-24','2020-05-28');
insert into book_lending values('113','3457','98','2020-06-10','2020-07-29');
select *from book_lending;


--retrieving data
--Getting details of all book in the library -- id,title,name of publisher,authors, copies in each branch etc
--Get th eparticulars of borrowers who have borrowed more than 3 books , but from jun 2017

