SELECT
    film.film_id,
    film.title,
    category.category_id,
    category.name AS name
FROM
    film
JOIN
    film_category ON film.film_id = film_category.film_id
JOIN
    category ON film_category.category_id = category.category_id;


SELECT 
    category.name,
    COUNT(film.film_id) AS Count
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    category.name;


SELECT
    actor.actor_id,
    actor.first_name,
    actor.last_name,
    COUNT(film_actor.film_id) AS Movies
FROM
    actor
JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY
    actor.actor_id
ORDER BY
    Movies desc;


SELECT
    store.store_id,
    film.film_id,
    COUNT(inventory.inventory_id) AS DVD
FROM
    film
JOIN
    inventory ON film.film_id = inventory.film_id
JOIN
    store ON inventory.store_id = store.store_id
GROUP BY
    store.store_id, film.film_id
ORDER BY
    store.store_id asc;


SELECT
    rental.rental_id,
    rental.rental_date,
    inventory.inventory_id,
    rental.customer_id,
    rental.return_date,
    staff.staff_id,
    rental.last_update
FROM
    rental
JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN
    film ON inventory.film_id = film.film_id
JOIN
    store ON inventory.store_id = store.store_id
JOIN
    staff ON rental.staff_id = staff.staff_id
WHERE
     rental.return_date IS NULL;


SELECT
    film.title,
    COUNT(rental.rental_id) AS rented
FROM
    film
JOIN
    Inventory ON film.film_id = inventory.film_id
JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY
    film.title
ORDER BY
    rented DESC
LIMIT 5;


SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    COUNT(rental.rental_id) AS count
FROM
    customer
JOIN
    rental ON customer.customer_id = rental.customer_id
GROUP BY
    customer.customer_id
ORDER BY
    count desc;



