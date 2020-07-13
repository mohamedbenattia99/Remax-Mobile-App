<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Address;
use Faker\Generator as Faker;

$factory->define(Address::class, function (Faker $faker) {

    return [
        'zip_code' => $faker->postcode,
        'address' => $faker->address,
        'longitude' => $faker->longitude,
        'latitude' => $faker->latitude,
        /*'municipality_id' => function () {
            return \App\Municipality::inRandomOrder()->first()->id;
        },*/
        'municipality'=> $faker->state,
        'governorate'=> $faker->city,
    ];
});
