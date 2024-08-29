CREATE DATABASE camp; 

\c camp

CREATE TABLE campers (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    dob DATE NOT NULL, 
    gender VARCHAR(10), 
    cabin VARCHAR(50)
);

INSERT INTO campers VALUES 
    (1, 'Achiles', '2011-01-01', 'male', 'greenland'), 
    (2, 'Apollo', '2011-02-01', 'male', 'greenland'),
    (3, 'Aphrodite', '2011-03-01', 'female', 'appalachian'), 
    (4, 'Isis', '2011-04-01', NULL, 'appalachian');

CREATE TABLE programs (
    name VARCHAR(50) PRIMARY KEY, 
    descr VARCHAR(200) NOT NULL, 
    price DECIMAL(10,2)
);

INSERT INTO programs VALUES 
    ('homestead', 'Our youngest adventurers learn how to make new friends, 
discover self-confidence, and learn independence', 5000), 
    ('outpost', 'Campers experience rewarding trips in the backcountry with the 
guidance and support of counselors', 5500);

CREATE TABLE participates (
    camper INT, 
    program VARCHAR(50), 
    PRIMARY KEY (camper, program),
    FOREIGN KEY (camper) REFERENCES campers (id), 
    FOREIGN KEY (program) REFERENCES programs (name)
);

INSERT INTO participates VALUES 
    (1, 'homestead'), 
    (2, 'homestead'),
    (3, 'homestead'), 
    (4, 'outpost');

CREATE USER "camp" PASSWORD '135791';
GRANT ALL ON TABLE campers TO "camp";
GRANT ALL ON TABLE programs TO "camp";
GRANT ALL ON TABLE participates TO "camp";

