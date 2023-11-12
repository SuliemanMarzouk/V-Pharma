<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePharmaciesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pharmacies', function (Blueprint $table) {
            $table->increments('ID');
            $table->string('PharmaLicense')->nullable();
            $table->string('PharmaName')->nullable();
            $table->string('Address')->nullable();
            $table->integer('PhoneNum')->nullable();
            $table->tinyInteger('status')->nullable();
            $table->string('pharmacistName')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pharmacies');
    }
}