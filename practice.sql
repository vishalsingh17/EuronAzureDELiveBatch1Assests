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

