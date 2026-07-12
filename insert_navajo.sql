-- =========================================================
-- HUMAN ATLAS — Insertion des données : Navajo (Diné)
-- =========================================================

-- 1. Système politique : clans matrilinéaires historiques
INSERT INTO political_systems (type, description)
VALUES ('clan system', 'Système matrilinéaire de clans (k''é) sans autorité politique centralisée avant la création du Conseil tribal navajo au XXe siècle');

-- 2. Nouvelle famille linguistique : Athabaskan (Na-Dené)
INSERT INTO language_families (name) VALUES ('Athabaskan (Na-Dené)');

-- 3. La langue navajo
INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Diné bizaad (navajo)',
    (SELECT id FROM language_families WHERE name = 'Athabaskan (Na-Dené)'),
    'vulnerable',
    'Langue autochtone comptant le plus de locuteurs aux États-Unis ; enseignée dans les écoles de la Navajo Nation et à l''université Diné College'
);

-- 4. Aliment : le mouton, introduit par les colons espagnols et central dans l'économie navajo
INSERT INTO foods (name, category, origin) VALUES ('mouton', 'livestock', 'Introduit par les colons espagnols au XVIIe siècle');

-- 5. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'Diné: A History of the Navajos',
        'Peter Iverson',
        'University of New Mexico Press',
        'https://unmpress.com/books/dine/9780826327154',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Reclaiming Diné History',
        'Jennifer Nez Denetdale',
        'University of Arizona Press',
        'https://uapress.arizona.edu/book/reclaiming-dine-history',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Navajo Nation — site officiel',
        NULL,
        'Navajo Nation',
        'https://www.navajo-nsn.gov',
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
    'Navajo',
    'Diné',
    'La plus grande nation amérindienne des États-Unis par la population et l''étendue du territoire. Parle une langue athabaskane (Na-Dené), liée aux langues apaches, distincte des familles linguistiques des peuples des Grands Lacs et des Plaines déjà documentés. Connue pour l''élevage ovin introduit par les colons espagnols et le tissage de laine.',
    'Sud-Ouest américain (Arizona, Nouveau-Mexique, Utah)',
    35.68,
    -109.05,
    1400, -- migration athabaskane estimée vers le Sud-Ouest
    NULL,
    400000,
    2021,
    (SELECT id FROM political_systems WHERE description LIKE 'Système matrilinéaire%'),
    'Élevage ovin et caprin, agriculture (maïs, courge, haricot), chasse historique',
    'active'
);

-- 7. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Navajo'),
    (SELECT id FROM languages WHERE name = 'Diné bizaad (navajo)'),
    TRUE
);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (
        (SELECT id FROM peoples WHERE name = 'Navajo'),
        (SELECT id FROM foods WHERE name = 'mouton'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Navajo'),
        (SELECT id FROM foods WHERE name = 'maïs'),
        'staple'
    );

INSERT INTO peoples_sources (people_id, source_id)
SELECT
    (SELECT id FROM peoples WHERE name = 'Navajo'),
    s.id
FROM sources s
WHERE s.title IN (
    'Diné: A History of the Navajos',
    'Reclaiming Diné History',
    'Navajo Nation — site officiel'
);
