<?php

namespace App\Http\Controllers;

use App\Models\CustomerOrder;
use App\Models\PharmacyOrder;
use App\Models\Pharmacy;
use App\Models\Warehouse;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Http\Request;

class orderToAdminController extends Controller
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
        //
    }

    /**
     * Display the specified resource.
     */
    public function show()
    {
        $userId = Auth::user()->id;
    
        if (Auth::user()->hasRole('Pharmacy')) {
            $pharmacyID = Pharmacy::where('user_id', $userId)->value('id');
    
            $customerOrders = CustomerOrder::where('pharmacyID', $pharmacyID)
                ->where('OrderStatus', 0)
                ->with('customerOrderDetails')
                ->get();
    
            return view('pharmacy/order_to_admin', compact('customerOrders'));
        }
        else if (Auth::user()->hasRole('Warehouse')) {
            $warehouseID = Warehouse::where('user_id', $userId)->value('id');
    
            $pharmacyOrders = PharmacyOrder::where('WarehouseID', $warehouseID)
                ->where('OrderStatus', 0)
                ->with('pharmacyOrderDetails')
                ->get();
    
            return view('warehouse/order_to_admin', compact('pharmacyOrders'));
        }
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
}
