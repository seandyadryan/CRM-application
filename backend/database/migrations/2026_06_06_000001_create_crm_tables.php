<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('customers', function (Blueprint $table): void {
            $table->id();
            $table->string('name', 120);
            $table->string('company', 160);
            $table->string('email', 160)->unique();
            $table->string('phone', 40)->nullable();
            $table->string('segment', 60)->default('Retail');
            $table->string('status', 40)->default('Active');
            $table->text('notes')->nullable();
            $table->timestamps();
        });

        Schema::create('leads', function (Blueprint $table): void {
            $table->id();
            $table->string('name', 160);
            $table->string('company', 160);
            $table->string('source', 80)->default('Website');
            $table->unsignedBigInteger('value')->default(0);
            $table->string('status', 40)->default('New');
            $table->string('contact_email', 160)->nullable();
            $table->string('contact_phone', 40)->nullable();
            $table->timestamps();
        });

        Schema::create('deals', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('customer_id')->nullable()->constrained()->nullOnDelete();
            $table->string('title', 160);
            $table->string('customer', 160);
            $table->string('stage', 60)->default('Proposal');
            $table->unsignedBigInteger('amount')->default(0);
            $table->unsignedTinyInteger('probability')->default(0);
            $table->date('expected_close_date')->nullable();
            $table->timestamps();
        });

        Schema::create('activities', function (Blueprint $table): void {
            $table->id();
            $table->string('title', 160);
            $table->string('contact', 120);
            $table->string('type', 60)->default('Call');
            $table->timestamp('due_at')->nullable();
            $table->boolean('is_done')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('activities');
        Schema::dropIfExists('deals');
        Schema::dropIfExists('leads');
        Schema::dropIfExists('customers');
    }
};
