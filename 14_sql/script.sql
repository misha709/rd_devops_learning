CREATE DATABASE IF NOT EXISTS SchoolDB;
USE SchoolDB;

CREATE TABLE IF NOT EXISTS Institutions (
    institution_id int NOT NULL AUTO_INCREMENT,
    institution_name varchar(255) NOT NULL,
    institution_type enum('School', 'Kindergarten') NOT NULL,
    address varchar(512),
    PRIMARY KEY (institution_id)
);

CREATE TABLE IF NOT EXISTS Classes (
    class_id int NOT NULL AUTO_INCREMENT,
    class_name varchar(255) NOT NULL,
    institution_id int NOT NULL,
    direction enum('Mathematics', 'Biology and Chemistry', 'Language Studies'),
    PRIMARY KEY(class_id),
    FOREIGN KEY (institution_id) REFERENCES Institutions(institution_id)
);

CREATE TABLE IF NOT EXISTS Children (
    child_id int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    birth_date DATE NOT NULL,
    year_of_entry YEAR NOT NULL,
    age int NOT NULL,
    institution_id int NOT NULL,
    class_id int NOT NULL,
    PRIMARY KEY(child_id),
    FOREIGN KEY (institution_id) REFERENCES Institutions(institution_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

CREATE TABLE IF NOT EXISTS Parents (
    parent_id  int NOT NULL AUTO_INCREMENT,
    first_name varchar(128) NOT NULL,
    last_name varchar(128) NOT NULL,
    child_id int NOT NULL,
    tuition_fee DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(parent_id),
    FOREIGN KEY (child_id) REFERENCES Children(child_id)
);

-- Insert Institutions
INSERT INTO Institutions (institution_id, institution_name, institution_type, address) VALUES
(1, 'Sunshine Elementary School', 'School', '123 Main Street, Springfield'),
(2, 'Little Stars Kindergarten', 'Kindergarten', '456 Oak Avenue, Riverside'),
(3, 'Green Valley High School', 'School', '789 Pine Road, Greenfield');

-- Insert Classes
INSERT INTO Classes (class_id, class_name, institution_id, direction) VALUES
-- Institution 1 (Sunshine Elementary) - 3 classes
(1, 'Grade 5A', 1, 'Mathematics'),
(2, 'Grade 5B', 1, 'Language Studies'),
(3, 'Grade 6A', 1, 'Mathematics'),
-- Institution 2 (Little Stars Kindergarten) - 2 classes
(4, 'Rainbow Group', 2, NULL),
(5, 'Sunshine Group', 2, NULL),
-- Institution 3 (Green Valley High) - 4 classes
(6, 'Grade 10A', 3, 'Mathematics'),
(7, 'Grade 10B', 3, 'Biology and Chemistry'),
(8, 'Grade 11A', 3, 'Language Studies'),
(9, 'Grade 11B', 3, 'Biology and Chemistry');

-- Insert Children
INSERT INTO Children (first_name, last_name, birth_date, year_of_entry, age, institution_id, class_id)VALUES
-- Institution 1, Class 1 (Grade 5A)
('Sophia', 'Johnson', '2015-03-15', 2020, 10, 1, 1),
('Alexander', 'Miller', '2015-05-20', 2020, 10, 1, 1),
('Anastasia', 'Peterson', '2015-08-10', 2020, 10, 1, 1),
-- Institution 1, Class 2 (Grade 5B)
('Oliver', 'Davis', '2015-04-12', 2020, 10, 1, 2),
('Emma', 'Wilson', '2015-06-25', 2020, 10, 1, 2),
('Liam', 'Moore', '2015-09-18', 2020, 10, 1, 2),
-- Institution 1, Class 3 (Grade 6A)
('Ava', 'Anderson', '2014-02-14', 2019, 11, 1, 3),
('Noah', 'Thomas', '2014-05-30', 2019, 11, 1, 3),
('Isabella', 'Jackson', '2014-08-22', 2019, 11, 1, 3),
-- Institution 2, Class 4 (Rainbow Group)
('Maria', 'Brown', '2020-11-08', 2023, 5, 2, 4),
('Yaroslav', 'Cooper', '2020-06-12', 2023, 5, 2, 4),
('Darina', 'Sanders', '2021-02-25', 2024, 4, 2, 4),
-- Institution 2, Class 5 (Sunshine Group)
('Mia', 'White', '2020-09-15', 2023, 5, 2, 5),
('Ethan', 'Harris', '2021-01-20', 2024, 4, 2, 5),
('Charlotte', 'Martin', '2020-12-05', 2024, 5, 2, 5),
-- Institution 3, Class 6 (Grade 10A)
('Lucas', 'Garcia', '2010-03-10', 2016, 15, 3, 6),
('Amelia', 'Martinez', '2010-07-18', 2016, 15, 3, 6),
('James', 'Rodriguez', '2010-10-25', 2016, 15, 3, 6),
-- Institution 3, Class 7 (Grade 10B)
('Maxim', 'Stevens', '2010-07-22', 2016, 15, 3, 7),
('Dimitri', 'Taylor', '2010-09-15', 2016, 15, 3, 7),
('Catherine', 'Evans', '2010-11-30', 2016, 15, 3, 7),
-- Institution 3, Class 8 (Grade 11A)
('Benjamin', 'Lee', '2009-04-05', 2015, 16, 3, 8),
('Harper', 'Walker', '2009-06-12', 2015, 16, 3, 8),
('Henry', 'Hall', '2009-08-28', 2015, 16, 3, 8),
-- Institution 3, Class 9 (Grade 11B)
('Evelyn', 'Allen', '2009-02-14', 2015, 16, 3, 9),
('Sebastian', 'Young', '2009-05-22', 2015, 16, 3, 9),
('Scarlett', 'King', '2009-09-10', 2015, 16, 3, 9);

-- Insert Parents
INSERT INTO Parents (first_name, last_name, child_id, tuition_fee) VALUES
('Andrew', 'Johnson', 1, 5000.00),
('Helen', 'Miller', 2, 5200.00),
('Victor', 'Peterson', 3, 4800.00),
('Robert', 'Davis', 4, 5100.00),
('Patricia', 'Wilson', 5, 5300.00),
('Michael', 'Moore', 6, 4900.00),
('Linda', 'Anderson', 7, 5500.00),
('David', 'Thomas', 8, 5400.00),
('Barbara', 'Jackson', 9, 5600.00),
('Julia', 'Brown', 10, 3500.00),
('William', 'Cooper', 11, 3600.00),
('Marina', 'Sanders', 12, 3400.00),
('Richard', 'White', 13, 3700.00),
('Susan', 'Harris', 14, 3300.00),
('Joseph', 'Martin', 15, 3800.00),
('Matthew', 'Garcia', 16, 7500.00),
('Jennifer', 'Martinez', 17, 7400.00),
('Daniel', 'Rodriguez', 18, 7600.00),
('Igor', 'Stevens', 19, 7500.00),
('Natalie', 'Taylor', 20, 7300.00),
('Sergey', 'Evans', 21, 7600.00),
('Christopher', 'Lee', 22, 8000.00),
('Sarah', 'Walker', 23, 7900.00),
('Anthony', 'Hall', 24, 8100.00),
('Nancy', 'Allen', 25, 8200.00),
('Mark', 'Young', 26, 7800.00),
('Lisa', 'King', 27, 8300.00);