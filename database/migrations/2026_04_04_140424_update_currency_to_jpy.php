<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        DB::transaction(function (): void {
            $now = now();

            // 全通貨のdefaultを一旦falseに
            DB::table('lunar_currencies')->update(['default' => false, 'updated_at' => $now]);

            // JPYが既に存在する場合はdefaultに設定
            $updated = DB::table('lunar_currencies')
                ->where('code', 'JPY')
                ->update([
                    'name' => 'Japanese Yen',
                    'decimal_places' => 0,
                    'default' => true,
                    'updated_at' => $now,
                ]);

            if ($updated === 0) {
                // JPYがなければGBPをJPYに変換
                DB::table('lunar_currencies')
                    ->where('code', 'GBP')
                    ->update([
                        'code' => 'JPY',
                        'name' => 'Japanese Yen',
                        'decimal_places' => 0,
                        'default' => true,
                        'updated_at' => $now,
                    ]);
            }
        });
    }

    public function down(): void
    {
        DB::transaction(function (): void {
            $now = now();

            DB::table('lunar_currencies')->update(['default' => false, 'updated_at' => $now]);

            $updated = DB::table('lunar_currencies')
                ->where('code', 'GBP')
                ->update([
                    'name' => 'British Pound',
                    'decimal_places' => 2,
                    'default' => true,
                    'updated_at' => $now,
                ]);

            if ($updated === 0) {
                DB::table('lunar_currencies')
                    ->where('code', 'JPY')
                    ->update([
                        'code' => 'GBP',
                        'name' => 'British Pound',
                        'decimal_places' => 2,
                        'default' => true,
                        'updated_at' => $now,
                    ]);
            }
        });
    }
};
