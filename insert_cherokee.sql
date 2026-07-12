-- =========================================================
-- HUMAN ATLAS — Insertion des données : Cherokee
-- =========================================================

-- 1. Système politique : clans matrilinéaires puis gouvernement national centralisé
INSERT INTO political_systems (type, description)
VALUES ('clan system', 'Sept clans matrilinéaires organisés en villes autonomes historiquement ; gouvernement national centralisé (Cherokee Nation) formé au XIXe siècle avec une Constitution écrite dès 1827');

-- 2. La langue cherokee (famille Iroquoian déjà créée pour Haudenosaunee/Wendat — fait intéressant :
-- les Cherokees parlent une langue iroquoienne malgré leur situation géographique très éloignée)
INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Tsalagi (cherokee)',
    (SELECT id FROM language_families WHERE name = 'Iroquoian'),
    'critically endangered',
    'Écoles d''immersion (ex. New Kituwah Academy en Caroline du Nord) ; syllabaire cherokee créé par Sequoyah au début du XIXe siècle'
);

-- 3. Aliment : gibier propre au Sud-Est (cerf, dindon sauvage)
INSERT INTO foods (name, category, origin) VALUES ('gibier (cerf, dindon sauvage)', 'game', 'Sud-Est de l''Amérique du Nord');

-- 4. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'The Cherokee Nation: A History',
        'Robert J. Conley',
        'University of New Mexico Press',
        'https://www.amazon.com/Cherokee-Nation-Robert-J-Conley/dp/0826332358',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Deconstructing the Cherokee Nation',
        'Tyler Boulware',
        'University Press of Florida',
        'https://upf.com/book.asp?id=9780813061719',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Cherokee Nation — site officiel',
        NULL,
        'Cherokee Nation',
        'https://www.cherokee.org',
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
    'Cherokee',
    'Aniyvwiya / Tsalagi',
    'Historiquement établis dans le Sud-Est des États-Unis, les Cherokees parlent une langue iroquoienne malgré leur grande distance géographique avec les autres peuples iroquoiens (Haudenosaunee, Wendat). Déportés de force vers l''Oklahoma en 1838-1839 (la "Piste des larmes"), ils forment aujourd''hui la plus grande nation amérindienne des États-Unis par le nombre de citoyens inscrits.',
    'Historique : Sud-Est des États-Unis (Géorgie, Caroline du Nord/Sud, Tennessee) ; aujourd''hui : Oklahoma (Cherokee Nation) et réserve de Qualla Boundary en Caroline du Nord (Eastern Band)',
    35.91,
    -94.97,
    NULL,
    NULL,
    450000,
    2021,
    (SELECT id FROM political_systems WHERE description LIKE 'Sept clans matrilinéaires%'),
    'Agriculture (maïs, haricot, courge), chasse (cerf, dindon sauvage)',
    'active'
);

-- 6. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Cherokee'),
    (SELECT id FROM languages WHERE name = 'Tsalagi (cherokee)'),
    TRUE
);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (
        (SELECT id FROM peoples WHERE name = 'Cherokee'),
        (SELECT id FROM foods WHERE name = 'maïs'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Cherokee'),
        (SELECT id FROM foods WHERE name = 'haricot'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Cherokee'),
        (SELECT id FROM foods WHERE name = 'courge'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Cherokee'),
        (SELECT id FROM foods WHERE name = 'gibier (cerf, dindon sauvage)'),
        'staple'
    );

INSERT INTO peoples_sources (people_id, source_id)
SELECT
    (SELECT id FROM peoples WHERE name = 'Cherokee'),
    s.id
FROM sources s
WHERE s.title IN (
    'The Cherokee Nation: A History',
    'Deconstructing the Cherokee Nation',
    'Cherokee Nation — site officiel'
);
