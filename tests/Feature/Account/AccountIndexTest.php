<?php

declare(strict_types=1);

use App\Models\User;
use Lunar\Models\Currency;
use Lunar\Models\Order;

it('ウェルカムメッセージにfirst_nameが表示されること', function (): void {
    $user = User::factory()->create(['first_name' => 'Taro']);

    $response = $this->actingAs($user)->get('/account');

    $response->assertOk();
    $response->assertSee('Taro');
});

it('直近3件の注文が表示されること', function (): void {
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->create();

    // placed_at を1分ずつずらして順序を確定させる
    // ORD-1: -4分前（最古・表示されない）, ORD-2〜4: -3〜-1分前（直近3件・表示される）
    foreach (range(1, 4) as $i) {
        Order::factory()->create([
            'user_id' => $user->id,
            'currency_code' => 'JPY',
            'compare_currency_code' => 'JPY',
            'reference' => 'ORD-' . $i,
            'placed_at' => now()->subMinutes(5 - $i),
            'status' => 'payment-received',
        ]);
    }

    $response = $this->actingAs($user)->get('/account');

    $response->assertOk();
    $response->assertSee('ORD-2');
    $response->assertSee('ORD-3');
    $response->assertSee('ORD-4');
    $response->assertDontSee('ORD-1');
});

it('注文履歴テキストが表示されること', function (): void {
    $user = User::factory()->create();

    $response = $this->actingAs($user)->get('/account');

    $response->assertOk();
    $response->assertSee('注文履歴をすべて見る');
});

it('ログアウトボタンが表示されること', function (): void {
    $user = User::factory()->create();

    $response = $this->actingAs($user)->get('/account');

    $response->assertOk();
    $response->assertSee('logout');
});
