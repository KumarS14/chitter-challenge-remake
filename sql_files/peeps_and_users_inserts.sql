TRUNCATE TABLE peeps, users RESTART IDENTITY CASCADE;

INSERT INTO users (email, user_name, password) VALUES ('email1@gmail.com', 'user1', crypt('password1', gen_salt('bf')));
INSERT INTO users (email, user_name, password) VALUES ('email2@gmail.com', 'user2', crypt('password2', gen_salt('bf')));
INSERT INTO users (email, user_name, password) VALUES ('email3@gmail.com', 'user3', crypt('password3', gen_salt('bf')));
INSERT INTO users (email, user_name, password) VALUES ('email4@gmail.com', 'user4', crypt('password4', gen_salt('bf')));

INSERT INTO peeps (content, time_posted, user_id) VALUES ('content1', CURRENT_TIMESTAMP, 1);
INSERT INTO peeps (content, time_posted, user_id) VALUES ('content2', CURRENT_TIMESTAMP, 2);
INSERT INTO peeps (content, time_posted, user_id) VALUES ('content3', CURRENT_TIMESTAMP, 3);
INSERT INTO peeps (content, time_posted, user_id) VALUES ('content4', CURRENT_TIMESTAMP, 3);
