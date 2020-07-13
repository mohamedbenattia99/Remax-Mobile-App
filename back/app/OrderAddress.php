<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class OrderAddress extends UuidModel
{
    protected $fillable = ['zip_code', 'address', 'city','latitude','longitude','municipality','governorate'];

    public function orders()
    {
        return $this->belongsTo(Order::class);
    }

}
