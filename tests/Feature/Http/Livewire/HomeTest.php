<?php

declare(strict_types=1);

it('renders home page with livewire components', function (): void {
    $this->get('/')
        ->assertStatus(200)
        ->assertSeeLivewire('home')
        ->assertSeeLivewire('components.navigation');
});
