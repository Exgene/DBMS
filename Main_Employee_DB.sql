use Employee_DBAIAIAI;

--We donot include foreign key directly due to citcular dependency of EMPLOYEE and DEPARTMENT 
--Employee requires DNO as foreign key but DEPARMENT requires mgrssn which refer SSN hence you update it later
create table department
(
dno varchar(5),
dname varchar(25),
mgrssn varchar(5),
mgrstartdate date,
primary key(dno)
)


create table employee
(
ssn varchar(5),
name varchar(15),
address varchar(50),
sex varchar(7),
salary int,
superssn varchar(5),
dno varchar(5),
primary key(ssn),
);

alter table employee add constraint fk1 foreign key(dno) references department(dno) on delete cascade;
alter table employee add constraint fk2 foreign key(superssn) references employee(ssn);
alter table department add constraint fk3 foreign key(mgrssn) references employee(ssn);

create table dlocation 
( 
dno varchar(5), 
dloc varchar(15), 
primary key (dno,dloc), 
foreign key(dno) references department(dno) on delete cascade 
); 

create table project 
( 
pno varchar(5), 
pname varchar(10), 
plocation varchar(10), 
dno varchar(5), 
primary key(pno), 
foreign key(dno) references department(dno) on delete cascade 
); 

create table works_on 
( 
ssn varchar(5), 
pno varchar(5), 
hours int, 
primary key(ssn,pno), 
foreign key(ssn) references employee(ssn) on delete cascade, 
foreign key(pno) references project(pno) on delete no action
);

--Insert
insert into department values
('1','networks',NULL,'10-JUN-13'),
('2','data mining',NULL,'17-OCT-10');

insert into employee values
('555','brian a smith','texas','male',70000,'222','2'),
('666','alicia zelaya','colarado','female',50000,'333','1'),
('777','julian smith','las vegas','female',70000,'333','2'),
('111','john b smith','nevada','male',65000,NULL,'1'),
('222','ramesh narayan','nebraska','male',80000,'111','2'),
('333','ahmad jabbar','san jose','male',75000,'111','1'),
('444','joyce a english','los angeles','female',65000,'222','1')

update department set mgrssn = '111' where dno='1';
update department set mgrssn = '333' where dno='2';

insert into dlocation values
('1','stanford'),
('2','houston'),
('1','vegas'),
('2','texas')

insert into project values 
('11','iot','texas','1'),
('12','webmining','texas','2'),
('13','sensors','vegas','1'),
('14','routing','stanford','1'),
('15','cluster','houston','2')

insert into works_on values
('555','11','4'),
('666','12','4'),
('666','15','3'),
('666','13','3'),
('777','14','2'),
('222','11','4'),
('444','15','3'),
('777','15','3')

select * from project;
select * from works_on;
select * from department;
select * from employee;
select * from dlocation;