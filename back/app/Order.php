<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Order extends UuidModel
{

    protected $fillable = [
        'phase',
        'completed',
        //'order_address_id',
        'first_name',
        'last_name',
        'cin', 'email', 'phone',
        'affiliate_id',
        'client_id',
        //'parentCompany_id',
        'gender',
        'agent',
    ];


    public function orderAddress()
    {
        return $this->hasOne(OrderAddress::class);
    }

    public function parentCompany()
    {
        return $this->belongsTo(ParentCompany::class);
    }

    public function affiliate()
    {
        return $this->belongsTo(Affiliate::class);
    }

    public function client()
    {
        return $this->belongsTo(Client::class);
    }
}
