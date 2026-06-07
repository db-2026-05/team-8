-- ================================================================
-- SQL DML TEMPLATE (TOPIC 09)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) INSERT scripts for all required tables in your database.
-- 2) At least 10 records per table with meaningful, realistic values.
-- 3) UPDATE / DELETE scripts where they are relevant to business logic.
-- 4) If UPDATE / DELETE are not relevant for a table, add a short note
--    in documentation explaining why.
-- 5) Comments by section so the script is easy to read and run.
--
-- SCRIPT GOALS:
-- - Populate the database with usable test data.
-- - Validate constraints through realistic DML scenarios.
-- - Support the core functionality of your application.
--
-- RECOMMENDED ORDER:
-- 1) Reference data (lookups/dictionaries)
-- 2) Core entities
-- 3) Transactional data
-- 4) Optional UPDATE / DELETE checks
--
-- IMPORTANT:
-- - Use anonymized or privacy-safe sample data where possible.
-- - The script must execute in PostgreSQL.
-- - Submit this as one SQL file.
-- ================================================================

-- Add your DML below this line

-- ====================================================================
-- DML Yevhen Pyrih
--   fitness_center.equipment
--   fitness_center.classes
--   fitness_center.schedules
--   fitness_center.classes_equipment
--   fitness_center.class_sessions
--   fitness_center.enrollments
-- ====================================================================
-- ====================================================================
-- DML Maksym Lohvinov
--   fitness_center.members
--   fitness_center.memberships
--   fitness_center.goals
--   fitness_center.progress
--   fitness_center.attendance
-- ====================================================================
-- ====================================================================
-- DML Vadym Iskryzhytskyi
--   fitness_center.specializations
--   fitness_center.trainers
--   fitness_center.trainer_availability
--   fitness_center.trainer_specializations
--   fitness_center.personal_trainings
-- ====================================================================


BEGIN;

-- SECTION 1: members
-- Основна таблиця профілів клієнтів та стану їхніх акаунтів.
INSERT INTO fitness_center.members (
        member_id,
        first_name,
        last_name,
        email,
        phone_number,
        registration_date,
        status
    )
VALUES (
        1,
        'Ivan',
        'Petrov',
        'ivan.petrov@gmail.com',
        '+380671110001',
        '2026-01-10',
        'Active'
    ),
    (
        2,
        'Anna',
        'Sydorenko',
        'anna.syd@yahoo.com',
        '+380932220002',
        '2026-01-15',
        'Active'
    ),
    (
        3,
        'Maksym',
        'Koval',
        'm.koval@outlook.com',
        '+380503330003',
        '2026-02-01',
        'Active'
    ),
    (
        4,
        'Kateryna',
        'Bondarenko',
        'katya.bond@gmail.com',
        '+380634440004',
        '2026-02-10',
        'Active'
    ),
    (
        5,
        'Andriy',
        'Tkachuk',
        'a.tkachuk@ukr.net',
        '+380975550005',
        '2026-03-01',
        'Active'
    ),
    (
        6,
        'Olena',
        'Pokhvalenna',
        'lena.pokh@gmail.com',
        '+380666660006',
        '2026-03-12',
        'Active'
    ),
    (
        7,
        'Volodymyr',
        'Kravets',
        'v.kravets@gmail.com',
        '+380987770007',
        '2026-03-20',
        'Inactive'
    ),
    (
        8,
        'Maryna',
        'Oliynyk',
        'mar.ol@icloud.com',
        '+380508880008',
        '2026-04-01',
        'Active'
    ),
    (
        9,
        'Dmytro',
        'Rudenko',
        'd.rudenko@gmail.com',
        '+380639990009',
        '2026-04-15',
        'Banned'
    ),
    (
        10,
        'Svitlana',
        'Morozova',
        'sveta.m@gmail.com',
        '+380930000010',
        '2026-05-01',
        'Active'
    );



    -- SECTION 1: specializations
-- Reference table for trainer specialization types.

INSERT INTO fitness_center.specializations (specialization_id, name, description) VALUES
  (1, 'Strength Training',    'Focus on building muscular strength through resistance exercises and progressive overload techniques.'),
  (2, 'Cardio & Endurance',   'Improving cardiovascular fitness, stamina, and aerobic capacity through sustained activity.'),
  (3, 'Yoga & Flexibility',   'Enhancing flexibility, balance, and mental well-being using yoga and stretching methods.'),
  (4, 'Weight Loss',          'Tailored programmes combining nutrition guidance and exercise to reduce body fat safely.'),
  (5, 'Rehabilitation',       'Supporting recovery from injuries with low-impact corrective exercises and mobility work.'),
  (6, 'HIIT',                 'High-Intensity Interval Training sessions designed to maximise calorie burn in short timeframes.'),
  (7, 'Nutrition Coaching',   'Evidence-based dietary planning and macro tracking to complement physical training goals.'),
  (8, 'Pilates',              'Core-focused training method improving posture, stability, and muscle balance.'),
  (9, 'CrossFit',             'Functional, high-intensity workouts drawn from multiple disciplines including gymnastics and weightlifting.'),
  (10, 'Martial Arts Fitness', 'Fitness-oriented martial arts drills improving coordination, agility, and self-defence skills.'),
  (11, 'Senior Fitness',       'Safe, low-impact programmes adapted for older adults to maintain mobility and independence.'),
  (12, 'Sports Performance',   'Sport-specific conditioning to improve speed, power, and agility for competitive athletes.');


-- SECTION 2: trainers
-- Core trainer profile table.

INSERT INTO fitness_center.trainers (trainer_id, first_name, last_name, email, phone_number, bio) VALUES
  (1, 'Olena',    'Kovalenko',   'olena.kovalenko@fitcenter.ua',    '+380671234567', 'Certified personal trainer with 8 years of experience in strength and weight-loss programmes.'),
  (2, 'Dmytro',   'Savchenko',   'dmytro.savchenko@fitcenter.ua',   '+380632345678', 'Former professional swimmer turned fitness coach specialising in cardio and endurance training.'),
  (3, 'Iryna',    'Bondarenko',  'iryna.bondarenko@fitcenter.ua',   '+380503456789', 'Yoga instructor and flexibility coach with certifications in Hatha and Vinyasa yoga.'),
  (4, 'Oleksii',  'Melnyk',      'oleksii.melnyk@fitcenter.ua',     '+380504567890', 'Sports performance coach working with amateur and semi-professional athletes.'),
  (5, 'Nataliia', 'Kravchenko',  'nataliia.kravchenko@fitcenter.ua','+380675678901', 'Pilates and rehabilitation specialist; formerly a physiotherapist assistant.'),
  (6, 'Vasyl',    'Tkachenko',   'vasyl.tkachenko@fitcenter.ua',    '+380636789012', 'CrossFit Level 2 trainer and nutrition coach focused on body recomposition.'),
  (7, 'Sofiia',   'Petrenko',    'sofiia.petrenko@fitcenter.ua',    '+380507890123', 'HIIT and martial arts fitness expert; national kickboxing champion 2019.'),
  (8, 'Andrii',   'Lysenko',     'andrii.lysenko@fitcenter.ua',     '+380668901234', 'Senior fitness specialist with a background in geriatric physiotherapy.'),
  (9, 'Maryna',   'Sydorenko',   'maryna.sydorenko@fitcenter.ua',   '+380509012345', 'Nutrition coach and weight-loss consultant with 5 years in clinical dietetics.'),
  (10, 'Taras',    'Honcharenko', 'taras.honcharenko@fitcenter.ua',  '+380670123456', 'Strength and CrossFit coach; 3x regional powerlifting champion.');


-- Catalog of physical assets available for classes and general use.
INSERT INTO fitness_center.equipment (equipment_id, equipment_name, quantity) VALUES
    (1, 'Olympic Barbell 20kg', 15),
    (2, 'Bumper Plates Set (150kg)', 15),
    (3, 'Concept2 RowErg', 8),
    (4, 'Yoga Mat Premium', 30),
    (5, 'Kettlebell 16kg', 20),
    (6, 'Kettlebell 24kg', 15),
    (7, 'Plyometric Box', 10),
    (8, 'TRX Suspension Trainer', 12),
    (9, 'Foam Roller', 25),
    (10, 'Boxing Heavy Bag', 5),
    (11, 'SkiErg', 4),
    (12, 'Assault AirBike', 6);



-- SECTION 2: memberships
-- Облік придбаних абонементів, фінансових транзакцій та термінів дії карток.
INSERT INTO fitness_center.memberships (
        member_id,
        type,
        start_date,
        end_date,
        price,
        status
    )
VALUES (
        1,
        'Basic',
        '2026-01-10',
        '2026-04-10',
        1200.00,
        'Expired'
    ),
    (
        1,
        'Basic',
        '2026-04-11',
        '2026-07-11',
        1300.00,
        'Valid'
    ),
    (
        2,
        'Premium',
        '2026-01-15',
        '2026-07-15',
        2500.00,
        'Valid'
    ),
    (
        3,
        'VIP',
        '2026-02-01',
        '2026-02-05',
        5000.00,
        'Cancelled'
    ),
    (
        3,
        'VIP',
        '2026-02-05',
        '2027-02-05',
        4800.00,
        'Valid'
    ),
    (
        4,
        'Basic',
        '2026-02-10',
        '2026-05-10',
        1200.00,
        'Expired'
    ),
    (
        5,
        'Premium',
        '2026-03-01',
        '2026-09-01',
        2500.00,
        'Valid'
    ),
    (
        6,
        'VIP',
        '2026-03-12',
        '2027-03-12',
        5000.00,
        'Valid'
    ),
    (
        8,
        'Premium',
        '2026-04-01',
        '2026-10-01',
        2600.00,
        'Valid'
    ),
    (
        10,
        'Basic',
        '2026-05-01',
        '2026-08-01',
        1400.00,
        'Valid'
    );
-- SECTION 3: goals
-- Explicitly defining goal_id to prevent sequence mismatch errors.
INSERT INTO fitness_center.goals (
        goal_id,
        member_id,
        fitness_goal,
        achievement_date,
        status
    )
VALUES (
        1, 1, 'Lose 10 kg of fat tissue', '2026-06-01', 'In Progress'
    ),
    (
        2, 2, 'Achieve splits', '2026-05-15', 'Completed'
    ),
    (
        3, 3, 'Increase deadlift to 150 kg', '2026-08-01', 'In Progress'
    ),
    (
        4, 4, 'Improve stamina and run 5k', '2026-04-30', 'Completed'
    ),
    (
        5, 5, 'Recover from mild lower back ache', '2026-07-01', 'In Progress'
    ),
    (
        6, 6, 'Maintain good cardiovascular shape', NULL, 'In Progress'
    ),
    (
        7, 8, 'Gain 4 kg of muscle mass', '2026-09-01', 'In Progress'
    ),
    (
        8, 1, 'Improve sleeping cycle through evening cardio', '2026-03-01', 'Completed'
    ),
    (
        9, 3, 'Master basic boxing punch combinations', '2026-06-15', 'In Progress'
    ),
    (
        10, 10, 'Learn how to breathe properly in water', '2026-07-15', 'In Progress'
    );



    -- SECTION 3: trainer_availability
-- Weekly availability windows for each trainer.

-- Olena Kovalenko (trainer_id = 1): Mon, Wed, Fri mornings
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (1, '1', '08:00', '13:00'),
  (1, '3', '08:00', '13:00'),
  (1, '5', '09:00', '14:00');

-- Dmytro Savchenko (2): Tue, Thu, Sat mornings
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (2, '2', '07:00', '12:00'),
  (2, '4', '07:00', '12:00'),
  (2, '6', '10:00', '15:00');

-- Iryna Bondarenko (3): Mon–Fri mornings
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (3, '1', '09:00', '12:00'),
  (3, '2', '09:00', '12:00'),
  (3, '3', '09:00', '12:00'),
  (3, '4', '09:00', '12:00'),
  (3, '5', '09:00', '12:00');

-- Oleksii Melnyk (4): Tue, Thu evenings + Sat midday
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (4, '2', '17:00', '21:00'),
  (4, '4', '17:00', '21:00'),
  (4, '6', '11:00', '16:00');

-- Nataliia Kravchenko (5): Mon, Wed, Fri midday
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (5, '1', '10:00', '15:00'),
  (5, '3', '10:00', '15:00'),
  (5, '5', '10:00', '15:00');

-- Vasyl Tkachenko (6): Mon–Sat early mornings
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (6, '1', '06:00', '10:00'),
  (6, '2', '06:00', '10:00'),
  (6, '3', '06:00', '10:00'),
  (6, '4', '06:00', '10:00'),
  (6, '5', '06:00', '10:00'),
  (6, '6', '08:00', '12:00');

-- Sofiia Petrenko (7): Tue, Thu evenings + Sat afternoon
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (7, '2', '18:00', '22:00'),
  (7, '4', '18:00', '22:00'),
  (7, '6', '14:00', '18:00');

-- Andrii Lysenko (8): Mon, Wed, Fri midday
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (8, '1', '11:00', '16:00'),
  (8, '3', '11:00', '16:00'),
  (8, '5', '11:00', '16:00');

-- Maryna Sydorenko (9): Tue, Thu, Sat mornings
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (9, '2', '10:00', '14:00'),
  (9, '4', '10:00', '14:00'),
  (9, '6', '09:00', '13:00');

-- Taras Honcharenko (10): Mon–Fri evenings
INSERT INTO fitness_center.trainer_availability (trainer_id, day_of_week, start_time, end_time) VALUES
  (10, '1', '17:00', '21:00'),
  (10, '2', '17:00', '21:00'),
  (10, '3', '17:00', '21:00'),
  (10, '4', '17:00', '21:00'),
  (10, '5', '17:00', '21:00');


-- SECTION 4: trainer_specializations
-- link between trainers and specializations.

INSERT INTO fitness_center.trainer_specializations (trainer_id, specialization_id) VALUES
  -- Olena: Strength Training, Weight Loss
  (1, 1), (1, 4),
  -- Dmytro: Cardio & Endurance, Sports Performance
  (2, 2), (2, 12),
  -- Iryna: Yoga & Flexibility, Pilates
  (3, 3), (3, 8),
  -- Oleksii: Sports Performance, Strength Training, HIIT
  (4, 12), (4, 1), (4, 6),
  -- Nataliia: Rehabilitation, Pilates
  (5, 5), (5, 8),
  -- Vasyl: CrossFit, Nutrition Coaching, Strength Training
  (6, 9), (6, 7), (6, 1),
  -- Sofiia: HIIT, Martial Arts Fitness
  (7, 6), (7, 10),
  -- Andrii: Senior Fitness, Rehabilitation
  (8, 11), (8, 5),
  -- Maryna: Nutrition Coaching, Weight Loss
  (9, 7), (9, 4),
  -- Taras: Strength Training, CrossFit, Sports Performance
  (10, 1), (10, 9), (10, 12);


-- SECTION 5: personal_trainings
-- Individual training sessions: booked, completed, or cancelled.

INSERT INTO fitness_center.personal_trainings
    (member_id, trainer_id, start_time, end_time, status, price, location)
VALUES
  -- Past completed sessions
  (1,  1, '2025-03-10 09:00:00', '2025-03-10 10:00:00', 'Completed', 500.00, 'Hall A'),
  (2,  2, '2025-03-11 07:30:00', '2025-03-11 08:30:00', 'Completed', 550.00, 'Pool Area'),
  (3,  3, '2025-03-12 10:00:00', '2025-03-12 11:00:00', 'Completed', 480.00, 'Yoga Studio'),
  (4,  4, '2025-03-13 18:00:00', '2025-03-13 19:30:00', 'Completed', 700.00, 'Sports Hall'),
  (5,  5, '2025-03-14 11:00:00', '2025-03-14 12:00:00', 'Completed', 520.00, 'Rehab Room'),
  (2,  5, '2025-05-20 11:00:00', '2025-05-20 12:00:00', 'Completed', 520.00, 'Rehab Room'),
  (4,  7, '2025-05-22 19:00:00', '2025-05-22 20:00:00', 'Completed', 580.00, 'Combat Room'),

  -- Upcoming booked sessions
  (6,  6, '2026-06-10 07:00:00', '2026-06-10 08:00:00', 'Booked',    600.00, 'CrossFit Box'),
  (7,  7, '2026-06-11 19:00:00', '2026-06-11 20:00:00', 'Booked',    580.00, 'Combat Room'),
  (8,  8, '2026-06-12 12:00:00', '2026-06-12 13:00:00', 'Booked',    450.00, 'Hall B'),
  (9,  9, '2026-06-13 10:30:00', '2026-06-13 11:30:00', 'Booked',    490.00, 'Nutrition Lab'),
  (10, 10,'2026-06-14 18:00:00', '2026-06-14 19:30:00', 'Booked',    650.00, 'Powerlifting Zone'),
  (5,  6, '2026-07-01 07:00:00', '2026-07-01 08:00:00', 'Booked',    600.00, 'CrossFit Box'),

  -- Cancelled sessions (member or trainer initiated)
  (1,  3, '2025-04-01 09:00:00', '2025-04-01 10:00:00', 'Cancelled', 480.00, 'Yoga Studio'),
  (3,  1, '2025-04-05 08:00:00', '2025-04-05 09:00:00', 'Cancelled', 500.00, 'Hall A');



-- Defining the core class offerings
INSERT INTO fitness_center.classes (class_id, class_name, starting_date, ending_date, trainer_id) VALUES
    (1, 'Powerlifting Basics', '2026-01-10', '2026-12-31', 1),   -- Trainer 1: Olena (Strength)
    (2, 'Endurance Engine', '2026-01-15', '2026-06-30', 2),      -- Trainer 2: Dmytro (Cardio)
    (3, 'Vinyasa Flow Yoga', '2026-02-01', '2026-12-31', 3),     -- Trainer 3: Iryna (Yoga)
    (4, 'Athletic Conditioning', '2026-02-10', '2026-08-10', 4), -- Trainer 4: Oleksii (Sports)
    (5, 'Core Pilates & Rehab', '2026-03-01', '2026-09-01', 5),  -- Trainer 5: Nataliia (Pilates/Rehab)
    (6, 'CrossFit WOD', '2026-01-10', '2026-12-31', 6),          -- Trainer 6: Vasyl (CrossFit)
    (7, 'Kickboxing HIIT', '2026-03-12', '2026-11-30', 7),       -- Trainer 7: Sofiia (HIIT/Martial Arts)
    (8, 'Active Seniors Mobility', '2026-04-01', '2026-12-31', 8),-- Trainer 8: Andrii (Senior Fitness)
    (9, 'Weight Loss Bootcamp', '2026-05-01', '2026-10-31', 9),  -- Trainer 9: Maryna (Weight Loss)
    (10, 'Advanced Barbell Club', '2026-01-20', '2026-12-31', 10);-- Trainer 10: Taras (Strength)


-- SECTION 4: progress
-- Історія метрик та логування проміжних результатів фізичних показників.
INSERT INTO fitness_center.progress (progress_id, goal_id, recorded_at, metric_name, metric_value)
VALUES 
    (
        1, 1, '2026-02-10', 'weight_kg', 84.00
    ),
    (
        2, 1, '2026-03-10', 'weight_kg', 82.50
    ),
    (
        3, 2, '2026-02-15', 'distance_to_floor_cm', 15.00
    ),
    (
        4, 2, '2026-05-15', 'distance_to_floor_cm', 0.00
    ),
    (
        5, 3, '2026-03-20', 'deadlift_max_kg', 135.00
    ),
    (
        6, 3, '2026-05-01', 'deadlift_max_kg', 142.50
    ),
    (
        7, 4, '2026-03-05', 'run_3k_mins', 18.00
    ),
    (
        8, 4, '2026-04-30', 'run_5k_mins', 27.00
    ),
    (
        9, 5, '2026-04-25', 'pain_level_1_to_10', 3.00
    ),
    (
        10, 7, '2026-05-10', 'muscle_mass_gain_kg', 1.20
    );


-- Standard weekly scheduling for the classes defined above.
INSERT INTO fitness_center.schedules (class_id, day_of_week, start_time, duration_minutes) VALUES
    (1, '1', '09:00:00', 90), -- Powerlifting on Monday
    (1, '3', '09:00:00', 90), -- Powerlifting on Wednesday
    (2, '2', '08:00:00', 60), -- Endurance on Tuesday
    (3, '1', '10:00:00', 60), -- Yoga on Monday
    (3, '3', '10:00:00', 60), -- Yoga on Wednesday
    (4, '4', '18:00:00', 90), -- Athletic on Thursday
    (5, '5', '11:00:00', 60), -- Pilates on Friday
    (6, '1', '07:00:00', 60), -- CrossFit on Monday
    (6, '2', '07:00:00', 60), -- CrossFit on Tuesday
    (7, '2', '19:00:00', 60), -- Kickboxing on Tuesday
    (8, '3', '12:00:00', 45), -- Seniors on Wednesday
    (9, '6', '13:00:00', 90), -- Weight loss on Saturday
    (10, '5', '18:00:00', 120);-- Advanced Barbell on Friday

-- Many-to-many link defining what equipment is needed for which class.
INSERT INTO fitness_center.classes_equipment (class_id, equipment_id, required_quantity) VALUES
    (1, 1, 10), (1, 2, 10), -- Powerlifting needs barbells and plates
    (2, 3, 8),  (2, 12, 6), -- Endurance needs rowers and bikes
    (3, 4, 20),             -- Yoga needs mats
    (5, 4, 15), (5, 9, 15), -- Pilates needs mats and foam rollers
    (6, 1, 10), (6, 5, 10), (6, 7, 10), -- CrossFit needs barbells, KBs, plyo boxes
    (7, 10, 5),             -- Kickboxing needs heavy bags
    (10, 1, 5), (10, 2, 5); -- Advanced Barbell needs barbells and plates

-- Specific instantiations of classes. 
INSERT INTO fitness_center.class_sessions (session_id, class_id, session_date, start_time, end_time) VALUES
    (1, 1, '2026-01-17', '09:00:00', '10:30:00'),
    (2, 1, '2026-01-19', '09:00:00', '10:30:00'),
    (3, 3, '2026-02-18', '10:00:00', '11:00:00'),
    (4, 4, '2026-02-25', '18:00:00', '19:30:00'),
    (5, 5, '2026-03-21', '11:00:00', '12:00:00'),
    (6, 6, '2026-04-02', '07:00:00', '08:00:00'),
    (7, 6, '2026-04-03', '07:00:00', '08:00:00'),
    (8, 7, '2026-03-17', '19:00:00', '20:00:00'),
    (9, 8, '2026-04-08', '12:00:00', '12:45:00'),
    (10, 10, '2026-03-20', '18:00:00', '20:00:00');

-- Tracking which members are formally enrolled in the long-term class programs.
INSERT INTO fitness_center.enrollments (member_id, class_id, enrollment_date, status) VALUES
    (1, 3, '2026-01-11', 'Active'),
    (2, 1, '2026-01-15', 'Active'),
    (2, 5, '2026-03-10', 'Cancelled'),
    (3, 2, '2026-02-05', 'Active'),
    (4, 3, '2026-02-12', 'Active'),
    (5, 6, '2026-03-02', 'Active'),
    (6, 1, '2026-03-12', 'Active'),
    (6, 10, '2026-03-15', 'Active'),
    (8, 5, '2026-04-05', 'Completed'),
    (10, 2, '2026-05-05', 'Active');


-- SECTION 5: attendance
-- Лог відвідуваності групових занять для аналізу активності клієнтів.
INSERT INTO fitness_center.attendance (member_id, session_id, attendance_date, status)
VALUES (2, 1, '2026-01-17 09:30:00', 'Attended'),
    (2, 2, '2026-01-19 09:30:00', 'Attended'),
    (6, 1, '2026-03-14 09:35:00', 'Attended'),
    (1, 3, '2026-02-18 11:00:00', 'Attended'),
    (4, 3, '2026-02-18 11:02:00', 'Attended'),
    (3, 2, '2026-02-09 18:30:00', 'Attended'),
    (3, 2, '2026-02-11 18:28:00', 'Attended'),
    (5, 6, '2026-04-02 12:00:00', 'Attended'),
    (2, 5, '2026-03-21 11:00:00', 'Absent'),
    (6, 10, '2026-03-20 20:00:00', 'Attended');


-- SECTION 6: updates & deletions
-- Демонстраційні скрипти для тестування бізнес-операцій та каскадних обмежень.
UPDATE fitness_center.members
SET status = 'Inactive',
    updated_at = CURRENT_TIMESTAMP
WHERE member_id = 7;
UPDATE fitness_center.memberships
SET price = price * 1.10
WHERE type = 'Basic'
    AND status = 'Valid';
DELETE FROM fitness_center.goals
WHERE goal_id = 10;


-- UPDATE: A piece of equipment broke and needs to be removed from inventory.
UPDATE fitness_center.equipment
SET quantity = quantity - 1
WHERE equipment_name = 'Concept2 RowErg';

-- UPDATE: Moving a schedule block. The Tuesday Endurance class is moved to 08:30.
UPDATE fitness_center.schedules
SET start_time = '08:30:00'
WHERE class_id = 2 AND day_of_week = '2';

-- DELETE: An enrollment is deleted because it was added by administrative error
DELETE FROM fitness_center.enrollments
WHERE member_id = 2 AND class_id = 5 AND status = 'Cancelled';


-- UPDATE example: trainer updated their phone number and refreshed their bio
UPDATE fitness_center.trainers
SET
  phone_number = '+380671111111',
  bio          = 'Certified personal trainer with 9 years of experience; added online coaching in 2024.'
WHERE email = 'olena.kovalenko@fitcenter.ua';
-- UPDATE example: Dmytro shifts his Saturday slot to a later window
UPDATE fitness_center.trainer_availability
SET start_time = '11:00', end_time = '16:00'
WHERE trainer_id = 2 AND day_of_week = '6';

-- DELETE example: Iryna closes her Friday slot (going on leave)
DELETE FROM fitness_center.trainer_availability
WHERE trainer_id = 3 AND day_of_week = '5';
-- DELETE example: remove Strength Training from Vasyl
DELETE FROM fitness_center.trainer_specializations
WHERE trainer_id = 6 AND specialization_id = 1;
-- UPDATE example 1: manager reschedules a booked session (time shift)
UPDATE fitness_center.personal_trainings
SET
    start_time = '2026-06-10 08:00:00',
    end_time   = '2026-06-10 09:00:00'
WHERE member_id = 6
  AND trainer_id = 6
  AND status = 'Booked'
  AND start_time = '2026-06-10 07:00:00';

-- UPDATE example 2: member cancels their booking
UPDATE fitness_center.personal_trainings
SET status = 'Cancelled'
WHERE member_id = 8
  AND trainer_id = 8
  AND status = 'Booked';


COMMIT;






