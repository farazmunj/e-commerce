<?php
namespace Core\Product;

class Add extends \Core\Controller
{

    function __invoke($request, $response, $args)
    {
        $return = [];
        $productId = (int) $args['id'];
        // get product from DB
        $statement = $this->database->select()
            ->from('Product')
            ->where('id', '=', $productId);
        $stmt = $statement->execute();
        $return['product'] = $stmt->fetch();
        if ($return['product']) {
            // get product unit from DB
            $statement = $this->database->select()
                ->from('ProductUnit')
                ->where('id', '=', $return['product']['unitId']);
            $stmt = $statement->execute();
            $return['unit'] = $stmt->fetch();

            // get product discounts
            $productDiscount = [];
            $stmt = $this->database->select()
                ->from('ProductDiscount')
                ->where('productId', '=', $productId)
                ->execute();

            while ($discount = $stmt->fetch()) {
                // fetch discount type;
                $stmtDisc = $this->database->select()
                    ->from('DiscountType')
                    ->where('id', '=', $discount['discountTypeId'])
                    ->execute();
                $discType = $stmtDisc->fetch();

                $stmtDiscQty = $this->database->select()
                    ->from('ProductDiscountQty')
                    ->where('productDiscountId', '=', $discount['id'])
                    ->execute();
                $discDiscQty = $stmtDiscQty->fetchAll();

                $productDiscount[] = [
                    'Discount' => $discount,
                    'DiscountType' => $discType,
                    'DiscountQty' => $discDiscQty
                ];
            }
            $return['productDiscount'] = $productDiscount;

            // find all group product belongs too
            $groupDiscount = [];
            $stmtGroups = $this->database->select()
                ->from('GroupProduct')
                ->where('productId', '=', $productId)
                ->execute();
            while ($group = $stmtGroups->fetch()) {
                // fetch goup name
                $stmtGroupName = $this->database->select()
                    ->from('system_core.Group')
                    ->where('id', '=', $group['groupId'])
                    ->execute();
                $groupName = $stmtGroupName->fetch();
                // get product discounts
                $productGroupDiscount = [];
                $stmt = $this->database->select()
                    ->from('GroupDiscount')
                    ->where('groupId', '=', $group['groupId'])
                    ->execute();

                while ($discount = $stmt->fetch()) {
                    // fetch discount type;
                    $stmtDisc = $this->database->select()
                        ->from('DiscountType')
                        ->where('id', '=', $discount['discountTypeId'])
                        ->execute();
                    $discType = $stmtDisc->fetch();

                    $stmtDiscQty = $this->database->select()
                        ->from('GroupDiscountQty')
                        ->where('GroupDiscountId', '=', $discount['id'])
                        ->execute();
                    $discDiscQty = $stmtDiscQty->fetchAll();

                    $productGroupDiscount[] = [
                        'Discount' => $discount,
                        'DiscountType' => $discType,
                        'DiscountQty' => $discDiscQty
                    ];
                }

                $groupDiscount[] = [
                    'GroupName' => $groupName,
                    'Discounts' => $productGroupDiscount
                ];
            }

            $return['groupDsicount'] = $groupDiscount;
        }

        return $response->withJson($return);
    }
}