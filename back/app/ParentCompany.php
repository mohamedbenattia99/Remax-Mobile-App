<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ParentCompany extends User
{
    protected $table = 'users';

    public function getUuid()
    {
        return $this->id;
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            $model->role_id = Role::where('name', 'parent_company')->first()->id;
        });
    }

    public function newQuery()
    {
        $adminRoleId = Role::where('name', 'parent_company')->first()->id;
        return parent::newQuery()
            ->where('role_id', $adminRoleId);
    }
}
