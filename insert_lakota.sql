-- =========================================================
-- HUMAN ATLAS — Insertion des données : Lakota
-- =========================================================

-- 1. Système politique : alliance des Sept Feux du Conseil (Oceti Sakowin)
INSERT INTO political_systems (type, description)
VALUES ('confederacy', 'Oceti Sakowin (Sept Feux du Conseil) : alliance des Dakota, Nakota et Lakota ; les Lakota (Titunwan) forment 7 bandes distinctes');

-- 2. Nouvelle famille linguistique : Siouan
INSERT INTO language_families (name) VALUES ('Siouan');

-- 3. La langue lakota
INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Lakȟótiyapi (lakota)',
    (SELECT id FROM language_families WHERE name = 'Siouan'),
    'endangered',
    'Programmes d''immersion sur plusieurs réserves (ex. Pine Ridge) ; enseignement universitaire du lakota (ex. Oglala Lakota College)'
);

-- 4. Aliment : le bison, central dans la culture lakota depuis l'adoption du cheval
INSERT INTO foods (name, category, origin) VALUES ('bison', 'game', 'Grandes Plaines d''Amérique du Nord');

-- 5. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'Lakota America: A New History of Indigenous Power',
        'Pekka Hämäläinen',
        'Yale University Press',
        'https://yalebooks.yale.edu/book/9780300255256/lakota-america/',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Lakhóta',
        'Rani-Henrik Andersson et David C. Posthumus',
        'University of Oklahoma Press',
        'https://www.oupress.com/9780806190754/lakhota/',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Oglala Sioux Tribe — site officiel',
        NULL,
        'Oglala Sioux Tribe',
        'https://oglalalakotanation.org',
        'primary',
        CURRENT_DATE,
        'high'
    );

-- 6. Le peuple lui-même
INSERT INTO peoples (
    name, endonym, description, region, latitude, longitude,
    period_start, period_end, population_estimate, population_year,
    political_system_id, subsistence_notes, status
) VALUES (
    'Lakota',
    'Lakȟóta (Titunwan)',
    'Le plus grand des trois groupes formant l''Oceti Sakowin (avec les Dakota et Nakota), aussi appelé Sioux. Repoussés par les Ojibwés hors de la région du lac Supérieur avant le XVIIIe siècle, ils se sont réinventés en peuple nomade des Grandes Plaines après l''adoption du cheval. La population totale de l''Oceti Sakowin (Dakota, Nakota, Lakota réunis) est estimée à environ 160 000 personnes aujourd''hui.',
    'Grandes Plaines du Nord (Dakota du Sud, Dakota du Nord, Nebraska, Montana)',
    43.15,
    -102.55,
    1750,
    NULL,
    160000,
    2023,
    (SELECT id FROM political_systems WHERE description LIKE 'Oceti Sakowin%'),
    'Chasse au bison à cheval (depuis le XVIIIe siècle) ; agriculture pratiquée avant la migration vers les Plaines',
    'active'
);

-- 7. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Lakota'),
    (SELECT id FROM languages WHERE name = 'Lakȟótiyapi (lakota)'),
    TRUE
);

INSERT INTO peoples_foods (people_id, food_id, role)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Lakota'),
    (SELECT id FROM foods WHERE name = 'bison'),
    'staple'
);

INSERT INTO peoples_sources (people_id, source_id)
SELECT
    (SELECT id FROM peoples WHERE name = 'Lakota'),
    s.id
FROM sources s
WHERE s.title IN (
    'Lakota America: A New History of Indigenous Power',
    'Lakhóta',
    'Oglala Sioux Tribe — site officiel'
);

-- 8. Bonus : relation historique avec les Ojibwés, déjà présents dans ta base
INSERT INTO peoples_relations (people_a_id, people_b_id, relation_type, period_start, period_end, notes)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Ojibwé'),
    (SELECT id FROM peoples WHERE name = 'Lakota'),
    'conflict',
    1600,
    1750,
    'Les Ojibwés repoussent les ancêtres des Lakota (Dakota) hors de la région du lac Supérieur vers les Grandes Plaines'
);
