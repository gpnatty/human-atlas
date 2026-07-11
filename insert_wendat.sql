-- =========================================================
-- HUMAN ATLAS — Insertion des données : Wendat
-- =========================================================

-- 1. Système politique (confédération wendat, distincte de celle des Haudenosaunee)
INSERT INTO political_systems (type, description)
VALUES ('confederacy', 'Confédération wendat : alliance de 4 à 5 nations formée fin XVIe siècle, dispersée en 1650 par les Haudenosaunee')
RETURNING id;
-- Note l'id retourné (probablement 2, puisque celui des Haudenosaunee est 1).

-- 2. La langue wendat (la famille Iroquoian existe déjà, id 1 normalement — pas besoin de la recréer)
INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Wendat',
    1, -- id de la famille Iroquoian déjà créée pour les Haudenosaunee ; ajuste si différent
    'critically endangered',
    'Langue éteinte au XIXe siècle, en cours de revitalisation depuis les années 1970-80 à Wendake (Québec) et chez les Wyandot (Oklahoma) à partir de dictionnaires historiques'
)
RETURNING id;
-- Note l'id retourné (probablement 2).

-- 3. Un aliment supplémentaire : le poisson (le maïs/haricot/courge existent déjà, ids 1/2/3)
INSERT INTO foods (name, category, origin) VALUES ('poisson', 'fish', 'Amérique du Nord')
RETURNING id;
-- Note l'id retourné (probablement 4).

-- 4. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'Huron-Wendat: The Heritage of the Circle',
        'Georges E. Sioui',
        'UBC Press / Michigan State University Press',
        'https://msupress.org/9780870135262/huron-wendat/',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Dispersed But Not Destroyed: A History of the Seventeenth-century Wendat People',
        'Kathryn Magee Labelle',
        'UBC Press',
        NULL,
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Nation Wendat — site officiel',
        NULL,
        'Nation Wendat (Wendake)',
        'https://www.wendake.ca/',
        'primary',
        CURRENT_DATE,
        'high'
    )
RETURNING id;
-- Note les 3 ids retournés (probablement 4, 5, 6).

-- 5. Le peuple lui-même
INSERT INTO peoples (
    name, endonym, description, region, latitude, longitude,
    period_start, period_end, population_estimate, population_year,
    political_system_id, subsistence_notes, status
) VALUES (
    'Wendat',
    'Wendat ("habitants de l''île")',
    'Confédération de nations iroquoiennes historiquement établie au nord du lac Ontario (Huronie), estimée à 20 000-25 000 personnes avant contact européen. Dispersée en 1650 par les Haudenosaunee ; les descendants vivent aujourd''hui à Wendake (Québec) et parmi les Wyandotte (Oklahoma, Kansas, Michigan). Anciennement appelée "Hurons-Wendat", la nation a repris officiellement le nom "Nation Wendat" en avril 2025.',
    'Historique : nord du lac Ontario (Huronie) ; aujourd''hui : Wendake, Québec',
    46.90,
    -71.38,
    1550,
    1650, -- fin de la confédération historique (la nation elle-même perdure aujourd'hui, voir description)
    4029,
    2017,
    2, -- id du système politique wendat (étape 1)
    'Agriculture (maïs, haricot, courge), pêche ; chasse secondaire',
    'active'
)
RETURNING id;
-- Note l'id retourné (probablement 2, puisque Haudenosaunee est 1).

-- 6. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary) VALUES (2, 2, TRUE);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (2, 1, 'staple'),  -- maïs
    (2, 2, 'staple'),  -- haricot
    (2, 3, 'staple'),  -- courge
    (2, 4, 'staple');  -- poisson

INSERT INTO peoples_sources (people_id, source_id) VALUES
    (2, 4),
    (2, 5),
    (2, 6);

-- 7. Bonus : une relation entre peuples (la table peoples_relations créée dès le schéma initial)
INSERT INTO peoples_relations (people_a_id, people_b_id, relation_type, period_start, period_end, notes)
VALUES (
    1, -- Haudenosaunee
    2, -- Wendat
    'conflict',
    1610,
    1650,
    'Série de conflits armés (guerres iroquoises) aboutissant à la dispersion de la confédération wendat en 1650'
);
