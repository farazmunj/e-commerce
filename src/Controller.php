<?php
namespace Core;

use Psr\Container\ContainerInterface;

class Controller
{

    protected $container;

    protected $database;

    // constructor receives container instance
    public function __construct(ContainerInterface $container)
    {
        echo $container->get('database');
        die();
        $this->container = $container;
        $this->database = $container->get('default')->database;
    }

    public function __invoke($request, $response, $args)
    {
        // your code
        // to access items in the container... $this->container->get('');
        return $response;
    }
}