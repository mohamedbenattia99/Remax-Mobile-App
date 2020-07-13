<?php

use Illuminate\Database\Seeder;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(\App\Order::class, 50)->create()->each(function ($order) {
            // $client->ClientDetails()->save(factory(App\ClientDetails::class)->make());
            $order->orderAddress()->save(factory(\App\OrderAddress::class)->make());
        });
    }
}
