<?php

namespace App\Repositories;

use App\Address;

/**
 * Class AddressRepository
 * @package App\Repositories
 */
class AddressRepository extends CrudRepository
{
    /**
     * AddressRepository constructor.
     * @param Address $address
     */
    public function __construct(Address $address)
    {
        parent::__construct($address);
    }
}
