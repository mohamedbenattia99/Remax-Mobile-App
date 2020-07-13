<?php

namespace App\Http\Controllers;

use App\Repositories\UserRepository;

class UserController extends CrudController
{

    /**
     * UserController constructor.
     * @param UserRepository $userRepository
     */

    public function __construct(UserRepository $userRepository)
    {
        $relations = ['role','address'];
        $orderBy = [];
        $conditions = [];
        $nullConditions = [];
        $whereBetweenConditions = [];
        $selectedAttributes = ['*'];
        parent::__construct($userRepository, $relations, $orderBy, $conditions, $nullConditions, $whereBetweenConditions, $selectedAttributes);

    }
}
