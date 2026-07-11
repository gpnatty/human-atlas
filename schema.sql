-- =========================================================
-- HUMAN ATLAS — Schéma de base de données (Sprint 1)
-- Périmètre MVP : Premières Nations d'Amérique du Nord
-- =========================================================

-- ---------------------------------------------------------
-- Table de référence : les sources (essentiel pour l'OSINT)
-- ---------------------------------------------------------
CREATE TABLE sources (
    id          SERIAL PRIMARY KEY,
    title       TEXT NOT NULL,
    author      TEXT,
    publisher   TEXT,
    url         TEXT,
    source_type TEXT,          -- 'academic', 'government', 'wikidata', 'museum', 'book', etc.
    accessed_on DATE,
    reliability TEXT           -- 'high', 'medium', 'low' — jugement OSINT sur la fiabilité
);

-- ---------------------------------------------------------
-- Familles linguistiques et langues
-- ---------------------------------------------------------
CREATE TABLE language_families (
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE   -- ex: 'Algonquian', 'Iroquoian', 'Siouan'
);

CREATE TABLE languages (
    id                 SERIAL PRIMARY KEY,
    name               TEXT NOT NULL,
    family_id          INTEGER REFERENCES language_families(id),
    speakers_estimate  INTEGER,
    endangerment_level TEXT,    -- 'safe', 'vulnerable', 'endangered', 'critically endangered', 'extinct'
    revitalization     TEXT     -- notes sur les programmes de revitalisation
);

-- ---------------------------------------------------------
-- Aliments / subsistance
-- ---------------------------------------------------------
CREATE TABLE foods (
    id       SERIAL PRIMARY KEY,
    name     TEXT NOT NULL,     -- ex: 'maïs', 'saumon', 'bison'
    category TEXT,              -- 'crop', 'game', 'fish', 'gathered'
    origin   TEXT
);

-- ---------------------------------------------------------
-- Systèmes politiques
-- ---------------------------------------------------------
CREATE TABLE political_systems (
    id          SERIAL PRIMARY KEY,
    type        TEXT NOT NULL,  -- 'confederacy', 'chiefdom', 'band', 'tribal council'
    description TEXT
);

-- ---------------------------------------------------------
-- Table centrale : les peuples
-- ---------------------------------------------------------
CREATE TABLE peoples (
    id                    SERIAL PRIMARY KEY,
    name                  TEXT NOT NULL,        -- nom communément utilisé
    endonym               TEXT,                 -- nom que le peuple se donne lui-même
    description           TEXT,
    region                TEXT,                 -- ex: 'Grands Lacs', 'Plaines', 'Côte Nord-Ouest'
    latitude              NUMERIC(9,6),
    longitude             NUMERIC(9,6),
    period_start          INTEGER,              -- année (peut être négative pour avant J.-C.)
    period_end            INTEGER,
    population_estimate   INTEGER,
    population_year       INTEGER,              -- année de l'estimation
    political_system_id   INTEGER REFERENCES political_systems(id),
    subsistence_notes      TEXT,                -- chasse/pêche/agriculture en texte libre pour le MVP
    status                TEXT                  -- 'active', 'assimilated', 'extinct', 'unknown'
);

-- ---------------------------------------------------------
-- Tables de liaison (many-to-many)
-- ---------------------------------------------------------
CREATE TABLE peoples_languages (
    people_id   INTEGER REFERENCES peoples(id),
    language_id INTEGER REFERENCES languages(id),
    is_primary  BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (people_id, language_id)
);

CREATE TABLE peoples_foods (
    people_id INTEGER REFERENCES peoples(id),
    food_id   INTEGER REFERENCES foods(id),
    role      TEXT,             -- 'staple', 'occasional', 'traded'
    PRIMARY KEY (people_id, food_id)
);

CREATE TABLE peoples_sources (
    people_id INTEGER REFERENCES peoples(id),
    source_id INTEGER REFERENCES sources(id),
    PRIMARY KEY (people_id, source_id)
);

-- Relations entre peuples : alliances, conflits, échanges commerciaux
CREATE TABLE peoples_relations (
    id            SERIAL PRIMARY KEY,
    people_a_id   INTEGER REFERENCES peoples(id),
    people_b_id   INTEGER REFERENCES peoples(id),
    relation_type TEXT NOT NULL,   -- 'alliance', 'conflict', 'trade'
    period_start  INTEGER,
    period_end    INTEGER,
    notes         TEXT
);

-- ---------------------------------------------------------
-- Index utiles pour les recherches géographiques et temporelles
-- ---------------------------------------------------------
CREATE INDEX idx_peoples_region ON peoples(region);
CREATE INDEX idx_peoples_period ON peoples(period_start, period_end);
CREATE INDEX idx_peoples_status ON peoples(status);
