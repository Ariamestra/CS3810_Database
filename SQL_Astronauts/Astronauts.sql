CREATE DATABASE astronauts;

\c astronauts -- Postgass connect/open database

DROP TABLE Astronauts;

CREATE TABLE Astronauts(
     id SERIAL PRIMARY KEY, -- auto increment in postgrass
     name VARCHAR(50) NOT NULL,
     year INT,
     nasa_group INT,
     status VARCHAR(10) NOT NULL,
     birth_date DATE,
     birth_place VARCHAR(50),
     gender VARCHAR(10) NOT NULL,
     alma_mater VARCHAR(150) ,
     ugrad_major VARCHAR(100),
     grad_major VARCHAR(100),
     mil_rank VARCHAR(50),
     mil_branch VARCHAR(50),
     number_flights INT NOT NULL,
     flight_hours FLOAT NOT NULL,
     number_walks INT NOT NULL,
     walk_hours FLOAT NOT NULL,
     missions VARCHAR(200),
     death_date DATE,
     death_mission VARCHAR(50)
);

-- copy command
\copy Astronauts (name, year, nasa_group, status, birth_date, birth_place, gender, alma_mater, ugrad_major, grad_major, mil_rank, mil_branch, number_flights, flight_hours, number_walks, walk_hours, missions, death_date, death_mission) from '/tmp/astronauts.csv' CSV HEADER;

-- a) the total number of astronauts. 
SELECT COUNT(*) AS total FROM Astronauts;


-- b) the total number of American astronauts. ------------
SELECT COUNT(*) FROM Astronauts Where birth_place Like '%, __';

-- c) birth places of all non-american astronauts in alphabetical order. 
SELECT birth_place FROM Astronauts Where birth_place Not Like '%, __';

-- d) alphabetical list of all astronauts
SELECT name FROM Astronauts ORDER BY name;

-- e) the total number of astronauts by gender. 
SELECT gender COUNT(*) AS total From Astronauts GROUP BY gender;

-- f) the total number of female astronauts that are still active. 
SELECT COUNT(*) AS total From Astronauts WHERE gender = 'Female' AND status = 'Active';

-- g) the total number of American female astronauts that are still active. 
SELECT COUNT(*) AS total From Astronauts Where birth_place Not Like '%, __' And gender = 'Female' AND status = 'Active';

-- h) alphabetical list of all American female astronauts that are still active ordered by last name (use the same name format used in d). 
SELECT COUNT(*) AS total From Astronauts Where birth_place Not Like '%, __' And gender = 'Female' AND status = 'Active' ORDER By name;


-- i) the total number of American astronauts by state birth plae. 
Select Substring (birth_place FROM Position (',' in birth_place) + 2) As state, count (*)
From Astronauts
Where birth_place Like '%, __'
Group BY state
Order By state;

-- j) the state that had the most number of astronauts according to the dataset. 
Select Substring (birth_place FROM Position (',' in birth_place) + 2) As state, count (*) As total
From Astronauts
Where birth_place Like '%, __'
Group BY state
Order By total DESC
LIMIT 1;

-- k) the total number of astronauts by statuses (i.e., active or retired). 
SELECT status, COUNT(*) AS total From Astronauts GROUP BY status;


-- l) name and age (in years) of all still active astronauts (oldest first). 
SELECT name, DATE_PART ('year', AGE(CURRENT_DATE, birth_date)) As age From Astronauts 
Where status = 'Active' Order By age DESC;

-- m) the average age of all astronauts that are still active. 
SELECT AVG(DATE_PART ('year', AGE(CURRENT_DATE, birth_date))) As averageage From Astronauts 
Where status = 'Active';