<?php

namespace App\Http\Controllers;

use App\Models\CustomerOrder;
use App\Models\CustomerOrderDetail;
use Illuminate\Http\Request;
use App\Models\Pharmacy;
use App\Models\User;
use App\Models\Medicine;
use App\Models\Customer;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;


class CustomerOrderController extends Controller
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
        // Retrieve the necessary input data from the request
        $customerId = $request->input('customer_id');
        $pharmacyId = $request->input('pharmacy_id');
        $deliveryId = $request->input('delivery_id');
        $CustomerOrderDetails = $request->input('order_details');

        // Create a new customer order
        $order = new CustomerOrder();
        $order->CustomerID = $customerId;
        $order->PharmacyID = $pharmacyId;
        $order->DeliveryID = $deliveryId;
        // Set other order properties

        // Save the order to the database
        $order->save();

        // Create order details for each medicine
        foreach ($CustomerOrderDetails as $CustomerOrderDetail) {
            $medicineId = $CustomerOrderDetail['medicine_id'];
            // $quantity = $CustomerOrderDetail['quantity'];

            $detail = new CustomerOrderDetail();
            $detail->customer_orderID = $order->ID;
            $detail->MedicineID = $medicineId;
            // $detail->Quantity = $quantity;
            // Set other order detail properties

            // Save the order detail to the database
            $detail->save();
        }

        // Optionally, you can return the created order in the response if desired
        return response()->json($order, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show($userId)
    {
        $customerOrders = CustomerOrder::whereHas('customer', function ($query) use ($userId) {
            $query->where('user_id', $userId);
        })->get();
    
        foreach ($customerOrders as $customerOrder) {
            $customerOrderDetails = CustomerOrderDetail::where('customer_orderID', $customerOrder->ID)->get();
            foreach ($customerOrderDetails as $customerOrderDetail) {
                $medicineOrder = Medicine::where('ID', $customerOrderDetail->MedicineID)->first(); // Use first() instead of get() to retrieve a single Medicine instance
                $customerOrderDetail->medicine = $medicineOrder; // Add the medicine as a property to the customerOrderDetail
            }
            $customerOrder->customerOrderDetails = $customerOrderDetails;
        }
    
        return response()->json([
            'customerOrders' => $customerOrders,
        ]);
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
// Add File 
    // $customerOrder = new CustomerOrder;
    
    // // Assign other fields
    
    // if ($request->hasFile('upload_prescription')) {
    //     $file = $request->file('upload_prescription');
    //     $filename = time() . '_' . $file->getClientOriginalName();
    //     $file->storeAs('prescriptions', $filename, 'public');
    //     $customerOrder->upload_prescription = $filename;
    // }
    
    // $customerOrder->save();

    // // Additional logic...

    // return redirect()->back()->with('success', 'Customer Order created successfully.');


//     <div class="form-group">
//     <label for="upload_prescription">Upload Prescription</label>
//     <input type="file" class="form-control-file" id="upload_prescription" name="upload_prescription">
// </div>

public function placeOrder(Request $request)
{
    $jsonData = $request->json()->all();
    $customerId = $jsonData['customer_id'];
    $pharmacyId = $jsonData['pharmacy_id'];
    $deliveryPrice = $jsonData['delivery_price'];
    $totalPrice = $jsonData['total_price'];
    $address = $jsonData['address'];
    $medicines_order = $jsonData['medicines_order'];

    $customerOrder = new CustomerOrder();
    $customerOrder->CustomerID = $customerId;
    $customerOrder->PharmacyID = $pharmacyId;
    $customerOrder->OrderStatus = 0;
    $customerOrder->DeliveryPrice = $deliveryPrice;
    $customerOrder->TotalPrice = $totalPrice;
    $customerOrder->OrderDate = Carbon::now();;
    $customerOrder->save();
    $customerOrder->OrderNum = $customerOrder->ID;
    $customerOrder->save();

    $customer = Customer::where("ID", $customerId)->first();
    $customer->update([
        'Address' => $address,
    ]);

    $medicinesorder = [];
    foreach ($medicines_order as $medOrder){
        $medicine_id = $medOrder['medOrder']['id'];
        $quantity = $medOrder['medOrder']['quan'];
    
        $customerOrderDetail = new CustomerOrderDetail();
        $customerOrderDetail->customer_orderID = $customerOrder->ID;
        $customerOrderDetail->MedicineID = $medicine_id;
        $customerOrderDetail->quantity = $quantity;
        $customerOrderDetail->save();

        $medicinesorder[] = $customerOrderDetail; 
            
    }

    


    return response()->json([
        'message' => 'Order placed successfully',
        'customerOrder' => $customerOrder,
        'customerOrderDetail' => $medicinesorder,
    ], 201);
}

}
