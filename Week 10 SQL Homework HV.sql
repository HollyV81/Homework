USE sakila;

#1a
Select first_name, last_name
From actor;

#1b
Select UPPER(CONCAT(first_name,' ', last_name))
from actor;

#2a
Select actor_id, first_name, last_name
from actor
where first_name = 'Joe';

#2b
Select actor_id, first_name, last_name
from actor
where last_name like '%gen%';

#2c
Select actor_id, first_name, last_name
from actor
where last_name like '%li%'
order by last_name, first_name;

#2d
Select country_id, country
from country
where country in('Afghanistan', 'Bangladesh', 'China');

#3a
Alter table actor
add column middle_name varchar(50) after first_name;

#3b
Alter table actor
modify column middle_name blob;

#3c
Alter table actor
drop column middle_name;

#4a
Select last_name, count(*) as count
from actor
group by last_name;

#4b
Select last_name, count(*) as count
from actor
group by last_name
having count > 1;

#4c
UPDATE actor
set first_name ='Harpo'
where first_name ='Groucho' AND last_name='Williams';

#4d
UPDATE actor set first_name=
CASE
	WHEN  first_name='Harpo' THEN 'Mucho Groucho'
	ELSE 'Groucho'
END
where actor_id=172;


#6a
SELECT staff.first_name, staff.last_name, address.address
from staff
left join address
ON staff.address_id= address.address_id;

#6b
SELECT staff.first_name, staff.last_name, SUM(payment.amount) as total
from staff
join payment
on staff.staff_id= payment.staff_id
group by staff.first_name;

#6c
SELECT film.title, count(film_actor.actor_id) as actors_in_film
from film
inner join film_actor
on film.film_id= film_actor.film_id
group by film.title;

#6d
Select film.title, count(inventory.film_id) as total_copies
from film
join inventory
on film.film_id= inventory.film_id
where film.title = 'Hunchback Impossible';

#6e
Select customer.first_name, customer.last_name, sum(payment.amount) as total
from customer
join payment
on customer.customer_id= payment.customer_id
group by customer.last_name
order by customer.last_name;

#7a
Select title, language_id
from film
where title like 'K%' or title like 'Q%' AND language_id = 
(Select language_id
from language
where name='English');

#7b
Select first_name, last_name
from actor
where actor_id IN 
(
select actor_id 
from film_actor 
where film_id IN 
(
select film_id
from film
where title = 'Alone Trip'));

#7c
Select first_name, last_name, email
from customer
where customer_id in
(
select customer_id
from address
 where city_id IN
 (
 Select city_id
 from city
 where country_id=
 (
 Select country_id
 from country 
 where country='Canada')));
 
#7d
select title
from film
where film_id in
(
Select film_id
from film_category
where category_id=
(
Select category_id
from category
where name='Family'));

#7e
Select film.title, count(rental.inventory_id) times_rented
from film
join inventory 
on film.film_id= inventory.film_id
join rental 
on inventory.inventory_id=rental.inventory_id
group by film.title
order by times_rented desc;

#7f
Select store.store_id, sum(payment.amount) as Total_Revenue
from store
join staff ON
	store.store_id=staff.store_id
join payment ON
	staff.staff_id=payment.staff_id
group by store_id;

#7g
Select store.store_id, city.city, country.country
from store
join address ON
	store.address_id=address.address_id
join city ON
	address.city_id=city.city_id
join country ON
	city.country_id=country.country_id
group by store_id;

#7h
select category.name, sum(payment.amount) as Gross_Revenue
from category
join film_category ON
	category.category_id=film_category.category_id
join inventory ON
	film_category.film_id=inventory.film_id
join rental ON
	inventory.inventory_id=rental.inventory_id
join payment ON
	rental.rental_id=payment.rental_id
group by category.name
order by Gross_Revenue DESC LIMIT 5;

#8a
CREATE VIEW top_five_genres AS
select category.name, sum(payment.amount) as Gross_Revenue
from category
join film_category ON
	category.category_id=film_category.category_id
join inventory ON
	film_category.film_id=inventory.film_id
join rental ON
	inventory.inventory_id=rental.inventory_id
join payment ON
	rental.rental_id=payment.rental_id
group by category.name
order by Gross_Revenue DESC LIMIT 5;

#8b
Select * from top_five_genres;

#8c
DROP VIEW top_five_genres;