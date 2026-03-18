create table t_matous_segen_project_SQL_secondary_final as (
	select
		e.country,
		e.year,
		e.gdp,
		e.population,
		e.gini
	from countries as c
	join economies as e -- odstrani se tri zaznamy oproti left join, protoze tam 3 staty nemaji data pro jeden rok
	on c.country = e.country
	where c.continent = 'Europe'
	and e.year between 2006 and 2018
	order by e.country, e.year
);
