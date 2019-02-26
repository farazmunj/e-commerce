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
    }

    public function update()
    {
        $this->save();
    }

    private function save()
    {
        foreach ($this->items as $item) {
            if (isset($item->updated)) {
                unset($item->updated);
                if (null === $item->id) {
                    $this->database->insert((array) $item)
                        ->into($this->table)
                        ->execute(false);
                } else {
                    $this->database->update((array) $item)
                        ->table($this->table)
                        ->where('id', '=', $item->id)
                        ->execute();
                }
            }
        }
    }
}

