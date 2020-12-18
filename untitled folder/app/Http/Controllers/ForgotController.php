<?php

namespace App\Http\Controllers;

use App\Http\Requests\ForgotRequest;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

class ForgotController extends Controller
{
    //

    public function forgot(ForgotRequest $request){
        $email= $request->input('email');

        if(User::where('email',$email)->doesntExist()){
            return response([
                'status' => 'false',
                'message' => 'User does not exist',

            ],
            404);
        }

        $token = Str::random(10);

        try{
        DB::table('password_resets')->insert([
            'email' => $email,
            'token' => $token
        ]);


        Mail::send('Mails.forgot',['token' => $token], function (Message $message) use ($email) {
            $message->to($email);
            $message->subject('Reset your password');
            $message->sender('info@next.pitstopsystems.com');
        });
       

        return response([
            'status' => 'true',
            'message' => 'Check your email!',
            'password_reset_token' => $token
        ]);

        } catch(\Exception $exception){
            return response([
                'message' => $exception ->getMessage()
            ], 400);
        }


    }

    public function reset (Request $request){
        $token = $request-> input('token');

        if(!$passwordResets = DB::table('password_resets')->where('token', $token)->first()){
            return response([
                'status' => 'false',
                'message'=> 'Invalid Token'
            ],400);
        }

        if(!$user =  User::where('email',$passwordResets->email)->first()){
            return response([
                'status' => 'false',
                'message'=> 'User doesnt exist'
            ],404);
        }

        $user->password = Hash::make($request->input('password'));

        $user->save();

        return response([
            'status' => 'true',
            'message' =>'success',
        ]);
    }
}
