<?php

namespace App\Http\Controllers;

use App\Address;
use App\Affiliate;
use App\AffiliateDetails;
use App\Repositories\AffiliateRepository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class AffiliateController extends CrudController
{

    /**
     * AffiliateController constructor.
     * @param AffiliateRepository $repository
     */

    public function __construct(AffiliateRepository $repository)
    {
        $relations = ['affiliateDetails','address','orders'];
        $orderBy = [];
        $conditions = [];
        $nullConditions = [];
        $whereBetweenConditions = [];
        $selectedAttributes = ['*'];
        parent::__construct($repository, $relations, $orderBy, $conditions, $nullConditions, $whereBetweenConditions, $selectedAttributes);
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


        if ($request->affiliate_name == '') {
            return response()->json([
                'error' => 'le champ affiliate name  est obligatoire !'
            ], 403);
        }

        $affiliate = new Affiliate([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'phone' => $request->phone,
            'performance' => $request->performance,
            'password' => bcrypt($request->password),
            'gender' => $request->gender
        ]);

        $affiliateDetails = [
            'affiliate_name' => $request->affiliate_name
        ];
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
            $affiliate->save();
            //Log::info('hereeeeeeee');
            //Log::info(Affiliate::find($affiliate));

            $affiliate->affiliateDetails()->create($affiliateDetails);
            $address_model = Address::create($address);
            $affiliate->address()->associate($address_model);
            $affiliate->address->id = $address_model->id ;
            $affiliate->address->save();
            $affiliate->save();
            DB::commit();
            return response()->json([
                'message' => 'Successfully created user!',
                'role'=> 'affiliate',
            ], 201);
        } catch (\Exception $e) {
            //failed logic here
            DB::rollback();
            throw $e;

        }
    }

    public function getAffiliateByPerformance(Request $request)
    {
        $this->orderBy = array_merge($this->orderBy, ['performance' => 'DESC']);
        return parent::index($request);
    }
}
