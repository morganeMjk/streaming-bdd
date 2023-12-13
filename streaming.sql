-- Création de la base de données
CREATE DATABASE IF NOT EXISTS streaming;


-- Utilisation de la base de données
USE streaming;


-- Création de la table streaming_user
CREATE TABLE streaming_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(190) NOT NULL UNIQUE,
    password VARCHAR(190) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Création de la table director
CREATE TABLE director (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(190) NOT NULL,
    lastname VARCHAR(190) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Création de la table movie
CREATE TABLE movie (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(190) NOT NULL,
    duration TIME NOT NULL,
    release_year INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Création de la table favorite
CREATE TABLE favorite (
    streaming_user_id INT NOT NULL,
    movie_id INT NOT NULL,
    FOREIGN KEY (streaming_user_id) REFERENCES streaming_user(id),
    FOREIGN KEY (movie_id) REFERENCES movie(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Création de la table actor
CREATE TABLE actor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(190) NOT NULL,
    lastname VARCHAR(190) NOT NULL,
    birthdate DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Création de la table perform
CREATE TABLE perform (
    movie_id INT NOT NULL,
    actor_id INT NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie(id),
    FOREIGN KEY (actor_id) REFERENCES actor(id),
    role VARCHAR(190) NOT NULL,
    is_lead_role SET('oui', 'non') NOT NULL DEFAULT 'non',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);