USE sakila;
#1List the number of films per category.

SELECT c.name AS category_name, COUNT(f.film_id) AS film_count
FROM film_category fc
JOIN film f ON fc.film_id = f.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

#2.Retrieve the store ID, city, and country for each store.

SELECT s.store_id, c.city, cn.country 
FROM store s
JOIN address a ON a.address_id = s.address_id
JOIN city c ON c.city_id = a.city_id
JOIN country cn ON cn.country_id=c.country_id
GROUP BY s.store_id, c.city, cn.country; 

#3.Calculate the total revenue generated by each store in dollars.

SELECT s.store_id, SUM(p.amount) AS total_revenue 
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON p.staff_id = st.staff_id
GROUP by s.store_id;

#4. Determine the average running time of films for each category.

SELECT  AVG(f.length) AS average_running_time, c.name AS category_name
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name;

#BONUS: 
#5. Identify the film categories with the longest average running time.
SELECT  AVG(f.length) AS average_running_time, c.name AS category_name
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER by average_running_time DESC;

#6.Display the top 10 most frequently rented movies in descending order.
SELECT * FROM rental;
SELECT * FROM film;
SELECT * FROM inventory;


SELECT f.title, COUNT(r.rental_id) AS number_of_rentals
FROM film f
JOIN inventory i ON i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC
LIMIT 10;


#7.Determine if "Academy Dinosaur" can be rented from Store 1.
# not clear

#8 Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
SELECT DISTINCT f.title, 
CASE WHEN IFNULL(r.return_date, 'NOT AVAILABLE') THEN 'NOT AVAILABLE'
ELSE 'AVAILABLE' 
END AS AVAILABILITY FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY f.title, r.return_date;
#!!!!
############