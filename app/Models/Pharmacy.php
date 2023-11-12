<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pharmacy extends Model
{
    protected $table = 'pharmacies';
    protected $primaryKey = 'ID';
    protected $fillable = ['PharmaLicense', 'PharmaName', 'Address', 'PhoneNum', 'status', 'pharmacistName','user_id'];
    
    use HasFactory;

    public function medicines()
    {
        return $this->belongsToMany(Medicine::class, 'medicine_pharmacies', 'PharmacyID', 'MedicineID')
            ->withPivot('Price', 'Quantity');
    }
    public function pharmacyOrders()
    {
        return $this->hasMany(PharmacyOrder::class, 'PharmacyID');
    }
}
