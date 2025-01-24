CREATE TABLE IF NOT EXISTS genre (
	id SERIAL PRIMARY KEY,
	name VARCHAR(127)
);

CREATE TABLE IF NOT EXISTS artist (
	id SERIAL PRIMARY KEY,
	name VARCHAR(127) NOT NULL
);

CREATE TABLE IF NOT EXISTS album (
	id SERIAL PRIMARY KEY,
	name VARCHAR(127) NOT NULL,
	year INTEGER NOT NULL CHECK (-10000 < year AND year < 10000)
);

CREATE TABLE IF NOT EXISTS track (
	id SERIAL PRIMARY KEY,
	name VARCHAR(127) NOT NULL,
	duration INTEGER NOT NULL CHECK (duration > 0),
	album_id INTEGER NOT NULL REFERENCES album(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS collection (
	id SERIAL PRIMARY KEY,
	name VARCHAR(127) NOT NULL,
	year INTEGER NOT NULL CHECK (-10000 < year AND year < 10000)
);

CREATE TABLE IF NOT EXISTS artist_genre (
	artist_id INTEGER NOT NULL REFERENCES artist(id) ON DELETE CASCADE,
	genre_id INTEGER NOT NULL REFERENCES genre(id) ON DELETE CASCADE,
	CONSTRAINT artist_genre_pkey PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE IF NOT EXISTS album_artist (
	album_id INTEGER NOT NULL REFERENCES album(id) ON DELETE CASCADE,
	artist_id INTEGER NOT NULL REFERENCES artist(id) ON DELETE CASCADE,
	CONSTRAINT album_artist_pkey PRIMARY KEY (album_id, artist_id)
);

CREATE TABLE IF NOT EXISTS collection_track (
	collection_id INTEGER NOT NULL REFERENCES collection(id) ON DELETE CASCADE,
	track_id INTEGER NOT NULL REFERENCES track(id) ON DELETE CASCADE,
	ordinal INTEGER NOT NULL CHECK (ordinal > 0),
	CONSTRAINT collection_track_pkey PRIMARY KEY (collection_id, track_id)
);
