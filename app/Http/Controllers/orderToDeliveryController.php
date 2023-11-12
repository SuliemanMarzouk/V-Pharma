<?php

namespace App\Http\Controllers;

use App\Models\CustomerOrder;
use App\Models\PharmacyOrder;
use App\Models\Delivery;
use Illuminate\Http\Request;

class orderToDeliveryController extends Controller
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
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show()
    {
        $deliveries = Delivery::where('status', 1)->get();

        $customerOrders = CustomerOrder::where('OrderStatus', 1)->where('DeliveryID', NULL)->get();
    
        $pharmacyOrders = PharmacyOrder::where('OrderStatus', 1)->where('DeliveryID', NULL)->get();
    
        return view('admin/orders_to_delivery', compact('customerOrders', 'pharmacyOrders', 'deliveries'));
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

    public function updateDeliveryPhOrder(Request $request, $pharmacyOrderId)
    {
        $pharmacyOrder = PharmacyOrder::find($pharmacyOrderId);
        $deliveryId = $request->input('deliveryId');
        
        // Update the DeliveryID of the pharmacy order
        $pharmacyOrder->DeliveryID = $deliveryId;
        $pharmacyOrder->OrderStatus = 2;
        $pharmacyOrder->save();
        
        // Optionally, you can redirect to another page or return a response
        return redirect()->back()->with('success', 'Delivery updated successfully');
    }

    public function updateDeliveryCusOrder(Request $request, $customerOrderId)
    {
        $customerOrder = CustomerOrder::find($customerOrderId);
        $deliveryId = $request->input('deliveryId');
        
        // Update the DeliveryID of the pharmacy order
        $customerOrder->DeliveryID = $deliveryId;
        $customerOrder->OrderStatus = 2;
        $customerOrder->save();
        
        // Optionally, you can redirect to another page or return a response
        return redirect()->back()->with('success', 'Delivery updated successfully');
    }
}
