CREATE TABLE raw_users (
user_id INT,
user_name VARCHAR(100),
country VARCHAR(50)
);


INSERT INTO raw_users
VALUES
(1, 'john_doe', 'Canada'),
(2, 'jane_smith', 'USA'),
(3, 'bob_johnson', 'UK');

CREATE TABLE raw_posts (
post_id INT,
post_text VARCHAR(500),
post_date DATE,
user_id INT
);

INSERT INTO raw_posts
VALUES
(101, 'My first post!', '2020-01-01', 1),
(102, 'Having fun learning SQL', '2020-01-02', 2),
(103, 'Big data is cool', '2020-01-03', 1),
(104, 'Just joined this platform', '2020-01-04', 3),
(105, 'Whats everyone up to today?', '2020-01-05', 2),
(106, 'Data science is the future', '2020-01-06', 1),
(107, 'Practicing my SQL skills', '2020-01-07', 2),
(108, 'Hows the weather where you are?', '2020-01-08', 3),
(109, 'TGI Friday!', '2020-01-09', 1),
(110, 'Any big plans for the weekend?', '2020-01-10', 2);


CREATE TABLE raw_likes (
like_id INT,
user_id INT,
post_id INT,
like_date DATE
);

INSERT INTO raw_likes
VALUES
(1001, 1, 101, '2020-01-01'),
(1002, 3, 101, '2020-01-02'),
(1003, 2, 102, '2020-01-03'),
(1004, 1, 103, '2020-01-04'),
(1005, 3, 104, '2020-01-05'),
(1006, 2, 104, '2020-01-06'),
(1007, 1, 105, '2020-01-07'),
(1008, 2, 106, '2020-01-08'),
(1009, 3, 107, '2020-01-09'),
(1010, 1, 108, '2020-01-10'),
(1011, 2, 109, '2020-01-11'),
(1012, 3, 110, '2020-01-12');


create table dim_user(
	user_id int,
	user_name varchar
);

insert into dim_user(user_id, user_name)
select user_id, user_name 
from raw_users;




create table dim_date(
	post_id int,
	post_date date
);


insert into dim_date(post_id, post_date)
select post_id, post_date
from raw_posts;

drop table dim_post;

drop table dim_date;

create table dim_post(
	id_user int,
	id_post int	
);


insert into dim_post(id_user, id_post)
select user_id, post_id
from raw_likes;


create table fact_post_performance(
	post_id int,
	like_id int,
	post_teks varchar
);


insert into fact_post_performance(post_id, like_id, post_teks)
select rl.post_id, rl.post_id, rp.post_text
from raw_likes rl
inner join raw_posts rp on rl.post_id = rp.post_id;

select * from raw_likes rl 
join raw_posts rp on rp.post_id = rl.post_id
;


create table fact_daily_posts(
	user_id int,
	post_id int,
	post_date date
);



insert into fact_daily_posts(user_id, post_id, post_date)
select rs.user_id, rp.post_id, rp.post_date
from raw_users rs
inner join raw_posts rp on rs.user_id = rp.user_id;