<?php

declare(strict_types=1);

use App\Livewire\Auth\VerifyEmailPage;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\URL;

uses(RefreshDatabase::class);

it('/email/verifyでメール未認証ユーザーに案内ページが表示されること', function (): void {
    $user = User::factory()->unverified()->create();

    $response = $this->actingAs($user)->get('/email/verify');

    $response->assertOk();
    $response->assertSeeLivewire(VerifyEmailPage::class);
});

it('メール認証リンクをクリックするとアカウントが認証済みになること', function (): void {
    $user = User::factory()->unverified()->create();

    $verificationUrl = URL::temporarySignedRoute(
        'verification.verify',
        now()->addMinutes(60),
        ['id' => $user->id, 'hash' => sha1((string) $user->email)]
    );

    $response = $this->actingAs($user)->get($verificationUrl);

    $user->refresh();
    expect($user->hasVerifiedEmail())->toBeTrue();
    $response->assertRedirect('/account');
});
