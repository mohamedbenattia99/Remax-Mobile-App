<?php

namespace App\Repositories;

use App\ParentCompany;

/**
 * Class ParentCompanyRepository
 * @package App\Repositories
 */
class ParentCompanyRepository extends CrudRepository
{
    /**
     * ParentCompanyRepository constructor.
     * @param ParentCompany $parentCompany
     */
    public function __construct(ParentCompany $parentCompany)
    {
        parent::__construct($parentCompany);
    }
}
