-- ============================================
-- Railway Database Setup Script
-- ============================================
-- Run this script sa Railway MySQL database mo
-- 
-- Connect using:
-- mysql -h hayabusa.proxy.rlwy.net -u root -pJAzgscTMSDFzQyetSZuiBDSVBscMVLOy -P 18615
--
-- Then run:
-- source setup-railway-database.sql
-- ============================================

-- Check existing databases
SHOW DATABASES;

-- Create database kung wala pa
CREATE DATABASE IF NOT EXISTS railway 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Use the database
USE railway;

-- Show current tables (dapat empty pa if first time)
SHOW TABLES;

-- ============================================
-- IMPORTANT NOTE:
-- ============================================
-- HUWAG mo na i-run ang schema.sql at demo-data.sql manually!
-- 
-- Automatic na gagawin yan ng Spring Boot application mo
-- via DatabaseSchemaInitializer at DemoDataInitializer
-- 
-- After deployment sa Railway, babalik ka dito and check:
-- ============================================

-- Check if tables were created
SHOW TABLES;

-- Check sample data
SELECT COUNT(*) as total_books FROM books;
SELECT COUNT(*) as total_students FROM students;
SELECT COUNT(*) as total_users FROM users;

-- View sample records
SELECT * FROM books LIMIT 5;
SELECT * FROM students LIMIT 5;
SELECT username, role FROM users;

-- ============================================
-- Para i-reset ang database (if needed):
-- ============================================
-- DROP DATABASE railway;
-- CREATE DATABASE railway CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
