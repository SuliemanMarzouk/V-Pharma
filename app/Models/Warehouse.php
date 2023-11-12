<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Warehouse extends Model
{
    protected $table = 'warehouses';
    protected $primaryKey = 'ID';
    protected $fillable = ['WHLicense', 'WHName', 'Address', 'PhoneNum', 'status', 'user_id'];

    use HasFactory;

    public function medicines()
    {
        return $this->belongsToMany(Medicine::class, 'medicine_warehouses', 'warehouseID', 'MedicineID')
            ->withPivot('Price', 'Quantity');
    }
    public function pharmacyOrders()
    {
        return $this->hasMany(PharmacyOrder::class, 'warehouseID');
    }
}
