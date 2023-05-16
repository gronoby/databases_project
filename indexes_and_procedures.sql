CREATE INDEX race_name ON races (descr);
CREATE INDEX universe_r ON characters_races(char_id);
CREATE INDEX universe_c ON characters_classes(char_id);
CREATE INDEX universe_w ON characters_weapons(char_id);

--update height in races table to be average of heights for one race
create or replace procedure upd_height(race_nm text)
language sql
    as
    $$
    update races
    set height = (select avg(chr.height) from (((select * from lord_of_the_rings UNION ALL SELECT * FROM full_stack UNION ALL select * from overlord) as chr inner join characters_races as connector on chr.char_id = connector.char_id) as chr inner join races as rc on chr.race_id = rc.race_id) where rc.descr = race_nm)
    where descr = race_nm;
    $$;

call upd_height('Elf');

--delete races witch do not have any present characters
create or replace procedure drop_unneeded_races()
language sql
    as
    $$
    delete from races where (descr not in (select rc.descr from (((select * from lord_of_the_rings UNION ALL SELECT * FROM full_stack UNION ALL select * from overlord) as chr inner join characters_races as connector on chr.char_id = connector.char_id) as chr inner join races as rc on chr.race_id = rc.race_id)))
    $$;

call drop_unneeded_races();
