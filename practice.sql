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
