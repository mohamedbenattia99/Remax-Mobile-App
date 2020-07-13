<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Governorate extends UuidModel
{
    protected $fillable = [
        'name'
    ];
    public function municipalities()
    {
        return $this->hasMany(Municipality::class);
    }
}
