<?php

declare(strict_types=1);

use App\Livewire\Components\AddToCart;
use Livewire\Livewire;
use Lunar\Facades\CartSession;
use Lunar\Models\Cart;
use Lunar\Models\Language;
use Lunar\Models\Product;
use Lunar\Models\ProductVariant;

it('fails when requested quantity exceeds stock', function (): void {
    Language::factory()->create(['default' => true]);
    $purchasable = ProductVariant::factory()
        ->for(Product::factory())
        ->create(['stock' => 1]);

    Livewire::test(AddToCart::class, ['purchasable' => $purchasable])
        ->set('quantity', 2)
        ->call('addToCart')
        ->assertHasErrors(['quantity']);
});

it('adds item to cart when stock is sufficient', function (): void {
    Language::factory()->create(['default' => true]);
    $purchasable = ProductVariant::factory()
        ->for(Product::factory())
        ->create(['stock' => 10]);

    $cart = Mockery::mock(Cart::class);
    $cart->shouldReceive('add')->once()->with(Mockery::type(ProductVariant::class), 2);

    CartSession::shouldReceive('manager')->andReturn($cart);

    Livewire::test(AddToCart::class, ['purchasable' => $purchasable])
        ->set('quantity', 2)
        ->call('addToCart')
        ->assertDispatched('add-to-cart');
});
