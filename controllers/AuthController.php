<?php
namespace controllers ;
use services\AuthService ;
class AuthController
{
    private $authService ;

    public function __construct()
    {
        $this->authService = new AuthService();
    }

    public function showlogin()
    {
        require_once __DIR__ . '/../views/auth/login.php';
    }


    public function login()
    {
        session_start();
        if($_SERVER['REQUEST_METHOD']==='POST')
            {
                $email = $_POST['email'] ??'';
                $password= $_POST['password'] ??'';
              $user = $this->authService->authenticate($email, $password);

             if ($user) {
             
                $_SESSION['user_id'] = $user['user_id'];
                $_SESSION['role'] = $user['role'];
                $_SESSION['email'] = $user['email'];

                if ($user['role'] === 'teacher') {
                    header("Location: /teacher/dashboard.php");
                } else {
                    header("Location: /student/dashboard.php");
                }
                exit;
            } else {
                $error = "Email or password incorrect";
                require_once __DIR__ . '/../views/auth/login.php';
            }

                } else{
                    $this->showlogin();
                }

                }

                public function logout()
            {
                session_start();
                session_unset();         
                session_destroy();       
                header("Location: /auth/login.php"); 
                exit;
            }

}
    


?>