<?php
namespace Tests\Functional;

use Core\Basket\Models\Basket as BasketModel;

class BasketTest extends BaseTestCase
{

    public static function setUpBeforeClass(): void
    {
        parent::setupApp();
    }

    /**
     * Test
     */
    public function testClearBasket()
    {
        $basket = BasketModel::singleton();
        $response = $basket->clear();
        $this->assertTrue($response, 'Basket is cleared');
    }
}