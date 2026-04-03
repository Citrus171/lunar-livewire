<?php

declare(strict_types=1);

use App\Livewire\Components\Navigation;
use Livewire\Livewire;
use Lunar\Models\Collection;
use Lunar\Models\Language;

it('mounts navigation component', function (): void {
    Livewire::test(Navigation::class)
        ->assertViewIs('livewire.components.navigation');
});

it('renders all collections in navigation', function (): void {
    Language::factory()->create(['default' => true]);

    $collections = Collection::factory(5)
        ->hasUrls(1, ['default' => true])
        ->create();

    $component = Livewire::test(Navigation::class)
        ->assertCount('collections', $collections->count())
        ->assertViewIs('livewire.components.navigation');

    foreach ($collections as $collection) {
        $component->assertSee($collection->translateAttribute('name'));
    }
});
