select * from job_data


/* Number of jobs reviewed: Amount of jobs reviewed over time.
Task: Calculate the number of jobs reviewed per hour per day for November 2020? */

select ds as Dates,count(job_id)::decimal/sum(time_spent)*3600 as num_jobs_reviewed 
from job_data
where ds between '2020-11-01' and '2020-11-30'
group by ds;

--or
select 
count(distinct job_id)::decimal/(30*24) as num_jobs_reviewed
from job_data
where 
ds between '2020-11-01' and '2020-11-30';


/* Throughput: It is the no. of events happening per second.
Task: Calculate 7 day rolling average of throughput? 
For throughput, do you prefer daily metric or 7-day rolling and why? */

--Weekly throughput
select round(cast(count(event)as decimal)/sum(time_spent),2) as weekly_throughput
from job_data;
--or
select round(count(event)::decimal /sum(time_spent),2) as weekly_throughput
from job_data;

--Daily throughput
select ds as Dates,round(count(event)::decimal/sum(time_spent),2) as daily_throughput
from job_data
group by ds
order by ds;


/* Percentage share of each language: Share of each language for different contents.
Task: Calculate the percentage share of each language in the last 30 days? */

select language as Languages,round(100*count(*)::decimal/total,2) as percentage
from job_data
cross join (select count(*) as total from job_data)sub
group by language,total;


/* Duplicate rows: Rows that have the same value present in them.
Task: display duplicates rows in the data. */

select actor_id,count(*) as duplicates
from job_data
group by actor_id
having count(*)> 1;







































































































