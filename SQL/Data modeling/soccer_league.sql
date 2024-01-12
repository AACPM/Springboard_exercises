CREATE TABLE teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(255)
);

CREATE TABLE players (
    player_id INT PRIMARY KEY,
    player_name VARCHAR(255),
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE referees (
    referee_id INT PRIMARY KEY,
    referee_name VARCHAR(255)
);

CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    team1_id INT,
    team2_id INT,
    match_date DATE,
    result VARCHAR(50),
    FOREIGN KEY (team1_id) REFERENCES teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES teams(team_id)
);

CREATE TABLE goals (
    goal_id INT PRIMARY KEY,
    match_id INT,
    player_id INT,
    goal_time TIME,
    FOREIGN KEY (match_id) REFERENCES matches(match_id),
    FOREIGN KEY (player_id) REFERENCES players(player_id)
);

CREATE TABLE seasons (
    season_id INT PRIMARY KEY,
);
