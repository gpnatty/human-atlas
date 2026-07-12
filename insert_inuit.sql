-- =========================================================
-- HUMAN ATLAS — Insertion des données : Inuit
-- =========================================================

-- 1. Système politique : camps saisonniers, sans autorité centralisée historique
INSERT INTO political_systems (type, description)
VALUES ('band', 'Organisation traditionnelle en camps familiaux saisonniers adaptés aux migrations du gibier arctique ; pas d''autorité politique centralisée avant les gouvernements régionaux modernes (ex. Nunavut, 1999)');

-- 2. Nouvelle famille linguistique : Eskimo-Aleut
INSERT INTO language_families (name) VALUES ('Eskimo-Aleut');

-- 3. La langue inuit
INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Inuktitut',
    (SELECT id FROM language_families WHERE name = 'Eskimo-Aleut'),
    'vulnerable',
    'Langue officielle du Nunavut (Canada) aux côtés de l''anglais et du français ; enseignement en immersion dans plusieurs communautés arctiques'
);

-- 4. Aliments propres au mode de vie arctique
INSERT INTO foods (name, category, origin) VALUES
    ('phoque', 'game', 'Arctique'),
    ('baleine', 'game', 'Arctique')
RETURNING id;

-- 5. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'In Order to Live Untroubled: Inuit of the Central Arctic, 1550-1940',
        'Renée Fossett',
        'University of Manitoba Press',
        NULL,
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Unfreezing the Arctic: Science, Colonialism, and the Transformation of Inuit Lands',
        'Andrew Stuhl',
        'University of Chicago Press',
        'https://press.uchicago.edu/ucp/books/book/chicago/U/bo24957300.html',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Inuit Circumpolar Council — site officiel',
        NULL,
        'Inuit Circumpolar Council',
        'https://www.inuitcircumpolar.com',
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
    'Inuit',
    'Inuit ("les gens")',
    'Peuple circumpolaire réparti sur l''ensemble de l''Arctique nord-américain et le Groenland, apparenté aux Yupik et Iñupiat d''Alaska et de Sibérie orientale. Mode de vie historiquement adapté au froid extrême, basé sur la chasse marine et terrestre.',
    'Arctique nord-américain (Alaska, Nunavut, Nunavik, Groenland)',
    63.75,
    -68.52,
    NULL,
    NULL,
    180000,
    2022,
    (SELECT id FROM political_systems WHERE description LIKE 'Organisation traditionnelle en camps familiaux%'),
    'Chasse au phoque, à la baleine et au caribou ; pêche ; historiquement nomadisme saisonnier',
    'active'
);

-- 7. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Inuit'),
    (SELECT id FROM languages WHERE name = 'Inuktitut'),
    TRUE
);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (
        (SELECT id FROM peoples WHERE name = 'Inuit'),
        (SELECT id FROM foods WHERE name = 'phoque'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Inuit'),
        (SELECT id FROM foods WHERE name = 'baleine'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Inuit'),
        (SELECT id FROM foods WHERE name = 'gibier (caribou, orignal)'),
        'staple'
    );

INSERT INTO peoples_sources (people_id, source_id)
SELECT
    (SELECT id FROM peoples WHERE name = 'Inuit'),
    s.id
FROM sources s
WHERE s.title IN (
    'In Order to Live Untroubled: Inuit of the Central Arctic, 1550-1940',
    'Unfreezing the Arctic: Science, Colonialism, and the Transformation of Inuit Lands',
    'Inuit Circumpolar Council — site officiel'
);
