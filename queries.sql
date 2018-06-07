-- Finding the five oldest users
select * from users order by created_at limit 5;

-- Finding most popular registration day of week
select dayname(created_at) as day, count(*) as total
from users group by day order by total desc;

-- Finding inactive users (those who has never posted a photo)
select username from users
left join photos on users.id = photos.user_id
where photos.created_at is null
order by username;

-- Finding a person with a photo that has the most likes
select users.username, photos.id as photo_id, count(*) as likes from photos
join likes on photos.id = likes.photo_id
join users on photos.user_id = users.id
group by photos.id
order by likes desc limit 5;

-- Finding how many times an average user posts
select ((select count(*) from photos) / (select count(*) from users)) as average_user_post;

-- Finding the top five commonly used hashtags
select tags.tag_name as hashtag, count(*) as total from photo_tags
join tags on photo_tags.tag_id = tags.id
group by hashtag order by total desc limit 5;

-- Finding users who liked every single photo
select username, count(*) as likes from users
join likes on users.id = likes.user_id
group by username
having likes = (select count(*) from photos);
