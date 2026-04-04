<?php

declare(strict_types=1);

use App\Livewire\Auth\ForgotPasswordPage;
use App\Livewire\Auth\ResetPasswordPage;
use App\Models\User;
use Illuminate\Auth\Notifications\ResetPassword;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\Password;
use Livewire\Livewire;

it('/forgot-passwordでパスワードリセット申請フォームが表示されること', function (): void {
    $response = $this->get('/forgot-password');

    $response->assertOk();
});

it('登録済みメールアドレスを入力した時、リセットメールが送信されること', function (): void {
    Notification::fake();

    $user = User::factory()->create();

    Livewire::test(ForgotPasswordPage::class)
        ->set('email', $user->email)
        ->call('sendResetLink')
        ->assertSet('sent', true);

    Notification::assertSentTo($user, ResetPassword::class);
});

it('未登録のメールアドレスを入力した時、メール存在有無が漏洩しないこと', function (): void {
    Notification::fake();

    Livewire::test(ForgotPasswordPage::class)
        ->set('email', 'nonexistent@example.com')
        ->call('sendResetLink')
        ->assertSet('sent', true);

    Notification::assertNothingSent();
});

it('/reset-passwordでパスワード再設定フォームが表示されること', function (): void {
    $response = $this->get('/reset-password/dummy-token');

    $response->assertOk();
});

it('有効なトークンで新しいパスワードを設定できること', function (): void {
    $user = User::factory()->create();
    $token = Password::createToken($user);

    Livewire::test(ResetPasswordPage::class, ['token' => $token])
        ->set('email', $user->email)
        ->set('password', 'new-password123')
        ->set('password_confirmation', 'new-password123')
        ->call('resetPassword')
        ->assertRedirect('/login');
});

it('パスワードリセット完了後に/loginへリダイレクトされること', function (): void {
    $user = User::factory()->create();
    $token = Password::createToken($user);

    $component = Livewire::test(ResetPasswordPage::class, ['token' => $token])
        ->set('email', $user->email)
        ->set('password', 'new-password123')
        ->set('password_confirmation', 'new-password123')
        ->call('resetPassword');

    $component->assertRedirect('/login');
});

it('無効なトークンを使用した時、エラーメッセージが表示されること', function (): void {
    $user = User::factory()->create();

    Livewire::test(ResetPasswordPage::class, ['token' => 'invalid-token'])
        ->set('email', $user->email)
        ->set('password', 'new-password123')
        ->set('password_confirmation', 'new-password123')
        ->call('resetPassword')
        ->assertHasErrors(['email']);
});
