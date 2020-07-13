<?php

namespace App\Http\Controllers;
use App\Repositories\AddressRepository;

class AddressController extends CrudController
{

    /**
     * AddressController constructor.
     * @param AddressRepository $adressRepository
     */

    public function __construct(AddressRepository $addressRepository)
    {
        $relations = [];
        $orderBy = [];
        $conditions = [];
        $nullConditions = [];
        $whereInConditions = [];
        $selectedAttributes = ['*'];
        parent::__construct($addressRepository, $relations, $orderBy, $conditions, $nullConditions, $whereInConditions, $selectedAttributes);

    }
}
