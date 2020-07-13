<?php

namespace App\Http\Controllers;

use App\Address;
use App\Client;
use App\Repositories\ClientRepository;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ClientController extends CrudController
{

    /**
     * ClientController constructor.
     * @param ClientRepository $clientRepository
     */

    public function __construct(ClientRepository $clientRepository)
    {
        $relations = ['orders'];
        $orderBy = [];
        $conditions = [];
        $nullConditions = [];
        $whereBetweenConditions = [];
        $selectedAttributes = ['*'];
        parent::__construct($clientRepository, $relations, $orderBy, $conditions, $nullConditions, $whereBetweenConditions, $selectedAttributes);

    }

    public function store(Request $request)
    {
        if ($request->first_name == '') {
            return response()->json([
                'error' => 'le champ prénom  est obligatoire !'
            ], 403);
        }
        if ($request->last_name == '') {
            return response()->json([
                'error' => 'le champ nom  est obligatoire !'
            ], 403);
        }
        if ($request->email == '') {
            return response()->json([
                'error' => 'le champ email  est obligatoire !'
            ], 403);
        }
        if ($request->phone == '') {
            return response()->json([
                'error' => 'le champ phone  est obligatoire !'
            ], 403);
        }
        if ($request->password == '') {
            return response()->json([
                'error' => 'le champ password  est obligatoire !'
            ], 403);
        }
        if ($request->gender == '') {
            return response()->json([
                'error' => 'le champ gender  est obligatoire !'
            ], 403);
        }


        $client = new Client([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'phone' => $request->phone,
            'performance' => $request->performance,
            'gender' => $request->gender,
            'password' => bcrypt($request->password)
        ]);
        $address = [
            'zip_code' => $request->zip_code,
            'municipality' => $request->municipality,
            'governorate' => $request->governorate,
            'address' => $request->address,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
        ];

        DB::beginTransaction(); //Start transaction!

        try {
            //saving logic here
            $client->save();
            //Log::info('hereeeeeeee');
            //Log::info(Affiliate::find($affiliate));
            $address_model = Address::create($address);
            $client->address()->associate($address_model);
            DB::commit();
            return response()->json([
                'message' => 'Successfully created user!',
                'role'=> 'client',
            ], 201);
        } catch (\Exception $e) {
            //failed logic here
            DB::rollback();
            throw $e;

        }


    }
}
