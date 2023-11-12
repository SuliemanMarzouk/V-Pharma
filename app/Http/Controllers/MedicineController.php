<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\MedicinePharmacy;
use App\Models\MedicineWarehouse;
use App\Models\Pharmacy;
use App\Models\Warehouse;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Auth;
use Spatie\Permission\Traits\HasRoles;


class MedicineController extends Controller
{
    use HasRoles;
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // Validate the form data
        $validatedData = $request->validate([
            'medicineName' => 'required',
            'medicineDetails' => 'required',
            'productionDate' => 'required|date',
            'expireDate' => 'required|date',
            'quantity' => 'required|integer',
            'price' => 'required|numeric',
        ]);
    
        // Create a new Medicine instance and assign the values from the form using create()
        $medicine = Medicine::create([
            'MedicineName' => $validatedData['medicineName'],
            'MedicineDetails' => $validatedData['medicineDetails'],
            'ProductionDate' => $validatedData['productionDate'],
            'ExpireDate' => $validatedData['expireDate'],
            'prescription_required' => $request->has('prescription_required'),
        ]);
        $medicine->save();

        // Retrieve the pharmacy ID based on the user ID
        $userId = Auth::user()->id;
        
        if (Auth::user()->hasRole('Pharmacy')) {

            $pharmacyId = Pharmacy::where('user_id', $userId)->value('id');

            $medicinePharmacy = MedicinePharmacy::create([
                'PharmacyID' => $pharmacyId,
                'MedicineID' => $medicine->ID,
                'Price' => $validatedData['price'],
                'Quantity' => $validatedData['quantity'],
            ]);
            $medicinePharmacy->save();

            return redirect('/pharmacyMed');
        } 
        
        else {
            $warehouseId = Warehouse::where('user_id', $userId)->value('id');

            $medicineWarehouse = MedicineWarehouse::create([
                'warehouseID' => $warehouseId,
                'MedicineID' => $medicine->ID,
                'Price' => $validatedData['price'],
                'Quantity' => $validatedData['quantity'],
            ]);
            $medicineWarehouse->save();

            return redirect('/warehouseMed');
        }
    }
    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        $medicine = Medicine::findOrFail($id);
        return view('medicines.edit', compact('medicine'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $validatedData = $request->validate([
            'medicineName' => 'required',
            'medicineDetails' => 'required',
            'productionDate' => 'required|date',
            'expireDate' => 'required|date',
            'quantity' => 'required|integer',
            'price' => 'required|numeric',
        ]);
    
        $medicine = Medicine::findOrFail($id);
        $medicine->prescription_required = $request->has('prescription_required');
        $medicine->MedicineName = $validatedData['medicineName'];
        $medicine->MedicineDetails = $validatedData['medicineDetails'];
        $medicine->ProductionDate = $validatedData['productionDate'];
        $medicine->ExpireDate = $validatedData['expireDate'];
        $medicine->save();

        if (Auth::user()->hasRole('Pharmacy')) {
            $medicinePharmacy = MedicinePharmacy::where('MedicineID', $id)->first();
            $medicinePharmacy->Price = $validatedData['price'];
            $medicinePharmacy->Quantity = $validatedData['quantity'];
            $medicinePharmacy->save();
        
            return redirect('/pharmacyMed')->with('success', 'Medicine updated successfully.');
        }
        else{
            $medicineWarehouse = MedicineWarehouse::where('MedicineID', $id)->first();
            $medicineWarehouse->Price = $validatedData['price'];
            $medicineWarehouse->Quantity = $validatedData['quantity'];
            $medicineWarehouse->save();
        
            return redirect('/warehouseMed')->with('success', 'Medicine updated successfully.');
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
    
        if (Auth::user()->hasRole('Pharmacy')) {
            $medicinePharmacy = MedicinePharmacy::where('MedicineID', $id)->first();
            $medicinePharmacy->delete();

            $medicine = Medicine::where('ID', $id)->first();
            $medicine->delete();
        
            return redirect('/pharmacyMed')->with('success', 'Medicine deleted successfully.');
        }
        else{
            $medicineWarehouse = MedicineWarehouse::where('MedicineID', $id)->first();
            $medicineWarehouse->delete();

            $medicine = Medicine::where('ID', $id)->first();
            $medicine->delete();
        
            return redirect('/warehouseMed')->with('success', 'Medicine deleted successfully.');
        }
    }
}
