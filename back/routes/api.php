<?php


use Illuminate\Http\Request;

// skander commentaire
//hello

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::resource('/user', 'UserController')->except(['edit', 'create','delete']);


Route::get('/address/search', 'AddressController@search');
Route::get('/assing_order_to_affiliate/{order_id}/{affiliate_name}', 'OrderController@assignOrderToAffilite');
Route::resource('/address', 'AddressController')->except(['edit', 'create']);

Route::resource('/municipality', 'MunicipalityController')->except(['edit', 'create']);
Route::resource('/governorate', 'GovernorateController')->except(['edit', 'create']);



Route::get('/order/search', 'OrderController@search');
Route::get('order/get_orders_not_assigned', 'OrderController@getAllOrdersNotAssigned');
Route::get('/order/client/{client_id}', 'OrderController@getClientOrders');
Route::get('/order/affiliate/{affiliate_id}', 'OrderController@getAffiliateOrders');
Route::get('/order/parent_company/{parentCompany_id}', 'OrderController@getParentCompanyOrders');
Route::get('/order/code/{code}', 'OrderController@getOrderByCode');
Route::get('/order/sort/date', 'OrderController@getOrderByDate');
Route::resource('/order', 'OrderController')->except(['edit', 'create']);

//Route::get('path', 'ClassController@methodName'); for a only 1 method in a controller we use this.

Route::get('order/get_orders_not_assigned', 'OrderController@getAllOrdersNotAssigned');
Route::group([
    'prefix' => 'auth'
], function () {
    Route::post('login', 'AuthController@login');
    Route::post('signup/client', 'ClientController@store');
    Route::post('signup/affiliate', 'AffiliateController@store');


    Route::group([
        'middleware' => 'auth:api'
    ], function () {
        Route::get('logout', 'AuthController@logout');
        Route::get('user', 'AuthController@user');
        Route::post('change-password', 'ChangePasswordController@updatePassword');
    });
});

Route::get('/parent_company/search', 'ParentCompanyController@search');
Route::resource('/parentcompany', 'ParentCompanyController')->except(['edit', 'create']);

Route::get('/client/search', 'ClientController@search');
Route::resource('/client', 'ClientController')->except(['edit', 'create', 'store']);

Route::get('/affiliate/search', 'AffiliateController@search');
Route::get('/affiliate/sort/performance', 'AffiliateController@getAffiliateByPerformance');
Route::resource('/affiliate', 'AffiliateController')->except(['create','edit']);



