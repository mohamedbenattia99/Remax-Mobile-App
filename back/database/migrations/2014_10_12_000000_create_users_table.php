<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->uuid('id');
            $table->string('first_name');
            $table->string('last_name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->integer('performance')->nullable();
            $table->string('password');
            $table->string('phone');
            $table->string('gender');
            $table->uuid('role_id');
            //
            $table->uuid('address_id')->nullable();

            $table->foreign('role_id')
                ->references('id')
                ->on('roles');
            //
            $table->foreign('address_id')
                ->references('id')
                ->on('addresses');

            $table->softDeletes();
            $table->rememberToken();
            $table->timestamps();

            $table->primary(['id']);


        });

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
