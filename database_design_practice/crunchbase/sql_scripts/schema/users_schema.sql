DROP TABLE IF EXISTS user_roles, roles, users;
DROP TYPE IF EXISTS role_names;
-- DROP ROLE IF EXISTS admin, normal_user, guest;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL, -- Store hashed passwords 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TYPE role_names AS ENUM ('admin', 'normal_user', 'guest');
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name role_names UNIQUE NOT NULL,
    role_description TEXT -- optional
);

CREATE TABLE user_roles (
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    role_id INT REFERENCES roles(role_id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, role_id)
);



