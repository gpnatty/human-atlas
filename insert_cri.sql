-- =========================================================
-- HUMAN ATLAS — Insertion des données : Cris (Nehiyawak)
-- Nouvelle méthode : les ids sont retrouvés par nom via des
-- sous-requêtes (SELECT id FROM ... WHERE ...), donc plus besoin
-- de deviner les numéros. Plus fiable pour la suite du projet.
-- =========================================================

-- 1. Système politique : bandes cries, alliées dans la "Confédération de fer"
INSERT INTO political_systems (type, description)
VALUES ('band', 'Organisation crie en bandes autonomes, historiquement alliées aux Assiniboines et Nakawē au sein de la Confédération de fer (Iron Confederacy)');

-- 2. La langue crie (la famille Algonquian existe déjà, créée pour les Ojibwés)
INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Nêhiyawêwin (cri)',
    (SELECT id FROM language_families WHERE name = 'Algonquian'),
    'vulnerable',
    'Langue autochtone la plus parlée au Canada ; enseignée dans plusieurs universités canadiennes et écoles des communautés cries'
);

-- 3. Aliments : gibier générique (le poisson existe déjà)
INSERT INTO foods (name, category, origin) VALUES ('gibier (caribou, orignal)', 'game', 'Amérique du Nord');

-- 4. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'Cree Narrative Memory: From Treaties to Contemporary Times',
        'Neal McLeod',
        'University of Regina Press / UBC Press',
        'https://www.ubcpress.ca/cree-narrative-memory',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Upholding Indigenous Economic Relationships: Nehiyawak Narratives',
        'Shalene Wuttunee Jobin',
        'UBC Press',
        'https://www.wildrumpusbooks.com/book/9780774865203',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Cree Nation Government / Grand Council of the Crees (Eeyou Istchee) — site officiel',
        NULL,
        'Cree Nation Government',
        'https://www.cngov.ca/',
        'primary',
        CURRENT_DATE,
        'high'
    );

-- 5. Le peuple lui-même
INSERT INTO peoples (
    name, endonym, description, region, latitude, longitude,
    period_start, period_end, population_estimate, population_year,
    political_system_id, subsistence_notes, status
) VALUES (
    'Cri',
    'Nêhiyawak',
    'L''un des plus grands groupes de Premières Nations d''Amérique du Nord, réparti sur un vaste territoire entre les Rocheuses et l''océan Atlantique. Comprend plusieurs sous-groupes (Cris des Plaines, Cris des bois, Cris de l''Est/Eeyou, etc.).',
    'Du Canada subarctique et des Plaines (Alberta à Québec) jusqu''au Montana (États-Unis)',
    53.90,
    -101.10,
    NULL,
    NULL,
    317000,
    2021,
    (SELECT id FROM political_systems WHERE description LIKE 'Organisation crie en bandes%'),
    'Chasse (caribou, orignal), pêche, piégeage (traite des fourrures historique)',
    'active'
);

-- 6. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Cri'),
    (SELECT id FROM languages WHERE name = 'Nêhiyawêwin (cri)'),
    TRUE
);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (
        (SELECT id FROM peoples WHERE name = 'Cri'),
        (SELECT id FROM foods WHERE name = 'poisson'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Cri'),
        (SELECT id FROM foods WHERE name = 'gibier (caribou, orignal)'),
        'staple'
    );

INSERT INTO peoples_sources (people_id, source_id)
SELECT
    (SELECT id FROM peoples WHERE name = 'Cri'),
    s.id
FROM sources s
WHERE s.title IN (
    'Cree Narrative Memory: From Treaties to Contemporary Times',
    'Upholding Indigenous Economic Relationships: Nehiyawak Narratives',
    'Cree Nation Government / Grand Council of the Crees (Eeyou Istchee) — site officiel'
);
