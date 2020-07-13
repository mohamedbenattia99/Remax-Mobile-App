<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\User;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Lang;
use Illuminate\Support\Facades\Validator;

class ChangePasswordController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    /*
    public function __construct()
    {
        $this->middleware('auth');
    }
    */

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */

    /**
     * Change user
     *
     * @return [json] user object
     */
    //public function store(Request $request)
    //{
        /*$request->validate([
            'current_password' => ['required', new MatchOldPassword],
            'password' => ['required'],
            'password_confirmation' => ['same:password'],
        ]);

        if (User::find($request->id)->update(['password' => Hash::make($request->password_confirmation)])) {
            return response()->json([
                'message' => 'Successfully changed password.'
            ], 200);
        }

        return response()->json([
            'message' => 'Error on changing password'
        ], 500);*/
        public function updatePassword(Request $request)
    {
        if ($request->password == '') {
            return response()->json([
                'error' => 'le champ password  est obligatoire !'
            ], 403);
        } if ($request->old_password == '') {
        return response()->json([
            'error' => 'le champ old_password  est obligatoire !'
        ], 403);
    } if ($request->password_confirmation == '') {
        return response()->json([
            'error' => 'le champ password_confirmed  est obligatoire !'
        ], 403);
    }
        if (Hash::check($request->old_password, Auth::user()->password))
        {
            if ( strcmp($request->password,$request->password_confirmation) != 0)
                return response()->json(['error' => 'Password do not match'], 401);
            $user = User::find(Auth::user()->id);
            $user->password = Hash::make($request->password);
            $user->save();
            return response()->json(['success' => 'Password updated with success']);
        }
        return response()->json(['error' => 'Wrong password'], 401);
    }
}



