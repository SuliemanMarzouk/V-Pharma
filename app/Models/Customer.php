<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    protected $table = 'customers';
    protected $primaryKey = 'ID';
    protected $fillable = ['NationNum', 'FullName', 'Address', 'PhoneNum', 'Gender', 'Birthdate', 'user_id'];
    
    use HasFactory;
}
