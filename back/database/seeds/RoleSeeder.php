<?php

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $roles = ['parent_company', 'client', 'affiliate'];
        foreach ($roles as $role) {
            \App\Role::updateOrCreate(['name' => $role], ['name' => $role]);
        }
    }
}
