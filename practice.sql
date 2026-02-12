select * from city;

select id, district, population from city;

-- write a query that tells the population of each district along with the country
select countrycode, District, Population from city;

select * from city where population > 1000000;

-- output all the column where country is AFG
select * from city where countrycode='AFG';

-- output all the column and rows except AFG
select * from city where countrycode <> 'AFG';
select * from city where countrycode != 'AFG';

-- Name, countrycode and population of Zuid-Holland
select name, countrycode, population from city where district='Zuid-Holland';

select * from city order by Population desc;

select * from city order by District desc;

-- output all the columns where country is in ascending order and ID is in descending order
select * from city order by CountryCode asc, id desc;

select * from city order by id desc, countrycode asc;

-- sum, avg, count, min, max

select * from city;

select District, avg(population) from city group by District;

select countrycode , sum(population) from city group by CountryCode;

select count(*) from city where district = "Noord-Brabant";

select * from country where Region="Antarctica";

-- the avg life expectancy of each continent of country table
select Continent, avg(lifeexpectancy) from country group by continent;

-- the sum of population of each continent of country table
select continent, sum(population) from country group by Continent;

-- sum of gnp, avg of capital of each country(name), region wise

select region, Name,sum(gnp), avg(capital) from country group by Region, Name;

 SELECT 
    region,
    name AS country_name,
    SUM(gnp) AS total_gnp,
    AVG(capital) AS avg_capital
FROM country
GROUP BY region, name
ORDER BY region;

-- total population of continent where GovernemtForm is republic 
select continent,GovernmentForm, sum(population) from country where GovernmentForm="Republic" group by continent;

select * from city;

select countrycode, sum(Population) 
from city 
group by countrycode, District 
having sum(population) > 20000000;


select countrycode, sum(Population) 
from city 
group by countrycode 
having sum(population) > 20000000;

select * from city;

-- add filter on id column where ID < 1000, group by countrycode where population > 10000000
select countrycode, sum(population) from city
where id < 1000
group by countrycode
having sum(population) > 10000000;

SELECT countrycode, SUM(population) AS total_population
FROM city
WHERE id < 1000
GROUP BY countrycode
HAVING total_population > 10000000;

select * from city where District = "Noord-Brabant";

select district, population from city;

select distinct CountryCode, district from city;

select distinct countrycode from city;

select * from city;

select * from city where id < 1000;

select * from city limit 1000;

select name, countrycode from city limit 3;

select * from country;

-- avg life expectancy of the regions where IndepYear > 1950 and filter the region having population > 1000000 and give me top 3 rows
select region, avg(LifeExpectancy) as avg_life_exp
from country
where IndepYear > 1950
group by Region
having sum(Population) > 10000000
order by avg_life_exp desc
limit 3;

-- Identify Continents that: have at least 2 countries, have a total population greater than 10 million, 
-- have an average GNP greater than 5,000
SELECT
    Continent,
    COUNT(Name) AS country_count,
    SUM(Population) AS total_population,
    AVG(GNP) AS avg_gnp
FROM country
WHERE GNP IS NOT NULL
GROUP BY Continent
HAVING
    COUNT(Name) >= 2
    AND SUM(Population) > 10000000
    AND AVG(GNP) > 5000;

-- Find the top 2 Regions with the highest average GNP per capita where GNP > 0, Population > 0, IndepYear IS NOT NULL

select region,
 avg(GNP/population) as gnp_avg
from country 
where  IndepYear IS NOT NULL and GNP > 0 and Population > 0
group by region 
order by gnp_avg desc
limit 2;

select * from city;

select * from city where CountryCode = "AFG" or CountryCode =  "NLD";

select countrycode, sum(Population) as sum_pop from city group by countrycode having sum_pop < 100000;

-- group by vs order by

select countrycode, sum(Population) as sum_pop from city group by countrycode;

select countrycode, sum(Population) as sum_pop from city group by countrycode order by sum_pop desc limit 10;

-- create database
create database fintech_db;

-- create database which allows to store emojis, symbols and multilingual data
create database chat_db 
character set utf8mb4
collate utf8mb4_unicode_ci;

use fintech_db;

-- create user table
create table users (
    user_id INT,
    name varchar(100),
    email varchar(100)
);

-- know about table schema
desc users;

insert into users values (NULL, "Vishal", NULL);

insert into users values (100, "Vishal", "A@casda.com");


select * from users;

-- create table (prod grade)
create table users_prod (
	user_id INT auto_increment,
    name varchar(100) NOT NULL,
    email varchar(100) unique,
    created_at timestamp default current_timestamp,
    primary key (user_id)
);

desc users_prod;

insert into users_prod(name, email) values ("Vishal", "vishal@gmail.com");

select * from users_prod;

insert into users_prod(name, email) values ("Raman", "raman@gmail.com");

insert into users_prod(name, email) values ("Raman Verma", "ramanv@gmail.com");

insert into users_prod(user_id, name, email) values (10, "Anikt", "ankit@gmail.com");

insert into users_prod(name, email) values ("Amit", "amit@gmail.com");

create table orders (
	order_id INT auto_increment primary key, 
    user_id INT NOT NULL, 
    amount decimal(10,2) check (amount > 0), 
    order_date timestamp default current_timestamp,
    foreign key (user_id) references users_prod(user_id)
);

desc orders;

insert into orders(user_id, amount) values (1, 200.50), (2, 500);

select * from orders;

insert into orders(user_id, amount) values (1, 250), (2, 1);

-- alter commands (use with caution)
alter table users 
add column phone varchar(10);

desc users;

select * from users;

insert into users values (101, "Vishal", "A@casda.com", 9876543872);

alter table users_prod
add column phone varchar(10) not null;

desc users_prod;

insert into users_prod(name, email, phone) values ("Divya", "divya@gmail.com", 9876543210);

select * from users_prod;

alter table users_prod
rename column phone to mobile_no;

alter table users_prod
modify column mobile_no varchar(15) not null;

desc users_prod;

-- drop column
alter table users_prod
drop column mobile_no;

-- rename table
rename table users to users_testing;

show tables;

-- truncate table
truncate table users_testing;

select * from users_testing;

desc users_testing;

-- drop table
drop table users_testing;

desc users_testing;

-- drop database
drop database chat_db;


-- DML Commands
use fintech_db;

select * from users_prod;

desc users_prod;

insert into users_prod(name, email) values ("Ketan", "ketan@gmail.com");

insert into users_prod(name, email) values ("Ketan", "ketan@gmail.com"), ("Ketan1", "ketan1@gmail.com"), ("Ketan2", "ketan2@gmail.com");

insert into users_prod(name, email) values ("ketan@gmail.com", "ketan");

alter table users_prod 
add column active int default 1;

insert into users_prod(name, email, active) values ("Bharathi", "Bharathi@gmail.com", 0);

insert into users_prod(name, email, active) values ("Bharathi", "Bharathi1@gmail.com", "inactive");

insert into users_prod(name, email) values ("xyz", NULL);

insert into users_prod(name) values ("abc");

insert into users_prod() values ();

create table students (id int, name varchar(50), marks int, course varchar(50));

insert into students() values ();

select * from students;

INSERT INTO students (id, name, marks, course)
VALUES
(1, 'Amit Sharma', 85, 'MBA'),
(2, 'Neha Verma', 78, 'BBA'),
(3, 'Rahul Mehta', 92, 'MBA'),
(4, 'Priya Singh', 88, 'BCom'),
(5, 'Karan Malhotra', 67, 'BCA'),
(6, 'Sneha Kapoor', 74, 'MBA'),
(7, 'Vikram Rao', 81, 'BTech'),
(8, 'Ananya Iyer', 90, 'MBA'),
(9, 'Rohit Gupta', 59, 'BBA'),
(10, 'Pooja Nair', 95, 'MBA');

create table students_copy (id int, name varchar(50), marks int, course varchar(50));

select * from students_copy;

insert into students_copy(id, name, marks, course) select id, name, marks, course from students;

create table students_copy1 (name varchar(50), marks int);

insert into students_copy1 select name, marks from students;

select * from students_copy1;

create table students_copy2 (id int, name varchar(50), marks int, email varchar(50));

insert into students_copy2 (id, name, marks, email) select id, name, marks, NULL from students;

select * from students_copy2;

create table students_copy_mba (id int, name varchar(50), marks int, course varchar(50));

insert into students_copy_mba select id, name, marks, course from students where course = "MBA";

select * from students_copy_mba;
                             
-- update command
update students_copy2 set email = "students@xyz.com";

select * from students_copy2;

update students_copy2 set email = "amit@xyz.com";

update students_copy2 set email = "Neha@xyz.com" where id = 2;

insert into students_copy2 values (11, "Rohit Gupta", 86, "amit@xyz.com");

update students_copy2 set email = "Rohit@xyz.com" where name = "Rohit Gupta";

update students_copy2 set email = "Vikram@xyz.com", marks = 85 where id = 7;

-- delete command
-- delete from tbl_name where condition;

delete from students_copy2 where id = 10;

delete from students_copy2 where marks > 85;

truncate students_copy2;

drop table students_copy2;

use world;

select * from city;

select * from city where CountryCode = "AFG";

select * from city where lower(CountryCode) = "afg";

select * from city where Population >= 1000000;

select * from city where Population <= 1000000;

select * from city where CountryCode <> "AFG";

select * from city;
select * from city where CountryCode = "ARG";

select * from city where CountryCode = "ARG" and Population > 1000000;

select * from city where CountryCode = "ARG" or Population > 1000000;

select * from city;

select * from city where CountryCode <> "ARG"; 

select count(*) from city where CountryCode <> "ARG" order by ID; 

select * from city where Population between 1500000 and 3500000;

select * from city where Population >= 1500000 and Population <= 3500000;

select * from city where Population > 1499999 and Population < 3500001;

select * from city;

select * from city where CountryCode in ("AFG", "NLD", "ARG");

select * from city where countrycode="AFG" or countrycode="NLD" or countrycode="ARG";

select * from city where CountryCode not in ("AFG", "NLD", "ARG");

-- city names which starts with "A"
select * from city where name like "A%";

-- city names which ends with "m"
select * from city where name like '%m';

-- city names which contains "dam"
select * from city where name like '%dam%';

-- city names having exactly 4 letters
select * from city where name like '____';

-- cities in country "NLD" which starts with "R"
select * from city where countrycode = "NLD" and name like "R%";

-- cities having "i" at the 3rd spot
select * from city where name like "__i%";

-- Cities not ending with "a"
select * from city where name not like "%A";
select * from city where name not like "%a";

use eurondb;
show tables;

create table customers (
  id int primary key,
  first_name varchar(50),
  country varchar(50),
  score int
);

create table orders(
order_id int primary key,
order_date date,
sales int,
customer_id int
);

INSERT INTO customers VALUES
(1, 'Maria',  'Germany', 350),
(2, 'John',   'USA',     900),
(3, 'Georg',  'USA',     750),
(4, 'Martin', 'Germany', 500),
(5, 'Peter',  'USA',     0);


INSERT INTO orders VALUES
(1001, '2021-01-11', 35, 1),
(1002, '2021-04-05', 15, 2),
(1003, '2021-06-18', 20, 3),
(1004, '2021-08-31', 10, 6);

-- no join
select * from customers;

select * from orders;

alter table orders add column id int; 

-- inner join
select customers.id, customers.first_name, orders.order_id, orders.sales
from customers
inner join orders
on customers.id = orders.customer_id;


select c.id, c.first_name, o.order_id, o.sales
from customers as c
inner join orders as o
on c.id = o.customer_id;


select c.id, c.first_name, o.order_id, o.sales
from orders as o
inner join customers as c
on o.customer_id = c.id;

-- left join (order of joining tables matters)
select c.id, c.first_name, o.order_id, o.sales
from orders as o
left join customers as c
on o.customer_id = c.id;

select c.id, o.order_id, o.sales
from customers as c
left join orders as o
on c.id = o.customer_id;

select * from customers;

select * from orders; 

select c.id, c.first_name, o.sales, o.order_id
from customers c
right join orders o
on c.id = o.customer_id;

select c.id, c.first_name, o.sales, o.order_id
from orders o
left join customers c
on c.id = o.customer_id;

select c.id, c.first_name, o.orders, o.order_id
from customers c
full join orders o
on c.id = o.customer_id;

select c.id, c.first_name, o.customer_id, o.sales, o.order_id
from orders o
left join customers c
on c.id = o.customer_id
where c.id is null;

select c.id, c.first_name, o.customer_id, o.sales, o.order_id
from customers c
left join orders o
on c.id = o.customer_id
where o.customer_id is null;

select c.id, c.first_name, o.customer_id, o.sales, o.order_id
from customers c
right join orders o
on c.id = o.customer_id
where c.id is null;

select c.id, c.first_name, o.customer_id, o.sales, o.order_id
from orders o
left join customers c
on o.customer_id = c.id
where c.id is null;

select c.id, c.first_name, o.customer_id, o.sales, o.order_id
from customers c
full join orders o
on c.id = o.customer_id
where c.id is null or o.customer_id is null;

select * from customers cross join orders;

create database salesDB;

use salesDB;

-- create a customer table having customer_id (PK), customer_name, email
create table customers (
	customer_id int primary key auto_increment,
    customer_name varchar(100) not null,
    email varchar(100)
);

create table products (
	product_id int primary key auto_increment,
    product_name varchar(100) not null,
    price decimal(10,2) not null
);

create table employees (
	employee_id int primary key auto_increment,
    employee_name varchar(100) not null,
    department varchar(100)
);

-- 
-- create table orders
create table orders (
	order_id int primary key auto_increment,
    customer_id int,
    product_id int,
    employee_id int,
    quantity int,
    sales_amount decimal(10,2),
    order_date date,
    
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id),
    foreign key (employee_id) references employees(employee_id)
);

desc orders;

INSERT INTO Customers (customer_name, email) VALUES
('Karan Malhotra', 'karan@gmail.com'),
('Sneha Iyer', 'sneha@gmail.com'),
('Ritika Jain', 'ritika@gmail.com'),
('Anuj Khanna', 'anuj@gmail.com'),
('Pooja Nair', 'pooja@gmail.com'),
('Suresh Yadav', 'suresh@gmail.com'),
('Nikita Bose', 'nikita@gmail.com');

INSERT INTO Products (product_name, price) VALUES
('Tablet', 35000.00),
('Smartwatch', 12000.00),
('Bluetooth Speaker', 5500.00),
('Power Bank', 2000.00),
('Gaming Mouse', 2500.00),
('Keyboard', 1800.00),
('Monitor', 15000.00);

INSERT INTO Employees (employee_name, department) VALUES
('Aakash Verma', 'Sales'),
('Simran Kaur', 'Sales'),
('Deepak Joshi', 'Sales'),
('Ritu Saxena', 'Sales'),
('Manoj Kumar', 'Support'),
('Alok Mishra', 'Sales');

INSERT INTO Orders
(customer_id, product_id, employee_id, quantity, sales_amount, order_date)
VALUES

(4, 4, 4, 1, 35000.00, '2026-01-20'),
(5, 5, 5, 2, 24000.00, '2026-01-21'),
(6, 6, 6, 1, 5500.00, '2026-01-22'),
(7, 7, 7, 3, 6000.00, '2026-01-23'),
(8, 8, 8, 1, 2500.00, '2026-01-24'),

(9, 9, 9, 2, 30000.00, '2026-01-25'),
(10, 10, 10, 1, 15000.00, '2026-01-26'),
(2, 4, 6, 1, 35000.00, '2026-02-01'),
(3, 5, 7, 1, 12000.00, '2026-02-03'),
(1, 6, 8, 2, 11000.00, '2026-02-05'),

(5, 1, 9, 1, 60000.00, '2026-02-06'),
(6, 2, 10, 1, 25000.00, '2026-02-08'),
(7, 3, 4, 2, 6000.00, '2026-02-10'),
(8, 7, 5, 1, 15000.00, '2026-02-12'),
(9, 8, 6, 1, 12000.00, '2026-02-15'),

(10, 9, 7, 3, 90000.00, '2026-02-18'),
(4, 10, 8, 2, 30000.00, '2026-02-20'),
(3, 1, 9, 1, 60000.00, '2026-02-22'),
(2, 5, 10, 2, 24000.00, '2026-02-25'),
(1, 4, 6, 1, 35000.00, '2026-02-28');

drop table orders;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    employee_id INT,
    quantity INT,
    sales_amount DECIMAL(10,2),
    order_date DATE,

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

INSERT INTO Orders
(customer_id, product_id, employee_id, quantity, sales_amount, order_date)
VALUES

(4, 4, 4, 1, 2000.00, '2026-01-20'),
(5, 5, 5, 2, 5000.00, '2026-01-21'),
(6, 6, 6, 1, 1800.00, '2026-01-22'),
(7, 7, 1, 1, 15000.00, '2026-01-23'),

(2, 3, 2, 1, 5500.00, '2026-01-25'),
(3, 2, 3, 1, 12000.00, '2026-02-01'),
(1, 1, 4, 2, 70000.00, '2026-02-05'),

(5, 1, 5, 1, 35000.00, '2026-02-08'),
(6, 4, 6, 2, 4000.00, '2026-02-10'),
(7, 5, 1, 1, 2500.00, '2026-02-12');

-- retrive all orders with customers, product and employee details
select 
	o.order_id,
	c.customer_name,
	p.product_name,
	o.sales_amount,
	p.price
from orders o
inner join customers c on o.customer_id = c.customer_id
inner join products p on o.product_id = p.product_id;

select 
	o.order_id,
	c.customer_name,
	p.product_name,
	o.sales_amount,
	p.price,
    e.employee_name
from orders o
inner join customers c on o.customer_id = c.customer_id
inner join products p on o.product_id = p.product_id
inner join employees e on o.employee_id = e.employee_id;

-- revenue per salesperson
SELECT 
    e.employee_name as Salesperson,
    SUM(o.sales_amount) AS revenue
FROM 
    orders o
INNER JOIN 
    employees e ON o.employee_id = e.employee_id
GROUP BY 
    e.employee_name
ORDER BY 
    revenue DESC;

-- top selling(most revenue) products
SELECT 
    p.product_name,
    SUM(o.sales_amount) AS total_sales
FROM orders o
JOIN products p 
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;

-- total orders, total customers, total revenue, avg order value, total units sold

select 
    count(distinct order_id) as total_orders,
    count(distinct customer_id) as total_customers,
    sum(sales_amount) as total_revenue,
    avg(sales_amount) as avg_order_value,
    sum(quantity) as total_units_sold
from orders;

select * from customers;

select * from employees;

-- select customer_name as all_names from customers
-- union
-- select employee_name from employees;

select customer_id as id, customer_name as name from customers
union
select employee_id, employee_name from employees;

select employee_id from employees
union
select customer_name from customers;

select employee_id from employees
union
select customer_name from customers;

select * from customers;

select * from orders;

select sales_amount, customer_id from orders
union
select customer_id, customer_name from customers;

select customer_id, sales_amount from orders
union 
select customer_id, customer_name from customers
order by customer_id;

select customer_name as all_names, customer_id as all_id from customers
union
select employee_name, employee_id as all_id from employees;

select customer_name from customers
union
select employee_name as all_names from employees;

desc employees;

insert into employees(employee_name, department) values ("Karan Malhotra", "Support");

select * from employees;

select customer_name as all_names from customers
union
select employee_name from employees;

select customer_name as all_names from customers
union all
select employee_name from employees;

-- find employees who are not customers
select employee_name from employees
except
select customer_name from customers;

select employee_id, employee_name from employees;
except
select customer_id ,customer_name from customers;

select employee_name from employees;
INTERSECT
select customer_name from customers;

-- concat/concatenation
select id, first_name from customers;

select id, first_name, concat(id, "-" ,first_name) as "id-name" from customers;

-- upper (Maria -> MARIA)
select id, upper(first_name) from customers;

-- lower (Maria -> maria)
select id, lower(first_name) from customers;

-- trim
select trim(first_name) from customers;

-- find customers whose names doesn't contain leading or trailing spaces
select * from customers where first_name = trim(first_name);

-- find customers whose names contains leading or trailing spaces
select * from customers where first_name != trim(first_name);

-- update id = 1 as "  Maria"
update customers set first_name = "  Maria" where id = 1;

-- replace
select "31-01-26" as date;

select "31-01-26" as date, replace("31-01-26", "-", "/") as new_date;

select order_date from orders;

select order_date, replace(order_date, "-", "/") as new_date from orders;

select "981-743-3432" as ph_no;
-- 9817433432
select "981-743-3432" as ph_no, replace("981-743-3432", "-", "");

select "reports.xls", replace("reports.xls", ".xls", ".csv");

select first_name, length(first_name) from customers;

-- find customers whose names contains leading or trailing spaces
select * from customers where length(first_name) <> length(trim(first_name));


select first_name, length(first_name), length(trim(first_name)) from customers;

select first_name, left(first_name, 3) from customers;

select first_name, right(first_name, 2) from customers;

-- substring(value/col, start_index, length) 
select first_name, substring(first_name, 2, 3) from customers;

-- give me everything after 3rd index from first_name col
select first_name, substring(first_name, 4, length(first_name)) from customers;

select first_name, substring(first_name, 4) from customers;

select 3.516, round(3.516,2), round(3.516,1), round(3.416,0);

select 10, abs(10), abs(-10);


select * from orders;

-- UTC zones
select order_date, "2026-02-03" as "static date", current_date() as today, current_time() as cur_time, current_timestamp() as date_time from orders;

-- who can i get timezone explicitly


-- datetime extraction
select current_timestamp();

select now();

-- extract date 
select day(now());

select order_date, day(order_date) from orders;

-- extract month
select month(now());

select order_date, month(order_date) from orders;

-- extract year
select year(now());

select year(order_date) from orders;

select dayname(now());

select order_date, dayname(order_date) from orders;

select monthname(now());

select order_date, monthname(order_date) from orders;

select weekday(now());

select weekday("2026-01-02");

select week("2026-01-02");

-- 2026-02-01
select dayofmonth(now());

select dayofmonth("2026-01-02");

select extract(month from now()) as month;

select extract(day from now()) as today;

select extract(year from now()) as year;

select date_format(now(), "%M");

select date_format(now(), "%m");

select date_format(now(), "%Y-%m");

select date_format(now(), "%Y-%M");

select date_format(now(), "%Y-%m-%d");

select last_day(now());

select last_day("2026-01-01");

select * from orders;

-- no the orders placed in each year
select count(*), year(order_date) from orders group by year(order_date);

-- no the orders placed in each month
SELECT 
    MONTH(order_date) AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY MONTH(order_date)
ORDER BY order_month;

-- details of order placed in "April"
select * from orders where monthname(order_date) = "April";

-- this query is more optimized
select * from orders where month(order_date) = 4;

-- dateadd(), datediff()
select date_add("2025-08-20", interval 3 year);

select date_add("2025-08-20", interval 2 month);

select date_add(now(), interval 2 day);

select day(now());

select 2+null;

select date_add(now(), interval 5 hour);

select day(date_add(now(), interval 2 day));

-- 1 year 2 months
select date_add(now(), interval '1-2' year_month);

-- 2 days 5 hr 30 min 
select date_add(now(), interval '2 05:30:00' day_second);

select date_add(now(), interval -3 day);

select date_add(now(), interval -2 year);

select date_sub(now(), interval 2 year);

-- datediff
select datediff("2026-02-10", "2026-02-01");

select datediff("2024-02-01", "2026-02-01");

select datediff("2026-12-31", now());

select * from orders;

-- no of days since the user ordered something
select customer_id, datediff(now(), order_date) as order_diff from orders where datediff(now(), order_date) > 30;

select * from orders;

select sales as sales_data from orders having sales_data > 30;

CREATE TABLE win_sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    city VARCHAR(50),
    sales_amount DECIMAL(10,2)
);

INSERT INTO win_sales VALUES
(101, '2026-01-01', 1, 'Delhi',   1200.00),
(102, '2026-01-02', 2, 'Mumbai',  1500.00),
(103, '2026-01-03', 1, 'Delhi',    800.00),
(104, '2026-01-04', 3, 'Bangalore',2000.00),
(105, '2026-01-05', 2, 'Mumbai',  1700.00),
(106, '2026-01-06', 1, 'Delhi',   2200.00),
(107, '2026-01-07', 3, 'Bangalore',1300.00),
(108, '2026-01-08', 4, 'Pune',     900.00),
(109, '2026-01-09', 2, 'Mumbai',  2500.00),
(110, '2026-01-10', 4, 'Pune',    1600.00);
insert into win_sales values(111, '2026-01-11', 5, 'Delhi', 1000);

select * from win_sales;

-- find total sales done
select sum(sales_amount) as totalSales from win_sales;

-- find total sales of each customer
select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id;

-- find total sales of each customer along with their order id
select customer_id, order_id, sum(sales_amount) as totalSales from win_sales group by customer_id;

select customer_id, order_id, sum(sales_amount) as totalSales from win_sales group by customer_id, order_id;

-- use window functions
select order_id ,sum(sales_amount) over() as totalSales from win_sales;

select customer_id, sum(sales_amount) over(partition by customer_id) as totalSalesPerCust from win_sales;

-- find total sales of each customer along with their order id
select customer_id, order_id, sum(sales_amount) over(partition by customer_id) as totalSalesPerCust from win_sales;

select * from win_sales;

select customer_id, order_id, order_date, sum(sales_amount) over() as totalSales from win_sales;

select customer_id, order_id, order_date, city, sum(sales_amount) over(partition by city) as totalSalesCity from win_sales;

select customer_id, order_id, order_date, city, sum(sales_amount) over(partition by city) as totalSalesCity,
sum(sales_amount) over(partition by city, customer_id) as totalSalesByCityCust
from win_sales;

select * from win_sales order by sales_amount desc;

-- order by clause
select customer_id, order_id, sales_amount, rank() over (order by sales_amount desc) as rk from win_sales;

select customer_id, order_id, sales_amount, rank() over (partition by customer_id order by sales_amount desc) as rk from win_sales;

-- rank the sales amount based on city
select customer_id, order_id, sales_amount, city, rank() over (partition by city order by sales_amount desc) as rk from win_sales;

select customer_id, order_id, sales_amount, city, 
rank() over (partition by city order by sales_amount desc) as rk from win_sales order by city desc;

select customer_id, order_id, sales_amount, city, 
rank() over (partition by city order by sales_amount desc) as rk from win_sales order by city desc;

-- Frame clause
select city, order_id, sales_amount, sum(sales_amount) 
over (order by sales_amount rows between current row and 2 following) as frameSales from win_sales;

select city, order_id, sales_amount, sum(sales_amount) 
over (partition by city order by sales_amount rows between current row and 1 following) as frameSales from win_sales;

select city, order_id, sales_amount, sum(sales_amount) 
over (partition by city order by sales_amount rows between unbounded preceding and 1 following) as frameSales from win_sales;

select city, order_id, sales_amount, sum(sales_amount) 
over (partition by city order by sales_amount rows between 1 preceding and 1 following) as frameSales from win_sales;

select customer_id, sales_amount from win_sales where sales_amount > 1000;

-- find customer id having sales amount greater than the avg of all sales amount

select avg(sales_amount) from win_sales;

select distinct customer_id, sales_amount from win_sales where sales_amount > 1518.181818;

select customer_id, sales_amount from 
(select customer_id, sales_amount, avg(sales_amount) over() as avgPrice from win_sales) as avgPriceTable 
where sales_amount > avgPrice;

select customer_id, sales_amount from win_sales where sales_amount > (select avg(sales_amount) from win_sales);

-- rank customers based on total amount of sales
select * from win_sales;

select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id;

select *, rank() over(order by totalSales desc) as custRank from 
(select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id) as custResult;

-- show customer_id, sales_amount, order_id, total orders

select count(*) from win_sales;

select customer_id, order_id, sales_amount, (select count(*) from win_sales) as totalOrder from win_sales;

-- show all customers details and find the total orders of each customer
select * from win_sales;

select customer_id , count(*) as totalOrders from win_sales group by customer_id;

select * from win_sales s1
left join 
(select customer_id , count(*) as totalOrders from win_sales group by customer_id) s2
on s1.customer_id = s2.customer_id; 

select s1.*, s2.totalOrders from win_sales s1
left join 
(select customer_id , count(*) as totalOrders from win_sales group by customer_id) s2
on s1.customer_id = s2.customer_id; 

select customer_id, sales_amount from win_sales where sales_amount > (select avg(sales_amount) from win_sales);

select customer_id, sales_amount from win_sales where sales_amount = (select avg(sales_amount) from win_sales);

select * from win_sales;

select * from customers;

-- which customer belong to delhi
select customer_id from customers where city = "Delhi";

-- give me all the order details of customers from delhi
select * from win_sales where customer_id in 
(select customer_id from customers where city = "Delhi");

-- give me all the order details of customers from delhi and pune
select * from win_sales where customer_id in 
(select customer_id from customers where city in ("Delhi", "Pune"));

-- give me all the order details of all customers apart from delhi
select * from win_sales where customer_id in 
(select customer_id from customers where city != "Delhi");

select * from win_sales;

select * from customers;

-- find orders whose amount is greater than any mumbai order
select * from win_sales 
where sales_amount > any(
		select sales_amount from win_sales s
        inner join customers c
        on s.customer_id = c.customer_id
        where c.city = "Mumbai"
        );
        
-- find order whose amount is greater than all pune order

select * from win_sales 
where sales_amount > all(
		select sales_amount from win_sales s
        inner join customers c
        on s.customer_id = c.customer_id
        where c.city = "Pune"
        );
        
-- non co related subquery
select *, (select count(*) from win_sales) as totalSales from customers;

-- co related subquery
select *, (select count(*) from win_sales s where s.customer_id = c.customer_id) as totalSales from customers c; 

-- CTEs
select * from win_sales;

-- step1: total sales per customer
select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id;

-- step2: Convert to CTE
-- CTE query
with CTE_total_sales as (select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id)
-- main query
select * from cte_total_sales;

-- step3: Use CTE
with CTE_total_sales as (select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id)
select c.customer_id, c.customer_name, c.city, cts.totalSales from customers c
left join CTE_total_sales cts
on cts.customer_id = c.customer_id;

-- order by in not guranteed inside CTE, always use order by outside the cte
with CTE_total_sales as (select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id)
select c.customer_id, c.customer_name, c.city, cts.totalSales from customers c
left join CTE_total_sales cts
on cts.customer_id = c.customer_id
order by customer_id desc;

-- calculating highest sale per customer along with their last order
-- step1: total sales
with CTE_total_sales as (select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id)
-- step2: find the last order date of each customer
, CTE_last_order as 
( select customer_id, max(order_date) as lastOrder from win_sales group by customer_id)
-- main query
select c.customer_id, c.customer_name, c.city, cts.totalSales, clo.lastOrder
from customers c
left join CTE_total_sales cts
on cts.customer_id = c.customer_id
left join CTE_last_order clo
on clo.customer_id = c.customer_id;



-- step1: total sales
with CTE_total_sales as (select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id)

-- step2: find the last order date of each customer
, CTE_last_order as 
( select customer_id, max(order_date) as lastOrder from win_sales group by customer_id)

-- step3: rank customers based on the total sales per customers
, CTE_rank_total_sales as
( select customer_id, totalSales, rank() over (order by totalSales desc) as customerRank from CTE_total_sales)

-- main query
select c.customer_id, c.customer_name, c.city, cts.totalSales, clo.lastOrder, crts.customerRank
from customers c
left join CTE_total_sales cts
on cts.customer_id = c.customer_id
left join CTE_last_order clo
on clo.customer_id = c.customer_id
left join CTE_rank_total_sales crts
on crts.customer_id = c.customer_id
order by crts.customerRank;


-- step1: total sales
with CTE_total_sales as (select customer_id, sum(sales_amount) as totalSales from win_sales group by customer_id)

-- step2: find the last order date of each customer
, CTE_last_order as 
( select customer_id, max(order_date) as lastOrder from win_sales group by customer_id)

-- step3: rank customers based on the total sales per customers
, CTE_rank_total_sales as
( select customer_id, totalSales, rank() over (order by totalSales desc) as customerRank from CTE_total_sales)

-- step4: segment customers if totalsales > 5000 -> high, totalSales > 3000 -> Medium else low
, CTE_customer_segment as
( select customer_id,
     case
        when totalSales > 6000 then "High"
        when totalSales > 4000 then "Medium"
        else "Low"
	end as customerSegment
   from CTE_total_sales   
)
-- main query
select c.customer_id, c.customer_name, c.city, cts.totalSales, clo.lastOrder, crts.customerRank, ccs.customerSegment
from customers c
left join CTE_total_sales cts
on cts.customer_id = c.customer_id
left join CTE_last_order clo
on clo.customer_id = c.customer_id
left join CTE_rank_total_sales crts
on crts.customer_id = c.customer_id
left join CTE_customer_segment ccs
on ccs.customer_id = c.customer_id;

-- generate numbers from 1 to 20
 with recursive numbers as (
   -- anchor query
	select 1 as num
    union all
    -- recursive query
    select num + 1 from numbers where num < 20
)
-- main query
select * from numbers;
   
   
select * from employees;

with recursive emp_hierarchy as 
(
  -- CEO
  select emp_id, emp_name, manager_id, department, salary, 1 as level
  from employees
  where manager_id is null
  -- recursive query
  union all
  select e.emp_id, e.emp_name, e.manager_id, e.department, e.salary, eh.level+1 as level from employees e
  join emp_hierarchy eh
  on e.manager_id = eh.emp_id
)
select emp_id, emp_name, department, salary, level from emp_hierarchy order by level, emp_id;
