describe cluster;

create keyspace my_ks with replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

--Хотим доставать посты заданного пользователя упорядоченные по времени создания поста - сначала новые.
--Хотим доставать последний пост заданного пользователя.
--Хотим доставать посты заданного пользователя, опубликованные после заданной даты.
--Хотим доставать пользователей, которые сделали пост в заданный день по заданной теме, упорядоченные по времени - сначала новые.

use my_ks;

--Создание таблицы
create table user_posts
(
    user_id         int,
    username        text,
    post_id         int,
    topic_id        int,
    created_at      timestamp,
    created_date    date,
    content         text,
    PRIMARY KEY (user_id, created_at)
) with clustering order by (created_at desc)

--Заполнение таблицы тестовыми данными
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (1, 'User_1', 1, 1, '2023-10-01 16:00+0000', '2023-10-01', 'Content_1');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (2, 'User_2', 2, 2, '2023-10-02 15:00+0000', '2023-10-02', 'Content_2');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (3, 'User_3', 3, 1, '2023-10-02 14:00+0000', '2023-10-02', 'Content_3');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (1, 'User_1', 4, 2, '2023-10-03 13:00+0000', '2023-10-03', 'Content_4');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (2, 'User_2', 5, 1, '2023-10-04 12:00+0000', '2023-10-04', 'Content_5');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (3, 'User_3', 6, 2, '2023-10-05 11:00+0000', '2023-10-05', 'Content_6');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (4, 'User_4', 7, 1, '2023-10-06 10:00+0000', '2023-10-06', 'Content_7');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (1, 'User_1', 8, 2, '2023-10-07 09:00+0000', '2023-10-07', 'Content_8');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (2, 'User_2', 9, 1, '2023-10-08 08:00+0000', '2023-10-08', 'Content_9');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (3, 'User_3', 10, 2, '2023-10-09 07:00+0000', '2023-10-09', 'Content_10');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (4, 'User_4', 11, 1, '2023-10-10 06:00+0000', '2023-10-10', 'Content_11');
insert into user_posts(user_id, username, post_id, topic_id, created_at, created_date, content)
values (2, 'User_2', 2, 2, '2023-10-02 16:00+0000', '2023-10-02', 'Content_11');

--Запрос 1
select post_id, content, created_at
from user_posts
where user_id = 1;

--Запрос 2
select post_id, content, created_at, username
from user_posts
where user_id = 1
limit 1;

--Запрос 3
select post_id, content, created_at
from user_posts
where user_id = 3 and created_at > '2023-10-03 07:00+0000';

--Запрос 4
select user_id, username, post_id, created_at
from user_posts
where topic_id = 2 and created_date = '2023-10-02';
