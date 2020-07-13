<?php

namespace App\Http\Controllers;

use App\Repositories\GovernorateRepository;

class GovernorateController extends CrudController
{

    /**
     * GovernorateController constructor.
     * @param GovernorateRepository $governorateRepository
     */

    public function __construct(GovernorateRepository $governorateRepository)
    {

            $relations = [
                'municipalities'
            ];
            $orderBy = [];
            $conditions = [];
            $nullConditions = [];
            $whereBetweenConditions = [];
            $selectedAttributes = ['*'];
            parent::__construct($governorateRepository, $relations, $orderBy, $conditions, $nullConditions, $whereBetweenConditions, $selectedAttributes);

    }
}
