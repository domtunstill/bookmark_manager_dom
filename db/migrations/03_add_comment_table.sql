CREATE TABLE comments(id SERIAL PRIMARY KEY, bookmark_id INT REFERENCES bookmarks (id), comment VARCHAR(1000));