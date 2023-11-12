<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomerOrder extends Model
{
    protected $table = 'customer_orders';
    protected $primaryKey = 'ID';
    protected $fillable = ['CustomerID', 'PharmacyID', 'DeliveryID', 'OrderNum', 'OrderDate', 'DeliveryPrice', 'OrderStatus', 'TotalPrice', 'upload_prescription'];

    use HasFactory;

        // Additional model methods and relationships

        public function customer()
        {
            return $this->belongsTo(Customer::class, 'CustomerID');
        }
    
        public function pharmacy()
        {
            return $this->belongsTo(Pharmacy::class, 'PharmacyID');
        }
        
        public function delivery()
        {
            return $this->belongsTo(Delivery::class, 'DeliveryID');
        }
        public function medicines()
        {
            return $this->belongsToMany(Medicine::class, 'customer_order_details', 'customer_orderID', 'MedicineID');
        }
        public function customerOrderDetails()
        {
            return $this->hasMany(CustomerOrderDetail::class, 'customer_orderID');
        }
}
