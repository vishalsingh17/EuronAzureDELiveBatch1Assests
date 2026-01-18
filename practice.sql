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
