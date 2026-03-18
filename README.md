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
Ze selectu v souboru question_1.sql je zřejmé, že je docela dost oborů, ve kterých mzda dokázala v průběhu let rovněž klesat. Na datech je vidět, že poklesy mzdy byly právě po roce roce 2008, kdy byla ekonomická krize. Zajímavé je, že poslední pokles v našich datech je v roce 2015 v oblasti Těžba a dobývání, což by mohlo souvislost s tehdejší ekologickou politikou v evropě.

### Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Select v dalším souboru ukazuje, že u těchto potravin se kupní síla čechů zlepšuje. Krajní období, která z dat šla porovnat byla Q1 2006 a Q4 2018. Z dat by mohlo vypadat, že chléb si lépe drží hodnotu vůči mzdám a skutečně tomu tak může být, ale vzhledem k tomu, že se porovnávají kvartály, je možné, že bylo v daném období třeba méně pšenice, což vyhnalo ceny, nebo měli mlékaři produktivní dojné krávy.

### Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
Z dat plyne, že nejnižší průměrný meziroční nárust ceny je u Cukru krystal a to do takové míry, že na dostupném období zlevňuje skoro o 2%.

### Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Pro 4. a 5. otázku jsem vytvořil view yearly_prices_and_wages_percentage, kde na dostupném období porovnávám meziroční procentuální rozdíly ve mzdách (jako průměr všech odvětví) a cenách potravin (jako průměr procentuálního meziročního nárůstu ceny všech produktů). V této otázce potom pouze porovnám data mezd a cen, kde rozdíl procent je větší než 10. Vrácena je prázdná tabulka, což znamená, že takový rozdíl meziročně v průměru nenastal.

### Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
s využitím zmíněného view využiji obě tabulky secondary a zprostředkovaně primary. V datech není zřejmé, že by výška HDP přímo ovlivňovala nárust mezd a cen. Zajímavé ale je, že za rok 2008 byly ceny průměrně o cca 6% nižší než předchozí rok, což je zároveň největší pokles pokles cen v našem selectu.
