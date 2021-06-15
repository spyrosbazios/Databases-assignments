create table Room(
	listing_id int,
	accommodates int,
   	bathrooms varchar(10),
   	bedrooms int,
   	beds int,
   	bed_type varchar(20),
   	amenities varchar(1660),
   	square_feet varchar(10),
   	price varchar(10),
   	weekly_price varchar(10),
   	monthly_price varchar(10),
   	security_deposit varchar(10)
);

insert into Room(listing_id, accommodates, bathrooms, bedrooms, beds, bed_type, amenities, square_feet, price, weekly_price, monthly_price, security_deposit)
	select id, accommodates, bathrooms, bedrooms, beds, bed_type, amenities, square_feet, price, weekly_price, monthly_price, security_deposit
	from copyoflistings
group by id, accommodates, bathrooms, bedrooms, beds, bed_type, amenities, square_feet, price, weekly_price, monthly_price, security_deposit;

/*
alter table copyoflistings
	drop column accommodates,
	drop column bathrooms,
	drop column bedrooms,
	drop column beds,
	drop column bed_type,
	drop column amenities,
	drop column square_feet,
	drop column price,
	drop column weekly_price,
	drop column monthly_price,
	drop column security_deposit; 	
*/

alter table Room
add foreign key(listing_id) references copyoflistings(id);