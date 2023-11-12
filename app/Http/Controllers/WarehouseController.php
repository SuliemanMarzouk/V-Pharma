<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Warehouse;
use App\Models\Medicine;
use App\Models\PharmacyOrder;
use App\Models\MedicineWarehouse;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Auth;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Spatie\Permission\Traits\HasRoles;

class WarehouseController extends Controller
{
    use HasRoles;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);
        $user->save();

            // Create a new instance of the Warehouse model
        $warehouse = Warehouse::create([
            'WHLicense' => $request->WHLicense,
            'WHName' => $request->WHName,
            'Address' => $request->Address,
            'PhoneNum' => $request->PhoneNum,
            'status' => 1,
            'user_id' => $user->id,
        ]);
            $user = User::find($warehouse->user_id);
            $role = Role::where('name', 'warehouse')->first();
        
            if ($user && $role) {
                $user->assignRole($role);
            }
        
        return redirect('/adminDashboard')->with('success', 'Pharmacy registered successfully!');
    }

    /**
     * Display the specified resource.
     */
    public function show()
    {
        $warehouses = Warehouse::all(); // Assuming you have a Delivery model
 
        return view('pharmacy.warehouses', compact('warehouses'));
    }
    public function showWHadmin()
    {
        $warehouses = Warehouse::all(); // Assuming you have a Delivery model
 
        return view('admin.warehouses_table', compact('warehouses'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    public function newWarehouse(User $user)
    {
        // You can pass the $user object to the view or perform any other necessary logic

        return view('admin.new_warehouse')->with('user', $user);
    }

    public function showWarehouse($id)
    {
        $warehouse = Warehouse::findOrFail($id);
        $medicines = $warehouse->medicines;
        return view('pharmacy.warehouse', compact('warehouse', 'medicines'));
    }

    public function showWarehouseMed()
    {
        $user = Auth::user();
        // Retrieve the pharmacy ID associated with the logged-in user
        $userId = $user->id;
        $warehouse = Warehouse::where('user_id', $userId)->first();
        $medicines = $warehouse->medicines;
        return view('warehouse.warehouseMed', compact('medicines', 'warehouse'));
    }

    public function warehouseProfile($userId)
    {
        $user = Auth::user();

        if ($user->hasRole('Warehouse')) {
            $warehouse = Warehouse::where('user_id', $userId)->first();

            if ($warehouse) {
                return view('warehouse.warehouseProfile', compact('warehouse', 'user'));
            } else {
                return response()->json(['error' => 'Warehouse not found'], 404);
            }
        } else {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
    }

    public function updateWarehouseProfile(Request $request, $userId)
    {
        $user = Auth::user();

        if ($user->hasRole('Warehouse')) {
            $warehouse = Warehouse::where('user_id', $userId)->first();

            if ($warehouse) {
                $request->validate([
                    'name' => 'required',
                    'address' => 'required',
                    'phoneNum' => 'required',
                    'license' => 'required',
                    // Add more validation rules for other fields
                ]);

                $warehouse->WHName = $request->input('name');
                $warehouse->Address = $request->input('address');
                $warehouse->PhoneNum = $request->input('phoneNum');
                $warehouse->WHLicense = $request->input('license');
                $warehouse->status = $request->input('status');
                // Set the status field based on the checkbox value
                $warehouse->status = $request->has('status') ? 1 : 0;

                $warehouse->save();

                return redirect()->route('warehouseProfile', ['userId' => $userId])->with('success', 'Profile updated successfully');
            } else {
                return response()->json(['error' => 'Warehouse not found'], 404);
            }
        } else {
            return response()->json(['error' => 'Unauthorized'], 401);
        }
    }

    public function acceptPhOrder($orderId)
    {
        $order = PharmacyOrder::find($orderId);
        $order->OrderStatus = 1; // Set the status to "accepted"
        $order->save();

        foreach ($order->pharmacyOrderDetails as $orderDetail) {
            $medicine = $orderDetail->medicine;
            $pivot = $medicine->warehouses->first()->pivot;

            $newQuantity = $pivot->Quantity - $orderDetail->quantity;
            $pivot->Quantity = $newQuantity;
            $pivot->save();
        }
        return redirect()->back()->with('success', 'Order accepted successfully');
    }

    public function rejectPhOrder($orderId)
    {
        $order = PharmacyOrder::find($orderId);
        $order->OrderStatus = 5; // Set the status to "rejected"
        $order->save();
        return redirect()->back()->with('success', 'Order rejected successfully');
    }

    public function dashboard()
    {
        $user = Auth::user();
        $orderCount = PharmacyOrder::whereHas('warehouse', function ($query) use ($user) {
            $query->where('user_id', $user->id)->where('OrderStatus',0);
        })->get()->count();
    ;
        $medicineCount = MedicineWarehouse::whereHas('warehouse', function ($query) use ($user) {
            $query->where('user_id', $user->id);
        })->get()->count();;
        return view('warehouse.dashboard', [
            'orderCount' => $orderCount,
            'medicineCount' => $medicineCount,
        ]);
    }
}
