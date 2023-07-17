select * from users
select * from events
select * from email


/* User Engagement: To measure the activeness of a user. 
Task: Calculate the weekly user engagement? */

select extract(week from occurred_at) as week_numbers,
       count(distinct user_id) as weekly_active_users
from events
where event_type = 'engagement'
group by 1; 


/* User Growth: Amount of users growing over time for a product.
Task: Calculate the user growth for product? */

select year, num_week, num_active_users,
sum(num_active_users) over(order by year, num_week rows between unbounded preceding and current row) 
as cumm_active_users
from
(select 
    extract(year from a.activated_at) as year,
    extract(week from a.activated_at)as num_week,
    count(distinct user_id) as num_active_users
from users a
where state='active' 
group by year, num_week 
order by year, num_week
)a;


/* Weekly Retention: Users getting retained weekly after signing-up for a product.
Task: Calculate the weekly retention of users-sign up cohort? */

select count(user_id),
       sum(case when retention_week = 1 then 1 else 0 end) as per_week_retention
from
(
select a.user_id,
       a.sign_up_week,
       b.engagement_week,
       b.engagement_week - a.sign_up_week as retention_week
from
(
(select distinct user_id, extract(week from occurred_at) as sign_up_week
from events
where event_type = 'signup_flow'
and event_name = 'complete_signup'
and extract(week from occurred_at)=18)a
left join
(select distinct user_id, extract(week from occurred_at) as engagement_week
from events
where event_type = 'engagement')b
on a.user_id = b.user_id
))sub
group by user_id
order by user_id;


/* Weekly Engagement: To measure the activeness of a user.
Task: Calculate the weekly engagement per device? */

select 
      extract(year from occurred_at) as num_years,
	  extract(week from occurred_at) as num_weeks,
	  device,
	  count(distinct user_id) as num_of_users
from events
where event_type = 'engagement'
group by 1,2,3
order by 1,2,3;


/* Email Engagement: Users engaging with the email service.
Task: Calculate the email engagement metrics? */

select 
100.0 * sum(case when email_cat = 'email_opened' then 1 else 0 end)
        /sum(case when email_cat = 'email_sent' then 1 else 0 end)
as email_opening_rate,
100.0 * sum(case when email_cat = 'email_clicked' then 1 else 0 end)
        /sum(case when email_cat = 'email_sent' then 1 else 0 end)
as email_clicking_rate
from
(
select *,
case when action in ('sent_weekly_digest', 'sent_reengagement_email')
     then 'email_sent'
     when action in ('email_open')
     then 'email_opened'
     when action in ('email_clickthrough')
     then 'email_clicked'
end as email_cat
from email
)a;






































