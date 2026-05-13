-- ================================================================
-- SQL DDL TEMPLATE (TOPIC 04)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) Full PostgreSQL DDL for your finalized schema.
-- 2) CREATE TABLE statements for all entities from your ER diagram.
-- 3) Primary keys, foreign keys, NOT NULL, UNIQUE, CHECK constraints.
-- 4) Indexes for important search/join columns.
-- 5) Clean structure and comments (group by tables/constraints/indexes).
--
-- RECOMMENDED ORDER:
-- 1) Tables
-- 2) Constraints (if not inline)
-- 3) Indexes
--
-- TEAM NOTE:
-- Add short attribution comments for who implemented which part.
-- Example:
-- [Name] - users, roles, permissions tables
-- [Name] - orders, payments, invoices tables
--
-- IMPORTANT:
-- The script must run in PostgreSQL and produce a working schema that
-- matches your approved ER diagram and conceptual schema.
-- Submit this as one SQL file.
-- ================================================================

Video link: https://youtu.be/-AG4SRJO94c?si=bixbNU3l4K2N1wlE

-- Add your DDL below this line

create schema if not exists fitness_center;


-- Yevhen Pyrih

-- stores classes data
create table fitness_center.classes (
    class_id serial primary key,
    class_name varchar(64) not null unique,
    starting_date date not null,
    ending_date date check (ending_date > starting_date),
    trainer_id int not null
);

-- stores equipment data
create table fitness_center.equipment (
    equipment_id serial primary key,
    equipment_name varchar(64) not null unique,
    quantity int default 1 check (quantity > 0)
);

-- stores schedules
create table fitness_center.schedules (
    schedule_id serial primary key,
    class_id int not null,
    day_of_week varchar(16) not null check (day_of_week in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),
    start_time time not null,
    duration_minutes int default 90 check (duration_minutes > 0)
);

-- links classes with equipment (many to many)
create table fitness_center.classes_equipment (
    class_id int not null,
    equipment_id int not null,
    required_quantity int default 1 check (required_quantity > 0),
    primary key (class_id, equipment_id)
);

-- links members with classes (many to many)
create table fitness_center.members_classes (
    member_id int not null,
    class_id int not null,
    primary key (member_id, class_id)
);

-- Vadym Iskryzhytskyi

-- Stores trainer profile information
CREATE TABLE fitness_center.trainers (
  trainer_id serial PRIMARY KEY,
  first_name varchar(20) NOT NULL,
  last_name varchar(20) NOT NULL,
  email varchar(100) UNIQUE,
  phone_number varchar(20),
  bio text
);

-- Stores trainer weekly availability
CREATE TABLE fitness_center.trainer_availability (
  availability_id serial PRIMARY KEY,
  trainer_id int NOT NULL REFERENCES fitness_center.trainers(trainer_id) ON DELETE CASCADE,
  day_of_week varchar(10) NOT NULL,
  start_time time NOT NULL,
  end_time time NOT NULL,

  CONSTRAINT allowed_day_of_week CHECK (
    day_of_week IN (
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday'
    )
  ),

  CONSTRAINT valid_availability_time CHECK (end_time > start_time)
);

-- Stores available specialization types
CREATE TABLE fitness_center.specializations(
  specialization_id serial PRIMARY KEY,
  name varchar(40) NOT NULL UNIQUE,
  description text NOT NULL
);

-- Links trainers and specializations
CREATE TABLE fitness_center.trainer_specializations(
  trainer_id int NOT NULL REFERENCES fitness_center.trainers(trainer_id) ON DELETE CASCADE,
  specialization_id int NOT NULL REFERENCES fitness_center.specializations(specialization_id) ON DELETE CASCADE,

  PRIMARY KEY (trainer_id, specialization_id)
);

-- Stores personal training sessions
CREATE TABLE fitness_center.personal_trainings(
  training_id serial PRIMARY KEY,
  member_id int NOT NULL,
  trainer_id int NOT NULL REFERENCES fitness_center.trainers(trainer_id),
  start_time timestamp NOT NULL,
  end_time timestamp NOT NULL,
  status varchar(10) NOT NULL,

  CONSTRAINT valid_training_time CHECK (end_time > start_time),
  CONSTRAINT valid_status CHECK (status IN ('booked', 'completed', 'canceled'))
);

-- Maksym Lohvinov

-- 1. Основна таблиця клієнтів
CREATE TABLE fitness_center.members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    registration_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'Active' -- Active, Inactive, Banned
);

-- 2. Абонементи (зв'язок з оплатами)
CREATE TABLE fitness_center.memberships (
    membership_id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    membership_type VARCHAR(50) NOT NULL, -- Basic, Premium, VIP
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    status VARCHAR(20) DEFAULT 'Valid', -- Valid, Expired, Cancelled
    CONSTRAINT check_dates CHECK (end_date >= start_date)
);

-- 3. Фітнес-цілі (для CRM-складової)
CREATE TABLE fitness_center.goals (
    goal_id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    fitness_goal VARCHAR(255) NOT NULL,
    achievement_date DATE,
    status VARCHAR(50) DEFAULT 'In Progress'
);

-- 4. Лог прогресу (метрики)
CREATE TABLE fitness_center.progress (
    progress_id SERIAL PRIMARY KEY,
    goal_id INTEGER NOT NULL,
    progress_metrics TEXT NOT NULL,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Відвідування (мест до блоку розкладу)
CREATE TABLE fitness_center.attendance (
    attendance_id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    class_id INTEGER NOT NULL, -- Зв'язок з таблицею колеги
    attendance_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Attended'
);


-- Alters

-- Yevhen Pyrih

alter table fitness_center.schedules
    add foreign key (class_id) references fitness_center.classes(class_id) on delete cascade;

alter table fitness_center.classes_equipment
    add foreign key (class_id) references fitness_center.classes(class_id) on delete cascade,
    add foreign key (equipment_id) references fitness_center.equipment(equipment_id);

alter table fitness_center.members_classes
    add foreign key (class_id) references fitness_center.classes(class_id) on delete cascade,
    add foreign key (member_id) references fitness_center.members(member_id) on delete cascade;

alter table fitness_center.classes
    add foreign key (trainer_id) references fitness_center.trainers(trainer_id);

-- Vadym Iskryzhytskyi

ALTER TABLE fitness_center.personal_trainings
  ADD FOREIGN KEY (member_id)
  REFERENCES fitness_center.members(member_id);

-- Maksym Lohvinov

-- Внутрішні зв'язки блоку
ALTER TABLE fitness_center.memberships ADD CONSTRAINT fk_mem_member FOREIGN KEY (member_id) REFERENCES fitness_center.members(member_id) ON DELETE CASCADE;
ALTER TABLE fitness_center.goals ADD CONSTRAINT fk_goals_member FOREIGN KEY (member_id) REFERENCES fitness_center.members(member_id) ON DELETE CASCADE;
ALTER TABLE fitness_center.progress ADD CONSTRAINT fk_prog_goal FOREIGN KEY (goal_id) REFERENCES fitness_center.goals(goal_id) ON DELETE CASCADE;
ALTER TABLE fitness_center.attendance ADD CONSTRAINT fk_att_member FOREIGN KEY (member_id) REFERENCES fitness_center.members(member_id) ON DELETE CASCADE;

-- Зовнішній зв'язок
ALTER TABLE fitness_center.attendance ADD CONSTRAINT fk_att_class FOREIGN KEY (class_id) REFERENCES fitness_center.classes(class_id) ON DELETE CASCADE;

-- Пошук по імейлу та прізвищу
CREATE INDEX idx_members_email ON fitness_center.members(email);
CREATE INDEX idx_members_last_name ON fitness_center.members(last_name);

-- Індекси на Foreign Keys
CREATE INDEX idx_memberships_member_id ON fitness_center.memberships(member_id);
CREATE INDEX idx_attendance_member_id ON fitness_center.attendance(member_id);
CREATE INDEX idx_goals_member_id ON fitness_center.goals(member_id);

ALTER TABLE fitness_center.members ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;


