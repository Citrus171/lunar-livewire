<?php

declare(strict_types=1);

use App\Livewire\CheckoutSuccessPage;
use Livewire\Livewire;
use Lunar\Facades\CartSession;
use Lunar\Models\Cart;
use Lunar\Models\Order;

it('redirects to home when there is no completed order', function (): void {
    CartSession::shouldReceive('current')->andReturn(null);

    Livewire::test(CheckoutSuccessPage::class)
        ->assertRedirect('/');
});

it('sets completed order and clears cart session', function (): void {
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
