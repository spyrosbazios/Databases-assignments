/*
Query 1:
List all reviews for any house located at Chicago, Illinois, United States
Shows the house's url, the reviewers name by descending order and the review.
Output: 27 lines
*/
select Listings.listing_url, Reviews.reviewer_name, Reviews.comments from Listings
inner join Reviews on Listings.id = Reviews.listing_id
where Listings.host_location = 'Chicago, Illinois, United States'
order by Reviews.reviewer_name asc;

/*
Query 2:
List prices for 50 available houses on 2020-05-20
Shows the house's url and the price.
*/
select Listings.listing_url, Calendar.price from Listings
join Calendar on Listings.id = Calendar.listing_id
where Calendar.available = 'true' and Calendar.date = '2020-05-20'
limit 50;

/*
Query 3:
List 50 house names and their price in neighbourhood 'ΠΕΤΡΑΛΩΝΑ'
Shows the houses name and the price.
*/
select Listings.name, Listings.price from Listings
join Neighbourhoods on Listings.neighbourhood_cleansed = Neighbourhoods.neighbourhood
where Neighbourhoods.neighbourhood = 'ΠΕΤΡΑΛΩΝΑ'
limit 50;

/*
Query 4:
List all the reviews for all Emmanouils's houses.
Shows the listing's name, the reviewer's name and the review.
Output: 721 lines
*/
select Listings.name, Reviews.reviewer_name, Reviews.comments from Reviews
join Listings on Listings.id = Reviews.listing_id
where Listings.host_name = 'Emmanouil';

/*
Query 5:
List 20 apartments by ascending order based on number of reviews
available on '2020-05-20' and their price on that day.
Shows the house's url, the house's name and the price.
*/
select Listings.listing_url, Listings.name, Calendar.price from Listings
join Calendar on Listings.id = Calendar.listing_id
where Listings.property_type = 'Apartment' and Listings.instant_bookable = 'true'
and Calendar.date = '2020-05-20'  and Calendar.price IS NOT NULL
order by Listings.number_of_reviews asc
limit 20;

/*
Query 6
List the 15 most expensive houses in neighbourhood ΠΕΤΡΑΛΩΝΑ.
Shows the house's name, the host's name and the price.
*/
select Listings_Summary.name, Listings_Summary.host_name, Listings_Summary.price from Listings_Summary
join Neighbourhoods on Neighbourhoods.neighbourhood = Listings_Summary.neighbourhood
where Neighbourhoods.neighbourhood = 'ΠΕΤΡΑΛΩΝΑ'
order by Listings_Summary.price desc
limit 15;

/*
Query 7
List all available houses on 2020-05-20 with square feet from 1100 to 1200
Shows the house's url, the price and the square feet.
Output: 6 rows
*/
select Listings.listing_url,  Calendar.price, cast(Listings.square_feet as int) from Listings
join Calendar on Listings.id = Calendar.listing_id
where Calendar.date = '2020-05-20' and Calendar.price IS NOT NULL
and Listings.square_feet IS NOT NULL and Calendar.available = 'true'
and (cast(Listings.square_feet as int) between 1100 and 1200)
order by cast(Listings.square_feet as int) desc

/*
Query 8 
List all reviews for the listings whose host is from Pedion Areos
Shows the house's name and the review.
Output: 7642
*/
select distinct Listings.name, Reviews.comments from Listings
join Reviews on Listings.id = Reviews.listing_id
where Listings.host_neighbourhood = 'Pedion Areos';

/*
Query 9
List 2000 comments for houses whose host doesn't live in Greece, even for houses without any comments.(Shows null for those)
Shows the house's name , the host's location and the comments.
*/
select Listings.name, Listings.host_location, Reviews.comments from Listings
left outer join Reviews on Listings.id = Reviews.listing_id
where upper(Listings.host_location) not like upper('%GR%')
limit 2000;

/*
Query 10
List how much costs the cheapest house and the average price of houses in each neighbourhood available on 2020-05-20
Shows the neighbourhood's name, the minimum and the average price
Output: 44 rows
*/
select Listings_Summary.neighbourhood, 
	   min(cast(replace(replace(Calendar.price, ',', ''), '$', '') as float)), 
	   avg(cast(replace(replace(Calendar.price, ',', ''), '$', '') as float)) 
from Calendar
right outer join Listings_Summary on Calendar.listing_id = Listings_Summary.id
where Calendar.date = '2020-05-20' and Calendar.available = 'true' 
group by Listings_Summary.neighbourhood

/*
Query 11
List how much costs the most expensive house in each neighbourhood available on 2020-05-20
Shows the neighbourhood's name and the maximum price
Output: 45 rows
*/
select Geolocation.properties_neighbourhood, max(Calendar.price) from Calendar
join Listings on Calendar.listing_id = Listings.id
join Neighbourhoods on Listings.neighbourhood_cleansed = Neighbourhoods.neighbourhood
join Geolocation on Neighbourhoods.neighbourhood = Geolocation.properties_neighbourhood
where Calendar.date = '2020-05-20'
group by Geolocation.properties_neighbourhood

/*
Query 12
List all houses available on 2020-05-20 and their price where smoking is allowed.
Shows the house's name and the price.
Output: 7902 rows
*/
select Listings.name, Calendar.price from Listings
join Calendar on Listings.id = Calendar.listing_id
where Listings.house_rules not like '%NO SMOKING%'
and Calendar.date = '2020-05-20' and Calendar.available = 'true'