<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCustomersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('customers', function (Blueprint $table) {
            $table->increments('ID');
            $table->integer('NationNum')->nullable();
            $table->string('FullName')->nullable();
            $table->string('Address')->nullable();
            $table->integer('PhoneNum')->nullable();
            $table->char('Gender', 1)->nullable();
            $table->date('Birthdate')->nullable();
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
        Schema::dropIfExists('customers');
    }
}