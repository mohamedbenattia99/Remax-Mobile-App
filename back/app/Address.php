<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Address extends UuidModel
{
    protected $fillable = [
        'zip_code',
        'municipality',
        'municipality_id',
        'governorate',
        'address',
        'city',
        'latitude',
        'longitude',
    ];

    public function user()
    {
        return $this->hasOne(User::class);
    }
    /*
    public function municipality()
    {
        return $this->belongsTo(Municipality::class);
    }
    */



}
