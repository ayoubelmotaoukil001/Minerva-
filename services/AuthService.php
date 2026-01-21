<?php
namespace services ;
use core\Database ;
use PDO;

class AuthService
{
    private $connection ;   
    public function __construct()
    {
        $this->connection =Database::getInstance()->getConnection();
        }   
        
        
        public function authenticate($email,$password)
        {
            $stm = $this->connection->prepare("select *from users where email = ?");
            $stm->execute([$email]) ;
            $users = $stm->fetch(PDO::FETCH_ASSOC) ;
            if($users && password_verify($password  ,$users['password'])) 
            {
              return $users ;  
            }    
            return false ;
        }

    public function createUser($email ,$password ,$role)
    {
        $hash = password_hash($password,PASSWORD_DEFAULT) ;
        $stm = $this->connection->prepare("insert into users (email, password, role) values(?,?,?)");
        $stm->execute([$email,$hash,$role]) ;
    }
}

?>