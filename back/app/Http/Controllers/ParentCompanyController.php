<?php

namespace App\Http\Controllers;

use App\Client;
use App\Repositories\ParentCompanyRepository;
use Illuminate\Http\Request;

class ParentCompanyController extends CrudController
{

    /**
     * ParentCompanyController constructor.
     * @param ParentCompanyRepository $parentCompanyRepository
     */

    public function __construct(ParentCompanyRepository $parentCompanyRepository)
    {
        $relations = [];
        $orderBy = [];
        $conditions = [];
        $nullConditions = [];
        $whereBetweenConditions = [];
        $selectedAttributes = ['*'];
        parent::__construct($parentCompanyRepository, $relations, $orderBy, $conditions, $nullConditions, $whereBetweenConditions, $selectedAttributes);
    }

}
