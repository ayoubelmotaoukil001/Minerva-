<?php
// التحقق مما إذا كان المستخدم مسجل الدخول بالفعل
if (isset($_SESSION['student_id'])) {
    header('Location: /student/dashboard');
    exit();
}
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Thoth LMS</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        body {
            background-color: #1b1b1b;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .register-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            padding: 40px;
        }

        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo h1 {
            color: #4a6fa5;
            margin: 0;
            font-size: 28px;
        }

        .logo p {
            color: #666;
            margin-top: 5px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 500;
        }

        .form-group input {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }

        .form-group input:focus {
            outline: none;
            border-color: #4a6fa5;
            box-shadow: 0 0 0 2px rgba(74, 111, 165, 0.2);
        }

        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }

        .password-requirements ul {
            margin: 5px 0;
            padding-left: 20px;
        }

        .password-requirements li {
            margin-bottom: 2px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background-color: #4a6fa5;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #3a5a85;
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .form-footer a {
            color: #4a6fa5;
            text-decoration: none;
            font-weight: 500;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .alert {
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error-message {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        .form-group.error input {
            border-color: #dc3545;
        }

        .form-group.error .error-message {
            display: block;
        }

        .requirement {
            transition: color 0.3s;
        }

        .requirement.valid {
            color: #28a745;
        }

        .requirement.invalid {
            color: #dc3545;
        }
    </style>
</head>

<body>
    <div class="register-container">
        <div class="logo">
            <h1>Thoth LMS</h1>
            <p>Créer votre compte étudiant</p>
        </div>

        <?php if (isset($_SESSION['error'])): ?>
            <div class="alert alert-error">
                <?php
                echo htmlspecialchars($_SESSION['error']);
                unset($_SESSION['error']);
                ?>
            </div>
        <?php endif; ?>

        <?php if (isset($_SESSION['success'])): ?>
            <div class="alert alert-success">
                <?php
                echo htmlspecialchars($_SESSION['success']);
                unset($_SESSION['success']);
                ?>
            </div>
        <?php endif; ?>

        <form action="/register" method="POST" id="registerForm">
            <!-- Token CSRF pour la sécurité -->
            <input type="hidden" name="csrf_token"
                value="<?php echo htmlspecialchars($_SESSION['csrf_token'] ?? ''); ?>">

            <div class="form-group" id="nameGroup">
                <label for="name">Nom complet</label>
                <input type="text" id="name" name="name" required placeholder="Votre nom et prénom"
                    value="<?php echo htmlspecialchars($_POST['name'] ?? ''); ?>">
                <div class="error-message" id="nameError"></div>
            </div>

            <div class="form-group" id="emailGroup">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required placeholder="votre@email.com"
                    value="<?php echo htmlspecialchars($_POST['email'] ?? ''); ?>">
                <div class="error-message" id="emailError"></div>
            </div>

            <div class="form-group" id="passwordGroup">
                <label for="password">Mot de passe</label>
                <input type="password" id="password" name="password" required placeholder="Votre mot de passe">
                <div class="error-message" id="passwordError"></div>

                <div class="password-requirements">
                    <p>Le mot de passe doit contenir :</p>
                    <ul>
                        <li id="reqLength" class="requirement">Au moins 8 caractères</li>
                        <li id="reqUppercase" class="requirement">Une lettre majuscule</li>
                        <li id="reqLowercase" class="requirement">Une lettre minuscule</li>
                        <li id="reqNumber" class="requirement">Un chiffre</li>
                        <li id="reqSpecial" class="requirement">Un caractère spécial (@$!%*?&)</li>
                    </ul>
                </div>
            </div>

            <div class="form-group" id="confirmPasswordGroup">
                <label for="confirm_password">Confirmer le mot de passe</label>
                <input type="password" id="confirm_password" name="confirm_password" required
                    placeholder="Confirmez votre mot de passe">
                <div class="error-message" id="confirmPasswordError"></div>
            </div>

            <button type="submit" class="btn">S'inscrire</button>
        </form>

        <div class="form-footer">
            <p>Déjà un compte ? <a href="/login">Se connecter</a></p>
            <p><a href="/">← Retour à l'accueil</a></p>
        </div>
    </div>

    <script>
        // Définir les éléments
        const form = document.getElementById('registerForm');
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirm_password');
        const nameInput = document.getElementById('name');
        const emailInput = document.getElementById('email');

        // Éléments des exigences
        const reqLength = document.getElementById('reqLength');
        const reqUppercase = document.getElementById('reqUppercase');
        const reqLowercase = document.getElementById('reqLowercase');
        const reqNumber = document.getElementById('reqNumber');
        const reqSpecial = document.getElementById('reqSpecial');

        // Fonction pour vérifier un champ requis
        function checkRequirement(element, condition) {
            if (condition) {
                element.classList.remove('invalid');
                element.classList.add('valid');
                return true;
            } else {
                element.classList.remove('valid');
                element.classList.add('invalid');
                return false;
            }
        }

        // Fonction de validation du mot de passe
        function validatePassword(pass) {
            const hasLength = pass.length >= 8;
            const hasUppercase = /[A-Z]/.test(pass);
            const hasLowercase = /[a-z]/.test(pass);
            const hasNumber = /[0-9]/.test(pass);
            const hasSpecial = /[@$!%*?&]/.test(pass);

            // Mettre à jour l'affichage des exigences
            checkRequirement(reqLength, hasLength);
            checkRequirement(reqUppercase, hasUppercase);
            checkRequirement(reqLowercase, hasLowercase);
            checkRequirement(reqNumber, hasNumber);
            checkRequirement(reqSpecial, hasSpecial);

            return hasLength && hasUppercase && hasLowercase && hasNumber && hasSpecial;
        }

        // Validation en temps réel
        password.addEventListener('input', function () {
            validatePassword(this.value);
            checkPasswordsMatch();
        });

        confirmPassword.addEventListener('input', checkPasswordsMatch);

        nameInput.addEventListener('input', function () {
            const nameGroup = document.getElementById('nameGroup');
            if (this.value.trim().length >= 2) {
                nameGroup.classList.remove('error');
                document.getElementById('nameError').textContent = '';
            }
        });

        emailInput.addEventListener('input', function () {
            const emailGroup = document.getElementById('emailGroup');
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (emailRegex.test(this.value)) {
                emailGroup.classList.remove('error');
                document.getElementById('emailError').textContent = '';
            }
        });

        function checkPasswordsMatch() {
            const confirmPasswordGroup = document.getElementById('confirmPasswordGroup');
            const confirmPasswordError = document.getElementById('confirmPasswordError');

            if (confirmPassword.value && password.value !== confirmPassword.value) {
                confirmPasswordGroup.classList.add('error');
                confirmPasswordError.textContent = 'Les mots de passe ne correspondent pas';
                return false;
            } else {
                confirmPasswordGroup.classList.remove('error');
                confirmPasswordError.textContent = '';
                return true;
            }
        }

        // Validation du formulaire
        form.addEventListener('submit', function (e) {
            e.preventDefault();

            let isValid = true;

            // Réinitialiser les erreurs
            document.querySelectorAll('.form-group').forEach(group => {
                group.classList.remove('error');
            });

            // Validation du nom
            const name = nameInput.value.trim();
            if (name.length < 2) {
                document.getElementById('nameGroup').classList.add('error');
                document.getElementById('nameError').textContent = 'Le nom doit contenir au moins 2 caractères';
                isValid = false;
            }

            // Validation de l'email
            const email = emailInput.value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                document.getElementById('emailGroup').classList.add('error');
                document.getElementById('emailError').textContent = 'Veuillez entrer une adresse email valide';
                isValid = false;
            }

            // Validation du mot de passe
            if (!validatePassword(password.value)) {
                document.getElementById('passwordGroup').classList.add('error');
                document.getElementById('passwordError').textContent = 'Le mot de passe ne respecte pas toutes les exigences';
                isValid = false;
            }

            // Validation de la confirmation
            if (!checkPasswordsMatch()) {
                isValid = false;
            }

            // Si tout est valide, soumettre le formulaire
            if (isValid) {
                // Montrer un message de chargement
                const submitBtn = form.querySelector('.btn');
                const originalText = submitBtn.textContent;
                submitBtn.textContent = 'Inscription en cours...';
                submitBtn.disabled = true;

                // Soumettre le formulaire après un court délai pour l'effet visuel
                setTimeout(() => {
                    this.submit();
                }, 500);
            }
        });

        // Validation initiale
        validatePassword(password.value);

        // Focus sur le premier champ
        nameInput.focus();
    </script>
</body>

</html>