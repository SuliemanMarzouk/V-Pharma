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
        Schema::create('pharmacy_order_details', function (Blueprint $table) {
            $table->increments('ID');
            $table->integer('pharmacy_orderID')->unsigned();
            $table->integer('MedicineID')->unsigned();
            $table->timestamps();

            $table->foreign('pharmacy_orderID')->references('ID')->on('pharmacy_orders');
            $table->foreign('MedicineID')->references('ID')->on('medicines');
        });



    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pharmacy_order_details');

    }
};
