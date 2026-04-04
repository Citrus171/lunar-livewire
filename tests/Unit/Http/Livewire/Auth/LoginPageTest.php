<?php

declare(strict_types=1);

use App\Livewire\Auth\LoginPage;
use App\Models\User;
use Livewire\Livewire;

it('/loginでログインフォームが表示されること', function (): void {
    $response = $this->get('/login');

    $response->assertOk();
    $response->assertSeeLivewire(LoginPage::class);
});

it('正しい認証情報でログインすると/accountへリダイレクトされること', function (): void {
    $user = User::factory()->create([
        'email' => 'test@example.com',
        'password' => bcrypt('password'),
    ]);

    Livewire::test(LoginPage::class)
        ->set('email', 'test@example.com')
        ->set('password', 'password')
        ->call('login')
        ->assertRedirect('/account');
});

it('誤った認証情報でエラーメッセージが表示されること', function (): void {
    Livewire::test(LoginPage::class)
        ->set('email', 'wrong@example.com')
        ->set('password', 'wrongpassword')
        ->call('login')
        ->assertHasErrors(['email']);
});
