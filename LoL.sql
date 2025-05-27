CREATE DATABASE League_of_legends;
USE League_of_legends;

-- Створює таблицю гравців з полями: ID гравця, ім'я користувача, ранг та сервер
CREATE TABLE Players (
player_id INT PRIMARY KEY,
username VARCHAR(50),
player_rank VARCHAR(20),
server VARCHAR(20)
);

-- Додає дані про 10 гравців
INSERT INTO Players VALUES
(101, 'Jack', 'Platinum', 'NA'),
(102, 'Musulmango', 'Gold', 'EUW'),
(103, 'Daniels', 'Diamond', 'NA'),
(104, 'Dmitry NaMoskvu', 'Silver', 'KR'),
(105, 'NoTeemwork', 'Bronze', 'EUW'),
(106, 'KawaiiKillua', 'Gold', 'NA'),
(107, 'JungleDiff', 'Diamond', 'EUW'),
(108, 'AFK4Life', 'Bronze', 'KR'),
(109, 'Tryndamirror', 'Silver', 'NA'),
(110, 'SeraphineMain', 'Platinum', 'EUW');


-- Створює таблицю чемпіонів з полями: ID, ім'я чемпіона, роль у грі, складність гри на цьому чемпіоні
CREATE TABLE Champions (
champion_id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50),
role VARCHAR(20),
difficulty VARCHAR(10)
);


-- Додає 10 чемпіонів з описом їх ролей та складності
INSERT INTO Champions (name, role, difficulty) VALUES
('Xayah', 'Marksman', 'Medium'),
('Rakan', 'Support', 'Medium'),
('Shaco', 'Assassin', 'High'),
('Teemo', 'Marksman', 'Medium'),
('Garen', 'Tank', 'Low'),
('Ahri', 'Mage', 'Medium'),
('Lee Sin', 'Fighter', 'High'),
('Braum', 'Support', 'Low'),
('Yasuo', 'Fighter', 'High'),
('Lux', 'Mage', 'Medium');


-- Створює таблицю матчів з ID матчу, датою, тривалістю в хвилинах та переможною командою
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    date_played DATE,
    duration_minutes INT,
    winning_team VARCHAR(10)
);

-- Додає 10 записів про матчі
INSERT INTO Matches VALUES
(1001, '2025-05-10', 35, 'Blue'),
(1002, '2025-05-11', 28, 'Red'),
(1003, '2025-05-11', 40, 'Blue'),
(1004, '2025-05-12', 30, 'Red'),
(1005, '2025-05-13', 25, 'Blue'),
(1006, '2025-05-14', 33, 'Red'),
(1007, '2025-05-14', 29, 'Blue'),
(1008, '2025-05-15', 36, 'Red'),
(1009, '2025-05-15', 42, 'Blue'),
(1010, '2025-05-16', 31, 'Red');


-- Створює таблицю статистики матчу: ID статистики, ID матчу, ID гравця, ID чемпіона, кількість вбивств, смертей, асистів, команда
-- Встановлює зовнішні ключі для зв'язку з таблицями Matches, Players, Champions
CREATE TABLE MatchStats (
    stat_id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    player_id INT,
    champion_id INT,
    kills INT,
    deaths INT,
    assists INT,
    team VARCHAR(10),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (champion_id) REFERENCES Champions(champion_id)
);


-- Додає статистику для 10 матчів
	INSERT INTO MatchStats (match_id, player_id, champion_id, kills, deaths, assists, team) VALUES 
	(1001, 101, 5, 2, 23, 7, 'Red'),
	(1005, 103, 2, 1, 0,23,'Blue'),
	(1002, 102, 1, 18, 12, 6, 'Blue'),
	(1003, 104, 3, 9, 9, 8, 'Red' ),
	(1004, 103, 2, 4, 5, 16,'Blue'),
	(1006, 106, 6, 7, 2, 5, 'Red'),   
	(1007, 107, 7, 10, 4, 6, 'Blue'),   
	(1008, 108, 8, 1, 10, 2, 'Red'),   
	(1009, 109, 9, 8, 5, 7, 'Blue'),    
	(1010, 110, 10, 12, 3, 9, 'Red');   




-- Створює таблицю предметів: ID, назва, ціна, тип (напад, захист, магія)
CREATE TABLE Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    cost INT,
    type VARCHAR(20)
);

-- Додає 10 ігрових предметів
INSERT INTO Items (name, cost, type) VALUES
('Infinity Edge', 3400, 'Attack'),
('Rabadon''s Deathcap', 3600, 'Magic'),
('Thornmail', 2700, 'Defense'),
('Kraken Slayer', 3000, 'Attack'),
('Zhonya''s Hourglass', 3000, 'Magic'),
('Sunfire Aegis', 3200, 'Defense'),
('Luden''s Tempest', 3400, 'Magic'),
('Bloodthirster', 3400, 'Attack'),
('Spirit Visage', 2800, 'Defense'),
('Serpent''s Fang', 2600, 'Attack');

-- Показує які предмети купував гравець у матчі
CREATE TABLE MatchItems (
    match_id INT,
    player_id INT,
    item_id INT,
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);


-- Дані про предмети, які використовували гравці
INSERT INTO MatchItems VALUES
(1001, 101, 3),
(1005, 103, 2),
(1002, 102, 1),
(1003, 104, 4),
(1004, 103, 5),
(1006, 106, 6),
(1007, 107, 7),
(1008, 108, 8),
(1009, 109, 9),
(1010, 110, 10);


-- створює cte для обчислення статистики гравців у матчах
-- Включає ім'я гравця, ім'я чемпіона, дату матчу, команду, кількість вбивств/смертей/асистів, KDA та умовний предмет який використовував гравець
-- З'єднує таблиці MatchStats, Players, Champions, Matches і Items
-- Об'єднує сині та червоні команди, фільтрує записи з KDA > 1, сортує за спаданням KDA, обмежує результат 10 записами
WITH playerstats AS (
    SELECT 
        p.player_id,
        p.username,
        c.name AS champion_name,
        m.match_id,
        m.date_played,
        ms.kills,
        ms.deaths,
        ms.assists,
        (ms.kills + ms.assists) / COALESCE(NULLIF(ms.deaths, 0), 1) AS KDA, 
        i.name as item.name,
        ms.team
    FROM MatchStats ms
    JOIN Players p ON ms.player_id = p.player_id
    JOIN Champions c ON ms.champion_id = c.champion_id
    JOIN Matches m ON ms.match_id = m.match_id
    LEFT JOIN MatchItems mi ON mi.match_id = ms.match_id AND mi.player_id = ms.player_id
    LEFT JOIN Items i ON i.item_id = mi.item_id
    WHERE m.date_played >= '2025-05-11'
    GROUP BY 
        p.player_id, p.username, c.name, m.match_id, m.date_played,
        ms.kills, ms.deaths, ms.assists, ms.team, i.name
)
SELECT * FROM (
    SELECT * FROM playerstats WHERE team = 'Blue'
    UNION ALL
    SELECT * FROM playerstats WHERE team = 'Red'
) AS combined
HAVING KDA > 1
ORDER BY KDA DESC
LIMIT 10;

