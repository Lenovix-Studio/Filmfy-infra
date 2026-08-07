CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create table
CREATE TABLE movies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(50) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    original_title VARCHAR(255),
    overview TEXT,
    release_date DATE,
    runtime_minutes INTEGER,
    language VARCHAR(30),
    country VARCHAR(100),
    tmdb_id INTEGER,
    imdb_id VARCHAR(30),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE genres (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE casts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL
);

CREATE TABLE directors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL
);

CREATE TABLE studios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE labels (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE series (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE movie_files (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    movie_id UUID NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
    file_path TEXT NOT NULL,
    resolution VARCHAR(20),
    video_codec VARCHAR(50),
    audio_codec VARCHAR(50),
    duration_seconds INTEGER,
    file_size BIGINT,
    checksum VARCHAR(64),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE images (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    movie_id UUID NOT NULL REFERENCES movies(id) ON DELETE CASCADE,
    image_type VARCHAR(20) NOT NULL,
    file_path TEXT NOT NULL
);

-- Junction Tables
CREATE TABLE movie_genres (
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    genre_id UUID REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY(movie_id, genre_id)
);

CREATE TABLE movie_casts (
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    cast_id UUID REFERENCES casts(id) ON DELETE CASCADE,
    PRIMARY KEY(movie_id, cast_id)
);

CREATE TABLE movie_directors (
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    director_id UUID REFERENCES directors(id) ON DELETE CASCADE,
    PRIMARY KEY(movie_id, director_id)
);

CREATE TABLE movie_studios (
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    studio_id UUID REFERENCES studios(id) ON DELETE CASCADE,
    PRIMARY KEY(movie_id, studio_id)
);

CREATE TABLE movie_labels (
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    label_id UUID REFERENCES labels(id) ON DELETE CASCADE,
    PRIMARY KEY(movie_id, label_id)
);

CREATE TABLE movie_series (
    movie_id UUID REFERENCES movies(id) ON DELETE CASCADE,
    series_id UUID REFERENCES series(id) ON DELETE CASCADE,
    PRIMARY KEY(movie_id, series_id)
);

--Example Data
INSERT INTO genres(name)
VALUES
('Action'),
('Comedy'),
('Drama'),
('Sci-Fi');

INSERT INTO tags(name)
VALUES
('Time Travel'),
('Superhero'),
('Based on Novel');

INSERT INTO casts(name)
VALUES
('Robert Downey Jr.'),
('Chris Evans'),
('Scarlett Johansson');

INSERT INTO directors(name)
VALUES
('Anthony Russo'),
('Joe Russo');

INSERT INTO studios(name)
VALUES
('Marvel Studios');

INSERT INTO labels(name)
VALUES
('Blu-ray');

INSERT INTO series(name)
VALUES
('Marvel Cinematic Universe');

INSERT INTO movies(
    code,
    title,
    original_title,
    overview,
    release_date,
    runtime_minutes,
    language,
    country
)
VALUES(
    'ABC-123',
    'Avengers: Endgame',
    'Avengers: Endgame',
    'The Avengers assemble one last time.',
    '2019-04-26',
    181,
    'English',
    'USA'
);

INSERT INTO movie_files(
    movie_id,
    file_path,
    resolution,
    video_codec,
    audio_codec,
    duration_seconds,
    file_size
)
SELECT
id,
'movies/01/ABC-123.mp4',
'1920x1080',
'H264',
'AAC',
10860,
4876543210
FROM movies
WHERE code='ABC-123';

INSERT INTO images(
movie_id,
image_type,
file_path
)
SELECT
id,
'POSTER',
'covers/01/ABC-123.webp'
FROM movies
WHERE code='ABC-123';

INSERT INTO movie_genres(movie_id, genre_id)
SELECT
m.id,
g.id
FROM movies m
JOIN genres g
ON g.name='Action'
WHERE m.code='ABC-123';

INSERT INTO movie_casts(movie_id, cast_id)
SELECT
m.id,
c.id
FROM movies m
JOIN casts c
ON c.name='Robert Downey Jr.'
WHERE m.code='ABC-123';