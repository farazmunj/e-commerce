<?php
namespace Tests\Functional;

use Core\Basket\Models\Basket;

class BasketTest extends BaseTestCase
{

    private $basket;

    public static function setUpBeforeClass(): void
    {
        parent::setupApp();
    }

    protected function setUp(): void
    {
        $this->basket = Basket::singleton();
    }

    /**
     * Test
     */
    public function testClearBasket()
    {
        $response = $this->basket->clear();
        $this->assertTrue($response, 'Basket is cleared');
    }

    public function testAddToBasket()
    {
        $this->basket->clear();
        $this->basket->add(1, 1);
        $items = $this->basket->getItems();
        $this->assertIsArray($items, 'Basket is array');
        $this->assertEquals(1, sizeof($items), 'Basket size is one');
    }

    public function testProductQtyDiscount()
    {
        $this->basket->clear();
        $this->basket->add(9, 3);
        $items = $this->basket->getItems();
        $this->assertEquals(3, $items[0]->quantity, 'three items in basket');
        $this->basket->calculateDiscount();
    }
}