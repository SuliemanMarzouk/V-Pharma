<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Delivery;
use App\Models\Customer;
use App\Models\Pharmacy;
use App\Models\Warehouse;
use App\Models\CustomerOrder;
use App\Models\PharmacyOrder;
use App\Models\CustomerOrderDetail;
use App\Models\PharmacyOrderDetail;
use App\Models\Medicine;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Auth;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Spatie\Permission\Traits\HasRoles;

class DeliveryController extends Controller
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
        
        // Create a new instance of the Delivery model
        $delivery = Delivery::create([
            'NationNum' => $request->NationNum,
            'FullName' => $request->FullName,
            'PhoneNum' => $request->PhoneNum,
            'status' => 1,
            'user_id' => $user->id,
        ]);
        
        $user = User::find($delivery->user_id);
        $role = Role::where('name', 'delivery')->first();
        
        if ($user && $role) {
            $user->assignRole($role);
        }
        
        return redirect('/adminDashboard')->with('success', 'Delivery registered successfully!');
    }

    /**
     * Display the specified resource.
     */
    public function show()
    {
       $deliveries = Delivery::all(); // Assuming you have a Delivery model

        return view('admin.deliveries_table', compact('deliveries'));

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

    public function newDelivery(User $user)
    {
        // You can pass the $user object to the view or perform any other necessary logic

        return view('admin.new_delivery')->with('user', $user);
    }

    public function showapi($user_id)
    {
        $delivery = Delivery::where('user_id', $user_id)->first();

        if (!$delivery) {
            return response()->json(['error' => 'Delivery not found'], 404);
        }

        return $delivery;

    }

    public function deliveryInfo(Request $request, $userId)
    {
        $delivery = Delivery::where('user_id', $userId)->get();
        $user = User::where('ID', $userId)->get();

        if (!$delivery) {
            return response()->json(['error' => 'Delivery not found'], 404);
        }

        return response()->json([
            'user' => $user,
            'delivery' => $delivery,
        ], 200);

    }

    public function deliveryOrders($deliveryId)
    {
        $customerOrders = CustomerOrder::where('DeliveryID', $deliveryId)
        ->where(function ($query) {
            $query->where('OrderStatus', 2)
                ->orWhere('OrderStatus', 3)
                ->orWhere('OrderStatus', 4)
                ->orWhere('OrderStatus', 5);
        })
        ->get();

        $pharmacyOrders = PharmacyOrder::where('DeliveryID', $deliveryId)
        ->where(function ($query) {
            $query->where('OrderStatus', 2)
                ->orWhere('OrderStatus', 3)
                ->orWhere('OrderStatus', 4)
                ->orWhere('OrderStatus', 5);
        })
        ->get();
    
        foreach ($customerOrders as $customerOrder) {
            $customerOrderDetails = CustomerOrderDetail::where('customer_orderID', $customerOrder->ID)->get();
    
            foreach ($customerOrderDetails as $customerOrderDetail) {
                $medicineOrder = Medicine::where('ID', $customerOrderDetail->MedicineID)->first();
                $customerOrderDetail->medicine = $medicineOrder;
            }
    
            $customerOrder->customerOrderDetails = $customerOrderDetails;
    
            $customer = Customer::where('ID', $customerOrder->CustomerID)->first();
            $pharmacy = Pharmacy::where('ID', $customerOrder->PharmacyID)->first();
            $customerOrder->customer = $customer;
            $customerOrder->pharmacy = $pharmacy;
        }
    
        foreach ($pharmacyOrders as $pharmacyOrder) {
            $pharmacyOrderDetails = PharmacyOrderDetail::where('pharmacy_orderID', $pharmacyOrder->ID)->get();
    
            foreach ($pharmacyOrderDetails as $pharmacyOrderDetail) {
                $medicineOrder = Medicine::where('ID', $pharmacyOrderDetail->MedicineID)->first();
                $pharmacyOrderDetail->medicine = $medicineOrder;
            }
    
            $pharmacyOrder->pharmacyOrderDetails = $pharmacyOrderDetails;
    
            $pharmacy = Pharmacy::where('ID', $pharmacyOrder->PharmacyID)->first();
            $warehouse = Warehouse::where('ID', $pharmacyOrder->warehouseID)->first();
            $pharmacyOrder->pharmacy = $pharmacy;
            $pharmacyOrder->warehouse = $warehouse;
        }
    
        return response()->json([
            'customerOrders' => $customerOrders,
            'pharmacyOrders' => $pharmacyOrders,
        ]);
    }
    public function updateStatus(Request $request, $deliveryId)
    {
        $delivery = Delivery::where("ID", $deliveryId)->first();
    
        $request->validate([
            'status' => 'nullable',
        ]);
    
        try {
            $status = $request->input('status');
    
            $delivery->update([
                'status' => $status,
            ]);
    
            return response()->json([
                'message' => 'Status updated successfully',
                'delivery' => $delivery,
            ], 200);
        } catch (\Throwable $th) {
            return response()->json([
                'message' => 'Failed to update status',
            ], 422);
        }
    }

    public function deliverySubmitOrder(Request $request, $orderId)
    {
        $order = CustomerOrder::where("ID", $orderId)->first();
    
        $request->validate([
            'OrderStatus' => 'nullable',
        ]);
    
        try {
            $OrderStatus = $request->input('OrderStatus');

            $order->update([
                'OrderStatus' => $OrderStatus,
            ]);
    
            return response()->json([
                'message' => 'Approved successfully',
                'order' => $order,
            ], 200);
        } catch (\Throwable $th) {
            return response()->json([
                'message' => 'Failed to approve',
            ], 422);
        }
    }
    public function deliverySubmitPharmaOrder(Request $request, $orderId)
    {
        $order = PharmacyOrder::where("ID", $orderId)->first();
    
        $request->validate([
            'OrderStatus' => 'nullable',
        ]);
    
        try {
            $OrderStatus = $request->input('OrderStatus');

            $order->update([
                'OrderStatus' => $OrderStatus,
            ]);
    
            return response()->json([
                'message' => 'Approved successfully',
                'order' => $order,
            ], 200);
        } catch (\Throwable $th) {
            return response()->json([
                'message' => 'Failed to approve',
            ], 422);
        }
    }

}
