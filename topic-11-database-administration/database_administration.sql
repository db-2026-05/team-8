-- ================================================================
-- DATABASE ADMINISTRATION TEMPLATE (TOPIC 11)
-- ================================================================
-- WHAT SHOULD BE ADDED HERE:
-- 1) CREATE ROLE statements for at least 2 distinct roles.
--    Example roles: read-only analyst, read-write editor.
--
-- 2) GRANT statements assigning appropriate permissions to each role:
--    - Read-only role: GRANT SELECT ON ALL TABLES IN SCHEMA ...
--    - Read-write role: GRANT SELECT, INSERT, UPDATE, DELETE ...
--
-- 3) CREATE USER statements for at least 2 users.
--    Each user must be assigned to one of the defined roles.
--
-- 4) Comments before each section explaining the rationale:
--    - Why this role exists
--    - What access it should and should not have
--
-- RECOMMENDED ORDER:
-- 1) Roles + their GRANTs
-- 2) Users + GRANT ROLE TO USER
-- 3) Optional: REVOKE statements for fine-grained restrictions
-- 4) Optional cleanup block (commented out by default):
--    -- DROP USER ...; DROP ROLE ...;
--
-- IMPORTANT:
-- - Use explicit GRANT / REVOKE statements — do not rely on defaults.
-- - Roles must have meaningfully different permission levels.
-- - Script must execute in PostgreSQL without errors.
-- ================================================================

-- Add your script below this line

-- ==========================================================
-- Pyrih Yevhen

create role members_manager;
-- granting members_manager access to members-related tables
grant usage on schema fitness_center to members_manager;

grant select, insert, update, delete on fitness_center.members, fitness_center.memberships to members_manager;
grant select on fitness_center.attendance, fitness_center.enrollments to members_manager;

create role readonly;
-- granting readonly select on all tables
grant usage on schema fitness_center to readonly;
grant select on all tables in schema fitness_center to readonly;

-- creating users
create user manager with password 'm@n@ger';
create user reader with password 're@der';
create user temporary with password '1234';

grant readonly to reader;
grant members_manager to manager;
grant readonly to temporary;

revoke readonly from temporary;


-- ====================================================================
-- Users and permissions
-- Vadym Iskryzhytskyi

-- role and user 1: devops - full access to the database

CREATE ROLE devops;
CREATE USER j_doe WITH PASSWORD 'ppr!BTm@NwI189LEWWc^n%G#5^2Mn8M!';

GRANT USAGE ON SCHEMA fitness_center TO devops;
GRANT ALL ON ALL TABLES IN SCHEMA fitness_center TO devops WITH GRANT OPTION;

GRANT devops TO j_doe;

-- role and user 2: sales_analytics - only select access to certain views

CREATE ROLE sales_analytics;
CREATE USER m_jane WITH PASSWORD 'Ghn$lXR^oGT70F9&9U&1L6TTzAU6gHFt';

GRANT USAGE ON SCHEMA fitness_center TO sales_analytics;
GRANT SELECT ON fitness_center.vip_trainings, fitness_center.high_active_members TO sales_analytics;

GRANT sales_analytics TO m_jane;

-- revoke access and remove users

--REVOKE devops FROM j_doe;
--REVOKE sales_analytics FROM m_jane;
--DROP USER IF EXISTS j_doe;
--DROP USER IF EXISTS m_jane;


-- ====================================================================
-- Component: Data Control Language (DCL) - CRM & Client Analytics
-- Developer: Lohvinov M. R. (Team #8)
-- ====================================================================
-- 1. Create role for coaching and training management
-- Base access: goals, progress, and attendance tables (excludes billing)
CREATE ROLE fitness_coach_manager;
-- Define fitness_coach_manager privileges
GRANT USAGE ON SCHEMA fitness_center TO fitness_coach_manager;
GRANT SELECT,
    INSERT,
    UPDATE,
    DELETE ON fitness_center.goals,
    fitness_center.progress TO fitness_coach_manager;
GRANT SELECT,
    INSERT,
    UPDATE ON fitness_center.attendance TO fitness_coach_manager;
-- 2. Create role for CRM auditing and marketing analytics
-- Read-only access: user behavior, traffic, and attendance logs
CREATE ROLE crm_marketing_analyst;
-- Define crm_marketing_analyst privileges
GRANT USAGE ON SCHEMA fitness_center TO crm_marketing_analyst;
GRANT SELECT ON fitness_center.members,
    fitness_center.attendance TO crm_marketing_analyst;
-- 3. Create database users and map them to roles
-- Account setup: Chief Coach -> fitness_coach_manager mapping
CREATE USER chief_coach WITH PASSWORD 'Str0ng_P@ss_Coach2026';
GRANT fitness_coach_manager TO chief_coach;
-- Account setup: Marketing Lead -> crm_marketing_analyst mapping
CREATE USER marketing_lead WITH PASSWORD 'M@rketing_V1ew_Sc0re';
GRANT crm_marketing_analyst TO marketing_lead;
-- 4. Demonstrate permission revocation (Data Integrity Protection)
-- Hard restriction: block delete operations on historical attendance logs
REVOKE DELETE ON fitness_center.attendance
FROM crm_marketing_analyst;
-- ====================================================================
-- Optional Cleanup Section (Commented out by default)
-- ====================================================================
-- DROP USER IF EXISTS chief_coach;
-- DROP USER IF EXISTS marketing_lead;
-- DROP ROLE IF EXISTS fitness_coach_manager;
-- DROP ROLE IF EXISTS crm_marketing_analyst;
