<?php
namespace Core\Basket\Models;

class Discount
{

    public function calculateDiscount($discountType, $basketQty, $unitPrice, $discountQty, $discountDiscount)
    {
        /**
         * '1', 'Quanity % discount', 'p', 'Buy {quantity}, get {quantity}% discount'
         * '2', 'Quantity discount', 'd', 'Buy {quantity}, get {quantity} free'
         * '3', 'quantity for fix price', 'f', 'Buy {quantity} for {quantity}'
         */
        switch ($discountType) {
            case 1:
                return $this->quantityPercentDiscount($basketQty, $unitPrice, $discountQty, $discountDiscount);
                break;
            case 2:
                return $this->buySomeGetSomeFree($basketQty, $unitPrice, $discountQty, $discountDiscount);
                break;
            case 3:
                return $this->quantityForFixPrice($basketQty, $unitPrice, $discountQty, $discountDiscount);
                break;
            default:
                break;
        }
    }

    private function quantityPercentDiscount($basketQty, $unitPrice, $discountQty, $discountDiscount)
    {
        // calculate if user can get multi disount e.g. 3 for 10%, 6 for 10% but 5 will get 3 for 10% only
        if ($basketQty >= $discountQty) {
            $fixNumber = (int) ($basketQty / $discountQty);
            $label = "Buy {$discountQty} get {$discountDiscount}% discount";
            if ($fixNumber > 1) {
                $label = "{$fixNumber} x {$label}";
            }
            $discountedQty = $fixNumber * $discountQty;
            $originalAmount = $unitPrice * $discountedQty;
            $discountedAmount = $originalAmount * ($discountDiscount / 100);

            return $this->returnDiscount($discountedAmount, $discountedQty, $label);
        }
    }

    private function buySomeGetSomeFree($basketQty, $unitPrice, $discountQty, $discountDiscount)
    {
        // calculate if user can get multi disount e.g. 3 for 10%, 6 for 10% but 5 will get 3 for 10% only
        if ($basketQty >= $discountQty) {
            $fixNumber = (int) ($basketQty / $discountQty);
            $label = "Buy {$discountQty} get {$discountDiscount} free";
            if ($fixNumber > 1) {
                $label = "{$fixNumber} x {$label}";
            }
            $discountedAmount = $unitPrice * $fixNumber;
            $discountedQty = $fixNumber * $discountQty;
            return $this->returnDiscount($discountedAmount, $discountedQty, $label);
        }
    }

    private function quantityForFixPrice($basketQty, $unitPrice, $discountQty, $discountDiscount)
    {
        if ($basketQty >= $discountQty) {
            $fixNumber = (int) ($basketQty / $discountQty);
            $label = "Buy {$discountQty} for {$discountDiscount} NOK";
            if ($fixNumber > 1) {
                $label = "{$fixNumber} x {$label}";
            }
            $discountedQty = $fixNumber * $discountQty;
            $originalAmount = $unitPrice * $discountedQty;
            $discountedAmount = $discountDiscount * $fixNumber;
            $dicsount = $originalAmount - $discountedAmount;
            return $this->returnDiscount($dicsount, $discountedQty, $label);
        }
    }

    private function returnDiscount($amount, $discountedQty, $label)
    {
        return (object) [
            'amount' => $amount,
            'discountedQty' => $discountedQty,
            'label' => $label
        ];
    }
}