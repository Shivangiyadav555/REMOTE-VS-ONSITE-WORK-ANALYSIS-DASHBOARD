SELECT * FROM remote_work_data.impact_of_remote_work_on_mental_health ;

-- Count of employees general and by work location
with data as (
select work_location,
count( Employee_ID)as no_of_employees
from remote_work_data.impact_of_remote_work_on_mental_health
group by 1 with rollup
)
select 
case
	when work_location is not null then work_location
    else 'Total' end as work_location, 
    no_of_employees
from data ;

-- Count of employees by 1.stress levels, 2.mental health condition and 3.productivity
-- by work location too
with data as ( 
select work_location, Stress_Level,
count( Employee_ID)as no_of_employees
from remote_work_data.impact_of_remote_work_on_mental_health
group by 1 ,2
)
select 

round(sum(case when work_location = 'Remote' and Stress_Level = 'High' then no_of_employees else 0 end  )
 / nullif( sum(no_of_employees),0) * 100,2) as pct_remote_h,
round(sum(case when work_location = 'Remote' and Stress_Level = 'Medium' then no_of_employees else 0 end  )/
nullif( sum(no_of_employees),0) * 100,2) as pct_remote_h,
round(sum(case when work_location = 'Remote' and Stress_Level = 'Low' then no_of_employees else 0 end  )
 / nullif( sum(no_of_employees),0) * 100,2)  as pct_remote_l,
 
 round(sum(case when work_location = 'Onsite' and Stress_Level = 'High' then no_of_employees else 0 end  )
 / nullif( sum(no_of_employees),0) * 100,2) as pct_Onsite_h,
round(sum(case when work_location = 'Onsite' and Stress_Level = 'Medium' then no_of_employees else 0 end  )/
nullif( sum(no_of_employees),0) * 100,2) as pct_Onsite_h,
round(sum(case when work_location = 'Onsite' and Stress_Level = 'Low' then no_of_employees else 0 end  )
 / nullif( sum(no_of_employees),0) * 100,2)  as pct_Onsite_low

 from data ;
 -- Onsite
 -- avg work life balance , hours worked, social isolation by work location
 
select
work_location,
round(avg(Hours_Worked_Per_Week),2) avg_Hours_Worked_Per_Week,
round(avg(Work_Life_Balance_Rating),2) avg_Work_Life_Balance_Rating,
round(avg(Social_Isolation_Rating),2) avg_Social_Isolation_Rating,
count( Employee_ID)as no_of_employees
from remote_work_data.impact_of_remote_work_on_mental_health
group by 1 
;

-- avg work life balance by job type and work location
 
select
work_location,
Job_Role,
round(avg(Work_Life_Balance_Rating),2) avg_Work_Life_Balance_Rating,
count(Employee_ID)as no_of_employees
from remote_work_data.impact_of_remote_work_on_mental_health
where Work_Location = 'Onsite'
group by 1,2
order by 3 desc
;



