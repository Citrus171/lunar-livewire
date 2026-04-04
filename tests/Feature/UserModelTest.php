<?php

declare(strict_types=1);

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

it('usersテーブルにfirst_name・last_name・phoneカラムが存在すること', function () {
    expect(\Illuminate\Support\Facades\Schema::hasColumn('users', 'first_name'))->toBeTrue();
    expect(\Illuminate\Support\Facades\Schema::hasColumn('users', 'last_name'))->toBeTrue();
    expect(\Illuminate\Support\Facades\Schema::hasColumn('users', 'phone'))->toBeTrue();
});

it('phoneカラムがnullableであること', function () {
    $user = User::factory()->create([
        'first_name' => '太郎',
        'last_name' => '田中',
        'phone' => null,
    ]);

    expect($user->fresh()->phone)->toBeNull();
});

it('MustVerifyEmailを実装していること', function () {
    $user = new User();

    expect($user)->toBeInstanceOf(\Illuminate\Contracts\Auth\MustVerifyEmail::class);
});

it('first_name・last_name・phoneがfillableに含まれていること', function () {
    $fillable = (new User())->getFillable();

    expect($fillable)->toContain('first_name')
        ->toContain('last_name')
        ->toContain('phone');
});
