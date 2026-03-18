with yearly_wages as (
	select 
		round(avg(average_wage)) as wage,
		industry,
		year
	from t_matous_segen_project_sql_primary_final
	group by industry, year
)
select 
	prev.industry,
	prev.wage as previous_wage,
	pres.wage as present_wage,
	(pres.wage - prev.wage) as difference,
	prev.year
from yearly_wages  as pres
join yearly_wages as prev
on prev.industry = pres.industry 
and pres.year = prev.year + 1
where (pres.wage - prev.wage) < 0
order by prev.industry, pres.year;
