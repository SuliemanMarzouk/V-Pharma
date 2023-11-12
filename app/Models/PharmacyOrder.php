<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PharmacyOrder extends Model
{
    protected $table = 'pharmacy_orders';
    protected $primaryKey = 'ID';
    public $timestamps = true;
    protected $fillable = ['warehouseID','PharmacyID','OrderNum','OrderDate','OrderStatus','TotalPrice','DeliveryPrice','DeliveryID'];

    use HasFactory;

   // Additional model methods and relationships
    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouseID');
    }

    public function pharmacy()
    {
        return $this->belongsTo(Pharmacy::class, 'PharmacyID');
    }

    public function delivery()
    {
        return $this->belongsTo(Delivery::class, 'DeliveryID');
    }
    public function pharmacyOrderDetails()
    {
        return $this->hasMany(PharmacyOrderDetail::class, 'pharmacy_orderID');
    }
}
