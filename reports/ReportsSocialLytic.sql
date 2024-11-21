CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    JoinDate DATETIME DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO Users (Username, FullName, Email)
VALUES
    ('zuena', 'Zuena Kiplagat', 'zuena.kiplagat@example.com'),
    ('wamboi', 'Beatrice Wamboi', 'beatrice.wamboi@example.com'),
    ('vivian', 'Vivian Ndung\'u', 'vivian.ndungu@example.com');



CREATE TABLE Posts (
    PostID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Content TEXT NOT NULL,
    PostDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);


INSERT INTO Posts (UserID, Content)
VALUES
    (1, 'Hello world! This is my first post.'),
    (2, 'Loving the weather today!'),
    (3, 'Just completed a 10K run. Feeling great!');



CREATE TABLE Comments (
    CommentID INT AUTO_INCREMENT PRIMARY KEY,
    PostID INT NOT NULL,
    UserID INT NOT NULL,
    CommentText TEXT NOT NULL,
    CommentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);


INSERT INTO Comments (PostID, UserID, CommentText)
VALUES
    (1, 2, 'Welcome to the platform, Vivian'),
    (1, 3, 'Nice to see you here!'),
    (2, 1, 'Yes, the weather is amazing!');


CREATE TABLE Likes (
    LikeID INT AUTO_INCREMENT PRIMARY KEY,
    PostID INT NOT NULL,
    UserID INT NOT NULL,
    LikeDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);


INSERT INTO Likes (PostID, UserID)
VALUES
    (1, 2),
    (2, 3),
    (3, 1),
    (1, 3);



CREATE TABLE Shares (
    ShareID INT AUTO_INCREMENT PRIMARY KEY,
    PostID INT NOT NULL,
    UserID INT NOT NULL,
    ShareDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PostID) REFERENCES Posts(PostID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);



INSERT INTO Shares (PostID, UserID)
VALUES
    (1, 2),
    (2, 1),
    (3, 3);



/*QUERY*/
/*Get All Users*/

SELECT * FROM Users;


/*Get All Posts with Their Authors*/

SELECT 
    Posts.PostID, 
    Users.Username, 
    Users.FullName, 
    Posts.Content, 
    Posts.PostDate
FROM Posts
JOIN Users ON Posts.UserID = Users.UserID;


/*Get All Comments on a Specific Post*/

SELECT 
    Comments.CommentID, 
    Comments.CommentText, 
    Users.Username, 
    Comments.CommentDate
FROM Comments
JOIN Users ON Comments.UserID = Users.UserID
WHERE Comments.PostID = 1;



/*Count Likes on Each Post*/

SELECT 
    Posts.PostID, 
    Posts.Content, 
    COUNT(Likes.LikeID) AS LikeCount
FROM Posts
LEFT JOIN Likes ON Posts.PostID = Likes.PostID
GROUP BY Posts.PostID;


/*Find Posts Shared by a Specific User*/

SELECT 
    Posts.PostID, 
    Posts.Content, 
    Shares.ShareDate
FROM Shares
JOIN Posts ON Shares.PostID = Posts.PostID
WHERE Shares.UserID = 2;


/*Engagement Summary for All Users (Posts, Comments, Likes, Shares)*/

SELECT 
    Users.UserID, 
    Users.Username, 
    (SELECT COUNT(*) FROM Posts WHERE Posts.UserID = Users.UserID) AS TotalPosts,
    (SELECT COUNT(*) FROM Comments WHERE Comments.UserID = Users.UserID) AS TotalComments,
    (SELECT COUNT(*) FROM Likes WHERE Likes.UserID = Users.UserID) AS TotalLikes,
    (SELECT COUNT(*) FROM Shares WHERE Shares.UserID = Users.UserID) AS TotalShares
FROM Users;


/*Most Liked Post*/

SELECT 
    Posts.PostID, 
    Posts.Content, 
    COUNT(Likes.LikeID) AS LikeCount
FROM Posts
JOIN Likes ON Posts.PostID = Likes.PostID
GROUP BY Posts.PostID
ORDER BY LikeCount DESC
LIMIT 1;


/*Inactive Users (No Posts or Engagements)*/

SELECT Users.UserID, Users.Username
FROM Users
WHERE Users.UserID NOT IN (
    SELECT DISTINCT UserID FROM Posts
    UNION
    SELECT DISTINCT UserID FROM Comments
    UNION
    SELECT DISTINCT UserID FROM Likes
    UNION
    SELECT DISTINCT UserID FROM Shares
);


/*REPORTS*/
/*Comments and Replies by Post*/

SELECT 
    Posts.PostID, 
    Posts.Content, 
    COUNT(Comments.CommentID) AS CommentCount
FROM Posts
LEFT JOIN Comments ON Posts.PostID = Comments.PostID
GROUP BY Posts.PostID
ORDER BY CommentCount DESC;


/*Post Engagement Score (Likes + Comments + Shares)*/
SELECT 
    Posts.PostID, 
    Posts.Content, 
    (COUNT(Likes.LikeID) + COUNT(Comments.CommentID) + COUNT(Shares.ShareID)) AS EngagementScore
FROM Posts
LEFT JOIN Likes ON Posts.PostID = Likes.PostID
LEFT JOIN Comments ON Posts.PostID = Comments.PostID
LEFT JOIN Shares ON Posts.PostID = Shares.PostID
GROUP BY Posts.PostID
ORDER BY EngagementScore DESC;


/*Timeline of Posts and Engagements*/

SELECT 
    Posts.PostID, 
    Posts.Content, 
    Posts.PostDate, 
    COUNT(Likes.LikeID) AS LikeCount, 
    COUNT(Comments.CommentID) AS CommentCount, 
    COUNT(Shares.ShareID) AS ShareCount
FROM Posts
LEFT JOIN Likes ON Posts.PostID = Likes.PostID
LEFT JOIN Comments ON Posts.PostID = Comments.PostID
LEFT JOIN Shares ON Posts.PostID = Shares.PostID
GROUP BY Posts.PostID
ORDER BY Posts.PostDate DESC;


/*Activity Report for a Specific User*/

SELECT 
    Users.Username, 
    (SELECT COUNT(*) FROM Posts WHERE Posts.UserID = Users.UserID) AS TotalPosts,
    (SELECT COUNT(*) FROM Comments WHERE Comments.UserID = Users.UserID) AS TotalComments,
    (SELECT COUNT(*) FROM Likes WHERE Likes.UserID = Users.UserID) AS TotalLikes,
    (SELECT COUNT(*) FROM Shares WHERE Shares.UserID = Users.UserID) AS TotalShares
FROM Users
WHERE Users.UserID = 2;


/*Views*/
/* View to Retrieve All Users*/

CREATE VIEW View_AllUsers AS
SELECT * FROM Users;


/*View to Get All Posts with Their Authors*/

CREATE VIEW View_PostsWithAuthors AS
SELECT 
    Posts.PostID, 
    Users.Username, 
    Users.FullName, 
    Posts.Content, 
    Posts.PostDate
FROM Posts
JOIN Users ON Posts.UserID = Users.UserID;


/*View to Get All Comments on a Specific Post*/

CREATE VIEW View_CommentsByPost AS
SELECT 
    Comments.CommentID, 
    Comments.CommentText, 
    Users.Username, 
    Comments.CommentDate, 
    Comments.PostID
FROM Comments
JOIN Users ON Comments.UserID = Users.UserID;


/*View to Count Likes on Each Post*/

CREATE VIEW View_LikesCountByPost AS
SELECT 
    Posts.PostID, 
    Posts.Content, 
    COUNT(Likes.LikeID) AS LikeCount
FROM Posts
LEFT JOIN Likes ON Posts.PostID = Likes.PostID
GROUP BY Posts.PostID;


/*View to Find Posts Shared by a Specific User*/

CREATE VIEW View_SharesByUser AS
SELECT 
    Shares.UserID, 
    Posts.PostID, 
    Posts.Content, 
    Shares.ShareDate
FROM Shares
JOIN Posts ON Shares.PostID = Posts.PostID;





