<?php

namespace App\Repositories;

use App\Affiliate;
use ErrorException;
use Illuminate\Support\Facades\Log;

/**
 * Class AffiliateRepository
 * @package App\Repositories
 */
class AffiliateRepository extends CrudRepository
{
    /**
     * AffiliateRepository constructor.
     * @param Affiliate $affiliate
     */
    public function __construct(Affiliate $affiliate)
    {
        parent::__construct($affiliate);
    }

    public function update(array $pks, array $data)
    {
        try{
            $affiliate = parent::update($pks, $data);
            $affiliate->affiliateDetails->affiliate_name = $data['affiliate_name'];
            $affiliate->affiliateDetails->save();

        } catch (ErrorException $e){
            $affiliate = parent::update($pks, $data);
        }

        return $affiliate->affiliateDetails;
    }

}
