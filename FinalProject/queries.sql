
-- To select all the users registered

SELECT * FROM Users;

-- To select the English translation of a certain Lithuanian word

SELECT translation FROM Words WHERE word = "Labas";

-- To Select Answer of a question by id

SELECT * FROM Answers WHERE question_id = (
    SELECT id FROM Questions WHERE question = "What is the meaning of Labas Rytas");

--  To Select a question and an Answer simultaneously by using a Join

SELECT question, answer FROM Answers JOIN Questions ON Answers.question_id = Questions.id WHERE difficulty_level = "Easy";

-- Insert a User

INSERT INTO Users (first_name, last_name, username, proficiency_level) VALUES ("Faris", "Ahmad", "faristheknight", "A1");

-- Insert a word

INSERT INTO Words (word, translation, sentence, sentence_translation, difficulty_level) VALUES ("Labas", "Hello", "Labas Rytas", "Good Morning", "Easy");

-- Insert a Question

INSERT INTO Questions (question, difficulty_level) VALUES ("What is the meaning of Labas Rytas", "Easy");

-- Insert an answer of the question

INSERT INTO Answers (question_id, answer) VALUES (1, "Good Morning");
