<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MedicineWarehouse extends Model
{
    protected $table = 'medicine_warehouses';
    protected $primaryKey = 'ID';
    public $timestamps = true;
    protected $fillable = ['MedicineID','warehouseID','Price','Quantity'];

    use HasFactory;

    // Additional model methods and relationships

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class, 'warehouseID');
    }

    public function medicine()
    {
        return $this->belongsTo(Medicine::class, 'MedicineID');
    }
}
