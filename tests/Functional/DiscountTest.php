<?php
namespace Tests\Functional;

use Core\Basket\Models\Discount;

class DiscountTest extends BaseTestCase
{

    private $discount;

    public static function setUpBeforeClass(): void
    {
        parent::setupApp();
    }

    protected function setUp(): void
    {
        $this->discount = new Discount();
    }

    public function testQuantityPercentDiscount()
    {
        $response = $this->discount->calculateDiscount(1, 3, 10, 3, 33);
        $this->assertEquals(9.9, $response->amount, '% Discount is equal');
        $this->assertEquals(3, $response->discountedQty, '% Discounted quantity');

        $response = $this->discount->calculateDiscount(1, 7, 10, 3, 33);
        $this->assertEquals(19.8, $response->amount, '% Discount is equal');
        $this->assertEquals(6, $response->discountedQty, '% Discounted quantity');
    }

    public function testBuySomeGetSomeFree()
    {
        $response = $this->discount->calculateDiscount(2, 3, 10, 3, 1);
        $this->assertEquals(10, $response->amount, 'BuySomeGetSome Discount is equal');
        $this->assertEquals(3, $response->discountedQty, 'BuySomeGetSome Discounted quantity');

        $response = $this->discount->calculateDiscount(2, 7, 10, 3, 1);
        $this->assertEquals(20, $response->amount, 'BuySomeGetSome Discount is equal');
        $this->assertEquals(6, $response->discountedQty, 'BuySomeGetSome Discounted quantity');
    }

    public function testQuantityForFixPrice()
    {
        $response = $this->discount->calculateDiscount(3, 3, 1.69, 3, 3);
        $this->assertEquals(2.07, $response->amount, 'Fix price Discount is equal');
        $this->assertEquals(3, $response->discountedQty, 'Fix price Discounted quantity');

        $response = $this->discount->calculateDiscount(3, 7, 1.69, 3, 3);
        $this->assertEquals(4.14, $response->amount, 'Fix price Discount is equal');
        $this->assertEquals(6, $response->discountedQty, 'Fix price Discounted quantity');
    }
}