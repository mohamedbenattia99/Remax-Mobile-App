<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use Faker\Generator as Faker;
use \App\OrderAddress;

$factory->define(OrderAddress::class, function (Faker $faker) {
    return [
        'id'=>$faker->uuid,
        'zip_code'=>$faker->postcode,
        'address'=>$faker->address,
        'longitude' => $faker->longitude,
        'latitude' => $faker->latitude,
        'order_id' => function () {
            return \App\Order::inRandomOrder()->first()->id;
        },
        'municipality'=> $faker->state,
        'governorate'=> $faker->city,
    ];

});
