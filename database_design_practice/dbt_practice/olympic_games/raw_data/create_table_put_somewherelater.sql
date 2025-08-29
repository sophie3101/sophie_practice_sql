CREATE SCHEMA raw_layer;
SET SEARCH_PATH TO raw_layer;
DROP TABLE IF EXISTS athlete_events;
CREATE TABLE athlete_events (
    id INTEGER,
    name TEXT,
    sex CHAR(1),
    age TEXT,
    height TEXT,
    weight TEXT,
    team TEXT,
    noc CHAR(3),
    games TEXT,
    year INTEGER,
    season TEXT,
    city TEXT,
    sport TEXT,
    event TEXT,
    medal TEXT
);

\copy athlete_events FROM raw_data/athlete_events.csv DELIMITER ',' CSV HEADER;