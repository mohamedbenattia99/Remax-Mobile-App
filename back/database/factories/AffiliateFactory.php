<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Affiliate;
use App\Model;
use Faker\Generator as Faker;
use Illuminate\Support\Str;

$factory->define(Affiliate::class, function (Faker $faker) {
    $status = $faker->numberBetween(1,2);

    return [
        'last_name' => $faker->lastname,
        'first_name' => $faker->lastname,
        'email' => $faker->unique()->safeEmail,
        'email_verified_at' => now(),
        'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', // password
        'remember_token' => Str::random(10),
        'phone' => $faker->phoneNumber,
        'performance' => $faker->numberBetween(1,5),
        'gender' => $status !== 1 ? 'Male': 'Female',
        'address_id' => function () {
            return \App\Address::inRandomOrder()->first()->id;
        },
        'role_id' => function () {
            return \App\Role::inRandomOrder()->first()->id;
        },
    ];
});
