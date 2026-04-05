<?php

declare(strict_types=1);

use Lunar\Base\DataTransferObjects\PaymentAuthorize;
use Lunar\Facades\CartSession;
use Lunar\Facades\Payments;
use Lunar\Models\Cart;
use Lunar\Models\Currency;

it('カートあり状態で /checkout にアクセスすると 200 が返ること', function (): void {
    Currency::factory()->create(['code' => 'GBP', 'decimal_places' => 2, 'default' => true]);
    $cart = Cart::factory()->create()->calculate();
    CartSession::shouldReceive('current')->andReturn($cart);

    $response = $this->get('/checkout');

    $response->assertOk();
});

it('カートなし状態で /checkout にアクセスするとトップページにリダイレクトされること', function (): void {
    CartSession::shouldReceive('current')->andReturn(null);

    $response = $this->get('/checkout');

    $response->assertRedirect('/');
});

it('payment_intentパラメータ付きでStripe authorize成功時に /checkout/success へリダイレクトされること', function (): void {
    $cart = Cart::factory()->create()->calculate();
    CartSession::shouldReceive('current')->andReturn($cart);

    $mockDriver = Mockery::mock();
    $mockDriver->shouldReceive('cart')->andReturnSelf();
    $mockDriver->shouldReceive('withData')->andReturnSelf();
    $mockDriver->shouldReceive('authorize')->andReturn(
        new PaymentAuthorize(success: true, orderId: 1)
    );
    Payments::shouldReceive('driver')->with('stripe')->andReturn($mockDriver);

    $response = $this->get('/checkout?payment_intent=pi_test_123&payment_intent_client_secret=pi_test_123_secret');

    $response->assertRedirectToSignedRoute('checkout-success.view', ['order' => 1]);
});

it('payment_intentパラメータ付きでStripe authorize失敗時にチェックアウトページが再表示されること', function (): void {
    Currency::factory()->create(['code' => 'GBP', 'decimal_places' => 2, 'default' => true]);
    $cart = Cart::factory()->create()->calculate();
    CartSession::shouldReceive('current')->andReturn($cart);

    $mockDriver = Mockery::mock();
    $mockDriver->shouldReceive('cart')->andReturnSelf();
    $mockDriver->shouldReceive('withData')->andReturnSelf();
    $mockDriver->shouldReceive('authorize')->andReturn(
        new PaymentAuthorize(success: false)
    );
    Payments::shouldReceive('driver')->with('stripe')->andReturn($mockDriver);

    $response = $this->get('/checkout?payment_intent=pi_test_456&payment_intent_client_secret=pi_test_456_secret');

    $response->assertOk();
});
