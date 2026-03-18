# Projekt z SQL

Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli,
že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. 
Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení.
Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.
Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin
na základě průměrných příjmů za určité časové období.
Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období,
jako primární přehled pro ČR.

## Datové sady, které je možné požít pro získání vhodného datového podkladu

### Primární tabulky
- czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
- czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
- czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
- czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
- czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
- czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
- czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.

### Číselníky sdílených informací o ČR
- czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
- czechia_district – Číselník okresů České republiky dle normy LAU.
  
### Dodatečné tabulky
- countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
- economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.


  
## Výsledné tabulky

### t_matous_segen_project_SQL_primary_final
V tabulce primary jsou předpřipravené data z tabulek czechia_payroll a czechia_price pomocí CTE pro finální select.
CTE czechia_payroll_full se filtruje podle kódů 5958 a 200, protože pro výzkum nejsou údaje o počtu zaměstnanců a fyzické kalkulace relevantní.
V selectech jsou vybrané pouze relevantní informace pro výzkum a tabulky czechia_payroll a czechia_price jsou spojené pomocí roku a kvartálu pro detailní informace.

### t_matous_segen_project_SQL_secondary_final
Tabulka secondary vytahuje data o evropských státech z tabulky economies. Propojení s tabulkou countries je čistě z důvodu chybějící informace o kontinentu protože jinak neobsahuje relevantní informace pro náš výzkum. Data jsou zároveň filtrovaná mezi roky 2006 a 2018, protože mimo tento rozsah neexistují data z tabulky primary a nebylo by možné s nimi pracovat.

## Výzkumné otázky

### Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

### Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

### Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 

### Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

### Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
