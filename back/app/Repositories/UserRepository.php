<?php

namespace App\Repositories;

use App\User;

/**
 * Class UserRepository
 * @package App\Repositories
 */
class UserRepository extends CrudRepository
{
    /**
     * UserRepository constructor.
     * @param User $user
     */
    public function __construct(User $user)
    {
        parent::__construct($user);
    }
}
