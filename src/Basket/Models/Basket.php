<?php
namespace Core\Basket\Models;

use Core\Product\Models\Product;

class Basket
{

    /**
     *
     * @var \Slim\PDO\Database
     */
    private $database;

    private $sessionId;

    private $items = [];

    private $discounts = [];

    private static $instance;

    private $table = 'Basket';

    private $tableDiscount = 'BasketDiscount';

    private $total = 0;

    private function __construct()
    {
        global $app;
        $this->database = $app->getContainer()->get('database');
        $this->sessionId = session_id();
        $this->items = $this->database->select()
            ->from($this->table)
            ->where('sessionId', '=', $this->sessionId)
            ->execute()
            ->fetchAll(\PDO::FETCH_OBJ);
    }

    /**
     *
     * @return \Core\Basket\Models\Basket
     */
    public static function singleton()
    {
        if (null === self::$instance) {
            self::$instance = new Basket();
        }
        return self::$instance;
    }

    public function add(int $productId, int $qty = 1)
    {
        $updatedQty = false;
        // check if we already have it in basket then update quantity else add new
        foreach ($this->items as &$item) {
            if ($item->id === $productId) {
                $item->quantity += $qty;
                $item->updated = true;
                $updatedQty = true;
            }
        }
        unset($item); // kill pointer/refrence
        if (! $updatedQty) {
            $product = (new Product($productId))->get();
            $this->items[] = (object) [
                'id' => null,
                'sessionId' => $this->sessionId,
                'productId' => $productId,
                'quantity' => $qty,
                'unitPrice' => $product->price,
                'total' => $product->price * $qty,
                'updated' => true
            ];
        }
    }

    public function clear()
    {
        $this->database->delete($this->table)
            ->where('sessionId', '=', $this->sessionId)
            ->execute();
        $this->database->delete($this->tableDiscount)
            ->where('sessionId', '=', $this->sessionId)
            ->execute();
        $this->items = [];
        $this->discounts = [];
        $this->total = 0;
        return true;
    }

    public function update()
    {
        $this->save();
    }

    public function getItems()
    {
        return $this->items;
    }

    public function getDiscount()
    {
        return $this->discounts;
    }

    public function calculateDiscount()
    {
        $this->calculateProductDiscount();
    }

    private function calculateProductDiscount()
    {
        // calculate product Discount
        $discountObj = new Discount();
        foreach ($this->items as &$item) {
            $stmt = $this->database->select()
                ->from('ProductDiscount')
                ->join('ProductDiscountQty', 'ProductDiscount.id', '=', 'ProductDiscountQty.productDiscountId')
                ->where('ProductDiscount.productId', '=', $item->productId)
                ->where('ProductDiscountQty.quantity', '<=', $item->quantity)
                ->where('ProductDiscount.active', '=', 1)
                ->orderBy('ProductDiscountQty.quantity', 'ASC')
                ->execute();
            while ($discount = $stmt->fetch(\PDO::FETCH_OBJ)) {
                $discCalculated = $discountObj->calculateDiscount($discount->discountTypeId, $item->quantity, $item->unitPrice, $discount->quantity, $discount->discount);
                $this->discounts[] = $discCalculated;
            }
        }
        unset($item); // kill pointer/refrence
    }

    private function save()
    {
        foreach ($this->items as &$item) {
            if (isset($item->updated)) {
                unset($item->updated);
                if (null === $item->id) {
                    $item->id = $this->database->insert((array) $item)
                        ->into($this->table)
                        ->execute();
                } else {
                    $this->database->update((array) $item)
                        ->table($this->table)
                        ->where('id', '=', $item->id)
                        ->execute();
                }
            }
        }
        unset($item); // kill pointer/refrence
    }
}

