<?php
namespace Tests\Functional;

use Core\Basket\Models\Basket as BasketModel;

class BasketTest extends BaseTestCase
{

    /**
     * Test
     */
    public function testClearBasket()
    {
        $this->setupApp();
        $basket = BasketModel::singleton();
        $response = $basket->clear();
        $this->assertTrue($response, 'Basket is cleared');
    }
}