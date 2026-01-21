-- Données de test pour Minerva
-- Insertion d'enseignants
INSERT INTO
    utilisateurs (email, mot_de_passe, prenom, nom, role)
VALUES
    (
        'martin.dupont@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Martin',
        'Dupont',
        'enseignant'
    ),
    (
        'sophie.leroy@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Sophie',
        'Leroy',
        'enseignant'
    ),
    (
        'pierre.martin@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Pierre',
        'Martin',
        'enseignant'
    );

INSERT INTO
    enseignants (
        utilisateur_id,
        departement,
        specialite,
        date_embauche
    )
VALUES
    (
        1,
        'Informatique',
        'Développement Web',
        '2020-09-01'
    ),
    (
        2,
        'Mathématiques',
        'Algèbre et Analyse',
        '2019-09-01'
    ),
    (3, 'Sciences', 'Physique-Chimie', '2021-09-01');

-- Insertion d'étudiants
INSERT INTO
    utilisateurs (email, mot_de_passe, prenom, nom, role)
VALUES
    (
        'lucas.martin@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Lucas',
        'Martin',
        'etudiant'
    ),
    (
        'lea.dubois@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Léa',
        'Dubois',
        'etudiant'
    ),
    (
        'thomas.roux@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Thomas',
        'Roux',
        'etudiant'
    ),
    (
        'emma.lefevre@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Emma',
        'Lefèvre',
        'etudiant'
    ),
    (
        'nathan.bernard@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Nathan',
        'Bernard',
        'etudiant'
    ),
    (
        'manon.petit@minerva.fr',
        '$2y$10$Z3JhdGVzQGBzY2hvb2wuY29tJywgJGVuY3J5cHRlZF9wYXNz',
        'Manon',
        'Petit',
        'etudiant'
    );

INSERT INTO
    etudiants (utilisateur_id, numero_etudiant, date_naissance)
VALUES
    (4, 'ETU2023001', '2005-03-15'),
    (5, 'ETU2023002', '2005-07-22'),
    (6, 'ETU2023003', '2005-11-08'),
    (7, 'ETU2023004', '2005-01-30'),
    (8, 'ETU2023005', '2005-09-14'),
    (9, 'ETU2023006', '2005-05-19');

-- Insertion de classes
INSERT INTO
    classes (
        nom,
        enseignant_id,
        matiere,
        niveau,
        annee_scolaire,
        description
    )
VALUES
    (
        'DWWM 2024',
        1,
        'Développement Web',
        'Bac+2',
        2024,
        'Formation Développeur Web et Web Mobile'
    ),
    (
        'Mathématiques Avancées',
        2,
        'Mathématiques',
        'Terminale',
        2024,
        'Cours de mathématiques niveau terminale'
    ),
    (
        'Physique-Chimie',
        3,
        'Sciences',
        'Première',
        2024,
        'Cours de physique-chimie pour première S'
    );

-- Inscription des étudiants aux classes
INSERT INTO
    inscriptions_classe (etudiant_id, classe_id)
VALUES
    (1, 1),
    (2, 1),
    (3, 1), -- DWWM
    (1, 2),
    (2, 2),
    (4, 2), -- Mathématiques
    (3, 3),
    (5, 3),
    (6, 3);

-- Physique-Chimie
-- Insertion de travaux
INSERT INTO
    travaux (
        titre,
        description,
        enseignant_id,
        classe_id,
        type,
        date_echeance,
        points_max
    )
VALUES
    (
        'Projet MVC',
        'Créer une application MVC complète',
        1,
        1,
        'projet',
        '2024-02-15 23:59:00',
        20
    ),
    (
        'Base de données SQL',
        'Exercices sur les requêtes SQL',
        1,
        1,
        'exercice',
        '2024-02-10 23:59:00',
        10
    ),
    (
        'Équations différentielles',
        'Résolution d''équations différentielles',
        2,
        2,
        'exercice',
        '2024-02-12 23:59:00',
        15
    ),
    (
        'Chimie organique',
        'TD sur la chimie organique',
        3,
        3,
        'document',
        '2024-02-14 23:59:00',
        10
    );

-- Assignation des travaux aux étudiants
INSERT INTO
    assignations_travail (travail_id, etudiant_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (2, 2),
    (2, 3),
    (3, 1),
    (3, 2),
    (3, 4),
    (4, 3),
    (4, 5),
    (4, 6);

-- Insertion de soumissions
INSERT INTO
    soumissions (
        travail_id,
        etudiant_id,
        date_soumission,
        note,
        commentaire_etudiant
    )
VALUES
    (
        1,
        1,
        '2024-02-14 15:30:00',
        18,
        'J''ai bien aimé ce projet'
    ),
    (
        2,
        1,
        '2024-02-09 14:20:00',
        9,
        'Exercices intéressants'
    ),
    (
        3,
        2,
        '2024-02-11 10:15:00',
        14,
        'Un peu difficile'
    ),
    (4, 3, '2024-02-13 16:45:00', 16, NULL);

-- Insertion d'évaluations
INSERT INTO
    evaluations (soumission_id, enseignant_id, note, commentaire)
VALUES
    (
        1,
        1,
        18,
        'Excellent travail ! Code bien structuré.'
    ),
    (2, 1, 9, 'Bien mais quelques erreurs de syntaxe.'),
    (3, 2, 14, 'Bon travail mais manque de détails.'),
    (4, 3, 16, 'Très bonne compréhension du sujet.');

-- Insertion de présences
INSERT INTO
    presences (
        etudiant_id,
        classe_id,
        date_presence,
        statut,
        enregistre_par
    )
VALUES
    (1, 1, '2024-02-01', 'present', 1),
    (2, 1, '2024-02-01', 'present', 1),
    (3, 1, '2024-02-01', 'retard', 1),
    (1, 1, '2024-02-08', 'present', 1),
    (2, 1, '2024-02-08', 'absent', 1),
    (3, 1, '2024-02-08', 'present', 1);

-- Insertion de messages de chat
INSERT INTO
    messages_chat (
        classe_id,
        utilisateur_id,
        message,
        type_message,
        lu
    )
VALUES
    (
        1,
        1,
        'Bonjour à tous, le cours commence dans 5 minutes',
        'texte',
        TRUE
    ),
    (
        1,
        4,
        'Bonjour Monsieur, j''ai une question sur le projet',
        'texte',
        TRUE
    ),
    (
        1,
        1,
        'Je suis disponible cet après-midi pour des questions',
        'texte',
        TRUE
    ),
    (
        1,
        5,
        'Merci pour le cours d''aujourd''hui',
        'texte',
        TRUE
    );

-- Insertion d'annonces
INSERT INTO
    annonces (
        titre,
        contenu,
        enseignant_id,
        classe_id,
        important
    )
VALUES
    (
        'Réunion parents-profs',
        'Réunion le 15 février à 18h en salle B12',
        1,
        1,
        TRUE
    ),
    (
        'Devoir surveillé',
        'DS de mathématiques prévu le 20 février',
        2,
        2,
        TRUE
    ),
    (
        'Laboratoire de chimie',
        'Séance de TP reportée au 22 février',
        3,
        3,
        FALSE
    );