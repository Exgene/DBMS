--Salesman Database


use Genghhis_Khan_Salesman;

create table salesman
(
	salesman_id varchar(5),
	name varchar(15),
	city varchar(15),
	commision int
	primary key(salesman_id)
);

create table customer
(
	customer_id varchar(5),
	cust_name varchar(15),
	city varchar(15),
	grade int,
	primary key(customer_id)
);

create table orders
(
	ord_no varchar(5),
	purchase_amt int,
	ord_date date,
	customer_id varchar(5),
	salesman_id varchar(5),
	primary key(ord_no),
	foreign key(customer_id) references customer(customer_id) on delete cascade,
	foreign key(salesman_id) references salesman(salesman_id) on delete cascade
);

select * from orders;

-- Insert statements for the "salesman" table
INSERT INTO salesman (salesman_id, name, city, commision) VALUES
('S001', 'John Doe', 'New York', 10),
('S002', 'Jane Smith', 'Los Angeles', 12),
('S003', 'David Johnson', 'Chicago', 8),
('S004', 'Robert Smith', 'New York', 10),
('S005', 'Sarah Johnson', 'Los Angeles', 12),
('S006', 'Michael Davis', 'Chicago', 8),
('S007', 'Joseph Lee', 'London', 10),
('S008', 'Emily Wilson', 'Paris', 12);

-- Insert statements for the "customer" table
INSERT INTO customer (customer_id, cust_name, city, grade) VALUES
('C001', 'ABC Company', 'New York', 5),
('C002', 'XYZ Corporation', 'Los Angeles', 3),
('C003', '123 Industries', 'Chicago', 2),
('C004', 'PQR Corporation', 'Bangalore', 4),
('C005', 'LMN Industries', 'Bangalore', 3),
('C006', 'DEF Company', 'Bangalore', 5);

-- Insert statements for the "orders" table
INSERT INTO orders (ord_no, purchase_amt, ord_date, customer_id, salesman_id) VALUES
('O001', 500, '2023-06-10', 'C001', 'S001'),
('O002', 1000, '2023-06-11', 'C002', 'S002'),
('O003', 750, '2023-06-12', 'C003', 'S003'),
('O004', 1200, '2023-06-13', 'C004', 'S004'),
('O005', 900, '2023-06-13', 'C004', 'S005'),
('O006', 800, '2023-06-13', 'C005', 'S004'),
('O007', 600, '2023-06-13', 'C006', 'S005');

select * from salesman;

--Q1 Check Github for questions
select count(*) as count from customer where grade>(select avg(grade) from customer where city='Bangalore');

--Q2
select s.salesman_id,s.name,count(o.customer_id) from salesman s, orders o where s.salesman_id=o.salesman_id group by s.salesman_id,s.name having count(o.customer_id)>1;

--Q3
SELECT s.salesman_id, s.name, s.city, 'Has Customers' AS status
FROM salesman s
WHERE EXISTS (
    SELECT 1
    FROM customer c
    WHERE c.city = s.city
)
UNION
SELECT s.salesman_id, s.name, s.city, 'No Customers' AS status
FROM salesman s
WHERE NOT EXISTS (
    SELECT 1
    FROM customer c
    WHERE c.city = s.city
);

--Sirs method for the same thing can be written as
--Downgraded version ngl
select name,'exists' as same_city
from salesman s
where city in 
	(select city
	from customer c, orders o
	where s.salesman_id=o.salesman_id and o.customer_id=c.customer_id)
union
select name,'non exists' as same_city
from salesman s where
city not in 
	(select city
	from customer c, orders o
	where s.salesman_id=o.salesman_id and o.customer_id=c.customer_id);

--At this point kausthubh if youre reading this you are not mentally sane 

--Q4
create view highest_order as 
	select s.salesman_id,s.name,o.purchase_amt,o.ord_date
	from salesman s,orders o
	where s.salesman_id=o.salesman_id;

	select name,ord_date
	from highest_order h
	where purchase_amt=(select max(purchase_amt)
	from hgihest_order
	where h.ord_date=ord.date);