create table Host(
   id int,
   url varchar(50),
   name varchar(40),
   since date,
   location varchar(260),
   about text,
   response_time varchar(20),
   response_rate varchar(10),
   acceptance_rate varchar(10),
   is_superhost boolean,
   thumbnail_url varchar(110),
   picture_url varchar(110),
   neighbourhood varchar(30),
   listings_count int,
   total_listings_count int,
   verifications varchar(150),
   has_profile_pic boolean,
   identity_verified boolean
);

alter table Host
add primary key (id);

insert into Host (id, url, name, since, location, about, response_time, response_rate, acceptance_rate, is_superhost, thumbnail_url, picture_url, neighbourhood, listings_count, total_listings_count, verifications, has_profile_pic, identity_verified)
select host_id,host_url ,host_name ,host_since,host_location,host_about,host_response_time,host_response_rate,host_acceptance_rate,host_is_superhost,host_thumbnail_url,host_picture_url,host_neighbourhood,host_listings_count,host_total_listings_count, host_verifications,host_has_profile_pic,host_identity_verified
from copyoflistings
group by host_id,host_url ,host_name ,host_since,host_location,host_about,host_response_time,host_response_rate,host_acceptance_rate,host_is_superhost,host_thumbnail_url,host_picture_url,host_neighbourhood,host_listings_count,host_total_listings_count, host_verifications,host_has_profile_pic,host_identity_verified;

/*
alter table copyoflistings
   drop column host_url ,
   drop column host_name ,
   drop column host_since,
   drop column host_location,
   drop column host_about,
   drop column host_response_time,
   drop column host_response_rate,
   drop column host_acceptance_rate,
   drop column host_is_superhost,
   drop column host_thumbnail_url,
   drop column host_picture_url,
   drop column host_neighbourhood,
   drop column host_listings_count,
   drop column host_total_listings_count,
   drop column host_verifications,
   drop column host_has_profile_pic,
   drop column host_identity_verified;
 */

alter table copyoflistings
add constraint FK_copyoflistings_host foreign key (host_id) references host(id);