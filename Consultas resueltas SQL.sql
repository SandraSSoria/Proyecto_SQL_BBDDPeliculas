-- 1. Crea el esquema de la BBDD.
    Para ver las tablas en formato "Diagrama": click derecho sobre Tablas/View Diagram

-- 2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.
select "title", "rating" 
from film f  
where "rating" in ('R'); 

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40.
select first_name as "Nombre",
	last_name as "Apellido",
	actor_id
from actor a 
where a.actor_id between 30 and 40; 

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select "title" 
from film f  
where "language_id" = "original_language_id"; 
No se obtiene resultado ya que ninguna película tiene coincidencia.

-- 5. Ordena las películas por duración de forma ascendente.
select "title", "length" 
from film f  
order by length asc; 

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.
SELECT CONCAT(first_name, ' ', last_name) AS "Nombre_completo_actor" 
FROM actor AS a 
WHERE last_name ILIKE '%Allen%'; 

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.
select "rating", count(*) as total_peliculas 
from film f  
group by "rating" 
order by total_peliculas desc; 

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.
select "title" 
from film f  
where "rating" = 'PG-13' 
or "length" > 180; 
Si no solo queremos ver la columna “title” sinó que también queremos la columna “rating” y “length”: 
select "title","rating","length" 
from film f  
where "rating" = 'PG-13' 
or "length" > 180; 

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select  
round(AVG(replacement_cost), 2) as media, 
round(STDDEV(replacement_cost), 2) as desviacion_estandard, 
min(replacement_cost) as minimo, 
max(replacement_cost) as maximo 
from film f ; 

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
select 
min(length) as duracion_minima, 
max(length) as duracion_maxima 
from film f ; 

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p.amount, r.rental_date 
from rental r  
join payment p on r.rental_id = p.rental_id  
order by r.rental_date desc 
offset 2 limit 1; 
Si queremos saber qué película es: 
SELECT f.title, 
       p.amount, 
       r.rental_date 
FROM rental r 
JOIN payment p ON r.rental_id = p.rental_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
ORDER BY r.rental_date DESC 
OFFSET 2 LIMIT 1; 

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC￾17’ ni ‘G’ en cuanto a su clasificación.
select "title"
from film f 
where rating not in ('NC-17' , 'G');

-- 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.
SELECT rating, 
       ROUND(AVG(length), 2) AS promedio_duracion 
FROM film 
GROUP BY rating 
ORDER BY rating;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.
SELECT title, length 
FROM film 
WHERE length > 180 
ORDER BY length ASC; 

-- 15. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM(amount) AS total_ingresos 
FROM payment; 

-- 16. Muestra los 10 clientes con mayor valor de id.
SELECT customer_id, first_name, last_name 
FROM customer 
ORDER BY customer_id DESC 
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’.
SELECT a.first_name, a.last_name 
FROM film f 
JOIN film_actor fa ON f.film_id = fa.film_id 
JOIN actor a ON fa.actor_id = a.actor_id 
WHERE f.title = 'EGG IGBY'; 

-- 18. Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT title 
FROM film 
ORDER BY title; 

-- 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.
SELECT f.title, f.length 
FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Comedy' 
  AND f.length > 180 
ORDER BY f.length DESC; 

-- 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.
SELECT c.name AS categoria, 
       ROUND(AVG(f.length), 2) AS promedio_duracion 
FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.name 
HAVING AVG(f.length) > 110 
ORDER BY promedio_duracion DESC; 

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT ROUND(AVG(rental_duration), 2) AS media_duracion_alquiler 
FROM film; 

-- 22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.
SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo 
FROM actor 
ORDER BY nombre_completo;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.
SELECT DATE(rental_date) AS dia, 
       COUNT(*) AS numero_alquileres 
FROM rental 
GROUP BY DATE(rental_date) 
ORDER BY numero_alquileres DESC; 

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT title, length 
FROM film 
WHERE length > (SELECT AVG(length) FROM film) 
ORDER BY length DESC;

-- 25. Averigua el número de alquileres registrados por mes
SELECT DATE_TRUNC('month', rental_date) AS mes, 
       COUNT(*) AS numero_alquileres 
FROM rental 
GROUP BY DATE_TRUNC('month', rental_date) 
ORDER BY mes;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.
SELECT  
    ROUND(AVG(amount), 2) AS promedio, 
    ROUND(STDDEV(amount), 2) AS desviacion_estandar, 
    ROUND(VARIANCE(amount), 2) AS varianza 
FROM payment; 

-- 27. ¿Qué películas se alquilan por encima del precio medio?
SELECT title, rental_rate 
FROM film 
WHERE rental_rate > (SELECT AVG(rental_rate) FROM film) 
ORDER BY rental_rate DESC; 

-- 28. Muestra el id de los actores que hayan participado en más de 40
películas.
SELECT actor_id, COUNT(film_id) AS numero_peliculas 
FROM film_actor 
GROUP BY actor_id 
HAVING COUNT(film_id) > 40 
ORDER BY numero_peliculas DESC; 

-- 29. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.
select 	
	f.film_id,
	f.title,
	count(i.inventory_id) as Cantidad_disponible
from film f 
left join inventory i 
	on f.film_id = i.film_id 
group by f.film_id , f.title 
order by f.title; 

-- 30. Obtener los actores y el número de películas en las que ha actuado.
SELECT a.first_name || ' ' || a.last_name AS nombre_completo, 
       COUNT(fa.film_id) AS numero_peliculas 
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
GROUP BY a.first_name, a.last_name 
ORDER BY numero_peliculas DESC; 

-- 31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.
SELECT f.title, 
       COALESCE(a.first_name || ' ' || a.last_name, 'Sin actores asociados') AS actor 
FROM film f 
LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
LEFT JOIN actor a ON fa.actor_id = a.actor_id 
ORDER BY f.title, actor; 

-- 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT a.first_name || ' ' || a.last_name AS nombre_completo, 
       COALESCE(f.title, 'Sin películas asociadas') AS pelicula 
FROM actor a 
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id 
LEFT JOIN film f ON fa.film_id = f.film_id 
ORDER BY nombre_completo, pelicula; 

-- 33. Obtener todas las películas que tenemos y todos los registros de
alquiler.
SELECT f.title, 
       r.rental_id, 
       r.rental_date, 
       r.customer_id 
FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id 
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
ORDER BY f.title, r.rental_date; 

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT c.customer_id, 
       c.first_name || ' ' || c.last_name AS nombre_completo, 
       SUM(p.amount) AS total_gastado 
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name 
ORDER BY total_gastado DESC 
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT first_name, last_name 
FROM actor 
where first_name = 'JOHNNY' 
order by actor.last_name ; 

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.
SELECT first_name AS Nombre, 
       last_name AS Apellido 
FROM actor 
ORDER BY Apellido, Nombre; 

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT MIN(actor_id) AS id_minimo, 
       MAX(actor_id) AS id_maximo 
FROM actor; 
Con los nombres: 
SELECT a.actor_id, 
       a.first_name || ' ' || a.last_name AS nombre_completo 
FROM actor a 
WHERE a.actor_id = (SELECT MIN(actor_id) FROM actor) 
   OR a.actor_id = (SELECT MAX(actor_id) FROM actor);

-- 38. Cuenta cuántos actores hay en la tabla “actor”.
SELECT COUNT(*) AS total_actores 
FROM actor; 

-- 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.
SELECT first_name AS Nombre, 
       last_name AS Apellido 
FROM actor 
ORDER BY Apellido ASC, Nombre ASC; 

-- 40. Selecciona las primeras 5 películas de la tabla “film”.
SELECT film_id, 
       title, 
       release_year, 
       rental_rate 
FROM film 
ORDER BY film_id ASC 
LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?
SELECT first_name AS nombre, 
       COUNT(*) AS cantidad 
FROM actor 
GROUP BY first_name 
ORDER BY cantidad DESC 
LIMIT 1;
El nombre más repetido es PENELOPE.

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.
SELECT r.rental_id, 
       c.first_name || ' ' || c.last_name AS nombre_cliente 
FROM rental r 
JOIN customer c ON r.customer_id = c.customer_id 
ORDER BY r.rental_date DESC; 

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.
SELECT c.first_name || ' ' || c.last_name AS nombre_cliente, 
       r.rental_id 
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id 
ORDER BY nombre_cliente, r.rental_id; 

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT f.film_id, 
       f.title, 
       c.category_id, 
       c.name AS categoria 
FROM film f 
CROSS JOIN category c 
ORDER BY f.film_id, c.category_id; 
Cada película (film) se combina con todas las categorías (category)
No aporta valor ya que el resultado no refleja la relación real entre películas y categorías.
El CROSS JOIN sirve para entender como funciona el producto cartesiano, pero no seria útil para un sistema real de videoclub, ya que genera datos redundantes.

-- 45. Encuentra los actores que han participado en películas de la categoría
'Action'.
SELECT DISTINCT a.first_name || ' ' || a.last_name AS nombre_actor 
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film f ON fa.film_id = f.film_id 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Action' 
ORDER BY nombre_actor; 

Si queremos la columna de la categoría: 
SELECT DISTINCT a.first_name || ' ' || a.last_name AS nombre_actor, 
       c.name AS categoria 
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film f ON fa.film_id = f.film_id 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Action' 
ORDER BY nombre_actor; 

-- 46. Encuentra todos los actores que no han participado en películas.
SELECT a.actor_id, 
       a.first_name || ' ' || a.last_name AS nombre_actor 
FROM actor a 
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id 
WHERE fa.film_id IS NULL 
ORDER BY nombre_actor; 
Nos da un resultado vacío, sin datos. Esto quiere decir que no hay actores que no hayan participado en ninguna película.

Podemos comprobarlo con la siguiente consulta:
SELECT COUNT(*) AS actores_sin_peliculas 
FROM actor a 
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id 
WHERE fa.film_id IS NULL; 

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.
SELECT a.first_name || ' ' || a.last_name AS nombre_actor, 
       COUNT(fa.film_id) AS cantidad_peliculas 
FROM actor a 
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id, a.first_name, a.last_name 
ORDER BY cantidad_peliculas DESC, nombre_actor; 

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.
Para crear la vista: 
create view actor_num_peliculas as  
select a.first_name || ' ' || a.last_name as nombre_actor, 
count(fa.film_id) as cantidad_peliculas 
from actor a  
left join film_actor fa on a.actor_id = fa.actor_id 
group by a.actor_id, a.first_name, a.last_name 
order by cantidad_peliculas desc, nombre_actor; 

Para visualizarla: 
select * from actor_num_peliculas; 

-- 49. Calcula el número total de alquileres realizados por cada cliente.
SELECT c.first_name || ' ' || c.last_name AS nombre_cliente, 
       COUNT(r.rental_id) AS total_alquileres 
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name 
ORDER BY total_alquileres DESC, nombre_cliente; 

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT c.name AS categoria, 
       SUM(f.length) AS duracion_total_minutos 
FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Action' 
GROUP BY c.name; 

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.
CREATE TEMP TABLE cliente_rentas_temporal AS 
SELECT c.customer_id, 
       c.first_name || ' ' || c.last_name AS nombre_cliente, 
       COUNT(r.rental_id) AS total_alquileres 
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name 
ORDER BY total_alquileres DESC; 

Para visualizar la tabla: 
SELECT * FROM cliente_rentas_temporal; 

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.
CREATE TEMP TABLE peliculas_alquiladas AS 
SELECT f.film_id, 
       f.title AS titulo, 
       COUNT(r.rental_id) AS total_alquileres 
FROM film f 
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY f.film_id, f.title 
HAVING COUNT(r.rental_id) >= 10 
ORDER BY total_alquileres DESC; 

Para visualizar la tabla: 
SELECT * FROM peliculas_alquiladas; 

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.
SELECT DISTINCT f.title AS titulo_pelicula 
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
WHERE c.first_name = 'TAMMY' 
  AND c.last_name = 'SANDERS' 
  AND r.return_date IS NULL 
ORDER BY f.title; 

-- 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.
select distinct a.first_name, 
a.last_name 
from actor a  
join film_actor fa on a.actor_id = fa.actor_id  
join film f on fa.film_id = f.film_id  
join film_category fc on f.film_id = fc.film_id  
join category c  on fc.category_id = c.category_id  
where c.name = 'Sci-Fi' 
order by a.last_name , a.first_name ; 

-- 55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.
SELECT DISTINCT a.first_name,  
       a.last_name 
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film f ON fa.film_id = f.film_id 
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
WHERE r.rental_date > ( 
    SELECT MIN(r2.rental_date) 
    FROM film f2 
    JOIN inventory i2 ON f2.film_id = i2.film_id 
    JOIN rental r2 ON i2.inventory_id = r2.inventory_id 
    WHERE f2.title = 'SPARTACUS CHEAPER' 
) 
ORDER BY a.last_name, a.first_name; 

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’.
SELECT a.first_name,  
       a.last_name 
FROM actor a 
WHERE a.actor_id NOT IN ( 
    SELECT DISTINCT fa.actor_id 
    FROM film_actor fa 
    JOIN film f ON fa.film_id = f.film_id 
    JOIN film_category fc ON f.film_id = fc.film_id 
    JOIN category c ON fc.category_id = c.category_id 
    WHERE c.name = 'Music' 
) 
ORDER BY a.last_name, a.first_name; 

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.
SELECT DISTINCT f.title AS titulo_pelicula 
FROM film f 
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
WHERE (r.return_date - r.rental_date) > INTERVAL '8 days' 
ORDER BY f.title; 

-- 58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’.
SELECT f.title AS titulo_pelicula 
FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
WHERE c.name = 'Animation' 
ORDER BY f.title; 

-- 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.
SELECT f.title AS titulo_pelicula 
FROM film f 
WHERE f.length = ( 
    SELECT length 
    FROM film 
    WHERE title = 'DANCING FEVER' 
) 
ORDER BY f.title; 

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.
SELECT c.first_name,  
       c.last_name 
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
GROUP BY c.customer_id, c.first_name, c.last_name 
HAVING COUNT(DISTINCT f.film_id) >= 7 
ORDER BY c.last_name, c.first_name; 

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name AS categoria, 
       COUNT(r.rental_id) AS total_alquileres 
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id 
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY c.name 
ORDER BY total_alquileres DESC, c.name; 

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT c.name AS categoria, 
       COUNT(f.film_id) AS numero_peliculas 
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id 
JOIN film f ON fc.film_id = f.film_id 
WHERE f.release_year = 2006 
GROUP BY c.name 
ORDER BY numero_peliculas DESC, c.name; 

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.
SELECT s.staff_id, 
       s.first_name || ' ' || s.last_name AS nombre_trabajador, 
       st.store_id, 
       st.manager_staff_id 
FROM staff s 
CROSS JOIN store st 
ORDER BY nombre_trabajador, st.store_id;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas
SELECT c.customer_id, 
       c.first_name, 
       c.last_name, 
       COUNT(r.rental_id) AS total_peliculas_alquiladas 
FROM customer c 
JOIN rental r ON c.customer_id = r.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name 

ORDER BY c.last_name, c.first_name; 
