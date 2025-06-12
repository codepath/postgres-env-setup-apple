-- create_users_table.sql

CREATE TABLE IF NOT EXISTS "User" (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Insert a dummy user to check write capability
INSERT INTO "User" (name, email)
VALUES ('Alice', 'alice@example.com');
