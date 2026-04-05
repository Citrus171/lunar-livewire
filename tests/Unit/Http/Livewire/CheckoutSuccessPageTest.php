<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Date;
use App\Livewire\CheckoutSuccessPage;
use Illuminate\Support\Facades\URL;
use Livewire\Livewire;
use Lunar\Facades\CartSession;
use Lunar\Models\Cart;
use Lunar\Models\Currency;
use Lunar\Models\Order;

it('redirects to home when there is no completed order', function (): void {
    CartSession::shouldReceive('current')->andReturn(null);

    Livewire::test(CheckoutSuccessPage::class)
        ->assertRedirect('/');
});

it('sets completed order and clears cart session', function (): void {
    Currency::query()->firstOrCreate(
        ['code' => 'GBP'],
        ['name' => 'Pound Sterling', 'enabled' => true, 'exchange_rate' => 1, 'decimal_places' => 2, 'default' => true]
    );

    $cart = Cart::factory()->create();
    $order = Order::factory()->create([
        'cart_id' => $cart->id,
        'placed_at' => now(),
    ]);

    CartSession::shouldReceive('current')->andReturn($cart->fresh());
    CartSession::shouldReceive('forget')->once();

    Livewire::test(CheckoutSuccessPage::class)
        ->assertSet('order.id', $order->id)
        ->assertViewIs('livewire.checkout-success-page');
});

it('署名付きURLから注文を復元し、再訪しても表示できること', function (): void {
    Date::setTestNow('2026-04-05 12:00:00');

    try {
        Currency::query()->firstOrCreate(
            ['code' => 'GBP'],
            ['name' => 'Pound Sterling', 'enabled' => true, 'exchange_rate' => 1, 'decimal_places' => 2, 'default' => true]
        );

        $order = Order::factory()->create([
            'placed_at' => now(),
        ]);

        CartSession::shouldReceive('forget')->twice();
        CartSession::shouldReceive('current')->zeroOrMoreTimes()->andReturn(null);

        $url = URL::temporarySignedRoute('checkout-success.view', now()->addMinutes(30), [
            'order' => $order->id,
        ]);

        $this->get($url)
            ->assertOk()
            ->assertSee('Order Successful!')
            ->assertSee($order->reference);

        $this->get($url)
            ->assertOk()
            ->assertSee('Order Successful!')
            ->assertSee($order->reference);
    } finally {
        Date::setTestNow();
    }
});
