<?php

namespace App\Http\Controllers;

use App\Repositories\KhlilRepository;

class KhlilController extends CrudController
{

    /**
     * KhlilController constructor.
     * @param KhlilRepository $khlilRepository
     */

    public function __construct(KhlilRepository $khlilRepository)
    {
        $relations = [''];
        parent::__construct($khlilRepository, $relations);
    }
}
