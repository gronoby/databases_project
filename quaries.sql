--all characters from our database
select * from lord_of_the_rings UNION ALL SELECT * FROM full_stack UNION ALL select * from overlord;

--adding couple of new characters
insert into overlord values (311, 'Mare', 'Trap^2');
insert into characters_races values(311, 2);
insert into characters_classes values (311, 5);
insert into characters_weapons values (311, 4);

--number of characters which use some type of weapon
SELECT wp.descr, count(*) as characters_count from (((select * from lord_of_the_rings UNION ALL SELECT * FROM full_stack UNION ALL select * from overlord) as chr inner join characters_weapons as connector on chr.char_id = connector.char_id) as chr inner join weapons as wp on chr.weapon_id = wp.weapon_id) GROUP BY wp.descr;

--number of characters of each race (inder the constraint that we see only "popular races" which is "we have at least 3 characters of such race")
SELECT rc.descr, count(*) as characters_count from (((select * from lord_of_the_rings UNION ALL SELECT * FROM full_stack UNION ALL select * from overlord) as chr inner join characters_races as connector on chr.char_id = connector.char_id) as chr inner join races as rc on chr.race_id = rc.race_id) GROUP BY rc.descr HAVING (count(*) > 2);

--number of characters of same classes ordered by popularity
SELECT cl.descr, count(*) as characters_count from (((select * from lord_of_the_rings UNION ALL SELECT * FROM full_stack UNION ALL select * from overlord) as chr inner join characters_classes as connector on chr.char_id = connector.char_id) as chr inner join classes as cl on chr.class_id = cl.class_id) GROUP BY cl.descr order by count(*);

--func over partition + order by, you asked i wrote...
select chr.name, rc.descr, rc.life_length, row_number() over (partition by rc.life_length order by rc.descr) from (((select * from lord_of_the_rings UNION ALL SELECT * FROM full_stack UNION ALL select * from overlord) as chr inner join characters_races as connector on chr.char_id = connector.char_id) as chr inner join races as rc on chr.race_id = rc.race_id)

--choosing all supports from characters and showing that i know where function
select chr.name, chr.descr from (((select * from lord_of_the_rings UNION ALL SELECT * FROM full_stack UNION ALL select * from overlord) as chr inner join characters_classes as connector on chr.char_id = connector.char_id) as chr inner join classes as cl on chr.class_id = cl.class_id) WHERE cl.role = 'Support';

