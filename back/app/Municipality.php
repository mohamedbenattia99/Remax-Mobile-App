<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Municipality extends UuidModel
{
    protected $fillable = [
        'name',
        'governorate_id'
    ];
    public function governorate()
    {
        return $this->belongsTo(Governorate::class);
    }
    /*
    public function addresses()
    {
        return $this->hasMany(Address::class);
    }
    */
}
