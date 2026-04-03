<?php

declare(strict_types=1);

use App\Livewire\Components\CheckoutAddress as CheckoutAddressComponent;
use Livewire\Livewire;
use Lunar\Facades\CartSession;
use Lunar\Models\Cart;
use Lunar\Models\CartAddress;
use Lunar\Models\Country;
use Lunar\Models\TaxClass;
use Lunar\Models\TaxZone;

it('refreshes address from cart by type', function (): void {
    TaxClass::factory()->create(['default' => true]);
    TaxZone::factory()->create(['default' => true]);

    $country = Country::factory()->create();
    $cart = Cart::factory()->create();

    $address = $cart->addresses()->create(
        CartAddress::factory()->make([
            'type' => 'shipping',
            'country_id' => $country->id,
        ])->toArray()
    );

    CartSession::shouldReceive('current')->andReturn($cart->calculate());

    Livewire::test(CheckoutAddressComponent::class, ['type' => 'shipping'])
        ->set('editing', true)
        ->call('refreshAddress')
        ->assertSet('editing', false)
        ->assertSet('address.id', $address->id);
});

it('saves billing address details', function (): void {
    TaxClass::factory()->create(['default' => true]);
    TaxZone::factory()->create(['default' => true]);

    $country = Country::factory()->create();
    $cart = Cart::factory()->create();

    CartSession::shouldReceive('current')->andReturn($cart->calculate());

    Livewire::test(CheckoutAddressComponent::class, ['type' => 'billing'])
        ->set('address.first_name', 'Tony')
        ->set('address.last_name', 'Stark')
        ->set('address.line_one', '10880 Malibu Point')
        ->set('address.city', 'Malibu')
        ->set('address.postcode', '90265')
        ->set('address.country_id', $country->id)
        ->set('address.contact_email', 'tony@example.com')
        ->call('save')
        ->assertHasNoErrors()
        ->assertSet('editing', false);

    expect($cart->fresh()->billingAddress)->not()->toBeNull();
});

it('saves shipping and billing when shipping-is-billing is enabled', function (): void {
    TaxClass::factory()->create(['default' => true]);
    TaxZone::factory()->create(['default' => true]);

    $country = Country::factory()->create();
    $cart = Cart::factory()->create();

    CartSession::shouldReceive('current')->andReturn($cart->calculate());

    Livewire::test(CheckoutAddressComponent::class, ['type' => 'shipping'])
        ->set('shippingIsBilling', true)
        ->set('address.first_name', 'Pepper')
        ->set('address.last_name', 'Potts')
        ->set('address.line_one', '200 Park Ave')
        ->set('address.city', 'New York')
        ->set('address.postcode', '10017')
        ->set('address.country_id', $country->id)
        ->set('address.contact_email', 'pepper@example.com')
        ->call('save')
        ->assertHasNoErrors();

    $freshCart = $cart->fresh();

    expect($freshCart->shippingAddress)->not()->toBeNull()
        ->and($freshCart->billingAddress)->not()->toBeNull();
});
