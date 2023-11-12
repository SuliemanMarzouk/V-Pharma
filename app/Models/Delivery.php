<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Delivery extends Model
{
    protected $table = 'deliveries';
    protected $primaryKey = 'ID';
    protected $fillable = ['NationNum', 'FullName', 'PhoneNum', 'status', 'user_id'];
    
    use HasFactory;

    public function pharmacyOrders()
    {
        return $this->hasMany(PharmacyOrder::class, 'DeliveryID');
    }
}
