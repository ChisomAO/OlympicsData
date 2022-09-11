create database OlympicsDatabase;
use OlympicsDatabase;

-- Check all the data has been imported properly 
select *
from olympic_athlete_event_results
order by edition_id
limit 50;

select *
from olympic_athlete_bio
order by athlete_id
limit 50;

select *
from olympic_results
limit 50;

select *
from olympics_games
limit 50;

select *
from olympics_games_medal_tally
limit 50;

select *
from olympic_countries
limit 50;
----------------------------------------------------------------------------------------------------------
-- Which athlete played which sport?
select g.edition_id, g.edition, e.sport, e.athlete_id
from olympics_games g, olympic_athlete_event_results e
where g.edition_id = e.edition_id;

-- What are the credentials of these athletes
select g.edition_id, g.edition, e.sport,e.country_noc, e.athlete_id, a.sex, a.height, a.weight
from olympics_games g, olympic_athlete_event_results e, olympic_athlete_bio a
where g.edition_id = e.edition_id
and e.athlete_id = a.athlete_id;
-- group by 3;

-- Did the athlete in a medal or not ?
select g.edition_id, g.edition, e.sport, e.country_noc, e.athlete_id, a.sex, a.height, a.weight, e.medal
from olympics_games g, olympic_athlete_event_results e, olympic_athlete_bio a
where g.edition_id = e.edition_id
and e.athlete_id = a.athlete_id
order by 1, 3, 9;

-- Medals by country + edition / year
select g.edition_id, g.edition, m.country_noc,c.country, m.total
from olympics_games g, olympics_games_medal_tally m, olympic_countries c
where g.edition_id = m.edition_id
and m.country_noc = c.country_noc
-- and country = 'Soviet Union'
order by 1, 5 desc ;

------------------------------------------------------------------------------------------------
-- Country with highest medals over the years/ best performing nations based on medals/top 10
select distinct m.country_noc,c.country, sum(m.total)
from olympics_games_medal_tally m
inner join olympic_countries c
	on m.country_noc = c.country_noc
group by 1
order by 3 desc
limit 10;
------------------------------------------------------------------------------------------------
-- Analysis based on Sports using medals
-- Medals by sport 
/*select g.edition_id, e.edition, e.sport,e.medal-- e.isTeamSport
from olympics_games g, olympic_athlete_event_result e
where g.edition_id = e.edition_id
and e.medal != 'na';
-- group by 3
-- order by 1, 4 desc;

select edition_id, edition, (distinct sport),count(medal)-- e.isTeamSport
from  olympic_athlete_event_result 
where medal != 'na'
order by 1;
select distinct sport 
from olympic_athlete_event_results;
select g.edition_id, a.edition, a.sport , count(a.medal) as TotalMedals, a.isTeamSport
from olympics_games g, olympic_athlete_event_results a
where g.edition_id = a.edition_id
group by 3;
-- order by 1, 4 desc;*/
select sport , count(medal) as TotalMedals
from olympic_athlete_event_results a
group by 1
order by 2 desc;

-- top 5 sports based on most medals
select sport , count(medal) as TotalMedals
from olympic_athlete_event_results 
group by 1
order by 2 desc
limit 5;

-- Athletes credentials based on the top sports
-- age /avergae age of atheletes that got medals in the top 5 sports
select e.sport, avg(abs(a.birthYear - g.year)) As averageAge -- a.sex, a.birthYear, a.height, a.weight
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympics_games g
	on e.edition_id = g.edition_id
where e.sport = 'Athletics'
order by 2;

select e.sport, avg(abs(a.birthYear - g.year)) As averageAge -- a.sex, a.birthYear, a.height, a.weight
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympics_games g
	on e.edition_id = g.edition_id
where e.sport = 'Swimming';

select e.sport, avg(abs(a.birthYear - g.year)) As averageAge -- a.sex, a.birthYear, a.height, a.weight
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympics_games g
	on e.edition_id = g.edition_id
where e.sport = 'Rowing';

select e.sport, avg(abs(a.birthYear - g.year)) As averageAge -- a.sex, a.birthYear, a.height, a.weight
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympics_games g
	on e.edition_id = g.edition_id
where e.sport = 'Football';

select e.sport, avg(abs(a.birthYear - g.year)) As averageAge -- a.sex, a.birthYear, a.height, a.weight
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympics_games g
	on e.edition_id = g.edition_id
where e.sport = 'Hockey';

-- Gender Distribution of the athletes in the top 5 sports
select e.athlete_id, a.sex, e.sport 
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.sport = 'Athletics';

select e.sport , a.sex, count(*) as genderCount
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.sport = 'Athletics'
group by 2;

select e.sport , a.sex, count(*) as genderCount
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.sport = 'Swimming'
group by 2;

select e.sport , a.sex, count(*) as genderCount
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.sport ='Rowing'
group by 2;

select e.sport , a.sex, count(*) as genderCount
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.sport ='Football'
group by 2;

select e.sport , a.sex, count(*) as genderCount
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.sport ='Hockey'
group by 2;

----------------------------------------------------------------------------------------
-- athletes that have won medals
select athlete_id, medal
from olympic_athlete_event_results
order by 2;

select e.athlete_id, e.medal, a.sex, a.birthYear, a.height, a.weight
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
order by 2;

-----------------------------------------------------------------------------------------------------------
-- Analysis based on counrty using medals
-- Which countries are the highest perfoming athletes from?
select distinct c.country, count(e.medal)  -- a.sex, a.birthYear, a.height, a.weight ,e.athlete_id,
from olympic_athlete_event_results e
inner join olympic_countries c
	on e.country_noc = c.country_noc
group by 1
order by 2 desc
limit 10;

select e.edition_id, g.year, e.athlete_id, e.medal, a.sex, a.birthYear, a.height, a.weight, c.country
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
inner join olympics_games g
	on e.edition_id = g.edition_id
order by 2, 3;


-- Age / Average age of athletes by country that have medals in the olympics 
/*select e.edition_id, g.year, e.athlete_id, e.medal, a.birthYear,abs((a.birthYear-g.year)) as Age , c.country
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
inner join olympics_games g
	on e.edition_id = g.edition_id;*/
    

select e.country_noc, c.country, avg(abs(a.birthYear - g.year)) As averageAge
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
left join olympic_countries c
	on e.country_noc = c.country_noc
inner join olympics_games g
	on e.edition_id = g.edition_id
group by 1;

-- Average age of highest perfoming athletes from the top perfoming countries 
select distinct c.country, count(e.medal), round(avg(abs(a.birthYear - g.year)), 2) As averageAge 
from olympic_athlete_event_results e
left join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
left join olympic_countries c
	on e.country_noc = c.country_noc
inner join olympics_games g
	on e.edition_id = g.edition_id
group by 1
order by 2 desc
limit 10;

-- Gender distribution of Athletes from highest performing countries
/*select e.athlete_id, e.medal, a.sex, c.country
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where country = 'Belarus'
order by 3;*/

select a.sex, count(*) as genderCount
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
group by 1;

create table Gender_by_Country_count as 
select distinct c.country, a.sex, count(*) as athletes
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
group by 2, 1;

create table olympics_top10_countries as
select distinct c.country, count(e.medal) as totalMedals
from olympic_athlete_event_results e
inner join olympic_countries c
	on e.country_noc = c.country_noc
group by 1
order by 2 desc
limit 10;

select o.country, b.sex, b.athletes 
from olympics_top10_countries o
inner join Gender_by_Country_count b
	on o.country = b.country;

-- avergae BMI of athletes from top 10 perfoming countries 
select e.athlete_id,a.height, a.weight, c.country
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
inner join olympics_top10_countries o
	on o.country = c.country
order by 4;

select e.athlete_id, c.country, round((a.weight/power(a.height/100, 2)),2) as BMI 
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
inner join olympics_top10_countries o
	on o.country = c.country
order by 2;

select c.country, avg(round((a.weight/power(a.height/100, 2)),2)) as avgBMI 
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
inner join olympics_top10_countries o
	on o.country = c.country
group by 1;

-----------------------------------------------------------------------------------------------------------------
-- Analysis based on only gold medals 
select m.country_noc,c.country, m.gold 
from olympics_games_medal_tally m
left join olympic_countries c
	on m.country_noc = c.country_noc;

-- countries with the most gold medals over the years
select c.country, m.country_noc, sum(m.gold)
from olympics_games_medal_tally m
left join olympic_countries c
	on m.country_noc = c.country_noc
group by 1
order by 3 desc
limit 10;

-- athletes that have gold medals 
select e.edition_id,e.athlete_id, e.medal
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
where e.medal = 'Gold'
order by 1;

-- Age distribution of athletes that got gold medals 
select e.athlete_id, e.medal,abs((a.birthYear-g.year)) as Age, c.country
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
inner join olympics_games g
	on e.edition_id = g.edition_id
where e.medal = 'Gold';

-- Gender Distribution of athletes that got gold medals 
select a.sex, count(*) as genderCount
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.medal = 'Gold'
group by 1;

-- sport distributuion of the gold medals obtained by the USA 
select e.sport, e.athlete_id, e.medal, c.country
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.medal = "Gold" 
and a.country_noc = "USA";

select e.sport, count(e.medal) as TotalMedals, c.country
from olympic_athlete_event_results e
inner join olympic_athlete_bio a 
	on e.athlete_id = a.athlete_id
inner join olympic_countries c
	on a.country_noc = c.country_noc
where e.medal = "Gold" 
and a.country_noc = "USA"
group by 1
order by 2 desc
limit 5;
