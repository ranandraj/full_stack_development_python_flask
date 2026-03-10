-- Create Database
CREATE DATABASE admission_portal_db;

USE admission_portal_db;


-- ===============================
-- STUDENTS TABLE
-- ===============================

CREATE TABLE students (

id INT AUTO_INCREMENT PRIMARY KEY,

full_name VARCHAR(100) NOT NULL,

email VARCHAR(100) UNIQUE NOT NULL,

password VARCHAR(255) NOT NULL,

phone VARCHAR(10) NOT NULL,

created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


-- ===============================
-- ADMIN TABLE
-- ===============================

CREATE TABLE admin (

id INT AUTO_INCREMENT PRIMARY KEY,

username VARCHAR(50) UNIQUE NOT NULL,

password VARCHAR(255) NOT NULL

);


-- Insert default admin
INSERT INTO admin(username,password)
VALUES('admin','admin123');


-- ===============================
-- COURSES TABLE
-- ===============================

CREATE TABLE courses (

id INT AUTO_INCREMENT PRIMARY KEY,

course_name VARCHAR(100) NOT NULL,

department VARCHAR(50),

duration INT

);


-- Insert Engineering Courses

INSERT INTO courses(course_name,department,duration) VALUES
('Computer Science Engineering','CSE',4),
('Mechanical Engineering','MECH',4),
('Electrical Engineering','EEE',4),
('Civil Engineering','CIVIL',4),
('Electronics and Communication','ECE',4),
('Information Technology','IT',4);


-- ===============================
-- APPLICATIONS TABLE
-- ===============================

CREATE TABLE applications (

id INT AUTO_INCREMENT PRIMARY KEY,

student_id INT,

course_id INT,

status VARCHAR(20) DEFAULT 'Pending',

applied_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

FOREIGN KEY(student_id) REFERENCES students(id),

FOREIGN KEY(course_id) REFERENCES courses(id)

);