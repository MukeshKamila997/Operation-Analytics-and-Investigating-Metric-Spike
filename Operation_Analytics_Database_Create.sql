-- Database: Operation_Analytics

-- DROP DATABASE IF EXISTS "Operation_Analytics";

CREATE DATABASE "Operation_Analytics"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	

create table job_data 
(
ds date,
job_id int,
actor_id int,
event varchar(50),
language varchar(50),
time_spent int,
org varchar(50)
);	

set client_encoding = 'ISO_8859_5';
copy job_data(job_id,actor_id,event,language,time_spent,org,ds)
from 'C:\Users\91977\Desktop\SQL Project-1 Table - Sheet1(AutoRecovered).csv'
delimiter ','
csv header;


create table users 
(
user_id int primary key,
created_at timestamp,
company_id	int,
language varchar(50),
activated_at timestamp default null, 
state varchar(50)	
);	

set client_encoding = 'ISO_8859_5';
copy users(user_id,created_at,company_id,language,activated_at,state)
from 'C:\Users\91977\Desktop\Table-1 users.csv'
delimiter ','
csv header;


create table events 
(
user_id int references users(user_id),
occurred_at timestamp,
event_type varchar(250),
event_name varchar(250),
location varchar(250),
device varchar(250),
user_type int
);	
	
set client_encoding = 'ISO_8859_5';
copy events(user_id,occurred_at,event_type,event_name,location,device,user_type)
from 'C:\Users\91977\Desktop\Table-2 events.csv'
delimiter ','
csv header;
drop table events

create table email
(
  user_id int references users(user_id),
  occurred_at timestamp,
  action varchar(250),
  user_type int
);
	
set client_encoding = 'ISO_8859_5';
copy email(user_id,occurred_at,action,user_type)
from 'C:\Users\91977\Desktop\Table-3 email_events.csv'
delimiter ','
csv header;
	

	
	
	
	
	
	
	