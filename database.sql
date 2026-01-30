

DROP DATABASE IF EXISTS electronic_diary;
CREATE DATABASE electronic_diary
COLLATE utf8mb4_general_ci;

USE electronic_diary;


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role ENUM('admin','teacher','student') NOT NULL
);


CREATE TABLE classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10) NOT NULL
);

CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
);


CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);


CREATE TABLE teacher_subject_class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT NOT NULL,
    subject_id INT NOT NULL,
    class_id INT NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (class_id) REFERENCES classes(id)
);


CREATE TABLE grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    grade TINYINT CHECK (grade BETWEEN 2 AND 6),
    grade_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);


CREATE TABLE absences (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    absence_date DATE NOT NULL,
    excused BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

-
INSERT INTO classes (name) VALUES ('10A'), ('10B');


INSERT INTO subjects (name) VALUES
('Български език и литература'),
('Математика'),
('Английски език'),
('История и цивилизации'),
('География и икономика'),
('Биология и здравно образование'),
('Химия и опазване на околната среда'),
('Физика и астрономия'),
('Информационни технологии'),
('Физическо възпитание и спорт');


INSERT INTO users (username,password,first_name,last_name,role) VALUES
('bg10','pass','Росица','Тодорова','teacher'),
('math10','pass','Димитър','Петров','teacher'),
('en10','pass','Виктория','Иванова','teacher'),
('hist10','pass','Калоян','Николов','teacher'),
('geo10','pass','Марина','Стоянова','teacher'),
('bio10','pass','Пламена','Георгиева','teacher'),
('chem10','pass','Ивайло','Димов','teacher'),
('phys10','pass','Александра','Костова','teacher'),
('it10','pass','Борис','Михайлов','teacher'),
('pe10','pass','Светослав','Илиев','teacher');


INSERT INTO teachers (user_id) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);


INSERT INTO users (username,password,first_name,last_name,role) VALUES
('student10a_1','pass','Александър','Петров','student'),
('student10a_2','pass','Мария','Иванова','student'),
('student10a_3','pass','Георги','Димитров','student'),
('student10a_4','pass','Виктория','Николова','student'),
('student10a_5','pass','Кристиян','Стоянов','student'),

('student10b_1','pass','Елена','Тодорова','student'),
('student10b_2','pass','Иван','Георгиев','student'),
('student10b_3','pass','Николай','Костов','student'),
('student10b_4','pass','Даниела','Павлова','student'),
('student10b_5','pass','Мартин','Илиев','student');

INSERT INTO students (user_id,class_id) VALUES 
(12,1),
(13,1),
(14,1),
(15,1),
(16,1),

(17,2),
(18,2),
(19,2),
(20,2),
(21,2);;


INSERT INTO teacher_subject_class (teacher_id,subject_id,class_id) VALUES
(1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),
(6,6,1),(7,7,1),(8,8,1),(9,9,1),(10,10,1);


INSERT INTO teacher_subject_class (teacher_id,subject_id,class_id) VALUES
(1,1,2),(2,2,2),(3,3,2),(4,4,2),(5,5,2),
(6,6,2),(7,7,2),(8,8,2),(9,9,2),(10,10,2);


INSERT INTO grades (student_id,subject_id,teacher_id,grade,grade_date) VALUES
(1,1,1,5,'2026-02-01'),
(1,2,2,6,'2026-02-02'),
(1,3,3,4,'2026-02-03'),
(1,9,9,6,'2026-02-04');


INSERT INTO absences (student_id,subject_id,absence_date,excused) VALUES
(1,2,'2026-02-05',FALSE),
(1,4,'2026-02-06',TRUE);
