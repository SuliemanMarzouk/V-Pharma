<?php

namespace App\Http\Controllers;

use App\Models\Pharmacy;
use App\Models\User;
use App\Models\Medicine;
use App\Models\Delivery;
use App\Models\Warehouse;
use App\Models\MedicinePharmacy;
use App\Models\PharmacyOrder;
use App\Models\CustomerOrder;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Auth;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Spatie\Permission\Traits\HasRoles;

class PharmacyController extends Controller
{

    use HasRoles;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // Retrieve all pharmacies
        $pharmacies = Pharmacy::all();

        return response()->json($pharmacies);
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

            // Create a new instance of the Pharmacy model
        $pharmacy = Pharmacy::create([
            'PharmaLicense'=>$request->PharmaLicense,
            'PharmaName'=>$request->PharmaName,
            'Address'=>$request->Address,
            'PhoneNum'=>$request->PhoneNum,
            'pharmacistName'=>$request->pharmacistName,
            'status'=>1,
            'user_id'=>$user->id,
            ]);
            $user = User::find($pharmacy->user_id);
            $role = Role::where('name', 'pharmacy')->first();
        
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
        $pharmacies = Pharmacy::all(); // Assuming you have a Delivery model
 
         return view('admin.pharmacies_table', compact('pharmacies'));
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

    public function getAllPharmacies()
    {
        $pharmacies = Pharmacy::all();

        return response()->json($pharmacies);
    }

    public function getAllMedicines()
    {
        $pharmacy = Pharmacy::first(); // Get a pharmacy instance

        $medicines = $pharmacy->medicines;

        return response()->json($medicines);
    }

    public function newPharmacy(User $user)
    {
        // You can pass the $user object to the view or perform any other necessary logic

        return view('admin.new_pharmacy')->with('user', $user);
    }

    public function getPharmacyDetails()
    {
        $pharmacyDetails = Pharmacy::with('medicines')->get();

        return response()->json($pharmacyDetails);
    }

    public function showPharmaMed()
    {
        $user = Auth::user();
        // Retrieve the pharmacy ID associated with the logged-in user
        $userId = $user->id;
        $pharmacy = Pharmacy::where('user_id', $userId)->first();
        $medicines = $pharmacy->medicines;
        return view('pharmacy.pharmacyMed', compact('medicines', 'pharmacy'));
    }

    public function pharmacyProfile($userId)
    {
        // Retrieve the authenticated user
        $user = Auth::user();

        // Check if the user has the appropriate role
        if ($user->hasRole('Pharmacy')) {
            // Find the pharmacy associated with the user
            $pharmacy = Pharmacy::where('user_id', $userId)->first();

            if ($pharmacy) {
                // Load the pharmacy profile view and pass the pharmacy data
                return view('pharmacy.profile', compact('pharmacy','user'));
            } else {
                // Pharmacy not found, handle the error as needed
                return response()->json(['error' => 'Pharmacy not found'], 404);
            }
        } else {
            // User does not have the appropriate role, handle the error as needed
            return response()->json(['error' => 'Unauthorized'], 401);
        }
    }

    public function updatePharmacyProfile(Request $request, $userId)
    {
        // Retrieve the authenticated user
        $user = Auth::user();
    
        // Check if the user has the appropriate role
        if ($user->hasRole('Pharmacy')) {
            // Find the pharmacy associated with the user
            $pharmacy = Pharmacy::where('user_id', $userId)->first();
    
            if ($pharmacy) {
                // Validate the incoming request data
                $request->validate([
                    'name' => 'required',
                    'address' => 'required',
                    'phoneNum' => 'required',
                    'license' => 'required',
                    'pharmacistName' => 'required',
                    // Add more validation rules for other fields
                ]);
    
                // Update the pharmacy profile with the new data
                $pharmacy->PharmaName = $request->input('name');
                $pharmacy->Address = $request->input('address');
                $pharmacy->PhoneNum = $request->input('phoneNum');
                $pharmacy->PharmaLicense = $request->input('license');
                $pharmacy->status = $request->input('status');
                $pharmacy->pharmacistName = $request->input('pharmacistName');

                // Set the status field based on the checkbox value
                $pharmacy->status = $request->has('status') ? 1 : 0;
    
                // Save the changes
                $pharmacy->save();

                // Redirect back to the profile page with a success message
                return redirect()->route('pharmacyProfile', ['userId' => $userId])->with('success', 'Profile updated successfully');
            } else {
                // Pharmacy not found, handle the error as needed
                return response()->json(['error' => 'Pharmacy not found'], 404);
            }
        } else {
            // User does not have the appropriate role, handle the error as needed
            return response()->json(['error'=> 'Unauthorized'], 401);
        }
    }
    public function myOrders()
    {
        $user = Auth::user();
    
        $pharmacyOrders = PharmacyOrder::whereHas('pharmacy', function ($query) use ($user) {
            $query->where('user_id', $user->id);
        })->with(['pharmacyOrderDetails', 'pharmacyOrderDetails.medicine'])->get();
    
        $medicinePharmacies = MedicinePharmacy::with('medicine')->get();
    
        return view('pharmacy.myOrders', compact('pharmacyOrders', 'medicinePharmacies'));
    }

    public function acceptOrder($orderId)
    {
        $order = CustomerOrder::find($orderId);
        $order->OrderStatus = 1; // Set the status to "accepted"
        $order->save();

        foreach ($order->customerOrderDetails as $orderDetail) {
            $medicine = $orderDetail->medicine;
            $pivot = $medicine->pharmacies->first()->pivot;

            $newQuantity = $pivot->Quantity - $orderDetail->quantity;
            $pivot->Quantity = $newQuantity;
            $pivot->save();
        }
        return redirect()->back()->with('success', 'Order accepted successfully');
    }

    public function rejectOrder($orderId)
    {
        $order = CustomerOrder::find($orderId);
        $order->OrderStatus = 5; // Set the status to "rejected"
        $order->save();
        return redirect()->back()->with('success', 'Order rejected successfully');
    }

    public function dashboard()
    {
        $user = Auth::user();
        $orderCount = CustomerOrder::whereHas('pharmacy', function ($query) use ($user) {
            $query->where('user_id', $user->id)->where('OrderStatus',0);
        })->get()->count();;
        $medicineCount = MedicinePharmacy::whereHas('pharmacy', function ($query) use ($user) {
            $query->where('user_id', $user->id);
        })->get()->count();;
        $myOrdersCount = PharmacyOrder::whereHas('pharmacy', function ($query) use ($user) {
            $query->where('user_id', $user->id);
        })->with(['pharmacyOrderDetails', 'pharmacyOrderDetails.medicine'])->get()->count();
    
        return view('pharmacy.dashboard', [
            'orderCount' => $orderCount,
            'medicineCount' => $medicineCount,
            'myOrdersCount' => $myOrdersCount,
        ]);
    }
}
