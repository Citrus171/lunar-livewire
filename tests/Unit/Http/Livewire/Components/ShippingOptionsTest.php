<?php

declare(strict_types=1);

use App\Livewire\Components\ShippingOptions as ShippingOptionsComponent;
use Livewire\Livewire;
use Lunar\DataTypes\Price;
use Lunar\DataTypes\ShippingOption;
use Lunar\Facades\CartSession;
use Lunar\Facades\ShippingManifest;
use Lunar\Models\Cart;
use Lunar\Models\CartAddress;
use Lunar\Models\Currency;
use Lunar\Models\TaxClass;

it('preselects shipping option from shipping address', function (): void {
    $option = makeShippingOption('STANDARD');

    $cart = Cart::factory()->create();
    $cart->addresses()->create(
        CartAddress::factory()->make([
            'type' => 'shipping',
            'shipping_option' => 'STANDARD',
        ])->toArray()
    );

    CartSession::shouldReceive('current')->andReturn($cart->calculate());
    CartSession::shouldReceive('getCart')->andReturn($cart->fresh());
    ShippingManifest::shouldReceive('getOptions')->andReturn(collect([$option]));

    Livewire::test(ShippingOptionsComponent::class)
        ->assertSet('chosenOption', 'STANDARD');
});

it('validates selected option and saves it into cart session', function (): void {
    $option = makeShippingOption('EXPRESS');
    $cart = Cart::factory()->create();

    CartSession::shouldReceive('current')->andReturn($cart->calculate());
    CartSession::shouldReceive('getCart')->andReturn($cart);
    CartSession::shouldReceive('setShippingOption')->once()->with($option);
    ShippingManifest::shouldReceive('getOptions')->andReturn(collect([$option]));

    Livewire::test(ShippingOptionsComponent::class)
        ->set('chosenOption', 'EXPRESS')
        ->call('save')
        ->assertHasNoErrors()
        ->assertDispatched('selectedShippingOption');
});

function makeShippingOption(string $identifier): ShippingOption
{
    $currency = Currency::factory()->create(['default' => true]);
    $taxClass = TaxClass::factory()->create(['default' => true]);

    return new ShippingOption(
        name: 'Test Shipping',
        description: 'Test option',
        identifier: $identifier,
        price: new Price(1000, $currency),
        taxClass: $taxClass,
    );
}
