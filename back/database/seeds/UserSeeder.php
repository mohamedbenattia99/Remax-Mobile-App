<?php

use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(\App\ParentCompany::class, 1)->create();
        factory(\App\Affiliate::class, 14)->create()->each(function ($client) {
            $client->affiliateDetails()->save(factory(\App\AffiliateDetails::class)->make());
        });
        factory(\App\Client::class, 3)->create();

    }
}
