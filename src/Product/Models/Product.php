<?php
namespace Core\Product\Models;

use Slim;

class Product
{

    private $id;

    /**
     *
     * @var Slim\PDO\Database
     */
    private $database;

    public function __construct($id = null)
    {
        $this->id = $id;
        global $app;
        $this->database = $app->getContainer()->get('database');
    }

    public function get()
    {
        return $this->database->select()
            ->from('Product')
            ->where('id', '=', $this->id)
            ->execute()
            ->fetchObject();
    }
}