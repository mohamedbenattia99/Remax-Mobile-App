<?php

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        /*Schema::create('orders', function (Blueprint $table)
        {
            $table->bigIncrements('code');
        });
        Schema::create('orders', function (Blueprint $table)
        {
            $table->dropPrimary();
        });*/


        Schema::create('orders', function (Blueprint $table) {

            //$table->bigIncrements('code');
            //$table->dropPrimary('code');
            $table->uuid('id');
            //$table->unsignedInteger('code')->index()->autoIncrement();
            $table->integer('phase');
            $table->boolean('completed');
            //$table->uuid('order_address_id');
            $table->string('first_name');
            $table->string('last_name');
            $table->string('cin');
            $table->string('email');
            $table->string('phone');
            //$table->string('address');
            $table->string('gender');
            $table->string('agent');
            $table->uuid('parent_company_id')->nullable();
            $table->uuid('affiliate_id')->nullable();
            $table->uuid('client_id')->nullable();

            $table->timestamps();

            $table->primary('id');
            /*$table->foreign('order_address_id')
                ->references('id')
                ->on('order_addresses');*/
            $table->foreign('parent_company_id')
                ->references('id')
                ->on('users');
            $table->foreign('affiliate_id')
                ->references('id')
                ->on('users');
            $table->foreign('client_id')
                ->references('id')
                ->on('users');
        });
        DB::statement('ALTER Table orders add code INTEGER NOT NULL UNIQUE AUTO_INCREMENT;');

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
