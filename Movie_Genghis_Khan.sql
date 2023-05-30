USE Geghis_Khan_Returns_Movies;

--Creating Table ACTOR
create table actor
(
	act_id varchar(50) PRIMARY KEY,
	act_name varchar(150),
	act_gender varchar(60),
);
--Creating Table DIRECTOR
create table director
(
	 dir_id varchar(50) PRIMARY KEY	,
	 dir_name varchar(150),
	 dir_phone bigint,
);
--Creating Table MOVIES
create table movies
(
	mov_id varchar(50) PRIMARY KEY,
	mov_title varchar(250),
	mov_year int,
	mov_lang varchar(100),
	dir_id varchar(50),
	foreign key(dir_id) references director(dir_id) on delete cascade
);

--Creating Table Movie Cast
create table movie_cast
(
	act_id varchar(50),
	mov_id varchar(50),
	role varchar(100),
	primary key(act_id, mov_id),
	foreign key(act_id) references actor(act_id) on delete cascade,
	foreign key(mov_id) references movies(mov_id) on delete cascade
);

--Creating Table Rating
create table rating
(
	rat_id varchar(50) PRIMARY KEY,
	mov_id varchar(50),
	rev_stars int,
	foreign key(mov_id) references movies(mov_id) on delete cascade
	
);

-- Inserting actors
INSERT INTO actor (act_id, act_name, act_gender) VALUES ('A001', 'Tom Hanks', 'Male');
INSERT INTO actor (act_id, act_name, act_gender) VALUES ('A002', 'Emma Stone', 'Female');
INSERT INTO actor (act_id, act_name, act_gender) VALUES ('A003', 'Brad Pitt', 'Male');
INSERT INTO actor (act_id, act_name, act_gender) VALUES ('A004', 'Meryl Streep', 'Female');
INSERT INTO actor (act_id, act_name, act_gender) VALUES ('A005', 'Leonardo DiCaprio', 'Male');
INSERT INTO actor (act_id, act_name, act_gender) VALUES ('A006', 'Jennifer Lawrence', 'Female');


-- Inserting directors

INSERT INTO director (dir_id, dir_name, dir_phone) VALUES ('D004', 'Quentin Tarantino', 5556667777);
INSERT INTO director (dir_id, dir_name, dir_phone) VALUES ('D005', 'Alfred Hitchcock', 9998887777);
INSERT INTO director (dir_id, dir_name, dir_phone) VALUES ('D006', 'James Cameron', 4443332222);
INSERT INTO director (dir_id, dir_name, dir_phone) VALUES ('D001', 'Christopher Nolan', 1234567890);
INSERT INTO director (dir_id, dir_name, dir_phone) VALUES ('D002', 'Steven Spielberg', 9876543210);
INSERT INTO director (dir_id, dir_name, dir_phone) VALUES ('D003', 'Martin Scorsese', 1112223333);

-- Inserting movies

INSERT INTO movies (mov_id, mov_title, mov_year, mov_lang, dir_id) VALUES ('M004', 'Pulp Fiction', 1994, 'English', 'D004');
INSERT INTO movies (mov_id, mov_title, mov_year, mov_lang, dir_id) VALUES ('M005', 'Psycho', 1960, 'English', 'D005');
INSERT INTO movies (mov_id, mov_title, mov_year, mov_lang, dir_id) VALUES ('M006', 'Avatar', 2009, 'English', 'D006');
INSERT INTO movies (mov_id, mov_title, mov_year, mov_lang, dir_id) VALUES ('M001', 'Inception', 2010, 'English', 'D001');
INSERT INTO movies (mov_id, mov_title, mov_year, mov_lang, dir_id) VALUES ('M002', 'Jurassic Park', 1993, 'English', 'D002');
INSERT INTO movies (mov_id, mov_title, mov_year, mov_lang, dir_id) VALUES ('M003', 'The Departed', 2006, 'English', 'D003');
INSERT INTO movies (mov_id, mov_title, mov_year, mov_lang, dir_id) VALUES ('M007', 'Stop Time', 2012, 'English', 'D001');

-- Inserting movie cast
INSERT INTO movie_cast (act_id, mov_id, role) VALUES ('A004', 'M004', 'Margaret Booth');
INSERT INTO movie_cast (act_id, mov_id, role) VALUES ('A005', 'M004', 'Vincent Vega');
INSERT INTO movie_cast (act_id, mov_id, role) VALUES ('A006', 'M004', 'Mia Wallace');
INSERT INTO movie_cast (act_id, mov_id, role) VALUES ('A001', 'M001', 'Cobb');
INSERT INTO movie_cast (act_id, mov_id, role) VALUES ('A002', 'M001', 'Arthur');
INSERT INTO movie_cast (act_id, mov_id, role) VALUES ('A003', 'M001', 'Eames');
INSERT INTO movie_cast (act_id, mov_id, role) VALUES ('A003', 'M007', 'Dio');
INSERT INTO movie_cast (act_id, mov_id, role) VALUES ('A005', 'M007', 'Jotaro');


-- Inserting movie ratings
INSERT INTO rating (rat_id, mov_id, rev_stars) VALUES ('R004', 'M004', 5);
INSERT INTO rating (rat_id, mov_id, rev_stars) VALUES ('R005', 'M005', 4);
INSERT INTO rating (rat_id, mov_id, rev_stars) VALUES ('R006', 'M006', 4);
INSERT INTO rating (rat_id, mov_id, rev_stars) VALUES ('R001', 'M001', 5);
INSERT INTO rating (rat_id, mov_id, rev_stars) VALUES ('R002', 'M002', 4);
INSERT INTO rating (rat_id, mov_id, rev_stars) VALUES ('R003', 'M003', 4);
INSERT INTO rating (rat_id, mov_id, rev_stars) VALUES ('R007', 'M007', 5);

select * from movies;

--Queries
--1. Select all Movie directed by Cristopher Nolan
SELECT m.mov_title from movies m,director d where m.dir_id=d.dir_id and d.dir_name = 'Christopher Nolan'; 


--2. Movie names where one or more actors acted in 2 or more movies
select distinct mov_title from movies m, movie_cast mc where m.mov_id=mc.mov_id and (select count(mov_id) from movie_cast where act_id=mc.act_id)>=2;

--3 List all actors who acted in a movie before 2000 and also in a movie after 2015
select act_name from actor a join movie_cast mc on a.act_id=mc.act_id join movies
m on mc.mov_id = m.mov_id where m.mov_year<2004 intersect select act_name from 
actor a join movie_cast mc on a.act_id=mc.act_id join movies m on mc.mov_id = m.mov_id where m.mov_year>2010;