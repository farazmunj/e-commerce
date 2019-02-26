<?php
use Slim\Http\Request;
use Slim\Http\Response;

// Routes
$app->group('/product', function () use ($app) {
    $app->get('/{id}', \Core\Product\Get::class);
});

$app->group('/basket', function () use ($app) {
    $app->get('/add/{id}', \Core\Basket\Controllers\Add::class);
});

$app->get('/[{name}]', function (Request $request, Response $response, array $args) {
    // Sample log message
    $this->logger->info("Slim-Skeleton '/' route");

    // Render index view
    return $this->renderer->render($response, 'index.phtml', $args);
});

