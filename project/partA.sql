--authors: Χρήστος Αργυρόπουλος(3170010), Σπυρίδων Μπάζιος(3170113)
-->< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< 

--creating db schema

CREATE TABLE credits(
	casts varchar(100000), 
	crew varchar(100000),
	id int
);

CREATE TABLE keywords(
	id int,
	keywords varchar(8000)
);

CREATE TABLE links(
	movieId int,
	imdbId int,
	tmdbId int
);

CREATE TABLE movies_metadata(
	adult bool,
	belongs_to_collection varchar(300),
	budget int,
	genres varchar(1000),
	homepage varchar(1000),
	id int primary key,
	imdb_id char(9),
	original_language char(2),
	original_title varchar(1000),
	overview varchar(2000),
	popularity float,
	poster_path varchar(50),
	production_companies varchar(2000),
	production_countries varchar(2000),
	release_date date,
	revenue	bigint,
	runtime	float,
	spoken_languages varchar(2000),
	status varchar(30),
	tagline varchar(300),
	title varchar(1000),
	video bool,
	vote_average float,
	vote_count int 
);

CREATE TABLE ratings (
	userId int, 
	movieId int, 
	rating float,
	timestamps int
);


-->< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< 


-- add constraints to the tables
alter table credits add constraint pk_credits primary key (id);
alter table credits add constraint fk_credits_movie foreign key (id) references movies_metadata (id);

alter table links add constraint pk_links primary key (movieId);
alter table links add constraint fk_links_movie foreign key (tmdbid) references movies_metadata (id);
alter table links add constraint unq_imdb_links unique (imdbId);
alter table links add constraint unq_tmdb_links unique (tmdbId);

alter table ratings add constraint pk_ratings primary key (userId, movieId);
alter table ratings add constraint fk_ratings foreign key (movieId) references movies_metadata (id);

alter table keywords add constraint pk_keywords primary key (id);
alter table keywords add constraint fk_keywords_movie foreign key (id) references movies_metadata (id);

--movies_metadata's pk was created upon the table's creation

alter table genres add constraint pk_genres primary key (id);

alter table movies_connect_genres add constraint pk_mcg primary key (movie_id, genre_id);
alter table movies_connect_genres add constraint fk_mcg_movie foreign key (movie_id) references movies_metadata (id);
alter table movies_connect_genres add constraint fk_mcg_genre foreign key (genre_id) references genres (id);
--------------

-->< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< 

delete from links 
where tmdbid not in (
	select id from movies_metadata
) ;

delete from ratings 
where movieId not in (
	select id from movies_metadata
) ;

delete from keywords 
where id not in (
	select id from movies_metadata
) ;

delete from credits 
where id not in (
	select id from movies_metadata
) ;


-->< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< 

--removing dublicates from credits
CREATE TABLE temptbl(
    casts varchar(100000), 
    crew varchar(100000),
    id int
);

insert into temptbl (id)
select distinct id from credits;

alter table temptbl
add constraint pk_temptbl primary key (id);

update temptbl
set casts = credits.casts
from credits
where temptbl.id = credits.id;

update temptbl
set casts = credits.crew
from credits
where temptbl.id = credits.id;

select * from temptbl limit 1000;
select count() from temptbl;
select count() from credits;

alter table credits
rename to credits_old;

alter table temptbl
rename to credits;
--

-->< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< 

-- creating genres table
create table temp as
select distinct (regexp_split_to_table(genres, '},'))
from movies_metadata;

update temp
set regexp_split_to_table = replace(regexp_split_to_table, '[', ''); 
update temp
set regexp_split_to_table = replace(regexp_split_to_table, ']', ''); 
update temp
set regexp_split_to_table = replace(regexp_split_to_table, '{', ''); 
update temp
set regexp_split_to_table = replace(regexp_split_to_table, '}', '');
update temp
set regexp_split_to_table = replace(regexp_split_to_table, ' ', ''); 

delete from temp
where length(regexp_split_to_table) = 0;

create table temp2 as
select distinct regexp_split_to_table as col
from temp;

drop table temp;

create table genres as
select split_part(col, ',', 1) as id,
	   split_part(col, ',', 2) as name
from temp2;

drop table temp2;

update genres
set id = replace(id, E'\'', '');
update genres
set name = replace(name, E'\'', '');
update genres
set id = replace(id, 'id:', '');
update genres
set name = replace(name, 'name:', '');

select * from genres

-->< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< >< 

-- connection movies with their genres
create table movies_connect_genres as
select movies_metadata.id as movie_id, genres.id as genre_id
from movies_metadata cross join genres
where movies_metadata.genres like '%'||genres.id||'%';
				     
