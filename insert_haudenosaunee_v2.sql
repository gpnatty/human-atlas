-- =========================================================
-- HUMAN ATLAS — Insertion des données : Haudenosaunee
-- Version corrigée : 3 sources académiques/primaires, sans Wikipédia
-- =========================================================

-- 1. Le système politique
INSERT INTO political_systems (type, description)
VALUES ('confederacy', 'Ligue de la Paix : six nations iroquoiennes alliées, gouvernées par un Grand Conseil')
RETURNING id;

-- 2. La famille linguistique et la langue
INSERT INTO language_families (name) VALUES ('Iroquoian')
RETURNING id;

INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Langues haudenosaunee (Mohawk, Oneida, Onondaga, Cayuga, Seneca, Tuscarora)',
    1, -- id de la famille Iroquoian (à ajuster si différent)
    'endangered',
    'Plusieurs nations font tourner des programmes d''enseignement de la langue pour les nouvelles générations'
)
RETURNING id;

-- 3. Les aliments (les "Trois Sœurs")
INSERT INTO foods (name, category, origin) VALUES
    ('maïs', 'crop', 'Amérique du Nord'),
    ('haricot', 'crop', 'Amérique du Nord'),
    ('courge', 'crop', 'Amérique du Nord')
RETURNING id;

-- 4. Les TROIS sources, croisées et académiques
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'The Ordeal of the Longhouse: The Peoples of the Iroquois League in the Era of European Colonization',
        'Daniel K. Richter',
        'University of North Carolina Press (Omohundro Institute)',
        'https://uncpress.org/9780807843949/the-ordeal-of-the-longhouse/',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Encyclopedia of the Haudenosaunee (Iroquois Confederacy)',
        'Bruce E. Johansen and Barbara Alice Mann',
        'Greenwood Publishing Group',
        NULL,
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Haudenosaunee Confederacy — site officiel',
        NULL,
        'Haudenosaunee Confederacy',
        'https://www.haudenosauneeconfederacy.com',
        'primary',
        CURRENT_DATE,
        'high'
    )
RETURNING id;
-- Note les 3 ids retournés (probablement 1, 2, 3) : on s'en sert plus bas.

-- 5. Le peuple lui-même
INSERT INTO peoples (
    name, endonym, description, region, latitude, longitude,
    period_start, period_end, population_estimate, population_year,
    political_system_id, subsistence_notes, status
) VALUES (
    'Haudenosaunee',
    'Ongweh''onweh',
    'Confédération de six nations iroquoiennes (Mohawk, Oneida, Onondaga, Cayuga, Seneca, Tuscarora), aussi appelée Iroquois ou Six Nations.',
    'Grands Lacs / Nord-Est de l''Amérique du Nord',
    43.05,
    -76.15,
    1450,
    NULL,
    125000,
    2009,
    1, -- id du système politique (étape 1)
    'Agriculture (maïs, haricot, courge), chasse, pêche',
    'active'
)
RETURNING id;

-- 6. Les liens entre le peuple et la langue / les aliments / les 3 sources
-- Ajuste les ids ci-dessous si les nombres retournés plus haut étaient différents.
INSERT INTO peoples_languages (people_id, language_id, is_primary) VALUES (1, 1, TRUE);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (1, 1, 'staple'),
    (1, 2, 'staple'),
    (1, 3, 'staple');

INSERT INTO peoples_sources (people_id, source_id) VALUES
    (1, 1),
    (1, 2),
    (1, 3);
