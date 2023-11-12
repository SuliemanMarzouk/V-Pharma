<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Pharmacy;
use App\Models\PharmacyOrder;
use App\Models\Warehouse;
use App\Models\User;
use App\Models\PharmacyOrderDetail;
use App\Models\Medicine;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;


class PharmacyOrderController extends Controller
{
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
    public function store($id, Request $request)
    {

        $userId = Auth::user()->id;
        $pharmacyId = Pharmacy::where('user_id', $userId)->value('id');
        $warehouse = Warehouse::findOrFail($id);
        $currentDateTime = Carbon::now();
        $pharmacyorder = PharmacyOrder::create([
            'warehouseID'=> $warehouse->ID,
            'PharmacyID'=>$pharmacyId,
            'OrderDate'=>$currentDateTime,
            'OrderStatus'=>0,
            'DeliveryPrice' =>8000,
        ]);
        $pharmacyorder->OrderNum = $pharmacyorder->ID;
        $pharmacyorder->save();
        // where('pharmacy_orderID', $pharmacyorder->ID)->get()
        $quantities = $request->input('quantity');
        foreach ($quantities as $medicineId => $quantity) {
            if ($quantity > 0) {
                $medicine = Medicine::findOrFail($medicineId);
                $price = $medicine->warehouses()
                ->where('warehouseID', $warehouse->ID)
                ->value('Price');
    
                $pharmacyOrderDetail = PharmacyOrderDetail::create([
                    'pharmacy_orderID' => $pharmacyorder->ID,
                    'MedicineID' => $medicineId,
                    'quantity' => $quantity,
                    'price' => $price,
                ]);
                $pharmacyorder->TotalPrice += ($price * $quantity);
            }
        }
        $pharmacyorder->TotalPrice += $pharmacyorder->DeliveryPrice;
        $pharmacyorder->save();
        

        return redirect('/myOrders');
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
