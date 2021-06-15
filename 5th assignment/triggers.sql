create or replace function increase_listings_count()
returns trigger as
$$
begin
	update Host 
	set listings_count = listings_count + 1
	where id = new.host_id;
return new;
end;
$$ language plpgsql;

create trigger add_listing after insert on Listing
for each row
execute procedure increase_listings_count();

create or replace function decrease_listings_count()
    returns trigger as
$$
begin
	update Host 
	set listings_count = listings_count - 1
	where id = old.host_id;
return old;
end
$$ language plpgsql;

create trigger remove_listing after delete on Listing
for each row
execute procedure decrease_listings_count();

select listings_count from host where id = 58146;
insert into Listing (id, host_id) values (1290319832, 58146);
select listings_count from host where id = 58146;
delete from Listing where id = 1290319832;
select listings_count from host where id = 58146;

--------------------------------------------------------

create or replace function increase_calculated()
returns trigger as
$$
begin
if new.room_type = 'Entire home/apt' then
	update Listing 
	set calculated_host_listings_count_entire_homes = calculated_host_listings_count_entire_homes + 1
	where host_id = new.host_id;
elsif new.room_type = 'Shared room' then
	update Listing 
	set calculated_host_listings_count_shared_rooms = calculated_host_listings_count_shared_rooms + 1
	where host_id = new.host_id;
elsif new.room_type = 'Private room' then
	update Listing 
	set calculated_host_listings_count_private_rooms = calculated_host_listings_count_private_rooms + 1
	where host_id = new.host_id;
end if;
return new;
end;
$$ language plpgsql;

create trigger add_calculated_listing after insert on Listing
for each row
execute procedure increased_calculated();

create or replace function decrease_calculated()
returns trigger as
$$
begin
if new.room_type = 'Entire home/apt' then
	update Listing 
	set calculated_host_listings_count_entire_homes = calculated_host_listings_count_entire_homes - 1
	where host_id = new.host_id;
elsif new.room_type = 'Shared room' then
	update Listing 
	set calculated_host_listings_count_shared_rooms = calculated_host_listings_count_shared_rooms - 1
	where host_id = new.host_id;
elsif new.room_type = 'Private room' then
	update Listing 
	set calculated_host_listings_count_private_rooms = calculated_host_listings_count_private_rooms - 1
	where host_id = new.host_id;
end if;
return old;
end;
$$ language plpgsql;

create trigger remove_calculated_listing after insert on Listing
for each row
execute procedure decrease_calculated();
