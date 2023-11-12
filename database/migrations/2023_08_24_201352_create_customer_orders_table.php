<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCustomerOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('customer_orders', function (Blueprint $table) {
            $table->increments('ID');
            $table->integer('CustomerID')->unsigned();
            $table->integer('PharmacyID')->unsigned();
            $table->integer('DeliveryID')->unsigned();
            $table->string('OrderNum')->nullable();
            $table->datetime('OrderDate')->nullable();
            $table->float('DeliveryPrice')->nullable();
            $table->tinyInteger('OrderStatus')->nullable();
            $table->float('TotalPrice')->nullable();
            $table->timestamps();

            $table->foreign('CustomerID')->references('ID')->on('customers');
            $table->foreign('PharmacyID')->references('ID')->on('pharmacies');
            $table->foreign('DeliveryID')->references('ID')->on('deliveries');
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('customer_orders');
    }
}