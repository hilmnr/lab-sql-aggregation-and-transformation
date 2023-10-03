-- Challenge 1
-- As a movie rental company, we need to use SQL built-in functions to help us gain insights into our business operations:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select min(length) as min_duration from film;
select max(length) as max_duration from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. 
-- Hint: look for floor and round functions.
select  
    floor(avg(length) / 60) AS hours,
    round(avg(length) % 60) AS minutes
from film;

-- 2.1 Calculate the number of days that the company has been operating. 
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select datediff(max(rental_date), min(rental_date)) as days_operating
from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select 
customer_id,
month (rental_date) as rental_month,
weekday (rental_date) as rental_day
from rental;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week. 
-- Hint: use a conditional expression.
with rental as (
select 
customer_id,
weekday(rental_date) as rental_day
from rental
)

select
customer_id,
rental_day,
case 
when rental_day between 0 and 5 then 'workday'
when rental_day between 6 and 7 then 'weekend'
end as day_type
from rental;


-- 3.0 We need to ensure that our customers can easily access information about our movie collection. 
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order. Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future. Hint: look for the IFNULL() function.
select
film_id,
coalesce(length, 'Not Available') as rental_duration
from film
order by film_id asc;


-- 4.0 As a marketing team for a movie rental company, we need to create a personalized email campaign for our customers. 
-- To achieve this, we want to retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address, so that we can address them by their first name and use their email address to send personalized recommendations. 
-- The results should be ordered by last name in ascending order to make it easier for us to use the data.

select concat(first_name, " ", last_name) as customer_full_name ,
left (email, 3) as first_3_email
from customer
order by last_name asc;

-- Challenge 2
-- We need to analyze the films in our collection to gain insights into our business operations. Using the film table, determine:
-- 1.1 The total number of films that have been released.
select count(*) release_year
from film;

-- 1.2 The number of films for each rating.
select rating, count(*) as number_of_films
from film
group by rating;

-- 1.3 The number of films for each rating, and sort the results in descending order of the number of films. This will help us better understand the popularity of different film ratings and adjust our purchasing decisions accordingly.
select rating, count(*) as number_of_films
from film
group by rating
order by number_of_films desc;

-- 2.0 We need to track the performance of our employees. Using the rental table, determine the number of rentals processed by each employee. This will help us identify our top-performing employees and areas where additional training may be necessary.
select staff_id, count(*) as rentals
from rental
group by staff_id;

-- Using the film table, determine:
-- 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help us identify popular movie lengths for each category.
select rating, round(avg(length), 2) as mean_duration
from film
group by rating
order by mean_duration desc; 

-- 3.2 Identify which ratings have a mean duration of over two hours, to help us select films for customers who prefer longer movies.
select rating, ROUND(avg(length), 2) as mean_duration
from film
group by rating
having avg (length) > 120;

-- Determine which last names are not repeated in the table actor.
select last_name
from actor
group by last_name
having count(*)=1;

