<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Affiliate extends User
{
    protected $table = 'users';

    public function orders()
    {
        return $this->hasMany(Order::class);
    }

    public function affiliateDetails()
    {
        return $this->hasOne(AffiliateDetails::class);
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            $model->role_id = Role::where('name', 'affiliate')->first()->id;
        });

    }

    public function newQuery()
    {
        $adminRoleId = Role::where('name', 'affiliate')->first()->id;
        return parent::newQuery()
            ->where('role_id', $adminRoleId);
    }
}
