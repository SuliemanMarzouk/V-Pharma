<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Pharmacy;
use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Auth;
use Spatie\Permission\Models\Role;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Spatie\Permission\Traits\HasRoles;


class UsersController extends Controller
{

    use HasRoles;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return UsersResource::collection(User::paginate(10));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {

    }

    /**
     * Display the specified resource.
     */
    public function show(User $user)
    {
        return new UsersResource($user);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, User $user)
    {

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        $user->delete();

        return response('deleted', 200);
    }

    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            $customerController = new CustomerController();
            $customer = $customerController->show($user->id);
    
            if ($user->hasRole('Customer')) {
                return response()->json([
                    'message' => 'Login successful',
                    'user' => $user,
                    'customer' => $customer
                ], 200);
            } else {
                return response()->json(['error' => 'Invalid role'], 401);
            }
        }
        else {
            return response()->json(['error' => 'Invalid credentials'], 401);
        }
    }

    public function deliverylogin(Request $request)
    {

        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $user = Auth::user();
            $deliveryController = new DeliveryController();
            $delivery = $deliveryController->showapi($user->id);

            if ($user->hasRole('Delivery')) {
                return response()->json([
                    'message' => 'Login successful',
                    'user' => $user,
                    'delivery' => $delivery
                ], 200);
            } else {
                return response()->json(['error' => 'Invalid role'], 401);
            }
        }
        else {
            return response()->json(['error' => 'Invalid credentials'], 401);
        }
    }

    public function updateProfile(Request $request, $userId)
{
    $customerController = new CustomerController();
    $customer = $customerController->show($userId);
    $user = User::where('ID', $userId)->first();

    $request->validate([
        'Address' => 'nullable',
        'PhoneNum' => 'nullable',
    ]);

    try {

        $customer->update([
            'Address' => $request->Address,
            'PhoneNum' => $request->PhoneNum,
        ]);

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => $user,
            'customer' => $customer,
        ], 200);
    } catch (\Throwable $th) {
        return response()->json([
            'message' => 'Failed to update profile',
        ], 422);
    }
}

public function updatePassword(Request $request)
{
    $user = Auth::user();
    $request->validate([
        'current_password' => 'required',
        'new_password' => 'required|min:8|confirmed',
    ]);
    
    if (!Hash::check($request->current_password, $user->password)) {
        return redirect()->back()->withErrors(['current_password' => 'The current password is incorrect.']);
    }
    
    $user->update([
        'password' => Hash::make($request->new_password),
    ]);
    
    
        if ($user->hasRole('Admin')) {
            return redirect('/adminDashboard')->with('user', $user)->with('success', 'Password updated successfully.');
        } elseif ($user->hasRole('Pharmacy')) {
            return redirect('/pharmacyDashboard')->with('user', $user)->with('success', 'Password updated successfully.');
        } elseif ($user->hasRole('Warehouse')) {
            return redirect('/warehouseDashboard')->with('user', $user)->with('success', 'Password updated successfully.');
        }
        
}

public function updatePasswordApi(Request $request, $userId)
{
        $customer = Customer::where('user_id', $userId)->first();
        $user = User::where('ID', $userId)->first();

        if (!$user) {
            return response()->json(['message' => 'User not found.'], 404);
        }

        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:8',
        ]);

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json(['message' => 'The current password is incorrect.'], 403);
        }

        $user->update([
            'password' => Hash::make($request->new_password),
        ]);

        return response()->json(['message' => 'Password updated successfully.'], 200);
}

}