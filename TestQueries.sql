create table persons --Creating the table (It only defines the table)
(
personid int,
lastname varchar(255),
firstname varchar(255),
address varchar(255),
city varchar(255),
);

--Deleting the table
--Also select the query you want to execute first before clicking execute

drop table persons;

--You can re execute any queries any amounts of time
--Use alter table statements to modify the table already present (add new attribute, remove existing ones etc)

alter table persons add phone_no int; -- added new column phone_no
alter table persons drop column phone_no; -- Deleted a colummn named phone_no
alter table persons alter column phone_no varchar(10); --Modify the existing column

--Adding primary key
alter table persons add primary key ()
