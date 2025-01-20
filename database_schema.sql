-- Structure de la base de données pour l'application de bien-être
-- Création des tables avec leurs relations

-- Table des utilisateurs
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

-- Table pour le suivi du sommeil
CREATE TABLE sleep_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    bed_time TIMESTAMP NOT NULL,
    wake_time TIMESTAMP,
    sleep_duration INTEGER,  -- en minutes
    sleep_quality INTEGER CHECK (sleep_quality BETWEEN 1 AND 5),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table pour les types d'exercices
CREATE TABLE exercise_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- Table pour les niveaux d'intensité
CREATE TABLE intensity_levels (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    level VARCHAR(20) NOT NULL UNIQUE,
    description TEXT
);

-- Table pour le suivi des exercices
CREATE TABLE exercise_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    exercise_type_id INTEGER NOT NULL,
    intensity_level_id INTEGER NOT NULL,
    duration INTEGER NOT NULL, -- en minutes
    calories_burned DECIMAL(10,2),
    date_time TIMESTAMP NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (exercise_type_id) REFERENCES exercise_types(id),
    FOREIGN KEY (intensity_level_id) REFERENCES intensity_levels(id)
);

-- Table pour les types de repas
CREATE TABLE meal_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Table pour les aliments
CREATE TABLE foods (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    calories_per_100g DECIMAL(10,2),
    proteins_per_100g DECIMAL(10,2),
    carbs_per_100g DECIMAL(10,2),
    fats_per_100g DECIMAL(10,2)
);

-- Table pour les repas
CREATE TABLE meals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    meal_type_id INTEGER NOT NULL,
    date_time TIMESTAMP NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (meal_type_id) REFERENCES meal_types(id)
);

-- Table de liaison entre repas et aliments (pour gérer la relation many-to-many)
CREATE TABLE meal_foods (
    meal_id INTEGER NOT NULL,
    food_id INTEGER NOT NULL,
    quantity DECIMAL(10,2) NOT NULL, -- en grammes
    PRIMARY KEY (meal_id, food_id),
    FOREIGN KEY (meal_id) REFERENCES meals(id) ON DELETE CASCADE,
    FOREIGN KEY (food_id) REFERENCES foods(id)
);

-- Table pour le suivi de l'hydratation
CREATE TABLE hydration_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    quantity DECIMAL(10,2) NOT NULL, -- en millilitres
    date_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table pour les statistiques quotidiennes (pour optimiser les requêtes de rapport)
CREATE TABLE daily_statistics (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    date DATE NOT NULL,
    total_sleep_duration INTEGER, -- en minutes
    total_calories_burned DECIMAL(10,2),
    total_calories_consumed DECIMAL(10,2),
    total_water_intake DECIMAL(10,2), -- en millilitres
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(user_id, date)
);

-- Index pour optimiser les performances
CREATE INDEX idx_sleep_records_user_date ON sleep_records(user_id, bed_time);
CREATE INDEX idx_exercise_records_user_date ON exercise_records(user_id, date_time);
CREATE INDEX idx_meals_user_date ON meals(user_id, date_time);
CREATE INDEX idx_hydration_records_user_date ON hydration_records(user_id, date_time);

-- Données initiales pour les tables de référence
INSERT INTO exercise_types (name) VALUES 
('Course'), ('Marche'), ('Vélo'), ('Natation'), ('Yoga'), ('Musculation');

INSERT INTO intensity_levels (level) VALUES 
('Faible'), ('Modéré'), ('Intense');

INSERT INTO meal_types (name) VALUES 
('Petit-déjeuner'), ('Déjeuner'), ('Dîner'), ('Collation');
