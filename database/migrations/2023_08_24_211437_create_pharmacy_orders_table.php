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
        Schema::create('pharmacy_orders', function (Blueprint $table) {
            $table->increments('ID');
            $table->integer('warehouseID')->unsigned();
            $table->integer('PharmacyID')->unsigned();
            $table->integer('DeliveryID')->unsigned();
            $table->string('OrderNum')->nullable();
            $table->datetime('OrderDate')->nullable();
            $table->float('DeliveryPrice')->nullable();
            $table->tinyInteger('OrderStatus')->nullable();
            $table->float('TotalPrice')->nullable();
            $table->timestamps();

            $table->foreign('warehouseID')->references('ID')->on('warehouses');
            $table->foreign('PharmacyID')->references('ID')->on('pharmacies');
            $table->foreign('DeliveryID')->references('ID')->on('deliveries');
        });

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pharmacy_orders');

    }
};
