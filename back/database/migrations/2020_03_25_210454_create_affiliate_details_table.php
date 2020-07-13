<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateAffiliateDetailsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('affiliate_details', function (Blueprint $table) {
            $table->uuid('id');
            $table->string('affiliate_name')->unique();
            $table->uuid('affiliate_id');
            $table->timestamps();

            $table->foreign('affiliate_id')
                ->references('id')
                ->on('users');
            $table->primary('id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('affiliate_details');
    }
}
