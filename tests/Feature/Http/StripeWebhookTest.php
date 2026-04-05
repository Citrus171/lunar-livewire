<?php

declare(strict_types=1);

use Illuminate\Support\Facades\Queue;
use Lunar\Stripe\Jobs\ProcessStripeWebhook;

$generateStripeSignature = function (string $payload, string $secret): string {
    $timestamp = time();
    $signature = hash_hmac('sha256', "{$timestamp}.{$payload}", $secret);

    return "t={$timestamp},v1={$signature}";
};

it('services.stripe.webhooks.lunar に STRIPE_WEBHOOK_SECRET が設定されていること', function (): void {
    expect(config('services.stripe.webhooks.lunar'))->not->toBeNull()->not->toBeEmpty();
});

it('不正なシグネチャを持つリクエストが 400 で拒否されること', function (): void {
    $response = $this->withHeaders([
        'Stripe-Signature' => 'invalid_signature',
        'Content-Type' => 'application/json',
    ])->post('/stripe/webhook', []);

    $response->assertStatus(400);
});

it('正当なシグネチャを持つ payment_intent.succeeded イベントが 200 で処理されること', function () use ($generateStripeSignature): void {
    Queue::fake();

    $secret = config('services.stripe.webhooks.lunar');
    $payload = json_encode([
        'id' => 'evt_test_123',
        'type' => 'payment_intent.succeeded',
        'data' => [
            'object' => [
                'id' => 'pi_test_123',
                'object' => 'payment_intent',
                'metadata' => [],
            ],
        ],
    ]);

    $sig = $generateStripeSignature($payload, $secret);

    $response = $this->call(
        'POST',
        '/stripe/webhook',
        [],
        [],
        [],
        ['HTTP_Stripe-Signature' => $sig, 'CONTENT_TYPE' => 'application/json'],
        $payload
    );

    $response->assertStatus(200);
    Queue::assertPushed(ProcessStripeWebhook::class);
});
