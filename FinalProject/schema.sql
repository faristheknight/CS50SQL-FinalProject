CREATE DATABASE IF NOT EXISTS my_database;

USE my_database;

CREATE TABLE IF NOT EXISTS Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(32) NOT NULL,
    last_name VARCHAR(32) NOT NULL,
    username VARCHAR(32) NOT NULL UNIQUE,
    proficiency_level ENUM('A1', 'A2', 'B1', 'B2', 'C1')
);

CREATE TABLE IF NOT EXISTS Words (
    id INT PRIMARY KEY AUTO_INCREMENT,
    word VARCHAR(100) NOT NULL,
    translation VARCHAR(100) NOT NULL,
    sentence TEXT,
    sentence_translation TEXT,
    difficulty_level ENUM('Easy', 'Medium', 'Hard') NOT NULL
);

CREATE TABLE IF NOT EXISTS Questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question TEXT NOT NULL,
    difficulty_level ENUM('Easy', 'Medium', 'Hard') NOT NULL
);

CREATE TABLE IF NOT EXISTS Answers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    answer TEXT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Question_Answers (
    question_id INT,
    answer_id INT,
    PRIMARY KEY (question_id, answer_id),
    FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE,
    FOREIGN KEY (answer_id) REFERENCES Answers(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Word_Logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    word_id INT,
    action VARCHAR(32) NOT NULL,
    time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (word_id) REFERENCES Words(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Question_Logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    question_id INT,
    action VARCHAR(32) NOT NULL,
    time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS User_Logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    action VARCHAR(32) NOT NULL,
    time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

DELIMITER //

CREATE TRIGGER IF NOT EXISTS user_signed_up
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO User_Logs (user_id, action, time)
    VALUES (NEW.id, 'User Added', NOW());
END;
//

CREATE TRIGGER IF NOT EXISTS user_deleted
AFTER DELETE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO User_Logs (user_id, action, time)
    VALUES (OLD.id, 'User Deleted', NOW());
END;
//

CREATE TRIGGER IF NOT EXISTS word_added
AFTER INSERT ON Words
FOR EACH ROW
BEGIN
    INSERT INTO Word_Logs (word_id, action, time)
    VALUES (NEW.id, 'Word Added', NOW());
END;
//

CREATE TRIGGER IF NOT EXISTS word_deleted
AFTER DELETE ON Words
FOR EACH ROW
BEGIN
    INSERT INTO Word_Logs (word_id, action, time)
    VALUES (OLD.id, 'Word Deleted', NOW());
END;
//

CREATE TRIGGER IF NOT EXISTS question_added
AFTER INSERT ON Questions
FOR EACH ROW
BEGIN
    INSERT INTO Question_Logs (question_id, action, time)
    VALUES (NEW.id, 'Question Added', NOW());
END;
//

CREATE TRIGGER IF NOT EXISTS question_deleted
AFTER DELETE ON Questions
FOR EACH ROW
BEGIN
    INSERT INTO Question_Logs (question_id, action, time)
    VALUES (OLD.id, 'Question Deleted', NOW());
END;
//

DELIMITER ;

CREATE INDEX word_search ON Words(word);
CREATE INDEX translation_search ON Words(translation);
CREATE INDEX user_search ON Users(first_name, last_name);
CREATE INDEX user_username_search ON Users(username);


-- CREATE TABLE IF NOT EXISTS Submissions (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     user_id INT,
--     question_id INT,
--     correctness DECIMAL(3,2) NOT NULL CHECK(correctness BETWEEN 0 AND 1),
--     timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE,
--     FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE
-- );

-- CREATE TABLE IF NOT EXISTS Question_Words_Relationship (
--     question_id INT,
--     word_id INT,
--     FOREIGN KEY (question_id) REFERENCES Questions(id) ON DELETE CASCADE,
--     FOREIGN KEY (word_id) REFERENCES Words(id) ON DELETE CASCADE,
--     PRIMARY KEY (question_id, word_id)
-- );
