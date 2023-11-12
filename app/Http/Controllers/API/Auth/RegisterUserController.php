<?php

namespace App\Http\Controllers\API\Auth;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class RegisterUserController extends Controller
{
    public function registerUserApi(Request $request)
    {
       try {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required|string|min:8',
            'NationNum' => 'required',
            'FullName' => 'required',
            'Address' => 'required',
            'PhoneNum' => 'required',
            'Gender' => 'required',
            'Birthdate' => 'required',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $role = Role::where('name', 'Customer')->first();
       $user->save();

        if ($role && $user) {
            $user->assignRole($role);

            $customer = Customer::create([
                'NationNum' => $request->NationNum,
                'FullName' => $request->FullName,
                'Address' => $request->Address,
                'PhoneNum' => $request->PhoneNum,
                'Gender' => $request->Gender,
                'Birthdate' => $request->Birthdate,
                'user_id' => $user->id,
            ]);

            return response()->json([
                'message' => 'Registration successfully',
                'user' => $user,
                'customer' => $customer,
            ], 201);
        }

        return response()->json([
            'message' => 'Failed to create customer',
        ], 422);

       } catch (\Throwable $th) {
        $user->delete();
        return response()->json([
            'message' => 'Failed to create customer',
        ], 422);
       }
    }

    public function createCustomerApi(Request $request)
{
    $request->validate([
        'NationNum' => 'required',
        'FullName' => 'required',
        'Address' => 'required',
        'PhoneNum' => 'required',
        'Gender' => 'required',
        'Birthdate' => 'required',
    ]);

    $role = Role::where('name', 'Customer')->first();
    $user_id = User::latest()->value('id');
    $user = User::find($user_id);

    if ($role && $user) {
        $user->assignRole($role);

        $customer = Customer::create([
            'NationNum' => $request->NationNum,
            'FullName' => $request->FullName,
            'Address' => $request->Address,
            'PhoneNum' => $request->PhoneNum,
            'Gender' => $request->Gender,
            'Birthdate' => $request->Birthdate,
            'user_id' => $user_id,
        ]);

        return response()->json([
            'message' => 'Customer created successfully',
            'customer' => $customer,
        ], 201);
    }

    return response()->json([
        'message' => 'Failed to create customer',
    ], 422);
}

}
