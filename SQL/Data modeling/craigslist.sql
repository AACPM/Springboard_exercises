CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR (255),
    preferred_region INT,
    FOREIGN KEY (preferred_region) REFERENCES regions(region_id)
);

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(255)
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    tittle VARCHAR(255),
    text TEXT,
    user_id INT,
    location VARCHAR(255),
    region_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE post_categories (
    post_id INT,
    category_id INT,
    PRIMARY KEY (post_id, category_id),
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
)