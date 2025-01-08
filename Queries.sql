use ig_clone;

select * from users 
order by created_at asc
limit 5;

select * from photos;

select * from users
left join photos
on users.id = photos.user_id
where image_url is null;

select photo_id, count(user_id) as likecount
from likes
group by photo_id
order by likecount desc;

select users.id,  users.username, users.created_at, 
photos.id as photo_id, photos.image_url, 
photos.created_dat
from users
inner join photos on users.id = photos.user_id
where photos.id = (
    select photo_id
	from likes
	group by photo_id
    order by count(user_id) desc
    );
    
select * from tags;

select tags.tag_name, tags.id, count(tag_name) as tag_count
from tags
inner join photo_tags 
on tags.id = photo_tags.tag_id
group by tag_name
order by tag_count desc;

select dayname(created_at) as day_name, 
count(dayname(created_at)) as accounts_created
from users
group by day_name
order by accounts_created desc;

select * 
from users
inner join photos
on users.id = photos.user_id;

select username, count(photos.user_id) as posts_per_user
from users
inner join photos
on users.id = photos.user_id
group by username;

select avg(post_count.posts_per_user) as avg_post
from (
	select username, count(photos.user_id) as posts_per_user
	from users
	inner join photos
	on users.id = photos.user_id
	group by username
) as post_count;

select
	(select count(*) from photos) / (select count(*) from users)
    as post_per_user;

select user_id, count(*) as total_photos_liked
from likes
group by user_id;

select * 
from users
join (
	select user_id, count(*) as total_photos_liked
    from likes
    group by user_id
) likes on users.id = likes.user_id
where likes.total_photos_liked = (
	select count(*) from photos
);