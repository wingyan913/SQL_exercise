create database exercise4;
use exercise4;

create table players (
    player_id integer not null unique, 
    group_id integer not null
);

create table matches (
    match_id integer not null unique, 
    first_player integer not null, 
    second_player integer not null, 
    first_score integer not null, 
    second_score integer not null
);

delete from players;
delete from matches;
insert into players values (20, 2);
insert into players values (30, 1);
insert into players values (40, 3);
insert into players values (45, 1);
insert into players values (50, 2);
insert into players values (65, 1);
insert into matches values (1, 30, 45, 10, 12);
insert into matches values (2, 20, 50, 5, 5);
insert into matches values (13, 65, 45, 10, 10);
insert into matches values (5, 30, 65, 3, 15);
insert into matches values (42, 45, 65, 8, 4);

with firstTable as (
	select first_player as player, first_score as score
	from matches
    ),
secondTable as (
	select second_player as player, second_score as score
    from matches
    ),
joinTables as (
	select * from firstTable
    union all
    select * from secondTable
    ),
sumScore as (
	select player, sum(score) as totalScore
	from joinTables
	group by player
    ),
joinTables2 as (
	select p.group_id, p.player_id, s.totalScore
	from players p left join sumScore s
	on s.player = p.player_id
	order by p.group_id, s.totalScore desc, p.player_id
    ),
joinTables3 as (
    select *, row_number() over (
	partition by group_id order by totalScore desc
    ) as roll
    from joinTables2
    )
select group_id, player_id
from joinTables3
where roll = 1;

select * from players;
select * from matches;