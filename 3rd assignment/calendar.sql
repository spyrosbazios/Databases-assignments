update copyOfCalendar
set price = replace(replace(price, ',', ''), '$', '');
update copyofCalendar
set adjusted_price = replace(replace(adjusted_price, ',', ''), '$', '');

alter table copyOfCalendar
alter column price type numeric using price::numeric,
alter column adjusted_price type numeric using price::numeric;