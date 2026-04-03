<?php

declare(strict_types=1);

use App\Livewire\Components\Cart as CartComponent;
use Livewire\Livewire;
use Lunar\Facades\CartSession;
use Lunar\Models\Cart;

it('renders cart component', function (): void {
    CartSession::shouldReceive('current')->andReturn(Cart::factory()->create()->calculate());

    Livewire::test(CartComponent::class)
        ->assertViewIs('livewire.components.cart');
});

it('updates editable cart lines', function (): void {
    $cart = Cart::factory()->create()->calculate();

    CartSession::shouldReceive('current')->andReturn($cart);
    CartSession::shouldReceive('updateLines')->once();

    Livewire::test(CartComponent::class)
        ->set('lines', [
            [
                'id' => 1,
                'identifier' => 'SKU-1',
                'quantity' => 2,
                'description' => 'Test item',
                'thumbnail' => null,
                'option' => null,
                'options' => 'Default',
                'sub_total' => 'GBP 10.00',
                'unit_price' => 'GBP 5.00',
            ],
        ])
        ->call('updateLines')
        ->assertDispatched('cartUpdated');
});

it('removes a cart line', function (): void {
    $cart = Cart::factory()->create()->calculate();

    CartSession::shouldReceive('current')->andReturn($cart);
    CartSession::shouldReceive('remove')->once()->with(123);

    Livewire::test(CartComponent::class)
        ->call('removeLine', 123);
});

it('shows cart lines after add-to-cart event', function (): void {
    CartSession::shouldReceive('current')->andReturn(Cart::factory()->create()->calculate());

    Livewire::test(CartComponent::class)
        ->call('handleAddToCart')
        ->assertSet('linesVisible', true);
});
