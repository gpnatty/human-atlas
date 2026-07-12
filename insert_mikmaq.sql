-- =========================================================
-- HUMAN ATLAS — Insertion des données : Mi'kmaq
-- =========================================================

-- 1. Système politique : Grand Conseil et sept districts traditionnels
INSERT INTO political_systems (type, description)
VALUES ('confederacy', 'Mi''kma''ki divisé traditionnellement en sept districts, gouvernés par un Grand Conseil (Sante'' Mawiómi)');

-- 2. La langue mi'kmaq (famille Algonquian déjà créée pour les Ojibwés et les Cris)
INSERT INTO languages (name, family_id, endangerment_level, revitalization)
VALUES (
    'Mi''kmawi''simk (mi''kmaq)',
    (SELECT id FROM language_families WHERE name = 'Algonquian'),
    'vulnerable',
    'Programmes d''enseignement dans les écoles des communautés mi''kmaq de Nouvelle-Écosse (ex. Mi''kmaw Kina''matnewey)'
);

-- 3. Aliment : ressources marines propres à la côte atlantique
INSERT INTO foods (name, category, origin) VALUES ('fruits de mer (homard, anguille)', 'fish', 'Atlantique Nord-Est');

-- 4. Les 3 sources
INSERT INTO sources (title, author, publisher, url, source_type, accessed_on, reliability) VALUES
    (
        'The Mi''kmaq: Resistance, Accommodation, and Cultural Survival',
        'Harald E. L. Prins',
        'Wadsworth / Cengage (Case Studies in Cultural Anthropology)',
        'https://us.amazon.com/Mikmaq-Resistance-Accommodation-Cultural-Anthropology/dp/0030534275',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Mi''kmaq Treaties on Trial',
        'William Wicken',
        'University of Toronto Press',
        'https://utppublishing.com/doi/book/10.3138/9780802076656',
        'academic',
        CURRENT_DATE,
        'high'
    ),
    (
        'Assembly of Nova Scotia Mi''kmaw Chiefs — site officiel',
        NULL,
        'Assembly of Nova Scotia Mi''kmaw Chiefs',
        'https://mikmaqrights.com/',
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
    'Mi''kmaq',
    'L''nu ("le peuple")',
    'Peuple fondateur de la Nouvelle-Écosse et des provinces maritimes canadiennes. Leur territoire historique, Mi''kma''ki, s''étendait de la Gaspésie au Nouveau-Brunswick, à la Nouvelle-Écosse et à l''Île-du-Prince-Édouard, traditionnellement divisé en sept districts sous un Grand Conseil.',
    'Provinces maritimes du Canada (Nouvelle-Écosse, Nouveau-Brunswick, Île-du-Prince-Édouard) et Gaspésie (Québec)',
    45.00,
    -63.00,
    NULL,
    NULL,
    170000,
    2016,
    (SELECT id FROM political_systems WHERE description LIKE 'Mi''kma''ki divisé%'),
    'Pêche côtière (homard, anguille, poisson), chasse, cueillette saisonnière',
    'active'
);

-- 6. Les liens langue / aliments / sources
INSERT INTO peoples_languages (people_id, language_id, is_primary)
VALUES (
    (SELECT id FROM peoples WHERE name = 'Mi''kmaq'),
    (SELECT id FROM languages WHERE name = 'Mi''kmawi''simk (mi''kmaq)'),
    TRUE
);

INSERT INTO peoples_foods (people_id, food_id, role) VALUES
    (
        (SELECT id FROM peoples WHERE name = 'Mi''kmaq'),
        (SELECT id FROM foods WHERE name = 'fruits de mer (homard, anguille)'),
        'staple'
    ),
    (
        (SELECT id FROM peoples WHERE name = 'Mi''kmaq'),
        (SELECT id FROM foods WHERE name = 'poisson'),
        'staple'
    );

INSERT INTO peoples_sources (people_id, source_id)
SELECT
    (SELECT id FROM peoples WHERE name = 'Mi''kmaq'),
    s.id
FROM sources s
WHERE s.title IN (
    'The Mi''kmaq: Resistance, Accommodation, and Cultural Survival',
    'Mi''kmaq Treaties on Trial',
    'Assembly of Nova Scotia Mi''kmaw Chiefs — site officiel'
);
