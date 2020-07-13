<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */

use App\Model;
use Faker\Generator as Faker;

$factory->define(\App\AffiliateDetails::class, function (Faker $faker) {
    return [
        'affiliate_name' => $faker->city
    ];
});
