<?php

declare(strict_types=1);

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Lunar\Models\Currency;
use Lunar\Models\Order;

uses(RefreshDatabase::class);

it('ウェルカムメッセージにfirst_nameが表示されること', function (): void {
    $user = User::factory()->create(['first_name' => 'Taro']);

    $response = $this->actingAs($user)->get('/account');

    $response->assertOk();
    $response->assertSee('Taro');
});

it('直近3件の注文が表示されること', function (): void {
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->create();

    Order::factory()->count(4)->create([
        'user_id' => $user->id,
        'currency_code' => 'JPY',
        'compare_currency_code' => 'JPY',
        'reference' => fn () => 'ORD-' . fake()->unique()->numerify('####'),
        'placed_at' => now(),
        'status' => 'payment-received',
    ]);

    $latestOrders = Order::query()
        ->where('user_id', $user->id)
        ->orderByDesc('placed_at')
        ->limit(3)
        ->get();

    $response = $this->actingAs($user)->get('/account');

    $response->assertOk();
    $latestOrders->each(fn ($order) => $response->assertSee($order->reference));
    $response->assertDontSee(
        Order::query()->where('user_id', $user->id)
            ->orderBy('placed_at')
            ->first()
            ->reference
    );
});

it('注文履歴ページへのリンクが表示されること', function (): void {
    $user = User::factory()->create();

    $response = $this->actingAs($user)->get('/account');

    $response->assertOk();
    $response->assertSee('/account/orders');
});

it('ログアウトボタンが表示されること', function (): void {
    $user = User::factory()->create();

    $response = $this->actingAs($user)->get('/account');

    $response->assertOk();
    $response->assertSee('logout');
});
