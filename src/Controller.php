<?php
namespace Core;

use Psr\Container\ContainerInterface;

class Controller
{

    protected $container;

    /**
     *
     * @var \Slim\PDO\Database
     */
    protected $database;

    // constructor receives container instance
    public function __construct(ContainerInterface $container)
    {
        $this->container = $container;
        $this->database = $container->get('database');
    }

    public function __invoke($request, $response, $args)
    {
        // your code
        // to access items in the container... $this->container->get('');
        return $response;
    }
}