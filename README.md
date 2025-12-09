# Proyecto_SQL_BBDDPeliculas
Proyecto de SQL sobre una BBDD de alquiler de películas
Este documento Readme recoge todos los pasos y consultas realizadas para el proyecto sobre SQL, en el cual se responde a un total de 64 consultas.
La BBDD utilizada simula el funcionamiento de un videoclub, gestionando clientes, películas, alquileres y categorías de las películas.
Está desarrollado sobre una base de PostgreSQL y se ha trabajado con herramientas como DBeaver y Visual Sudio Code.

Contenido del repositorio:
-Esquema_SQL: Contiene el esquema completo de la base de datos.
-consultas resueltas SQL: Incluye todas las consultas realizadas durante el proyecto.

Análisis del proyecto:
Para llevar a cabo este proyecto SQL se han aplicado consultas básicas de selección y filtrado como "WHERE".
También consultas con agregaciones y agrupaciones como "SUM", COUNT" o "GROUP BY".
Para las tablas temporales se ha utilizado "CREATE TEMP TABLE" con el fin de almacenar resultados intermedios.
Las consultas con condiciones sobre fechas se han realizado utilizando operadores como "RETURN_DATE" o "MIN".
Algunas consultas requerian de exclusiones por lo que se ha utilizado "NOT IN".
Las consultas con joins múltiples han sido las que combinaban varias tablas y se han realizado con "COUNT" o "DISTINCT" por ejemplo, para evitar duplicados.
Alguna consulta requeria todas las combinaciones posibles por lo que se ha utilizado "CROSS JOIN" que genera combinaciones completas.

Este proyecto ha generado un aprendizaje paso a paso: desde las consultas más básicas hasta el análisis avanzado para la toma de decisiones.
Además, cada consulta puede pertenecer a situaciones reales en la gestión de un videoclub.

Como ejecutar el proyecto:
Abrir el archivo "Esquema_SQL" en DBeaver y ejecutarlo para crear la estructura.
Abrir "consultas resueltas SQL" y ejecutar las consultas una por una o en bloque.

Autora: Sandra Soria
