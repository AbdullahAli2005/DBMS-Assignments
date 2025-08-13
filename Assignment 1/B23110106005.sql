-- Create table
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    year_published INT,
    isAvailable BOOLEAN,
    price NUMERIC(10,2),
    publication VARCHAR(255)
);

-- Insert sample data
INSERT INTO books (title, author, year_published, isAvailable, price, publication) VALUES
('Whispers of Eternity', 'Lena Carter', 1999, TRUE, 499.00, 'ABC'),
('Iron Horizon', 'Victor Hale', 1949, TRUE, 300.00, 'XYZ'),
('Steps to Tomorrow', 'Diana Brooks', 2020, TRUE, 750.00, 'XYZ'),
('Echoes in the Fog', 'Marcus Gray', 2019, FALSE, 550.00, 'XYZ'),
('Breaking the Silence', 'Eva Dalton', 2018, TRUE, 600.00, 'Penguin'),
('Small Changes, Big Wins', 'Nathan Reid', 2018, TRUE, 599.00, 'Random House'),
('The Long Road Home', 'Isabel Monroe', 2018, TRUE, 720.00, 'ABC'),
('Wired for Wonder', 'Colin Frost', 2011, TRUE, 680.00, 'Harper'),
('Dreamers & Machines', 'Sophie Lang', 2016, FALSE, 640.00, 'Harper'),
('Path of the Seeker', 'Felix Romero', 1988, TRUE, 400.00, 'XYZ'),
('Skybound Souls', 'Noah Sinclair', 2003, TRUE, 510.00, 'XYZ'),
('When the Willow Weeps', 'Grace Holloway', 1960, FALSE, 450.00, 'ABC'),
('Letters from the Ashes', 'Julian Marks', 2005, TRUE, 580.00, 'XYZ'),
('The Sandstorm Prophecy', 'Miles Carrington', 1965, TRUE, 350.00, 'SciFi'),
('Moments Between Worlds', 'Amelia Drake', 2020, TRUE, 520.00, 'XYZ');

-- Select all books published after 2000
SELECT * FROM books WHERE year_published > 2000;

-- Select books with a price less than 599.00, ordered by price in descending order
SELECT * FROM books WHERE price < 599.00 ORDER BY price DESC;

-- Select the top 3 most expensive books
SELECT * FROM books ORDER BY price DESC LIMIT 3;

-- Select 2 books, skipping the first 2, ordered by publication_year in descending order
SELECT * FROM books ORDER BY year_published DESC OFFSET 2 LIMIT 2;

-- Select all books of the publication “XYZ” ordered alphabetically by title
SELECT * FROM books WHERE publication = 'XYZ' ORDER BY title;


