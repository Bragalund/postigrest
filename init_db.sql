
create schema api;

create table api.todos (
  id serial primary key,
  done boolean not null default false,
  task text not null,
  due timestamptz
);

insert into api.todos (task) values
  ('finish tutorial 0'), ('pat self on back');

create role web_anon nologin;

grant usage on schema api to web_anon;
grant select on api.todos to web_anon;

create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator;

create role todo_user nologin;
grant todo_user to authenticator;

grant usage on schema api to todo_user;
grant all on api.todos to todo_user;
grant usage, select on sequence api.todos_id_seq to todo_user;

---------------------------------------

create schema blog;

-- Create a table called "users" with columns "id", "username", "email", and "password"
CREATE TABLE blog.users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

-- Create a table called "posts" with columns "id", "title", "body", "user_id", and "created_at"
CREATE TABLE blog.posts (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER REFERENCES blog.users(id),
  created_at TIMESTAMP DEFAULT NOW()
);

-- Create a table called "comments" with columns "id", "body", "post_id", "user_id", and "created_at"
CREATE TABLE blog.comments (
  id SERIAL PRIMARY KEY,
  body TEXT NOT NULL,
  post_id INTEGER REFERENCES blog.posts(id),
  user_id INTEGER REFERENCES blog.users(id),
  created_at TIMESTAMP DEFAULT NOW()
);

create role read_blog nologin;
grant usage on schema blog to read_blog;  
grant select on blog.posts, blog.comments to read_blog;

-- Insert data into the "users" table
INSERT INTO blog.users (username, email, password) VALUES
('1337coder', 'coder1@gmail.com', 'c0d3rhot'),
('backdev', 'firstname_lastname@example.com', '@ssword2'),
('i_found_some_code_in_ur_bugs', 'bugzy@myemail.com', 'BUGS_IS-MY_speciality<');

-- Insert data into the "posts" table
INSERT INTO blog.posts (title, body, user_id) VALUES
('Python Tips and Tricks', 'Python is a great language for beginners and experienced programmers alike. Here are some tips and tricks to help you get the most out of it: 1. Use list comprehensions for concise and readable code. 2. Use the "with" statement for clean and simple file handling. 3. Use the "enumerate" function when looping through lists to keep track of your index.', 1),
('JavaScript for Web Development', 'JavaScript is the language of the web. Whether you are a beginner or an experienced programmer, here are some tips to help you become a better JavaScript developer: 1. Learn the basics of DOM (Document Object Model) manipulation. 2. Use functional programming concepts like map, filter, and reduce to write clean and efficient code. 3. Make use of modern frameworks like React and Vue.js to build dynamic and interactive web applications.', 2),
('Data Structures and Algorithms in C++', 'Data structures and algorithms are the building blocks of computer science. Here are some tips for learning data structures and algorithms in C++: 1. Start with the basics, like arrays and linked lists. 2. Learn how to implement popular algorithms like sorting and searching. 3. Practice solving coding problems on sites like LeetCode to improve your skills. 4. Take advantage of libraries like the Standard Template Library (STL) to save time and write more efficient code.', 3);

-- Insert data into the "comments" table
INSERT INTO blog.comments (body, post_id, user_id) VALUES
('Wow, these tips are really helpful! Thanks for sharing! 🤓', 1, 1),
('I love JavaScript, it makes web development so much fun! 😎', 2, 2),
('C++ is such a powerful language. Can''t wait to dive into data structures and algorithms! 😃', 3, 3);
