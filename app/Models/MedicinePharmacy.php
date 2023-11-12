<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MedicinePharmacy extends Model
{
    protected $table = 'medicine_pharmacies';
    protected $primaryKey = 'ID';
    public $timestamps = true;
    protected $fillable = ['MedicineID','PharmacyID','Price','Quantity'];

    use HasFactory;

    // Additional model methods and relationships

    public function pharmacy()
    {
        return $this->belongsTo(Pharmacy::class, 'PharmacyID');
    }

    public function medicine()
    {
        return $this->belongsTo(Medicine::class, 'MedicineID');
    }
}
