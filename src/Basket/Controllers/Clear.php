<?php
namespace Core\Basket\Controllers;

use Core\Controller;
use Core\Basket\Models\Basket;

class Clear extends Controller
{

    public function __invoke($request, $response, $args)
    {
        if (isset($args['id'])) {
            $basket = Basket::singleton();
            $basket->clear();
            $basket->update();
        }
        return $response;
    }
}