-- Creating a new database
create database ig_clone;

-- Using the database
use ig_clone;

-- Creating Users table
create table users (
	id int auto_increment primary key,
	username varchar(100) unique not null,
	created_at timestamp default now()
);

-- Creating Photos table
create table photos(
	id int auto_increment primary key,
	image_url varchar(255) not null,
	user_id int not null,
	created_at timestamp default now(),
	foreign key(user_id) references users(id)
);

-- Creating Comments table
create table comments(
	id int auto_increment primary key,
	comment_text varchar(255) not null,
	user_id int not null,
	photo_id int not null,
	created_at timestamp default now(),
	foreign key(user_id) references users(id),
	foreign key(photo_id) references photos(id)
);

-- Creating Likes table
create table likes(
	user_id int not null,
	photo_id int not null,
	created_at timestamp default now(),
	foreign key(user_id) references users(id),
	foreign key(photo_id) references photos(id),
	primary key(user_id, photo_id)
);

-- Creating Follows table
create table follows(
	follower_id int not null,
	followee_id int not null,
	created_at timestamp default now(),
	foreign key(follower_id) references users(id),
	foreign key(followee_id) references users(id),
	primary key(follower_id, followee_id)
);

-- Creating Tags table
create table tags(
	id int auto_increment primary key,
	tag_name varchar(255) unique,
	created_at timestamp default now()
);

-- Creating Photo Tags table
create table photo_tags(
	photo_id int not null,
	tag_id int not null,
	foreign key(photo_id) references photos(id),
	foreign key(tag_id) references tags(id),
	primary key(photo_id, tag_id)
);

-- Populating the database with sample data from a file
source sample_data.sql;
