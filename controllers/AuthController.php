<?php
namespace controllers ;
use services\AuthService ;
class AuthController
{
    private $authService ;

    private function __construct()
    {
        $this->authService = new AuthService();
    }

    public function showlogin()
    {
        require_once "/../views/auth/login.php" ;
    }


    public function login()
    {
        if($_SERVER['REQUEST_METHOD']==='POST')
            {
                $email = $_POST['email'] ??'';
                $password= $_POST['password'] ??'';
              $user = $this->authService->authenticate($email, $password);

              if($user)
                {
                    session_start() ;
                    $_SESSION['user_id'] = $user['$user_id'] ;
                    $_SESSION['role'] = $user['role'] ;
                    $_SESSION['email'] = $user['email'] ;
                
                if($user['role']==='teacher')
                    {
                        header("loctaion: /teacher/dashboard.php") ;
                    }
                else{
                         header("loctaion: /student/dashboard.php") ;
                    }
                    exit; 
            }else{
                $eror= "email or password incorrect "  ;
                 require_once __DIR__ . '/../views/auth/login.php';
            }
    } else{
        $this->showlogin();
    }

    }
}
    


?>