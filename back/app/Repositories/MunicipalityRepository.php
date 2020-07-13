<?php

namespace App\Repositories;

use App\Municipality;

/**
 * Class MunicipalityRepository
 * @package App\Repositories
 */
class MunicipalityRepository extends CrudRepository
{
    /**
     * MunicipalityRepository constructor.
     * @param Municipality $municipality
     */
    public function __construct(Municipality $municipality)
    {
        parent::__construct($municipality);
    }
}
