delete from user_role;
delete from usr;

insert into usr (id, username, password, active) values
(1, 'admin', '$2a$08$MFR5gZ5wmhJjYOlj4Xi8OO3Xyuimow.sO2IwRyVvNCmE7MZ8FVQbW', true),
(2, 'user1', '$2a$08$SUO2aJXzRTWB8uSLP4hxg.QyqA0VtWKFdRl5uts.uQJCa6wRgpCfq', true);

insert into user_role(user_id, roles) values
(1, 'ADMIN'), (1, 'USER'),
(2, 'USER');