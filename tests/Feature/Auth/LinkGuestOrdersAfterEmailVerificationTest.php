<?php

declare(strict_types=1);

use App\Models\User;
use Illuminate\Support\Facades\URL;
use Lunar\Models\Currency;
use Lunar\Models\Order;
use Lunar\Models\OrderAddress;

it('メール認証完了の時、一致するゲスト注文が会員に紐付くこと', function (): void {
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->unverified()->create([
        'email' => 'verified-user@example.com',
    ]);

    $order = Order::factory()->create([
        'user_id' => null,
        'reference' => 'GUEST-ORDER-001',
        'currency_code' => 'JPY',
        'compare_currency_code' => 'JPY',
    ]);

    OrderAddress::factory()->create([
        'order_id' => $order->id,
        'type' => 'billing',
        'contact_email' => $user->email,
    ]);

    $verificationUrl = URL::temporarySignedRoute(
        'verification.verify',
        now()->addMinutes(60),
        ['id' => $user->id, 'hash' => sha1((string) $user->email)]
    );

    $this->actingAs($user)->get($verificationUrl)->assertRedirect('/account');

    $order->refresh();

    expect($order->user_id)->toBe($user->id);

    $this->actingAs($user)
        ->get('/account/orders')
        ->assertOk()
        ->assertSee('GUEST-ORDER-001');
});

it('メール認証完了の時、既に会員紐付け済みの注文は上書きされないこと', function (): void {
    Currency::factory()->create(['code' => 'JPY', 'decimal_places' => 0, 'default' => true]);

    $user = User::factory()->unverified()->create([
        'email' => 'verified-user@example.com',
    ]);
    $alreadyLinkedUser = User::factory()->create();

    $order = Order::factory()->create([
        'user_id' => $alreadyLinkedUser->id,
        'reference' => 'LINKED-ORDER-001',
        'currency_code' => 'JPY',
        'compare_currency_code' => 'JPY',
    ]);

    OrderAddress::factory()->create([
        'order_id' => $order->id,
        'type' => 'billing',
        'contact_email' => $user->email,
    ]);

    $verificationUrl = URL::temporarySignedRoute(
        'verification.verify',
        now()->addMinutes(60),
        ['id' => $user->id, 'hash' => sha1((string) $user->email)]
    );

    $this->actingAs($user)->get($verificationUrl)->assertRedirect('/account');

    $order->refresh();

    expect($order->user_id)->toBe($alreadyLinkedUser->id)
        ->and($order->user_id)->not->toBe($user->id);
});

it('メール認証完了の時、紐付け対象の注文がなくてもエラーにならないこと', function (): void {
    $user = User::factory()->unverified()->create([
        'email' => 'no-target@example.com',
    ]);

    $verificationUrl = URL::temporarySignedRoute(
        'verification.verify',
        now()->addMinutes(60),
        ['id' => $user->id, 'hash' => sha1((string) $user->email)]
    );

    $this->actingAs($user)->get($verificationUrl)->assertRedirect('/account');

    $this->actingAs($user)
        ->get('/account/orders')
        ->assertOk()
        ->assertSee('注文はまだありません。');
});
