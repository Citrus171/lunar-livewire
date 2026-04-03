<?php

declare(strict_types=1);

use App\Livewire\Home;
use Livewire\Livewire;

it('mounts home component', function (): void {
    Livewire::test(Home::class)
        ->assertViewIs('livewire.home');
});
