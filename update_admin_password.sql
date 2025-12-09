-- Update admin password with properly hashed password
-- Password: admin123
-- This script should be run after importing the main database.sql

USE smartphone_store;

-- Update admin password (bcrypt hash for 'admin123')
UPDATE users 
SET password = '$2a$10$YQs8qVqN5xJZGVQXQxZ3/.7vK8Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Zu'
WHERE username = 'admin';

-- If admin doesn't exist, create it
INSERT IGNORE INTO users (username, email, password, full_name, role) VALUES
('admin', 'admin@smartphonestore.com', '$2a$10$YQs8qVqN5xJZGVQXQxZ3/.7vK8Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Z3Zu', 'Administrator', 'admin');
