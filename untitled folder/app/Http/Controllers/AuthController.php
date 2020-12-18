<?php

namespace App\Http\Controllers;

use App\Http\Requests\RegisterRequest;
use App\Http\Requests\RegistrationRequest;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function login(Request $request){

        try {
            if (Auth::attempt($request->only('email', 'password'))) {
                $user = Auth::user();

                $token = $user->createToken('app')->accessToken;

                return response([
                    'status'=> 'true',
                    'message' => 'success',
                    'token' => $token,
                    'user' => $user
                ]);
            }
        }catch (\Exception $exception){
            return response([
                'status'=> 'false',
                'message'=>$exception->getMessage()
            ],400);
        }

        return response([
            'status'=> 'false',
            'message' => 'invalid username / password'
        ], 401);
    }


    public function user(){
        return Auth::user();
    }

    public function register(Request $request){

        $valid = Validator::make($request->all(), [
            'name' => 'required| max:255',
            'email' => 'required|email|unique:users,email',
            'phone_number' => 'min:11|numeric',
            'password' => 'required| min:8',
            'password_confirm' => 'required| same:password',
        ]);

        if($valid->fails()){
            return response([
                'status' => 'false',
                'message' => $valid->errors()
            ], 401);
        }



        try{
            $user = User::create([
                'name' => $request->input('name'),
                'email' => $request->input('email'),
                'phone_number' => $request->input('phone_number'),
                'password' => Hash::make($request->input('password')),
            ]);
            return response([
                'status' => 'true',
                'message' => 'Created Successfully',
                'user' => $user
            ], 200);
            
        }catch(\Exception $exception){
            return response([
                'status' => 'false',
                'message' => $exception->getMessage()
            ], 400);
        }
    }

}
