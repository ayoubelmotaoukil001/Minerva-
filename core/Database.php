<?php
<<<<<<< HEAD
namespace core ;
use config\info ;

use PDO ;
use PDOException ;
class Database extends info 
{
   

=======
namespace Core;

use PDO;
use PDOException;

class Database
{
>>>>>>> 48d6fef31b0b213c17e41f5bdca1dea45ebe3bf1
    private static $instance = null;
    private $connection;

    private function __construct()
    {
        try {
            $this->connection = new PDO(
<<<<<<< HEAD
                "mysql:host={$this->server};port={$this->port};dbname={$this->db_name};charset=utf8mb4",
                $this->user,
                $this->password
            );

            $this->connection->setAttribute(
                PDO::ATTR_ERRMODE,
                PDO::ERRMODE_EXCEPTION
            );

        } catch (PDOException $e) {
            die("Database connection error");
=======
                "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET,
                DB_USER,
                DB_PASSWORD,
                [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES => false
                ]
            );
        } catch (PDOException $e) {
            error_log("Erreur de connexion DB: " . $e->getMessage());
            die("Erreur de connexion à la base de données. Veuillez contacter l'administrateur.");
>>>>>>> 48d6fef31b0b213c17e41f5bdca1dea45ebe3bf1
        }
    }

    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function getConnection()
    {
        return $this->connection;
    }
<<<<<<< HEAD
=======

    public function query($sql, $params = [])
    {
        $stmt = $this->connection->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    public function fetch($sql, $params = [])
    {
        return $this->query($sql, $params)->fetch();
    }

    public function fetchAll($sql, $params = [])
    {
        return $this->query($sql, $params)->fetchAll();
    }

    public function lastInsertId()
    {
        return $this->connection->lastInsertId();
    }

    private function __clone()
    {
    }
    public function __wakeup()
    {
        throw new \Exception("Cannot unserialize singleton");
    }
>>>>>>> 48d6fef31b0b213c17e41f5bdca1dea45ebe3bf1
}