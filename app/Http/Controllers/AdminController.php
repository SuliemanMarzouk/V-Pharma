<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PharmacyOrder;
use App\Models\CustomerOrder;
use App\Models\Delivery;
use App\Models\Pharmacy;
use App\Models\Warehouse;

class AdminController extends Controller
{

    public function dashboard()
    {
        $orderCount = (PharmacyOrder::get()->where('OrderStatus',1)->count())+(CustomerOrder::get()->where('OrderStatus',1)->count());
        $deliveryCount = Delivery::count();
        $pharmacyCount = Pharmacy::count();
        $warehouseCount = Warehouse::count();

        return view('admin.index', [
            'orderCount' => $orderCount,
            'deliveryCount' => $deliveryCount,
            'pharmacyCount' => $pharmacyCount,
            'warehouseCount' => $warehouseCount,
        ]);
    }
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
    public function show(string $id)
    {
        //
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
