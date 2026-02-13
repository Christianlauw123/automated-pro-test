<?php

namespace App\Http\Controllers\V1;

use App\Helpers\ResponseHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\AuthRequest;
use App\Http\Requests\SignUpRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function register(SignUpRequest $request){
        $user = new User();
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password = Hash::make($request->password);
        $user->phone = $request->phone;
        if($request->role)
            $user->role = $request->role;
        $user->save();
        return ResponseHelper::success($user,'Register successful', 200);
    }

    public function login(AuthRequest $request){
        if (!Auth::attempt($request->only('email', 'password'))) {
            return ResponseHelper::error('Invalid credentials', null, 401);
        }

        $user = User::where('email', $request->email)->first();
        $token = $user->createToken('api-token')->plainTextToken;

        return ResponseHelper::success(
            [
                'token' => $token,
                'token_type' => 'Bearer',
                'user' => $user
            ]
        , 'Login successful', 200);
    }

    public function logout(Request $request){
        $request->user()->currentAccessToken()->delete();
        return ResponseHelper::success(null,'Logout successful', 200);
    }

    public function me(Request $request){
        return ResponseHelper::success($request->user(),'Me Retrieved', 200);
    }
}
