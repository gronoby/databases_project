create or replace function race_grouth()
returns trigger
    as
    $$
    begin
        update races set height = (height + 1) where (race_id = new.race_id);
        return new;
    end;
    $$
language plpgsql;


create or replace trigger update_races
    after insert on characters_races
    for each row execute function race_grouth();

insert into lord_of_the_rings values (111, 'Smeagol', 'My preacious', 110);
INSERT INTO characters_races VALUES(111, 7);
