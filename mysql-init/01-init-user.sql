CREATE USER IF NOT EXISTS 'chattingo'@'%' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON chattingo_db.* TO 'chattingo'@'%';
FLUSH PRIVILEGES;
