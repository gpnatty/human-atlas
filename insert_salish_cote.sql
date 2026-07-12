-- =========================================================
-- HUMAN ATLAS — Insertion des données : Salish de la côte
-- =========================================================

-- 1. Système politique : villages autonomes dirigés par un siy̓ám̓ (personne respectée)
INSERT INTO political_systems (type, description)
VALUES ('band', 'Villages autonomes dirigés par un siy̓ám̓ (personne respectée pour sa sagesse, pas un chef héréditaire centralisé) ; société historiquement hiérarchisée (noblesse, gens du commun, esclaves)');

-- 2. Nouvelle famille linguistique : Salishan
INSERT INTO language_families (name) VALUES ('Salishan');

-- 3. La langue (générique — chaque nation a sa propre langue salish, ex. Sḵwx̱wú7mesh sníchim pour les Squamish)
INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Langues salish de la côte (ex. Sḵwx̱wú7mesh, Halkomelem, Sechelt)',
    (SELECT id FROM language_families WHERE name = 'Salishan'),
    'critically endangered',
    'Programmes de revitalisation dans plusieurs nations (ex. Squamish) ; certaines langues n''ont plus que quelques locuteurs de plus de 65 ans'
);

-- 4. Aliment central : le saumon
INSERT INTO foods (name, category, origin) VALUES ('saumon', 'fish', 'Pacifique Nord-Ouest');

-- 5. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'Indians in the Making',
        'Alexandra Harmon',
        'University of California Press',
        'https://ais.washington.edu/research/publications/coast-salish-history',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Coast Salish Essays',
        'Wayne Suttles',
        'Talonbooks / University of Washington Press',
        'https://www.amazon.com/Coast-Salish-Essays-Wayne-Suttles/dp/0889222126',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Squamish Nation — site officiel',
        NULL,
        'Squamish Nation (Sḵwx̱wú7mesh Úxwumixw)',
        'https://www.squamish.net/about-our-nation/',
        'primary',
        CURRENT_DATE,
        'high'
    );

-- 6. Le peuple lui-même
-- Note importante (comme pour les Ojibwés) : "Salish de la côte" regroupe plusieurs nations
-- distinctes (Squamish, Musqueam, Cowichan, Tsleil-Waututh, etc.), pas un peuple unique.
-- Faute d'estimation fiable pour l'ensemble, population_estimate est laissé vide plutôt
-- que d'inventer un chiffre agrégé.
INSERT INTO peoples (
    name, endonym, description, region, latitude, longitude,
    period_start, period_end, population_estimate, population_year,
    political_system_id, subsistence_notes, status
) VALUES (
    'Salish de la côte',
    'Variable selon les nations (ex. Sḵwx̱wú7mesh pour les Squamish)',
    'Ensemble de nations distinctes (Squamish, Musqueam, Cowichan, Tsleil-Waututh, et bien d''autres) partageant des langues de la famille salish et une culture maritime du Nord-Ouest Pacifique, connue pour le potlatch, le tissage et l''art du totem. Présence archéologique attestée depuis au moins 8 600 ans dans certains territoires (ex. Squamish).',
    'Côte Nord-Ouest Pacifique (sud de la Colombie-Britannique, État de Washington)',
    49.28,
    -123.12,
    -6500,
    NULL,
    NULL, -- pas de chiffre agrégé fiable pour l'ensemble des nations salish de la côte
    NULL,
    (SELECT id FROM political_systems WHERE description LIKE 'Villages autonomes dirigés par un siy̓ám̓%'),
    'Pêche au saumon, chasse marine, cueillette ; cérémonies de redistribution (potlatch)',
    'active'
);

-- 7. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Salish de la côte'),
    (SELECT id FROM languages WHERE name = 'Langues salish de la côte (ex. Sḵwx̱wú7mesh, Halkomelem, Sechelt)'),
    TRUE
);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (
        (SELECT id FROM peoples WHERE name = 'Salish de la côte'),
        (SELECT id FROM foods WHERE name = 'saumon'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Salish de la côte'),
        (SELECT id FROM foods WHERE name = 'poisson'),
        'staple'
    );

INSERT INTO peoples_sources (people_id, source_id)
SELECT
    (SELECT id FROM peoples WHERE name = 'Salish de la côte'),
    s.id
FROM sources s
WHERE s.title IN (
    'Indians in the Making',
    'Coast Salish Essays',
    'Squamish Nation — site officiel'
);
