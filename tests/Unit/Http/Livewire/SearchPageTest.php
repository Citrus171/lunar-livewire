<?php

declare(strict_types=1);

use App\Livewire\SearchPage;
use Illuminate\Pagination\LengthAwarePaginator;
use Livewire\Livewire;

it('renders search page', function (): void {
    Livewire::test(SearchPage::class)
        ->assertViewIs('livewire.search-page');
});

it('returns paginated search results', function (): void {
    $component = Livewire::test(SearchPage::class);

    expect($component->instance()->results())
        ->toBeInstanceOf(LengthAwarePaginator::class)
        ->and($component->instance()->results()->perPage())
        ->toBe(50);
});
