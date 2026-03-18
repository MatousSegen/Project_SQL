select
	round(average_wage / average_price) as items_amount,
	category,
	year,
	quarter
from t_matous_segen_project_sql_primary_final
where category in ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
and ((year = 2006 and quarter = 1) or (year = 2018 and quarter = 4))
and industry is null
order by category, year;