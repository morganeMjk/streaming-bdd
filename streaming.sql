-- Création de la base de données
CREATE DATABASE IF NOT EXISTS streaming;


-- Utilisation de la base de données
USE streaming;


-- Création de la table streaming_user
CREATE TABLE streaming_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Création de la table director
CREATE TABLE director (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Création de la table movie
CREATE TABLE movie (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    duration TIME NOT NULL,
    release_year INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Création de la table favorite
CREATE TABLE favorite (
    streaming_user_id INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (streaming_user_id) REFERENCES streaming_user(id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Création de la table actor
CREATE TABLE actor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    birthdate DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Création de la table perform
CREATE TABLE perform (
    movie_id INT NOT NULL,
    actor_id INT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
    FOREIGN KEY (actor_id) REFERENCES actor(id) ON DELETE CASCADE,
    role VARCHAR(50) NOT NULL,
    is_lead_role SET('oui', 'non') NOT NULL DEFAULT 'non',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Ajout de données dans la table streaming_user
INSERT INTO streaming_user (email, password) VALUES
    ('john.doe@example.com', 'password1'),
    ('alice.smith@example.com', 'password2'),
    ('michael.jones@example.com', 'password3'),
    ('emily.white@example.com', 'password4'),
    ('william.brown@example.com', 'password5'),
    ('olivia.johnson@example.com', 'password6'),
    ('daniel.miller@example.com', 'password7');

-- Ajout de données dans la table director
INSERT INTO director (firstname, lastname) VALUES
    ('Christopher', 'Nolan'),
    ('Greta', 'Gerwig'),
    ('Quentin', 'Tarantino');

-- Ajout de données dans la table movie
INSERT INTO movie (title, duration, release_year) VALUES
    ('Inception', '02:30:00', 2010),
    ('Little Women', '02:15:00', 2019),
    ('Pulp Fiction', '02:34:00', 1994),
    ('The Dark Knight', '02:32:00', 2008),
    ('La La Land', '02:08:00', 2016),
    ('Django Unchained', '02:45:00', 2012),
    ('Interstellar', '02:49:00', 2014),
    ('Once Upon a Time in Hollywood', '02:41:00', 2019),
    ('Memento', '01:53:00', 2000),
    ('Lady Bird', '01:34:00', 2017),
    ('Kill Bill: Volume 1', '01:51:00', 2003),
    ('Kill Bill: Volume 2', '02:17:00', 2004),
    ('The Prestige', '02:10:00', 2006),
    ('Reservoir Dogs', '01:39:00', 1992),
    ('Tenet', '02:30:00', 2020),
    ('Once Upon a Time in the West', '02:45:00', 1968),
    ('Dunkirk', '01:46:00', 2017),
    ('The Hateful Eight', '03:07:00', 2015);

-- Ajout de données dans la table favorite
INSERT INTO favorite (streaming_user_id, movie_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 4),
    (2, 5),
    (3, 6),
    (3, 7),
    (3, 8),
    (4, 9),
    (4, 10),
    (4, 11),
    (4, 12),
    (5, 13),
    (5, 14),
    (5, 15),
    (6, 16),
    (6, 17),
    (6, 18),
    (7, 1),
    (7, 5),
    (7, 10);

-- Ajout de données dans la table actor
INSERT INTO actor (firstname, lastname, birthdate) VALUES
    ('Leonardo', 'DiCaprio', '1974-11-11'),
    ('Emma', 'Watson', '1990-04-15'),
    ('Brad', 'Pitt', '1963-12-18'),
    ('Scarlett', 'Johansson', '1984-11-22'),
    ('Ryan', 'Gosling', '1980-11-12'),
    ('Meryl', 'Streep', '1949-06-22'),
    ('Tom', 'Hardy', '1977-09-15'),
    ('Margot', 'Robbie', '1990-07-02'),
    ('Joaquin', 'Phoenix', '1974-10-28'),
    ('Saoirse', 'Ronan', '1994-04-12'),
    ('Uma', 'Thurman', '1970-04-29'),
    ('Samuel', 'L. Jackson', '1948-12-21'),
    ('Hugh', 'Jackman', '1968-10-12'),
    ('Tim', 'Roth', '1961-05-14'),
    ('Robert', 'Pattinson', '1986-05-13'),
    ('Henry', 'Fonda', '1905-05-16'),
    ('Harry', 'Styles', '1994-02-01'),
    ('Cillian', 'Murphy', '1976-05-25'),
    ('Christian', 'Bale', '1974-01-30');

-- Ajout de données dans la table perform
INSERT INTO perform (movie_id, actor_id, role, is_lead_role) VALUES
    (1, 1, 'Dom Cobb', 'oui'),
    (1, 3, 'Arthur', 'non'),
    (2, 2, 'Meg March', 'oui'),
    (2, 6, 'Aunt March', 'non'),
    (3, 7, 'Jules Winnfield', 'oui'),
    (3, 8, 'Mia Wallace', 'non'),
    (4, 5, 'Bruce Wayne / Batman', 'oui'),
    (4, 7, 'Bane', 'non'),
    (5, 16, 'Sebastian', 'oui'),
    (6, 7, 'Stephen', 'oui'),
    (6, 8, 'Calvin Candie', 'non'),
    (7, 1, 'Joseph Cooper', 'oui'),
    (7, 6, 'Murph (jeune)', 'non'),
    (8, 7, 'Rick Dalton', 'oui'),
    (8, 8, 'Cliff Booth', 'oui'),
    (9, 3, 'Leonard Shelby', 'oui'),
    (9, 7, 'Robert Angier', 'non'),
    (10, 11, 'Mr. Pink', 'oui'),
    (11, 1, 'The Protagonist', 'oui'), 
    (12, 16, 'Frank', 'oui'), 
    (13, 3, 'Alex Jones', 'oui'),
    (14, 16, 'Willard', 'oui'),
    (15, 5, 'Tommy', 'non'),
    (16, 17, 'Alex DeLarge', 'oui'),
    (17, 16, 'Farrier', 'oui'),
    (18, 3, 'Major Marquis Warren', 'oui');