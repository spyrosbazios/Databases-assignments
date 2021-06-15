set enable_seqscan=off;

VACUUM (FULL, ANALYZE) listing;
VACUUM (FULL, ANALYZE) host;

create index host_id_index on Host (id);

--Query 1: w/out index: 9.791 ms; w/index: 9.593 ms
--Διαλεξαμε το παραπάνω index διότι εμφανίζεται στην εντολή where και group by.


--  .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-
-- / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \
--`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   \ 

VACUUM (FULL, ANALYZE) listing;
VACUUM (FULL, ANALYZE) host;
VACUUM (FULL, ANALYZE) price;


create index price_price_index on Price(price)
create index price_guests_included_index on price(guests_included)

--Query 2: w/out index:  1978.830 ms; w/index: 1957.114 ms
--Διαλεξαμε τα παραπάνω indexes διότι εμφανίζονται στην εντολή where.

--  .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-
-- / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \ \ / / \
--`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   \ 
VACUUM (FULL, ANALYZE) listing;
VACUUM (FULL, ANALYZE) host;
VACUUM (FULL, ANALYZE) price;
VACUUM (FULL, ANALYZE) room;

create index price_listing_id_index on price(listing_id);

--Query 1: w/out index: 58.223 ms; w/index: 59.848 ms 
--Μετά απο δοκίμες καταλήξαμε στην δημιουργία του παραπάνω index.

-----------------------------------------

VACUUM (FULL, ANALYZE) listing;
VACUUM (FULL, ANALYZE) host;
VACUUM (FULL, ANALYZE) price;
VACUUM (FULL, ANALYZE) room;

create index listing_property_type_index on listing(property_type);
create index location_listing_id_index on location(listing_id);

-- Query 2: w/out index:  95.060 ms; w/index: 40.313 ms
-- Το listing_property_type_index χρησιμοποιήθηκε διότι επιταχύνει σημαντικά την εκτέλεση 
-- του ερωτήματος στο where ... like και το location_listing_id_index για περαιτέρω βελτίωση
-- (οχι τοσο σημαντική όσο την προηγούμενη) επειδή οι πίνακες geolocation και Neighbourhood
-- έχουν τον ίδιο αριθμό εγγραφών ενώ στον πίνακα location που γίνεται η σύνδεση με τον 
-- listing κάθε γειτονία εμφανίζεται πολλές φορές.

-----------------------------------------

VACUUM (FULL, ANALYZE) listing;
VACUUM (FULL, ANALYZE) host;
VACUUM (FULL, ANALYZE) price;
VACUUM (FULL, ANALYZE) room;
VACUUM (FULL, ANALYZE) location;

create index lisitng_listing_url_index on listing(listing_url);

--Query 3: w/out index:  4481.790 ms; w/index: 649.353 ms
--Διαλεξαμε το παραπάνω index διότι εμφανίζεται στην εντολή group by.


-----------------------------------------

VACUUM (FULL, ANALYZE) listing;
VACUUM (FULL, ANALYZE) calendar;

create index calendar_date_index on calendar(date);
create index listing_id_url_index on listing(id, listing_url);

--Query 4: w/out index:  9263.851 ms; w/index: 189.749 ms
-- Διαλέξαμε το calendar_date_index γιατί χρησιμοποιήται στο where και βελτιώνει σημαντικά 
-- τον έλεγχο για το αν η ημερομηνια βρίσκεται ανάμεσα απο '2020-05-20' and '2020-05-25' 
--Διαλεξαμε το listing_id_url_index διότι εμφανίζεται στην εντολή group by.
 
-----------------------------------------

VACUUM (FULL, ANALYZE) host;
VACUUM (FULL, ANALYZE) review;

create index review_id_index on review(id);

--Query 5: w/out index:  2085.411 ms; w/index: 1088.761 ms
-- Απο το πρώτο query εχουμε ήδη δημιουργήσει το host_id_index όπου βοηθάει και σε αυτό 
-- το ερώτημα και επίσης προσθέσαμε και το review_id_index στον ελεγχό αν τα reviews id 
-- ειναι απο 1000
-----------------------------------------



