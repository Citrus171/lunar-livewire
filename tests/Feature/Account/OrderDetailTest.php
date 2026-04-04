<?php

declare(strict_types=1);

use App\Models\User;
use Lunar\Models\Currency;
use Lunar\Models\Language;
use Lunar\Models\Order;
use Lunar\Models\OrderAddress;
use Lunar\Models\OrderLine;

it('他ユーザーの注文詳細にアクセスした時、404になること', function (): void {
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->create();
    $other = User::factory()->create();
    $order = Order::factory()->create([
        'user_id' => $other->id,
        'currency_code' => 'JPY',
        'compare_currency_code' => 'JPY',
    ]);

    $response = $this->actingAs($user)->get('/account/orders/' . $order->id);

    $response->assertNotFound();
});

it('注文詳細ページがログイン済みの時、表示されること', function (): void {
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->create();
    $order = Order::factory()->create([
        'user_id' => $user->id,
        'currency_code' => 'JPY',
        'compare_currency_code' => 'JPY',
    ]);

    $response = $this->actingAs($user)->get('/account/orders/' . $order->id);

    $response->assertOk();
});

it('注文詳細の時、注文明細（商品名・数量・単価）が表示されること', function (): void {
    Language::factory()->create(['default' => true]);
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->create();
    $order = Order::factory()->create([
        'user_id' => $user->id,
        'currency_code' => 'JPY',
        'compare_currency_code' => 'JPY',
    ]);
    OrderLine::factory()->create([
        'order_id' => $order->id,
        'description' => 'テスト商品',
        'quantity' => 2,
        'unit_price' => 1000,
    ]);

    $response = $this->actingAs($user)->get('/account/orders/' . $order->id);

    $response->assertOk();
    $response->assertSee('テスト商品');
    $response->assertSee('2');
});

it('注文詳細の時、配送先住所が表示されること', function (): void {
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->create();
    $order = Order::factory()->create([
        'user_id' => $user->id,
        'currency_code' => 'JPY',
        'compare_currency_code' => 'JPY',
    ]);
    OrderAddress::factory()->create([
        'order_id' => $order->id,
        'type' => 'shipping',
        'city' => '東京都',
        'line_one' => '渋谷区1-1-1',
    ]);

    $response = $this->actingAs($user)->get('/account/orders/' . $order->id);

    $response->assertOk();
    $response->assertSee('東京都');
    $response->assertSee('渋谷区1-1-1');
});
