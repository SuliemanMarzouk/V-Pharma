<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('medicine_pharmacies', function (Blueprint $table) {
            $table->increments('ID');
            $table->integer('PharmacyID')->unsigned();
            $table->integer('MedicineID')->unsigned();
            $table->float('Price')->nullable();
            $table->integer('Quantity')->nullable();
            $table->timestamps();

            $table->foreign('PharmacyID')->references('ID')->on('pharmacies');
            $table->foreign('MedicineID')->references('ID')->on('medicines');
        });
        
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('medicine_pharmacies');

    }
};
