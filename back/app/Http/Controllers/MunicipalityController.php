<?php

namespace App\Http\Controllers;

use App\Repositories\MunicipalityRepository;

class MunicipalityController extends CrudController
{

    /**
     * MunicipalityController constructor.
     * @param MunicipalityRepository $municipalityRepository
     */

    public function __construct(MunicipalityRepository $municipalityRepository)
    {
        $relations = [
            'municipalities'
        ];
        $orderBy = [];
        $conditions = [];
        $nullConditions = [];
        $whereBetweenConditions = [];
        $selectedAttributes = ['*'];
        parent::__construct($municipalityRepository, $relations, $orderBy, $conditions, $nullConditions, $whereBetweenConditions, $selectedAttributes);

    }
}
