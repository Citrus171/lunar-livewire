<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::table('lunar_currencies')->where('code', 'GBP')->update([
            'code' => 'JPY',
            'name' => 'Japanese Yen',
            'decimal_places' => 0,
            'updated_at' => now(),
        ]);
    }

    public function down(): void
    {
        DB::table('lunar_currencies')->where('code', 'JPY')->update([
            'code' => 'GBP',
            'name' => 'British Pound',
            'decimal_places' => 2,
            'updated_at' => now(),
        ]);
    }
};
