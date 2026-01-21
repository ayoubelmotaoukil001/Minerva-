<?php
// Configuration de la base de données
define('DB_HOST', 'localhost');
define('DB_NAME', 'minerva');
define('DB_USER', 'root');
define('DB_PASSWORD', '');
define('DB_CHARSET', 'utf8mb4');

// Configuration de l'application
define('APP_NAME', 'Minerva - Gestion Scolaire');
define('BASE_URL', 'http://localhost/minerva/public/');

// Configuration des sessions
session_start();

// Constantes pour les rôles
define('ROLE_TEACHER', 'enseignant');
define('ROLE_STUDENT', 'etudiant');

// Configuration de sécurité
define('CSRF_TOKEN_NAME', 'minerva_csrf');
define('SESSION_TIMEOUT', 7200); // 2 heures en secondes

// Configuration des uploads
define('UPLOAD_DIR', __DIR__ . '/../public/uploads/');
define('MAX_FILE_SIZE', 10 * 1024 * 1024); // 10MB

// Vérifier la connexion à la base de données
function checkDatabaseConnection()
{
    try {
        $pdo = new PDO(
            "mysql:host=" . DB_HOST,
            DB_USER,
            DB_PASSWORD
        );
        return true;
    } catch (PDOException $e) {
        return false;
    }
}

// Fonction pour vérifier si l'utilisateur est connecté
function isLoggedIn()
{
    return isset($_SESSION['user_id']);
}

// Fonction pour vérifier le rôle
function checkRole($requiredRole)
{
    if (!isLoggedIn() || $_SESSION['user_role'] !== $requiredRole) {
        header('Location: ' . BASE_URL . '?action=login');
        exit();
    }
}

// Fonction pour rediriger selon le rôle
function redirectByRole()
{
    if (isLoggedIn()) {
        if ($_SESSION['user_role'] === ROLE_TEACHER) {
            header('Location: ' . BASE_URL . '?action=teacher_dashboard');
        } else {
            header('Location: ' . BASE_URL . '?action=student_dashboard');
        }
        exit();
    }
}