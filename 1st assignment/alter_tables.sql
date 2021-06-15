--calendar
alter table Calendar
add constraint PK_Calendar primary key (listing_id, date);

alter table Calendar
add constraint FK_Calendar_Listings foreign key (listing_id) references Listings (id);

--geolocation
alter table Geolocation
add constraint PK_Geolocation primary key (properties_neighbourhood);

alter table Geolocation
add constraint FK_Geolocation_Neighbourhoods foreign key (properties_neighbourhood) references Neighbourhoods (neighbourhood);

--listings
alter table Listings
add constraint PK_Listings primary key (id);

alter table Listings
add constraint FK_Listings_Neighbourhoods foreign key (neighbourhood_cleansed) references Neighbourhoods (neighbourhood);

--listings_summary
alter table Listings_Summary
add constraint PK_Listings_Summary primary key (id);

alter table Listings_Summary
add constraint FK_Listings_Summary_Listings foreign key (id) references Listings (id);

--neighbourhoods
alter table Neighbourhoods
add constraint PK_Neighbourhoods primary key (neighbourhood);

--reviews
--primary key was created on create_table query
--foreign key was created on create_table query

--reviews_summary
alter table Reviews_summary
add constraint FK_Reviews_Summary_Listings foreign key (listing_id) references Listings (id);