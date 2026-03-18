with yearly_prices as (
	select 
		avg(average_price) as price,
		category,
		year
	from t_matous_segen_project_sql_primary_final
	group by category, year 
	order by  category, year
)
select 
	prev.category,
	round(avg(((pres.price - prev.price) / prev.price) * 100)::numeric, 2) as average_percentage_increase
from yearly_prices as prev
join yearly_prices as pres
on pres.year = prev.year + 1
and prev.category = pres.category
group by prev.category
order by average_percentage_increase;

