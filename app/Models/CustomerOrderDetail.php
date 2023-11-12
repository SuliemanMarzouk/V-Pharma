<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CustomerOrderDetail extends Model
{
    protected $table = 'customer_order_details';
    protected $primaryKey = 'ID';
    public $timestamps = true;

    use HasFactory;
    
    // Additional model methods and relationships

    public function customerOrder()
    {
        return $this->belongsTo(CustomerOrder::class, 'customer_orderID');
    }

    public function medicine()
    {
        return $this->belongsTo(Medicine::class, 'MedicineID');
    }
}
