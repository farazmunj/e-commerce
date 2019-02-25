<?php
namespace Core\Product;

class Add extends \Core\Controller
{

    function __invoke($request, $response, $args)
    {
        // Update book identified by $args['id']
        $statement = $this->database->select()
            ->from('Product')
            ->where('id', '=', 1);
        $stmt = $statement->execute();
        $data = $stmt->fetch();
        // print_r($data);
        return $response->withJson($data);
    }
}