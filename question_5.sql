with czech_stats as (
	select *
	from t_matous_segen_project_sql_secondary_final
	where country = 'Czech Republic'
)
select
	ypaw.wage_percentage,
	ypaw.price_percentage,
	cs.gdp,
	cs.year
from yearly_prices_and_wages as ypaw
join czech_stats as cs
on ypaw.year = cs.year + 1