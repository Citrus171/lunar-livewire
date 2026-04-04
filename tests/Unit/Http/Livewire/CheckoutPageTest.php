<?php

declare(strict_types=1);

use App\Livewire\CheckoutPage;
use Illuminate\Support\Facades\Config;
use Livewire\Livewire;
use Lunar\Base\DataTransferObjects\PaymentAuthorize;
use Lunar\Facades\CartSession;
use Lunar\Facades\Payments;
use Lunar\Models\Cart;
use Lunar\Models\CartAddress;
use Lunar\Models\Country;
use Lunar\Models\TaxClass;
use Lunar\Models\TaxZone;

it('mounts checkout component', function (): void {
    CartSession::shouldReceive('current')->andReturn(
        Cart::factory()->create()->calculate()
    );

    Livewire::test(CheckoutPage::class)
        ->assertViewIs('livewire.checkout-page');
});

it('has correct step on load', function (): void {
    CartSession::shouldReceive('current')->andReturn(
        Cart::factory()->create()->calculate()
    );

    Livewire::test(CheckoutPage::class)
        ->assertViewIs('livewire.checkout-page')
        ->assertSet('currentStep', 1);
});

it('has correct step with shipping address on load', function (): void {
    TaxClass::factory()->create(['default' => true]);

    $cart = Cart::factory()->create();
    $cart->addresses()->create(
        CartAddress::factory()->make(['type' => 'shipping'])->toArray()
    );

    CartSession::shouldReceive('current')->andReturn($cart->calculate());

    Livewire::test(CheckoutPage::class)
        ->assertViewIs('livewire.checkout-page')
        ->assertSet('currentStep', 2);
});

it('is on billing step when shipping option is selected', function (): void {
    Config::set('shipping-tables.enabled', false);

    TaxClass::factory()->create(['default' => true]);
    TaxZone::factory()->create(['default' => true]);

    $cart = Cart::factory()->create();
    $cart->addresses()->create(
        CartAddress::factory()->make(['type' => 'shipping', 'shipping_option' => 'BASDEL'])->toArray()
    );

    CartSession::shouldReceive('current')->andReturn($cart->calculate());

    Livewire::test(CheckoutPage::class)
        ->assertViewIs('livewire.checkout-page')
        ->assertSet('currentStep', 3);
});

it('is on payment step when billing address exists', function (): void {
    Config::set('shipping-tables.enabled', false);

    TaxClass::factory()->create(['default' => true]);
    TaxZone::factory()->create(['default' => true]);

    $cart = Cart::factory()->create();
    $cart->addresses()->create(
        CartAddress::factory()->make(['type' => 'shipping', 'shipping_option' => 'BASDEL'])->toArray()
    );
    $cart->addresses()->create(
        CartAddress::factory()->make(['type' => 'billing'])->toArray()
    );

    CartSession::shouldReceive('current')->andReturn($cart->calculate());

    Livewire::test(CheckoutPage::class)
        ->set('paymentType', 'cash')
        ->assertViewIs('livewire.checkout-page')
        ->assertSet('currentStep', 4);
});

it('can save shipping address', function (): void {
    TaxClass::factory()->create(['default' => true]);
    TaxZone::factory()->create(['default' => true]);

    $cart = Cart::factory()->create();

    CartSession::shouldReceive('getCart')->andReturn($cart->calculate());
    CartSession::shouldReceive('current')->andReturn($cart->calculate());

    $country = Country::factory()->create();

    Livewire::test(CheckoutPage::class)
        ->set('paymentType', 'cash')
        ->assertViewIs('livewire.checkout-page')
        ->call('saveAddress', 'shipping')
        ->assertHasErrors([
            'shipping.first_name' => 'required',
            'shipping.last_name' => 'required',
            'shipping.line_one' => 'required',
            'shipping.country_id' => 'required',
            'shipping.city' => 'required',
            'shipping.postcode' => 'required',
            'shipping.contact_email' => 'required',
        ])
        ->set('shipping.first_name', 'Tony')
        ->set('shipping.last_name', 'Stark')
        ->set('shipping.company_name', 'Stark Industries')
        ->set('shipping.line_one', '1200 Industrial Ave')
        ->set('shipping.line_two', null)
        ->set('shipping.line_three', null)
        ->set('shipping.city', 'Long Beach')
        ->set('shipping.state', 'CA')
        ->set('shipping.postcode', '90803')
        ->set('shipping.delivery_instructions', 'Press the buzzer')
        ->set('shipping.contact_email', 'deliveries@stark.co')
        ->set('shipping.contact_phone', '123123123')
        ->set('shipping.country_id', $country->id)
        ->call('saveAddress', 'shipping')
        ->assertHasNoErrors();

    $this->assertDatabaseHas((new CartAddress)->getTable(), [
        'first_name' => 'Tony',
        'last_name' => 'Stark',
        'company_name' => 'Stark Industries',
        'line_one' => '1200 Industrial Ave',
        'city' => 'Long Beach',
        'state' => 'CA',
        'postcode' => '90803',
        'delivery_instructions' => 'Press the buzzer',
        'contact_email' => 'deliveries@stark.co',
        'contact_phone' => '123123123',
        'country_id' => $country->id,
        'type' => 'shipping',
    ]);
});

it('can save billing address', function (): void {
    TaxClass::factory()->create(['default' => true]);
    TaxZone::factory()->create(['default' => true]);

    $cart = Cart::factory()->create();

    CartSession::shouldReceive('getCart')->andReturn($cart->calculate());
    CartSession::shouldReceive('current')->andReturn($cart->calculate());

    $country = Country::factory()->create();

    Livewire::test(CheckoutPage::class)
        ->set('paymentType', 'cash')
        ->assertViewIs('livewire.checkout-page')
        ->call('saveAddress', 'billing')
        ->assertHasErrors([
            'billing.first_name' => 'required',
            'billing.last_name' => 'required',
            'billing.line_one' => 'required',
            'billing.country_id' => 'required',
            'billing.city' => 'required',
            'billing.postcode' => 'required',
            'billing.contact_email' => 'required',
        ])
        ->set('billing.first_name', 'Tony')
        ->set('billing.last_name', 'Stark')
        ->set('billing.company_name', 'Stark Industries')
        ->set('billing.line_one', '1200 Industrial Ave')
        ->set('billing.line_two', null)
        ->set('billing.line_three', null)
        ->set('billing.city', 'Long Beach')
        ->set('billing.state', 'CA')
        ->set('billing.postcode', '90803')
        ->set('billing.delivery_instructions', 'Press the buzzer')
        ->set('billing.contact_email', 'deliveries@stark.co')
        ->set('billing.contact_phone', '123123123')
        ->set('billing.country_id', $country->id)
        ->call('saveAddress', 'billing')
        ->assertHasNoErrors();

    $this->assertDatabaseHas((new CartAddress)->getTable(), [
        'first_name' => 'Tony',
        'last_name' => 'Stark',
        'company_name' => 'Stark Industries',
        'line_one' => '1200 Industrial Ave',
        'city' => 'Long Beach',
        'state' => 'CA',
        'postcode' => '90803',
        'delivery_instructions' => 'Press the buzzer',
        'contact_email' => 'deliveries@stark.co',
        'contact_phone' => '123123123',
        'country_id' => $country->id,
        'type' => 'billing',
    ]);
});

it('カートが空の時、トップページにリダイレクトされること', function (): void {
    CartSession::shouldReceive('current')->andReturn(null);

    Livewire::test(CheckoutPage::class)
        ->assertRedirect('/');
});

it('決済が成功した時、チェックアウト完了ページにリダイレクトされること', function (): void {
    $cart = Cart::factory()->create()->calculate();
    CartSession::shouldReceive('current')->andReturn($cart);

    $mockDriver = Mockery::mock();
    $mockDriver->shouldReceive('withData')->andReturnSelf();
    $mockDriver->shouldReceive('authorize')->andReturn(
        new PaymentAuthorize(success: true, orderId: 1)
    );
    Payments::shouldReceive('cart')->andReturn($mockDriver);

    Livewire::test(CheckoutPage::class)
        ->call('checkout')
        ->assertRedirect(route('checkout-success.view'));
});
