--authors: Χρήστος Αργυρόπουλος(3170010), Σπυρίδων Μπάζιος(3170113)


--Αριθμός ταινιών ανά χρόνο
select date_part('year', release_date) as year, count(*) as total_movies
from movies_metadata
group by year 
order by total_movies desc;

--Αριθμός ταινιών ανά είδος(genre)
select genres.name, count(*) as total_movies
from movies_connect_genres
join genres on movies_connect_genres.genre_id = genres.id
group by genres.id, genres.name;

--Αριθμός ταινιών ανά είδος(genre) και ανά χρόνο
select genres.name, date_part('year', release_date) as year, count(*) as total_movies
from movies_metadata
join movies_connect_genres on movies_metadata.id = movies_connect_genres.movie_id
join genres on movies_connect_genres.genre_id = genres.id
group by genre_id, genres.name, date_part('year', release_date);

--Μέση βαθμολογία (rating) ανά είδος (ταινίας)
select genres.name, sum(rating)/count(rating) as average_rating
from ratings
join movies_metadata on ratings.movieId = movies_metadata.id
join movies_connect_genres on movies_metadata.id = movies_connect_genres.movie_id
join genres on movies_connect_genres.genre_id = genres.id
group by genre_id, genres.name;

--Αριθμός από ratings ανά χρήστη
select userid, count(*) as total_ratings
from ratings
group by userid
order by total_ratings desc;

--Μέση βαθμολογία (rating) ανά χρήστη
select userid, sum(rating)/count(rating) as average_rating
from ratings
group by userid
order by average_rating desc;

--view table
create view user_insight as
select userid, count(rating) as total_ratings, sum(rating)/count(rating) as average_rating
from ratings
group by userid;
