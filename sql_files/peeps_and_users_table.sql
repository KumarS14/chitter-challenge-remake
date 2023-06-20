CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email text ,
  user_name text ,
  password text 
);

CREATE TABLE peeps (
  id SERIAL PRIMARY KEY,
  content text,
  time_posted TIMESTAMP,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);