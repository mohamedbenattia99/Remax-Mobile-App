<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAddressesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('addresses', function (Blueprint $table) {
            $table->uuid('id');
            $table->string('zip_code');
            $table->string('address');
            $table->String('municipality');
            $table->String('governorate');

            $table->double('latitude');
            $table->double('longitude');
            //$table->integer('municipality_id')->unsigned();


            $table->timestamps();
            $table->primary('id');

            /*
            $table->foreign('municipality_id')
                ->references('id')
                ->on('municipalities');
            */
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('addresses');
    }
}
