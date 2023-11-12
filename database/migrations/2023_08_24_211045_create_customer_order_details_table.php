<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCustomerOrderDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('customer_order_details', function (Blueprint $table) {
            $table->increments('ID');
            $table->integer('customer_orderID')->unsigned();
            $table->integer('MedicineID')->unsigned();
            $table->timestamps();

            $table->foreign('customer_orderID')->references('ID')->on('customer_orders');
            $table->foreign('MedicineID')->references('ID')->on('medicines');
        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {

    }
}