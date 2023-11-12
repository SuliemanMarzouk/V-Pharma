<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PharmacyOrderDetail extends Model
{
    protected $table = 'pharmacy_order_details';
    protected $primaryKey = 'ID';
    public $timestamps = true;
    protected $fillable = ['pharmacy_orderID','MedicineID','quantity'];

    use HasFactory;

    public function pharmacyOrder()
    {
        return $this->belongsTo(PharmacyOrder::class, 'pharmacy_orderID');
    }

    public function medicine()
    {
        return $this->belongsTo(Medicine::class, 'MedicineID');
    }
}
