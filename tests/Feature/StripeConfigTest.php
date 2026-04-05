<?php

declare(strict_types=1);

it('config lunar.stripe が policy=automatic で設定されていること', function (): void {
    expect(config('lunar.stripe'))->not->toBeNull()
        ->and(config('lunar.stripe.policy'))->toBe('automatic');
});

it('config lunar.payments に stripe ドライバーが登録されていること', function (): void {
    expect(config('lunar.payments.types.stripe'))->not->toBeNull()
        ->and(config('lunar.payments.types.stripe.driver'))->toBe('stripe');
});

it('lunar_stripe_payment_intents テーブルが存在すること', function (): void {
    expect(\Illuminate\Support\Facades\Schema::hasTable('lunar_stripe_payment_intents'))->toBeTrue();
});

