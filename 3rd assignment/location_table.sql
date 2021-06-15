create table Location as
	select id, street, neighbourhood, neighbourhood_cleansed, city, state,
	zipcode, market, smart_location, country_code, country, latitude, longitude,
	is_location_exact
	from copyofListings;
	
alter table Location
rename column id to listing_id;
	
alter table Location
add constraint FK_Location_copyOfListings foreign key (listing_id) references copyOfListings (id);

alter table copyOfListings
drop constraint FK_copyOfListings_copyOfNeighbourhoods;

alter table Location
add constraint FK_Location_copyOfNeighbourhoods foreign key (neighbourhood_cleansed) references copyOfNeighbourhoods (neighbourhood);

/*
alter table copyOfListings
drop column street, 
drop column neighbourhood, 
drop column neighbourhood_cleansed, 
drop column city, 
drop column state,
drop column zipcode, 
drop column market, 
drop column smart_location, 
drop column country_code, 
drop column country, 
drop column latitude, 
drop column longitude,
drop column is_location_exact;
*/