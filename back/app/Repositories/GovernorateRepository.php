<?php

namespace App\Repositories;

use App\Governorate;

/**
 * Class GovernorateRepository
 * @package App\Repositories
 */
class GovernorateRepository extends CrudRepository
{
    /**
     * GovernorateRepository constructor.
     * @param Governorate $governorate
     */
    public function __construct(Governorate $governorate)
    {
        parent::__construct($governorate);
    }
}
