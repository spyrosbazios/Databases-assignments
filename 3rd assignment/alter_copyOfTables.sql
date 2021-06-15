--copyOfCalendar
alter table copyOfCalendar
add constraint copyOfPK_Calendar primary key (listing_id, date);

alter table copyOfCalendar
add constraint FK_copyOfCalendar_copyOfListings foreign key (listing_id) references copyOfListings (id);

--copyOfGeolocation
alter table copyOfGeolocation
add constraint PK_copyOfGeolocation primary key (properties_neighbourhood);

alter table copyOfGeolocation
add constraint FK_copyOfGeolocation_copyOfNeighbourhoods foreign key (properties_neighbourhood) references copyOfNeighbourhoods (neighbourhood);

--copyOfListings
alter table copyOfListings
add constraint PK_copyOfListings primary key (id);

alter table copyOfListings
add constraint FK_copyOfListings_copyOfNeighbourhoods foreign key (neighbourhood_cleansed) references copyOfNeighbourhoods (neighbourhood);

--copyOfListings_Summary
alter table copyOfListings_Summary
add constraint PK_copyOfListings_Summary primary key (id);

alter table copyOfListings_Summary
add constraint FK_copyOfListings_copyOfSummary_Listings foreign key (id) references copyOfListings (id);

--copyOfNeighbourhoods
alter table copyOfNeighbourhoods
add constraint PK_copyOfNeighbourhoods primary key (neighbourhood);

--reviews
--primary key was created on create_table query
--foreign key was created on create_table query

--copyOfReviews_summary
alter table copyOfReviews_summary
add constraint FK_copyOfReviews_copyOfSummary_Listings foreign key (listing_id) references copyOfListings (id);

alter table copyOfListings rename to copyOfListing;
alter table copyOfListings_Summary rename to copyOfListing_Summary;
alter table copyOfReviews rename to copyOfReview;
alter table copyOfReviews_Summary rename to copyOfReview_Summary;
alter table copyOfNeighbourhoods rename to copyOfNeighbourhood;