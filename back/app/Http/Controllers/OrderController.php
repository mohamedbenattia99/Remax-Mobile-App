<?php

namespace App\Http\Controllers;

use App\Affiliate;
use App\AffiliateDetails;
use App\Order;
use App\ParentCompany;
use App\Repositories\OrderRepository;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class OrderController extends CrudController
{

    /**
     * OrderController constructor.
     * @param OrderRepository $orderRepository
     */

    public function __construct(OrderRepository $orderRepository)
    {
        {
            $relations = [
                'parentCompany','affiliate.affiliateDetails','client','orderAddress'
            ];
            $orderBy = [];
            $conditions = [];
            $nullConditions = [];
            $whereBetweenConditions = [];
            $selectedAttributes = ['*'];
            parent::__construct($orderRepository, $relations, $orderBy, $conditions, $nullConditions, $whereBetweenConditions, $selectedAttributes);
        }
    }
    public function store(Request $request)
    {
        $parent_company_all = ParentCompany::all();
        //$test = ParentCompany::find(1);
        //echo $parent_company_all;
        $parent_company = $parent_company_all[0];
        //echo $parent_company[0];
        $parent_company_id = $parent_company->id;
        //echo  $parent_company_id;
        $order = new Order([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'phase' => $request->phase,
            'completed' => $request->completed,
            'cin' => $request->cin,
            'email' => $request->email,
            'phone' => $request->phone,
            'affiliate_id' => $request->affiliate_id,
            'client_id' => $request->client_id,
            'gender' => $request->gender,
            'agent' => $request->agent,
            //'order_address_id' => $request->order_address_id,
            //'parent_company_id' => $parent_company_id
        ]);
        $order_adress = [
            'zip_code' => $request->zip_code,
            'address' => $request->address,
            'municipality'=>$request->municipality,
            'governorate'=> $request->governorate,
            'latitude'=>$request->latitude,
            'longitude'=>$request->longitude,

        ];
        DB::beginTransaction(); //Start transaction!

        try {

            $order->save();
            Log::info(Affiliate::find($order));
            $order->orderAddress()->create($order_adress);
            $order->parentCompany()->associate($parent_company);
            $order->save();
            DB::commit();
            return response()->json([
                'message' => 'Successfully created order!',
            ], 201);
        } catch (\Exception $e) {
            DB::rollback();
            throw $e;

        }

    }
    public function destroy ($id) {
        DB::beginTransaction(); //Start transaction!
        /*echo $id;
        $order = DB::table('orders')->where('id', '=',$id)->get();
        print_r($order);*/
        $order =Order::where('id',$id)->first();
        $orderAddress = $order->orderAddress();
        $orderAddress->delete();
        $order->save();
        DB::commit();

        //print_r ($orderAdress);
        /*$orderAddress =$order->orderAddress();
        $orderAddress->delete();
        $order->delete();*/


        return parent::destroy($id);
    }

    public function getAllOrdersNotAssigned(Request $request)
    {

        $this->nullConditions = array_merge
        (
            $this->nullConditions,
            [
                'affiliate_id' => true,
                'client_id' => true
            ]
        );
        return parent::index($request);

    }

    public function getClientOrders(Request $request, $client_id)
    {
        $this->conditions = array_merge($this->conditions, ['client_id' => $client_id]);
        return parent::index($request);
    }

    public function getAffiliateOrders(Request $request, $affiliate_id)
    {
        $this->conditions = array_merge($this->conditions, ['affiliate_id' => $affiliate_id]);
        return parent::index($request);
    }

    public function getParentCompanyOrders(Request $request, $parentCompany_id)
    {
        $this->conditions = array_merge($this->conditions, ['parentCompany_id' => $parentCompany_id]);
        return parent::index($request);
    }

    public function assignOrderToAffilite(Request $request, $order_id, $affiliate_name)
    {

        // $role = Role::findOrFail(auth()->user()->role_id);
        $affiliate_details = AffiliateDetails::where(
            ['affiliate_name' => $affiliate_name]
        )->first();
        $affiliate_id = $affiliate_details->getUuid();

        // $request->affiliate_id = $affiliate_id;
        // $request->request->add(['affiliate_id', $affiliate_id]);
        $request->merge(['affiliate_id' => $affiliate_id]);
        // print $affiliate_id;
        return parent::update($request, $order_id);
    }
    public function getOrderByCode(Request $request,$code)
    {
        $this->conditions = array_merge($this->conditions, ['code' => $code]);
        return parent::index($request);
    }

    public function getOrderByDate(Request $request)
    {
        $this->orderBy = array_merge($this->orderBy, ['created_at' => 'DESC']);
        return parent::index($request);
    }

}
