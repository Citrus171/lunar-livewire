<?php

declare(strict_types=1);

use App\Livewire\Auth\RegisterPage;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Notification;
use Livewire\Livewire;

uses(RefreshDatabase::class);

it('/registerで新規登録フォームが表示されること', function (): void {
    $response = $this->get('/register');

    $response->assertOk();
    $response->assertSeeLivewire(RegisterPage::class);
});

it('必須フィールドが未入力の時、バリデーションエラーが表示されること', function (): void {
    Livewire::test(RegisterPage::class)
        ->call('register')
        ->assertHasErrors(['first_name', 'last_name', 'email', 'password']);
});

it('パスワードが一致しない時、バリデーションエラーが表示されること', function (): void {
    Livewire::test(RegisterPage::class)
        ->set('first_name', '山田')
        ->set('last_name', '太郎')
        ->set('email', 'test@example.com')
        ->set('password', 'password123')
        ->set('password_confirmation', 'different')
        ->call('register')
        ->assertHasErrors(['password']);
});

it('既存のメールアドレスで登録しようとした時、バリデーションエラーが表示されること', function (): void {
    User::factory()->create(['email' => 'existing@example.com']);

    Livewire::test(RegisterPage::class)
        ->set('first_name', '山田')
        ->set('last_name', '太郎')
        ->set('email', 'existing@example.com')
        ->set('password', 'password123')
        ->set('password_confirmation', 'password123')
        ->call('register')
        ->assertHasErrors(['email']);
});

it('正常登録後に/email/verifyへリダイレクトされること', function (): void {
    Notification::fake();

    Livewire::test(RegisterPage::class)
        ->set('first_name', '山田')
        ->set('last_name', '太郎')
        ->set('email', 'redirect@example.com')
        ->set('password', 'password123')
        ->set('password_confirmation', 'password123')
        ->call('register')
        ->assertRedirect('/email/verify');
});

it('正常な情報を入力した時、ユーザーがDBに保存されメール認証メールが送信されること', function (): void {
    Notification::fake();

    Livewire::test(RegisterPage::class)
        ->set('first_name', '山田')
        ->set('last_name', '太郎')
        ->set('email', 'newuser@example.com')
        ->set('password', 'password123')
        ->set('password_confirmation', 'password123')
        ->set('phone', '090-1234-5678')
        ->call('register');

    $user = User::where('email', 'newuser@example.com')->first();
    expect($user)->not->toBeNull();
    expect($user->first_name)->toBe('山田');
    expect($user->last_name)->toBe('太郎');
    expect($user->phone)->toBe('090-1234-5678');

    Notification::assertSentTo($user, \Illuminate\Auth\Notifications\VerifyEmail::class);
});
