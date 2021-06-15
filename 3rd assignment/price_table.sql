create table Price as	select id, price, weekly_price, monthly_price, security_deposit, cleaning_fee,	guests_included, extra_people, minimum_nights, maximum_nights,	minimum_minimum_nights, maximum_minimum_nights, minimum_maximum_nights,	maximum_maximum_nights, minimum_nights_avg_ntm, maximum_nights_avg_ntm	from copyOfListings;	alter table Pricerename column id to listing_id;update Priceset price = replace(replace(price, ',', ''), '$', '');update Priceset weekly_price = replace(replace(weekly_price, ',', ''), '$', '');update Priceset monthly_price = replace(replace(monthly_price, ',', ''), '$', '');alter table Pricealter column price type numeric using price::numeric,alter column weekly_price type numeric using weekly_price::numeric,alter column monthly_price type numeric using monthly_price::numeric;alter table Priceadd constraint FK_Price_copyOfListings foreign key (listing_id) references copyOfListings (id);/*alter table copyOfListingsdrop column price, drop column weekly_price, drop column monthly_price, drop column security_deposit, drop column cleaning_fee,drop column guests_included, drop column extra_people, drop column minimum_nights, drop column maximum_nights,drop column minimum_minimum_nights, drop column maximum_minimum_nights, drop column minimum_maximum_nights, drop column maximum_maximum_nights, drop column minimum_nights_avg_ntm, drop column maximum_nights_avg_ntm;*/