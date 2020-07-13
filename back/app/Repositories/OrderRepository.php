<?php

namespace App\Repositories;

use App\Order;

/**
 * Class OrderRepository
 * @package App\Repositories
 */
class OrderRepository extends CrudRepository
{
    /**
     * OrderRepository constructor.
     * @param Order $order
     */
    public function __construct(Order $order)
    {
        parent::__construct($order);
    }



    /*
    public function update(array $pks, array $data)
    {
        $order = parent::update($pks, $data);
        $order->orderAddress()->update($data['order_address']);
        return $order->orderAddress;
    }*/

}
