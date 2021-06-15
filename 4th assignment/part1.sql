create table copyofRoom as
select * from Room;

alter table copyofRoom
add constraint unique_copyofroom unique (listing_id);

create table Amenity(
    id serial,
    name varchar(50)   
);

alter table Amenity
add constraint pk_amenity primary key (id);

insert into Amenity(name)
select distinct replace(replace(replace(regexp_split_to_table(amenities, ','), '"', ''), '{', ''), '}', '')
from copyofRoom;

create table Connect_Room_Amenity as
select listing_id as room, replace(replace(replace(regexp_split_to_table(amenities, ','), '"', ''), '{', ''), '}', '') as amenity
from copyofRoom;

update Connect_Room_Amenity
set amenity = Amenity.id
from Amenity
where Amenity.name = Connect_Room_Amenity.amenity;

alter table Connect_Room_Amenity
alter column amenity type int using amenity::integer;

alter table Connect_Room_Amenity
add constraint FK_Connect_Room_Amenity_Room foreign key (room) references CopyofRoom (listing_id);

alter table Connect_Room_Amenity
add constraint FK_Connect_Room_Amenity_Amenity foreign key (amenity) references Amenity (id);

alter table copyofRoom
drop column amenities;
