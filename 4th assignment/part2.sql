/*
     _ _          _       _                     
    | (_)        | |     (_)                    
  __| |_ ___  ___| | __ _ _ _ __ ___   ___ _ __ 
 / _` | / __|/ __| |/ _` | | '_ ` _ \ / _ \ '__|  ()	Eπειδή η αποθήκευση των πινάκων 2 φορές για να γίνει πιο εύκολα ο έλεγχος κατανάλωνε
| (_| | \__ \ (__| | (_| | | | | | | |  __/ |   		πολλά credits και μας ήρθε ειδοποίηση ότι έχουμε χρησιμοποιήσει πάνω από το 75% ,
 \__,_|_|___/\___|_|\__,_|_|_| |_| |_|\___|_|     ()	έχουμε σβήσει ολους τους παλιους πινακες και εχουμε μετονομασει τους copyOf.

*/


/*
displays the url of all houses below 100$ in descending order which have exactly 4 rooms
rows: 3295 rows 
*/
select listing_url, price.price from Listing
    join price on price.listing_id = listing.id
    join room on Listing.id = room.listing_id
    where room.accommodates = 4
    group by listing_url, price.price
    having price.price<100
    order by price.price desc;

/*
displays every geolocation's neighbourhood and the number of apartments located there
rows: 45
*/
select properties_neighbourhood, count(properties_neighbourhood)
from Geolocation
join Neighbourhood on Geolocation.properties_neighbourhood = Neighbourhood.neighbourhood
join Location on Neighbourhood.neighbourhood = Location.neighbourhood_cleansed
join Listing on Location.listing_id = Listing.id
where Listing.property_type like '%Apartment%'
group by properties_neighbourhood

/*
displays the urls of the top 100 houses with the bigest number of amenities in descending order. 
rows: 100
*/
SELECT listing_url, count(amenity.id) FROM Listing
left outer join room on room.listing_id = listing.id
left outer join connect_room_amenity on connect_room_amenity.room = room.listing_id
left outer join amenity on amenity.id = connect_room_amenity.amenity
GROUP BY listing_url
ORDER BY count(amenity.id) DESC
LIMIT 100;

/*
Display all houses betweeen 20/5/20 and 25/5/20 which cost less than 500$ in total, in discending order.
rows: 9167
*/
select id, listing_url, sum(price)
from Listing
left outer join Calendar on id = Calendar.listing_id
where Calendar.date between '2020-05-20' and '2020-05-25' 
group by id, listing_url
having sum(price) < 500
order by sum(price) desc;

/*
Display the hosts who have been reviewed more than 1000 times in descending order.
rows: 28
*/
select Host.name, count(Review.id)
from Host
join Listing on Host.id = Listing.host_id
join Review on Listing.id = Review.listing_id
group by Host.id
having count(Review.id) > 1000
order by count(Review.id) desc;
