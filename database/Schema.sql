-- Création de la base de données
CREATE DATABASE IF NOT EXISTS minerva CHARACTER
SET
    utf8mb4 COLLATE utf8mb4_unicode_ci;

USE minerva;

-- Table : Utilisateurs (doit être créée en premier)
CREATE TABLE
    utilisateurs (
        id INT PRIMARY KEY AUTO_INCREMENT,
        email VARCHAR(255) UNIQUE NOT NULL,
        mot_de_passe VARCHAR(255) NOT NULL,
        prenom VARCHAR(100) NOT NULL,
        nom VARCHAR(100) NOT NULL,
        role ENUM ('enseignant', 'etudiant') NOT NULL,
        date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        date_maj TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Enseignants
CREATE TABLE
    enseignants (
        id INT PRIMARY KEY AUTO_INCREMENT,
        utilisateur_id INT UNIQUE NOT NULL,
        departement VARCHAR(100),
        specialite VARCHAR(150),
        bureau VARCHAR(50),
        date_embauche DATE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Étudiants
CREATE TABLE
    etudiants (
        id INT PRIMARY KEY AUTO_INCREMENT,
        utilisateur_id INT UNIQUE NOT NULL,
        numero_etudiant VARCHAR(50) UNIQUE,
        classe_id INT,
        date_naissance DATE,
        telephone VARCHAR(20)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Classes
CREATE TABLE
    classes (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nom VARCHAR(100) NOT NULL,
        enseignant_id INT NOT NULL,
        matiere VARCHAR(100),
        niveau VARCHAR(50),
        annee_scolaire YEAR,
        description TEXT,
        date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Inscriptions aux classes
CREATE TABLE
    inscriptions_classe (
        id INT PRIMARY KEY AUTO_INCREMENT,
        etudiant_id INT NOT NULL,
        classe_id INT NOT NULL,
        date_inscription TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        statut ENUM ('actif', 'inactif') DEFAULT 'actif',
        UNIQUE (etudiant_id, classe_id)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Travaux/Devoirs
CREATE TABLE
    travaux (
        id INT PRIMARY KEY AUTO_INCREMENT,
        titre VARCHAR(255) NOT NULL,
        description TEXT,
        enseignant_id INT NOT NULL,
        classe_id INT,
        chemin_fichier VARCHAR(500),
        type ENUM (
            'document',
            'lecon',
            'exercice',
            'examen',
            'projet'
        ),
        date_echeance DATETIME,
        points_max DECIMAL(5, 2),
        date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Assignations des travaux
CREATE TABLE
    assignations_travail (
        id INT PRIMARY KEY AUTO_INCREMENT,
        travail_id INT NOT NULL,
        etudiant_id INT NOT NULL,
        date_assignation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        statut ENUM ('assigné', 'en_cours', 'soumis', 'corrigé') DEFAULT 'assigné',
        UNIQUE (travail_id, etudiant_id)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Soumissions
CREATE TABLE
    soumissions (
        id INT PRIMARY KEY AUTO_INCREMENT,
        travail_id INT NOT NULL,
        etudiant_id INT NOT NULL,
        contenu TEXT,
        chemin_fichier VARCHAR(500),
        date_soumission TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        en_retard BOOLEAN DEFAULT FALSE,
        note DECIMAL(5, 2),
        commentaire_etudiant TEXT,
        UNIQUE (travail_id, etudiant_id)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Évaluations/Notes
CREATE TABLE
    evaluations (
        id INT PRIMARY KEY AUTO_INCREMENT,
        soumission_id INT NOT NULL,
        enseignant_id INT NOT NULL,
        note DECIMAL(5, 2),
        commentaire TEXT,
        date_evaluation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Présences
CREATE TABLE
    presences (
        id INT PRIMARY KEY AUTO_INCREMENT,
        etudiant_id INT NOT NULL,
        classe_id INT NOT NULL,
        date_presence DATE NOT NULL,
        statut ENUM ('present', 'absent', 'retard', 'excusé') NOT NULL,
        notes TEXT,
        enregistre_par INT NOT NULL,
        date_enregistrement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        UNIQUE (etudiant_id, classe_id, date_presence)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Messages de chat
CREATE TABLE
    messages_chat (
        id INT PRIMARY KEY AUTO_INCREMENT,
        classe_id INT NOT NULL,
        utilisateur_id INT NOT NULL,
        message TEXT NOT NULL,
        chemin_fichier VARCHAR(500),
        type_message ENUM ('texte', 'fichier', 'image', 'lien'),
        date_envoi TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        lu BOOLEAN DEFAULT FALSE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Annonces
CREATE TABLE
    annonces (
        id INT PRIMARY KEY AUTO_INCREMENT,
        titre VARCHAR(255) NOT NULL,
        contenu TEXT NOT NULL,
        enseignant_id INT NOT NULL,
        classe_id INT,
        date_publication TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        date_expiration DATE,
        important BOOLEAN DEFAULT FALSE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- Table : Fichiers partagés
CREATE TABLE
    fichiers_partages (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nom_fichier VARCHAR(255) NOT NULL,
        chemin_fichier VARCHAR(500) NOT NULL,
        taille INT,
        type_fichier VARCHAR(100),
        enseignant_id INT,
        classe_id INT,
        date_upload TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- ==================================================
-- AJOUT DES CONTRAINTES DE CLÉ ÉTRANGÈRE
-- ==================================================
-- Contraintes pour la table enseignants
ALTER TABLE enseignants ADD CONSTRAINT fk_enseignants_utilisateur FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs (id) ON DELETE CASCADE;

-- Contraintes pour la table etudiants
ALTER TABLE etudiants ADD CONSTRAINT fk_etudiants_utilisateur FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs (id) ON DELETE CASCADE;

-- Contraintes pour la table classes
ALTER TABLE classes ADD CONSTRAINT fk_classes_enseignant FOREIGN KEY (enseignant_id) REFERENCES enseignants (id) ON DELETE CASCADE;

-- Contraintes pour la table inscriptions_classe
ALTER TABLE inscriptions_classe ADD CONSTRAINT fk_inscriptions_etudiant FOREIGN KEY (etudiant_id) REFERENCES etudiants (id) ON DELETE CASCADE;

ALTER TABLE inscriptions_classe ADD CONSTRAINT fk_inscriptions_classe FOREIGN KEY (classe_id) REFERENCES classes (id) ON DELETE CASCADE;

-- Contraintes pour la table travaux
ALTER TABLE travaux ADD CONSTRAINT fk_travaux_enseignant FOREIGN KEY (enseignant_id) REFERENCES enseignants (id) ON DELETE CASCADE;

ALTER TABLE travaux ADD CONSTRAINT fk_travaux_classe FOREIGN KEY (classe_id) REFERENCES classes (id) ON DELETE SET NULL;

-- Contraintes pour la table assignations_travail
ALTER TABLE assignations_travail ADD CONSTRAINT fk_assignations_travail FOREIGN KEY (travail_id) REFERENCES travaux (id) ON DELETE CASCADE;

ALTER TABLE assignations_travail ADD CONSTRAINT fk_assignations_etudiant FOREIGN KEY (etudiant_id) REFERENCES etudiants (id) ON DELETE CASCADE;

-- Contraintes pour la table soumissions
ALTER TABLE soumissions ADD CONSTRAINT fk_soumissions_travail FOREIGN KEY (travail_id) REFERENCES travaux (id) ON DELETE CASCADE;

ALTER TABLE soumissions ADD CONSTRAINT fk_soumissions_etudiant FOREIGN KEY (etudiant_id) REFERENCES etudiants (id) ON DELETE CASCADE;

-- Contraintes pour la table evaluations
ALTER TABLE evaluations ADD CONSTRAINT fk_evaluations_soumission FOREIGN KEY (soumission_id) REFERENCES soumissions (id) ON DELETE CASCADE;

ALTER TABLE evaluations ADD CONSTRAINT fk_evaluations_enseignant FOREIGN KEY (enseignant_id) REFERENCES enseignants (id) ON DELETE CASCADE;

-- Contraintes pour la table presences
ALTER TABLE presences ADD CONSTRAINT fk_presences_etudiant FOREIGN KEY (etudiant_id) REFERENCES etudiants (id) ON DELETE CASCADE;

ALTER TABLE presences ADD CONSTRAINT fk_presences_classe FOREIGN KEY (classe_id) REFERENCES classes (id) ON DELETE CASCADE;

ALTER TABLE presences ADD CONSTRAINT fk_presences_enseignant FOREIGN KEY (enregistre_par) REFERENCES enseignants (id) ON DELETE CASCADE;

-- Contraintes pour la table messages_chat
ALTER TABLE messages_chat ADD CONSTRAINT fk_messages_chat_classe FOREIGN KEY (classe_id) REFERENCES classes (id) ON DELETE CASCADE;

ALTER TABLE messages_chat ADD CONSTRAINT fk_messages_chat_utilisateur FOREIGN KEY (utilisateur_id) REFERENCES utilisateurs (id) ON DELETE CASCADE;

-- Contraintes pour la table annonces
ALTER TABLE annonces ADD CONSTRAINT fk_annonces_enseignant FOREIGN KEY (enseignant_id) REFERENCES enseignants (id) ON DELETE CASCADE;

ALTER TABLE annonces ADD CONSTRAINT fk_annonces_classe FOREIGN KEY (classe_id) REFERENCES classes (id) ON DELETE CASCADE;

-- Contraintes pour la table fichiers_partages
ALTER TABLE fichiers_partages ADD CONSTRAINT fk_fichiers_enseignant FOREIGN KEY (enseignant_id) REFERENCES enseignants (id) ON DELETE SET NULL;

ALTER TABLE fichiers_partages ADD CONSTRAINT fk_fichiers_classe FOREIGN KEY (classe_id) REFERENCES classes (id) ON DELETE CASCADE;

-- ==================================================
-- INDEX POUR AMÉLIORER LES PERFORMANCES
-- ==================================================
-- Index pour la table utilisateurs
CREATE INDEX idx_utilisateurs_email ON utilisateurs (email);

CREATE INDEX idx_utilisateurs_role ON utilisateurs (role);

-- Index pour la table etudiants
CREATE INDEX idx_etudiants_classe_id ON etudiants (classe_id);

-- Index pour la table travaux
CREATE INDEX idx_travails_classe_id ON travaux (classe_id);

CREATE INDEX idx_travails_date_echeance ON travaux (date_echeance);

CREATE INDEX idx_travails_enseignant_id ON travaux (enseignant_id);

-- Index pour la table assignations_travail
CREATE INDEX idx_assignations_etudiant_id ON assignations_travail (etudiant_id);

CREATE INDEX idx_assignations_statut ON assignations_travail (statut);

-- Index pour la table soumissions
CREATE INDEX idx_soumissions_travail_id ON soumissions (travail_id);

CREATE INDEX idx_soumissions_etudiant_id ON soumissions (etudiant_id);

CREATE INDEX idx_soumissions_date_soumission ON soumissions (date_soumission);

-- Index pour la table evaluations
CREATE INDEX idx_evaluations_soumission_id ON evaluations (soumission_id);

CREATE INDEX idx_evaluations_enseignant_id ON evaluations (enseignant_id);

-- Index pour la table presences
CREATE INDEX idx_presences_date ON presences (date_presence);

CREATE INDEX idx_presences_etudiant_classe ON presences (etudiant_id, classe_id);

-- Index pour la table messages_chat
CREATE INDEX idx_messages_chat_classe_date ON messages_chat (classe_id, date_envoi);

CREATE INDEX idx_messages_chat_utilisateur ON messages_chat (utilisateur_id);

-- Index pour la table annonces
CREATE INDEX idx_annonces_classe_id ON annonces (classe_id);

CREATE INDEX idx_annonces_date_expiration ON annonces (date_expiration);