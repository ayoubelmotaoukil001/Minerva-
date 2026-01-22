<?php
namespace core;

class Router
{
    private array $routes = [];

    public function get($path, $action)
    {
        $this->routes['GET'][$path] = $action;
    }

    public function post($path, $action)
    {
        $this->routes['POST'][$path] = $action;
    }

    public function dispatch()
    {
        $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
        $method = $_SERVER['REQUEST_METHOD'];

        
        $basePath = '/minerva/public';
        if (strpos($uri, $basePath) === 0) {
            $uri = substr($uri, strlen($basePath));
        }

        
        if (empty($uri) || $uri === '/') {
            $uri = '/';
        }

   
        $action = $this->routes[$method][$uri] ?? null;

        if (!$action) {
            http_response_code(404);
            echo '404 - Page not found';
            return;
        }

       
        if (!is_array($action) || count($action) !== 2) {
            die('Invalid action format');
        }

        [$controller, $methodName] = $action;

        
        if (!class_exists($controller)) {
            die("Controller '$controller' not found");
        }

         
        $controller = new $controller();

        
        if (!method_exists($controller, $methodName)) {
            die("Method '$methodName' not found");
        }

                $controller->$methodName();
    }
}