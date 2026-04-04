<?php

declare(strict_types=1);

use App\Models\User;

it('ログアウト後にトップページ（/）へリダイレクトされること', function (): void {
    $user = User::factory()->create();

    $response = $this->actingAs($user)->post('/logout');

    $response->assertRedirect('/');
    $this->assertGuest();
});

it('未認証状態で/accountにアクセスすると/loginへリダイレクトされること', function (): void {
    $response = $this->get('/account');

    $response->assertRedirect('/login');
});
