-- ================================================================
-- SQL VIEWS TEMPLATE (TOPIC 10)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) CREATE VIEW scripts for required view types:
--    - Horizontal view (select specific columns)
--    - Vertical view (filter specific rows)
--    - Mixed view (columns + row filters)
--    - Join-based view (multiple tables)
--    - Subquery-based view
--    - UNION-based view
--    - View based on another view
--    - Updatable view with WITH CHECK OPTION
--
-- 2) Comments before each view explaining:
--    - Purpose of the view
--    - How it supports your project design
--
-- 3) Optional demo SELECT statements to show view output.
--
-- RECOMMENDED ORDER:
-- 1) Simple views (horizontal / vertical / mixed)
-- 2) Join and subquery views
-- 3) UNION and layered views
-- 4) CHECK OPTION view
--
-- IMPORTANT:
-- - Script must execute in PostgreSQL without errors.
-- - Keep naming consistent and readable.
-- - Submit all views in this single SQL file.
-- ================================================================

-- Add your CREATE VIEW statements below this line

-- ====================================================================
-- Yevhen Pyrih


-- Selecting only the name of the class
CREATE OR REPLACE VIEW fitness_center.classes_vertical_view AS
SELECT class_name from fitness_center.classes;

-- Filtering the rows of equipment on quantity<10
CREATE OR REPlACE VIEW fitness_center.equipment_horizontal_view AS 
SELECT * FROM fitness_center.equipment
WHERE quantity < 10;

-- Getting contact information of active members
create or replace view fitness_center.members_mixed_view as
select email, phone_number from fitness_center.members
where status = 'Active';

-- showing which member follows which class
create or replace view fitness_center.classes_members_joined_view as
select c.class_name, m.first_name || ' ' || m.last_name as member_name
from fitness_center.classes as c 
join fitness_center.enrollments as e on c.class_id = e.class_id
join fitness_center.members as m on e.member_id = m.member_id;

-- Selecting only those trainers whose average cost of a personal training is higher than the average personal training cost
create or replace view fitness_center.trainers_subqueries_view as
select t.first_name || ' ' || t.last_name as trainer_name, round(avg(p.price), 2) as average_price
from fitness_center.trainers as t 
join fitness_center.personal_trainings as p on t.trainer_id = p.trainer_id
group by t.trainer_id
having avg(p.price) > (select avg(p1.price) from fitness_center.personal_trainings as p1);

-- selecting all the people that are conected to the fitness center
create or replace view fitness_center.members_trainers_union_view as
select first_name || ' ' || last_name as full_name from fitness_center.members
union
select first_name || ' ' || last_name as full_name from fitness_center.trainers;

-- selecting only members who are active
create or replace view fitness_center.members_another_view_general_view as
select * from fitness_center.members
where status = 'Active';

-- selecting only members who are active and registered from 2026-02-01 onwards
create or replace view fitness_center.members_another_view_specific_view as
select first_name || ' ' || last_name as full_name, phone_number
from fitness_center.members_another_view_general_view
where registration_date >= '2026-02-01';

-- selecting fitness goals that have been completed with check option to ensure rows still match view condition
create or replace view fitness_center.goals_check_option_view as
select * from fitness_center.goals
where status = 'Completed'
with check option;

/*

Selects:

select * from fitness_center.classes_vertical_view;
select * from fitness_center.equipment_horizontal_view;
select * from fitness_center.members_mixed_view;
select * from fitness_center.classes_members_joined_view;
select * from fitness_center.trainers_subqueries_view;
select * from fitness_center.members_trainers_union_view;
select * from fitness_center.members_another_view_specific_view;
select * from fitness_center.goals_check_option_view;

*/



-- ====================================================================
-- Views Vadym Iskryzhytskyi


-- horisontal view - shows VIP trainings (price more than 500.00)
CREATE OR REPLACE VIEW fitness_center.vip_trainings AS
SELECT *
FROM fitness_center.personal_trainings
WHERE price > 500.00;

-- vertical view - displays basic information about trainers 
CREATE OR REPLACE VIEW fitness_center.trainers_information AS
SELECT first_name, last_name, phone_number, bio
FROM fitness_center.trainers;

-- mixed view - shows canceled trainings with related trainer and member
CREATE OR REPLACE VIEW fitness_center.canceled_trainings AS
SELECT training_id, member_id, trainer_id
FROM fitness_center.personal_trainings
WHERE status IN ('Cancelled');

-- join view - shows trainers specializations
CREATE OR REPLACE VIEW fitness_center.trainers_specializations_view AS
SELECT t.first_name, t.last_name, s.name
FROM fitness_center.trainers t
JOIN fitness_center.trainer_specializations ts on t.trainer_id = ts.trainer_id
JOIN fitness_center.specializations s on ts.specialization_id = s.specialization_id
ORDER BY t.first_name, t.last_name;

-- view with subqueries - shows members that have done more than 2 trainings
CREATE OR REPLACE VIEW fitness_center.high_active_members AS
SELECT m.first_name, m.last_name, subq.total_trainings
FROM fitness_center.members m
JOIN(
  SELECT member_id, COUNT(*) as total_trainings
  FROM fitness_center.personal_trainings
  GROUP BY member_id
  HAVING COUNT(*) > 2
) AS subq ON m.member_id = subq.member_id;

-- view with union - categorizes trainings status
CREATE OR REPLACE VIEW fitness_center.personal_trainings_status AS
SELECT member_id, trainer_id, 'Past' AS category
FROM fitness_center.personal_trainings
WHERE status = 'Completed'

UNION
SELECT member_id, trainer_id, 'Upcoming' AS category
FROM fitness_center.personal_trainings
WHERE status = 'Booked';

-- view based on another view - shows only trainers with 'Strength Training' specialization
CREATE OR REPLACE VIEW fitness_center.strength_trainers AS
SELECT *
FROM fitness_center.trainers_specializations_view
WHERE name = 'Strength Training';

-- view with check option
CREATE VIEW fitness_center.active_trainings AS
SELECT *
FROM fitness_center.personal_trainings
WHERE status = 'Booked'
WITH CHECK OPTION;


-- ====================================================================
-- Компонент: CRM та аналітика клієнтської активності
-- Розробник: Lohvinov Maksym (Команда №8)
-- ====================================================================
-- 1. Horizontal View
-- Реєстр контактних даних клієнтів для маркетингових розсылок (ізоляція персональних даних).
CREATE OR REPLACE VIEW fitness_center.member_contact_registry AS
SELECT first_name,
    last_name,
    email
FROM fitness_center.members
ORDER BY last_name,
    first_name;
-- 2. Vertical View
-- Вибірка абонементів, термін дії яких закінчився, для автоматизації сповіщень про продовження.
CREATE OR REPLACE VIEW fitness_center.expired_memberships_view AS
SELECT membership_id,
    member_id,
    membership_type,
    end_date,
    status
FROM fitness_center.memberships
WHERE status = 'Expired';
-- 3. Mixed View
-- Список діючих контактів заблокованих користувачів для внутрішньої служби безпеки.
CREATE OR REPLACE VIEW fitness_center.banned_members_contacts AS
SELECT first_name,
    last_name,
    phone_number,
    status
FROM fitness_center.members
WHERE status = 'Banned';
-- 4. Join View
-- Агрегація профілів клієнтів та їхніх поточних фітнес-цілей для тренерського складу.
CREATE OR REPLACE VIEW fitness_center.members_goals_report AS
SELECT m.member_id,
    m.first_name,
    m.last_name,
    g.fitness_goal,
    g.status AS goal_status
FROM fitness_center.members m
    JOIN fitness_center.goals g ON m.member_id = g.member_id;
-- 5. Subqueries View
-- Виявлення цільової групи клієнтів із середньою вагою понад 85 кг для коригування програм.
CREATE OR REPLACE VIEW fitness_center.heavy_weight_members AS
SELECT m.first_name, m.last_name, m.email
FROM fitness_center.members m
WHERE m.member_id IN (
        SELECT g.member_id
        FROM fitness_center.progress p
        JOIN fitness_center.goals g ON p.goal_id = g.goal_id
        WHERE p.metric_name = 'weight_kg'
        GROUP BY g.member_id
        HAVING AVG(p.metric_value) > 85.00
    );

-- 6. UNION View
-- Консолідація логів присутності та пропусків в єдиний аналітичний потік відвідуваності.
CREATE OR REPLACE VIEW fitness_center.attendance_comprehensive_log AS
SELECT member_id,
    session_id,
    attendance_date,
    'Present' AS activity_type
FROM fitness_center.attendance
WHERE status = 'Attended'
UNION
SELECT member_id,
    session_id,
    attendance_date,
    'Absent' AS activity_type
FROM fitness_center.attendance
WHERE status = 'Absent';
-- 7. View based on another View
-- Деталізація успішно виконаних фітнес-цілей на основі звіту members_goals_report.
CREATE OR REPLACE VIEW fitness_center.completed_goals_summary AS
SELECT first_name,
    last_name,
    fitness_goal
FROM fitness_center.members_goals_report
WHERE goal_status = 'Completed';
-- 8. View with CHECK OPTION
-- Захищене представлення для менеджерів: дозволяє оновлення та вставку лише валідних абонементів.
CREATE OR REPLACE VIEW fitness_center.active_memberships_management AS
SELECT membership_id,
    member_id,
    membership_type,
    price,
    status
FROM fitness_center.memberships
WHERE status = 'Valid' WITH CHECK OPTION;

