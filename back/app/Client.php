<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Client extends User
{
    protected $table = 'users';
    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            $model->role_id = Role::where('name', 'client')->first()->id;
        });
    }

    public function newQuery()
    {
        $clientRoleId = Role::where('name', 'client')->first()->id;
        return parent::newQuery()
            ->where('role_id', $clientRoleId);
    }

}
