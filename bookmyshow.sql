-- =========================================================
-- BOOKMYSHOW DATABASE ASSIGNMENT
-- MySQL 8+
-- =========================================================

CREATE DATABASE IF NOT EXISTS bookmyshow_db;

USE bookmyshow_db;

-- =========================================================
-- CLEANUP
-- =========================================================

DROP TABLE IF EXISTS shows;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS screens;
DROP TABLE IF EXISTS theatres;

-- =========================================================
-- 1. THEATRE
-- =========================================================

CREATE TABLE theatres (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- =========================================================
-- 2. SCREEN
-- =========================================================

CREATE TABLE screens (
    screen_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT NOT NULL,
    screen_name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,

    CONSTRAINT fk_screens_theatre
        FOREIGN KEY (theatre_id)
        REFERENCES theatres(theatre_id),

    CONSTRAINT uq_theatre_screen
        UNIQUE (theatre_id, screen_name)
);

-- =========================================================
-- 3. MOVIE
-- =========================================================

CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(150) NOT NULL,
    language VARCHAR(50) NOT NULL,
    duration_minutes INT NOT NULL,
    certificate VARCHAR(10) NOT NULL
);

-- =========================================================
-- 4. SHOW
-- =========================================================

CREATE TABLE shows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    screen_id INT NOT NULL,
    movie_id INT NOT NULL,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,

    CONSTRAINT fk_shows_screen
        FOREIGN KEY (screen_id)
        REFERENCES screens(screen_id),

    CONSTRAINT fk_shows_movie
        FOREIGN KEY (movie_id)
        REFERENCES movies(movie_id),

    CONSTRAINT uq_screen_date_time
        UNIQUE (screen_id, show_date, show_time)
);

-- =========================================================
-- SAMPLE THEATRES
-- =========================================================

INSERT INTO theatres
    (theatre_name, city, address)
VALUES
    ('PVR Nexus', 'Bhopal', 'Nexus Mall, Bhopal'),
    ('INOX DB City', 'Bhopal', 'DB City Mall, Bhopal'),
    ('Cinepolis', 'Indore', 'Central Mall, Indore');

-- =========================================================
-- SAMPLE SCREENS
-- =========================================================

INSERT INTO screens
    (theatre_id, screen_name, capacity)
VALUES
    (1, 'Screen 1', 200),
    (1, 'Screen 2', 150),
    (2, 'Screen 1', 180),
    (2, 'Screen 2', 120),
    (3, 'Screen 1', 200);

-- =========================================================
-- SAMPLE MOVIES
-- =========================================================

INSERT INTO movies
    (movie_name, language, duration_minutes, certificate)
VALUES
    ('Dasara', 'Telugu', 156, 'UA'),
    ('Kisi Ka Bhai Kisi Ki Jaan', 'Hindi', 145, 'UA'),
    ('Tu Jhoothi Main Makkaar', 'Hindi', 150, 'UA'),
    ('Avatar: The Way of Water', 'English', 192, 'UA'),
    ('KGF Chapter 2', 'Hindi', 168, 'UA');

-- =========================================================
-- SAMPLE SHOWS
-- =========================================================

INSERT INTO shows
    (screen_id, movie_id, show_date, show_time)
VALUES

-- PVR Nexus - 25 April
(1, 1, '2026-04-25', '12:15:00'),
(1, 2, '2026-04-25', '13:00:00'),
(1, 2, '2026-04-25', '16:40:00'),
(1, 2, '2026-04-25', '20:20:00'),
(1, 2, '2026-04-25', '23:00:00'),

(2, 3, '2026-04-25', '13:15:00'),
(2, 4, '2026-04-25', '17:20:00'),

-- PVR Nexus - 26 April
(1, 1, '2026-04-26', '10:30:00'),
(1, 2, '2026-04-26', '14:00:00'),
(1, 3, '2026-04-26', '18:00:00'),

-- PVR Nexus - 27 April
(1, 4, '2026-04-27', '11:00:00'),
(2, 2, '2026-04-27', '15:30:00'),
(2, 5, '2026-04-27', '20:00:00'),

-- INOX - 25 April
(3, 3, '2026-04-25', '11:00:00'),
(3, 2, '2026-04-25', '15:00:00'),
(3, 5, '2026-04-25', '19:00:00'),

-- INOX - 26 April
(4, 1, '2026-04-26', '12:00:00'),
(4, 4, '2026-04-26', '18:30:00'),

-- Cinepolis - 25 April
(5, 4, '2026-04-25', '10:00:00'),
(5, 5, '2026-04-25', '17:00:00');

-- =========================================================
-- VERIFY TABLES
-- =========================================================

SELECT * FROM theatres;
SELECT * FROM screens;
SELECT * FROM movies;
SELECT * FROM shows;