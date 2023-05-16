create table lord_of_the_rings(
    char_id serial primary key,
    name text not null,
    descr text,
    height int
);

create table full_stack(
    char_id serial primary key,
    name text not null,
    descr text,
    height int
);

create table overlord(
    char_id serial primary key,
    name text not null,
    descr text,
    height int
);

create table races(
    race_id serial primary key,
    height integer not null,
    life_length integer not null,
    descr text
);

create table classes(
    class_id serial primary key,
    role text not null,
    descr text
);

create table weapons(
    weapon_id serial primary key,
    weapon_type text not null,
    descr text
);

create table characters_races(
    char_id integer primary key,
    race_id integer not null,
    foreign key (race_id) references races(race_id)
);

create table characters_classes(
    char_id integer primary key,
    class_id integer not null,
    foreign key (class_id) references classes(class_id)
);

create table characters_weapons(
    char_id integer,
    weapon_id integer not null,
    foreign key (weapon_id) references weapons(weapon_id)
);

create table classes_weapon_types(
    class_id integer not null,
    weapon_id integer not null,
    foreign key (class_id) references classes(class_id)
);

