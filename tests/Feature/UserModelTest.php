<?php

declare(strict_types=1);

use App\Models\User;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Schema;

uses(RefreshDatabase::class);

it('usersテーブルにfirst_name・last_name・phoneカラムが存在すること', function (): void {
    expect(Schema::hasColumn('users', 'first_name'))->toBeTrue();
    expect(Schema::hasColumn('users', 'last_name'))->toBeTrue();
    expect(Schema::hasColumn('users', 'phone'))->toBeTrue();
});

it('phoneカラムがnullableであること', function (): void {
    $user = User::factory()->create([
        'first_name' => '太郎',
        'last_name' => '田中',
        'phone' => null,
    ]);

    expect($user->fresh()->phone)->toBeNull();
});

it('MustVerifyEmailを実装していること', function (): void {
    $user = new User();

    expect($user)->toBeInstanceOf(MustVerifyEmail::class);
});

it('first_name・last_name・phoneがfillableに含まれていること', function (): void {
    $fillable = (new User())->getFillable();

    expect($fillable)->toContain('first_name')
        ->toContain('last_name')
        ->toContain('phone');
});
