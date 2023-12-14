# README

## Description du Projet
Ce projet comprend un modèle physique des données (MPD) basé sur la méthode Merise, ainsi qu'un fichier SQL nommé streaming.sql. Le script SQL crée et peuple une base de données appelée streaming avec plusieurs tables telles que streaming_user, director, movie, favorite, actor, et perform.

## Structure de la Base de Données
La base de données comprend les tables suivantes :

### streaming_user

- id: Identifiant unique de l'utilisateur.
- email: Adresse e-mail de l'utilisateur.
- password: Mot de passe de l'utilisateur.
- created_at: Date de création de l'utilisateur.
- updated_at: Date de la dernière mise à jour de l'utilisateur.

### director

- id: Identifiant unique du réalisateur.
- firstname: Prénom du réalisateur.
- lastname: Nom de famille du réalisateur.
- created_at: Date de création du 
réalisateur.
- updated_at: Date de la dernière mise à jour du réalisateur.

### movie

- id: Identifiant unique du film.
- title: Titre du film.
- duration: Durée du film.
- release_year: Année de sortie du film.
- created_at: Date de création du film.
- updated_at: Date de la dernière mise à jour du film.

### favorite

- streaming_user_id: Identifiant de l'utilisateur qui a ajouté le film en favori.
- movie_id: Identifiant du film ajouté en favori.
- created_at: Date de création de l'entrée favorite.
- updated_at: Date de la dernière mise à jour de l'entrée favorite.

### actor

- id: Identifiant unique de l'acteur.
- firstname: Prénom de l'acteur.
- lastname: Nom de famille de l'acteur.
- birthdate: Date de naissance de l'acteur.
- created_at: Date de création de l'acteur.
- updated_at: Date de la dernière mise à jour de l'acteur.

### perform

- movie_id: Identifiant du film.
- actor_id: Identifiant de l'acteur.
- role: Rôle joué par l'acteur dans le film.
- is_lead_role: Indique si l'acteur a un rôle principal ('oui' ou 'non').
- created_at: Date de création de l'entrée de performance.
- updated_at: Date de la dernière mise à jour de l'entrée de performance.

## Exemples de Requêtes

### Afficher les titres et dates de sortie des films du plus récent au plus ancien

    SELECT title, release_year
    FROM movie
    ORDER BY release_year DESC;

### Afficher les noms prénoms et âges des acteurs/actrices de plus de 30 ans dans l'ordre alphabétique (prénom d'abord, puis nom)

    SELECT firstname, lastname, birthdate,
    TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age
    FROM actor;

### Afficher la liste des acteurs/actrices principaux pour un film donné

    SELECT actor.firstname, actor.lastname, perform.role
    FROM movie
    JOIN perform ON movie.id = perform.movie_id
    JOIN actor ON perform.actor_id = actor.id
    WHERE title = 'Inception'
    AND is_lead_role = 'oui';

### Afficher la liste des films pour un acteur actrice donné

    SELECT movie.title, movie.release_year, perform.role
    FROM actor
    JOIN perform ON actor.id = perform.actor_id
    JOIN movie ON perform.movie_id = movie.id
    WHERE firstname = 'Brad'
    AND lastname = 'Pitt';

### Ajouter un film

    INSERT INTO movie (title, duration, release_year) VALUES ('Les Goonies', '02:47:00', 1985);

### Ajouter un acteur/actrice

    INSERT INTO actor (firstname, lastname, birthdate) VALUES ('Bradley', 'Cooper', '1975-01-05');

### Modifier un film

    UPDATE movie
    SET release_year = 2023
    WHERE title = 'Les Goonies';

### Supprimer un acteur/actrice

    DELETE FROM movie
    WHERE title = 'Little Women';

### Afficher les 3 derniers acteurs/actrices ajouté(e)s

    SELECT *
    FROM actor
    ORDER BY created_at DESC
    LIMIT 3;

### Afficher la moyenne du nombre de films des acteurs/trices de plus de 50 ans

    SELECT AVG(movie_count) AS average_movies
    FROM (
        SELECT actor_id, COUNT(DISTINCT movie_id) AS movie_count
        FROM actor
        JOIN perform ON actor.id = perform.actor_id
        JOIN movie ON perform.movie_id = movie.id
        WHERE TIMESTAMPDIFF(YEAR, actor.birthdate, CURDATE()) > 50
        GROUP BY actor_id
    ) AS actor_movie_counts;

### Afficher le réalisateur ayant le plus de film mis en favoris et combien de ses films ont été mis en favoris.

    SELECT director.id AS director_id, director.firstname, director.lastname,
    COUNT(favorite.movie_id) AS favorite_count
    FROM director
    JOIN movie ON director.id = movie.id
    JOIN favorite ON movie.id = favorite.movie_id
    GROUP BY director.id
    ORDER BY favorite_count DESC
    LIMIT 1;

### Afficher les films qui ont plus d'acteurs que la moyenne des acteurs par film.

    SELECT movie.id AS movie_id, movie.title, COUNT(perform.actor_id) AS actor_count
    FROM movie
    JOIN perform ON movie.id = perform.movie_id
    GROUP BY movie.id, movie.title
    HAVING actor_count > (SELECT AVG(actor_count_per_movie) FROM (SELECT movie.id, COUNT(perform.actor_id) AS actor_count_per_movie FROM movie JOIN perform ON movie.id = perform.movie_id GROUP BY movie.id) AS avg_actor_count_subquery);

### Écrivez un script de transaction qui ajoute un nouveau film, puis l'ajoute aux films favoris d'un utilisateur spécifique, en s'assurant que les deux opérations réussissent ou échouent ensemble. (Astuce : Utilisez BEGIN TRANSACTION, COMMIT, et ROLLBACK)

