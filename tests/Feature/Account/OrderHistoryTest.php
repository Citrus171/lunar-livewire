<?php

declare(strict_types=1);

use App\Models\User;
use Lunar\Models\Currency;
use Lunar\Models\Order;

it('注文一覧ページがログイン済みの時、表示されること', function (): void {
    $user = User::factory()->create();

    $response = $this->actingAs($user)->get('/account/orders');

    $response->assertOk();
});

it('注文が0件の時、メッセージが表示されること', function (): void {
    $user = User::factory()->create();

    $response = $this->actingAs($user)->get('/account/orders');

    $response->assertOk();
    $response->assertSee('注文はまだありません');
});

it('注文一覧の時、自分の注文のみ表示されること', function (): void {
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->create();
    $other = User::factory()->create();

    Order::factory()->create(['user_id' => $user->id, 'reference' => 'MY-ORDER', 'currency_code' => 'JPY', 'compare_currency_code' => 'JPY']);
    Order::factory()->create(['user_id' => $other->id, 'reference' => 'OTHER-ORDER', 'currency_code' => 'JPY', 'compare_currency_code' => 'JPY']);

    $response = $this->actingAs($user)->get('/account/orders');

    $response->assertSee('MY-ORDER');
    $response->assertDontSee('OTHER-ORDER');
});
