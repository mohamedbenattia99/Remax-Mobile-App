<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Order;
use Faker\Generator as Faker;

$factory->define(Order::class, function (Faker $faker) {
    $status = $faker->numberBetween(1,2);
    $status2 = $faker->numberBetween(0, 4);
    $status3 = $faker->numberBetween(0, 4);
    return [
        'id' => $faker->uuid,
        'phase'=> $faker->numberBetween(1,4),
        'completed'=>$faker->boolean(50),

        'first_name'=>$faker->firstName,
        'last_name'=>$faker->lastName,
        'cin'=>$faker->word,
        'email'=>$faker->email,
        'phone'=>$faker->phoneNumber,
        //'address'=>$faker->address,
        'gender'=> $status !==1 ? 'Female' : 'Male',
        'agent'=> $faker->name,

        /*'order_address_id' => function () {
            return \App\OrderAddress::inRandomOrder()->first()->id;
        },*/
        'parent_company_id' => function () {
        return \App\ParentCompany::inRandomOrder()->first()->id;
        },
        'affiliate_id' => $status2 !== 1 ? function () {
        return \App\Affiliate::inRandomOrder()->first()->id;
        } : null,
        'client_id' => $status3 !== 1 ? function () {
        return \App\Client::inRandomOrder()->first()->id;
        } : null,
    ];

});
