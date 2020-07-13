<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class AffiliateDetails extends UuidModel
{
    protected $fillable = ['affiliate_name'];


    public function getUuid()
    {
        return $this->affiliate_id;
    }

    public function affiliate()
    {
        return $this->belongsTo(Affiliate::class);
    }
}
