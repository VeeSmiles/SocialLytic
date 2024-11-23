/*Create tables*/
CREATE TABLE Users (
user_id INT PRIMARY KEY,
username VARCHAR(50),
email VARCHAR(100)
);
CREATE TABLE Posts(
post_id INT PRIMARY KEY,
user_id INT,
content TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE Analytics (
analytics_id INT PRIMARY KEY,
post_id INT,
views INT,
likes INT,
shares INT,
FOREIGN KEY(post_id)
REFERENCES Posts(post_id)
);

/*Insert initial data*/
INSERT INTO Users (user_id, username, email) VALUES (102, 'James Mike', 'james@gmail.com');
INSERT INTO Users (user_id, username, email) VALUES (104, 'Mary Mueni', 'mueni@gmail.com');
INSERT INTO Users (user_id, username, email) VALUES (106, 'Miller Hugo', 'miller@gmail.com');

INSERT INTO Posts (post_id, user_id, content) VALUES (3, 102, 'One in a Million');
INSERT INTO Posts (post_id, user_id, content) VALUES (5, 104, 'Health and Fitness');
INSERT INTO Posts (post_id, user_id, content) VALUES (7, 106, 'Controversial Talks');

INSERT INTO Analytics (analytics_id, post_id, views, likes, shares) VALUES (3, 3, 150, 40, 38);
INSERT INTO Analytics (analytics_id, post_id, views, likes, shares) VALUES (5, 5, 385, 78, 50);
INSERT INTO Analytics (analytics_id, post_id, views, likes, shares) VALUES (7, 7, 890, 697, 89);

/*Read data*/
SELECT * FROM Posts;

/*Update data*/
UPDATE Posts SET Content = 'Music and luxury' WHERE post_id = 1;
/*Delete data*/
DELETE FROM Posts WHERE post_id = 3;

/*CREATE - To add new data to your database, you use the INSERT statement.*/
/*READ - To retrieve data, you use the SELECT statement.*/
/*UPDATE - To modify existing data, you use the UPDATE statement.*/
/* DELETE - To modify existing data, you use the DELETE statement.*/
