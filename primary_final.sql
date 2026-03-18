create table t_matous_segen_project_SQL_primary_final as (
	with czechia_payroll_full as (
		select
			cpay.value as average_wage,
			cpay.payroll_year,
			cpay.payroll_quarter,
			cpib.name as industry
		from czechia_payroll as cpay
		left join czechia_payroll_industry_branch cpib
		on cpay.industry_branch_code = cpib.code 
		where cpay.value_type_code = 5958
		and cpay.calculation_code = 200
	), czechia_price_full as (
		select
			avg(cp.value) as average_price,
			cpc.name as category,
			date_part('year', cp.date_from) as price_year,
			date_part('quarter', cp.date_from) as price_quarter
		from czechia_price as cp
		left join czechia_price_category as cpc
		on cp.category_code = cpc.code
		group by category, price_year, price_quarter 
	)
	select 
		row_number() over (order by 
			cpayf.payroll_year , 
			cpayf.payroll_quarter, 
			cpf.category,
			cpayf.industry
			) as id,
		cpayf.average_wage,
		cpayf.industry,
		cpf.average_price,
		cpf.category,
		cpayf.payroll_year as year,
		cpayf.payroll_quarter as quarter
	from czechia_payroll_full as cpayf
	join czechia_price_full as cpf
	on cpayf.payroll_year = cpf.price_year
	and cpayf.payroll_quarter = cpf.price_quarter
);