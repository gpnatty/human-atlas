-- =========================================================
-- HUMAN ATLAS — Insertion des données : Ojibwés
-- =========================================================

-- 1. Système politique : organisation en bandes et clans (pas de confédération centralisée)
INSERT INTO political_systems (type, description)
VALUES ('band', 'Organisation traditionnelle en bandes autonomes, structurées en clans (doodem) ; pas d''autorité centrale unique')
RETURNING id;
-- Note l'id retourné (probablement 3).

-- 2. Nouvelle famille linguistique : Algonquian (différente de l'Iroquoian des 2 peuples précédents)
INSERT INTO language_families (name) VALUES ('Algonquian')
RETURNING id;
-- Note l'id retourné (probablement 2).

INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Anishinaabemowin (ojibwé)',
    2, -- id de la famille Algonquian créée juste au-dessus ; ajuste si différent
    'endangered',
    'Programmes d''immersion (ex. Waadookodaading Ojibwe Language Immersion School) ; la majorité des locuteurs courants ont aujourd''hui plus de 70 ans'
)
RETURNING id;
-- Note l'id retourné (probablement 3).

-- 3. Aliments propres aux Ojibwés (le poisson existe déjà, id 4)
INSERT INTO foods (name, category, origin) VALUES
    ('riz sauvage (manoomin)', 'gathered', 'Région des Grands Lacs'),
    ('sirop d''érable', 'gathered', 'Amérique du Nord')
RETURNING id;
-- Note les 2 ids retournés (probablement 5, 6).

-- 4. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'Ojibwe in Minnesota',
        'Anton Treuer',
        'Minnesota Historical Society Press',
        'https://shop.mnhs.org/products/ojibwe-minnesota',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'History of the Ojibway People',
        'William W. Warren (édité par Theresa Schenck)',
        'Minnesota Historical Society Press',
        NULL,
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Anishinabek Nation — site officiel',
        NULL,
        'Anishinabek Nation (Union of Ontario Indians)',
        'https://anishinabek.ca/who-we-are-and-what-we-do/',
        'primary',
        CURRENT_DATE,
        'high'
    )
RETURNING id;
-- Note les 3 ids retournés (probablement 7, 8, 9).

-- 5. Le peuple lui-même
INSERT INTO peoples (
    name, endonym, description, region, latitude, longitude,
    period_start, period_end, population_estimate, population_year,
    political_system_id, subsistence_notes, status
) VALUES (
    'Ojibwé',
    'Ojibwe / Anishinaabeg',
    'Le plus grand peuple du groupe plus large des Anishinaabe (qui inclut aussi les Odawa, Potawatomi, Mississaugas, Nipissing et Algonquins). Traditionnellement établis autour des Grands Lacs, en particulier du lac Supérieur.',
    'Grands Lacs (Ontario, Manitoba, Michigan, Wisconsin, Minnesota, Dakota du Nord)',
    47.70,
    -84.50,
    NULL, -- présence ancienne dans la région, pas de date de fondation politique précise
    NULL,
    330000,
    2014,
    3, -- id du système politique (étape 1)
    'Chasse, pêche, cueillette du riz sauvage (manoomin), récolte du sirop d''érable',
    'active'
)
RETURNING id;
-- Note l'id retourné (probablement 3).

-- 6. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary) VALUES (3, 3, TRUE);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (3, 4, 'staple'),  -- poisson
    (3, 5, 'staple'),  -- riz sauvage
    (3, 6, 'occasional'); -- sirop d'érable

INSERT INTO peoples_sources (people_id, source_id) VALUES
    (3, 7),
    (3, 8),
    (3, 9);
