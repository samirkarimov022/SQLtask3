CREATE DATABASE TASKSQL3
USE TASKSQL3


CREATE TABLE Users (
    ID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(255),
    Surname VARCHAR(255),
    Username VARCHAR(255) UNIQUE,
    Password VARCHAR(255),
    Gender VARCHAR(10)
);

INSERT INTO Users
VALUES
    ('USER1', 'USURNAME1', 'SS111', 'pass111', 'KISI'),
    ('USER2', 'USURNAME2', 'SS222', 'pass222', 'QADIN'),
    ('USER3', 'USURNAME3', 'SS333', 'pass333', 'KISI')

SELECT * FROM Users

CREATE TABLE Artists (
    ID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(255),
    Surname VARCHAR(255),
    Birthday DATE,
    Gender VARCHAR(10)
);

INSERT INTO Artists 
VALUES
    ('NIYAMEDDIN', 'MUSAYEV', '1958-08-08', 'KISI'),
    ('FLORA', 'KERIMOVA', '1971-01-01', 'QADIN'),
    ('MANAF', 'AGAYEV', '1962-12-12', 'KISI');

	SELECT * FROM Artists

CREATE TABLE Categories (
    Id INT IDENTITY PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

INSERT INTO Categories (Name)
VALUES
    ('DISKO'),
    ('MAHNI'),
    ('MUGAM')

	SELECT * FROM Categories

CREATE TABLE Musics (
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(255),
    Duration DATE,
    Artist_ID INT REFERENCES Artists(ID),
    Category_ID INT REFERENCES Categories(ID)
);


INSERT INTO Musics 
VALUES
    ('DUNYA SENIN DUNYA MENIM', '00:03:30', 1, 1),
    ('ELE ONNAN', '00:04:20', 2, 3),
    ('MANAF SEN ESIL KISISEN', '00:03:50', 3, 1);

	SELECT * FROM Musics

CREATE TABLE Playlists (
    ID INT IDENTITY PRIMARY KEY,
    User_ID INT REFERENCES Users(ID),
    Name VARCHAR(255)
);

INSERT INTO Playlists (User_ID, Name)
VALUES
    (1, 'QRUZ'),
    (2, 'TOY'),
    (3, 'ANALOGU BELLI DEYIL');

	SELECT * FROM Playlists

CREATE TABLE Playlist_Musics (
    Playlist_ID INT REFERENCES Playlists(ID),
    Music_ID INT REFERENCES Musics(ID),
    PRIMARY KEY (Playlist_ID, Music_ID)
);

INSERT INTO Playlist_Musics (Playlist_ID, Music_ID)
VALUES
    (1, 3),
    (2, 2),
    (3, 1),
    (3, 3);
	SELECT * FROM Playlist_Musics


CREATE VIEW Music_Details AS
SELECT m.Name AS Music_Name, m.Duration, c.Name AS Category, a.Name AS Artist_Name, a.Surname AS Artist_Surname
FROM Musics m
JOIN Artists a ON m.Artist_ID = a.ID
JOIN Categories c ON m.Category_ID = c.ID;

SELECT p.Name AS Playlist_Name, m.Name AS Music_Name
FROM Playlists p
JOIN Playlist_Musics pm ON p.ID = pm.Playlist_ID
JOIN Musics m ON pm.Music_ID = m.ID
WHERE p.User_ID = User_ID;

SELECT Name, Duration
FROM Musics
ORDER BY Duration;


SELECT a.Name, a.Surname, COUNT(*) AS Number_of_Songs
FROM Artists a
JOIN Musics m ON a.ID = m.Artist_ID
GROUP BY a.ID, a.Name, a.Surname
HAVING COUNT(*) = (
    SELECT MAX(SongCount)
    FROM (
        SELECT COUNT(*) AS SongCount
        FROM Musics
        GROUP BY Artist_ID
    ) AS MaxCounts
);