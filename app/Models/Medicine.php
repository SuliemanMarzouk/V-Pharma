<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Medicine extends Model
{
    protected $table = 'medicines';
    protected $primaryKey = 'ID';
    protected $fillable = ['MedicineName', 'MedicineDetails', 'ProductionDate', 'ExpireDate', 'prescription_required'];

    use HasFactory;

    // Additional model methods and relationships

    public function customerOrders()
    {
        return $this->belongsToMany(CustomerOrder::class, 'customer_order_details', 'MedicineID', 'customer_orderID');
    }

    public function pharmacies()
    {
        return $this->belongsToMany(Pharmacy::class, 'medicine_pharmacies', 'MedicineID', 'PharmacyID')
            ->withPivot('Price', 'Quantity');
    }
    public function warehouses()
    {
        return $this->belongsToMany(Warehouse::class, 'medicine_warehouses', 'MedicineID', 'warehouseID')
            ->withPivot('Price', 'Quantity');
    }
    public function pharmacyOrderDetails()
    {
        return $this->hasMany(PharmacyOrderDetail::class, 'MedicineID');
    }
}
