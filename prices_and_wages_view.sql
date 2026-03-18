create or replace view yearly_prices_and_wages_percentage as (
	with yearly_prices_and_wages as (
		select 
			avg(average_wage) as wage,
			avg(average_price) as price,
			category,
			year
		from t_matous_segen_project_sql_primary_final
		where industry is null
		group by industry, category, year 
		order by  industry, category, year
	)
	select 
		round(avg((((pres.wage  - prev.wage ) / prev.wage ) * 100))::numeric, 2)
		as wage_percentage,
		round(avg((((pres.price - prev.price) / prev.price) * 100))::numeric, 2)
		as price_percentage,
		prev.year
	from yearly_prices_and_wages as prev
	join yearly_prices_and_wages as pres
	on pres.year = prev.year + 1
	and prev.category = pres.category
	group by prev.year
);
