<?php
namespace Core\Basket\Controllers;

use Core\Controller;
use Core\Basket\Models\Basket;

class Add extends Controller
{

    public function __invoke($request, $response, $args)
    {
        if (isset($args['id'])) {
            $basket = Basket::singleton();
            $basket->add((int) $args['id']);
            $basket->update();
        }
        return $response;
    }
}