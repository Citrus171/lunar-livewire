<?php

declare(strict_types=1);

use App\Livewire\Home;
use Livewire\Livewire;
use Lunar\Models\Collection;
use Lunar\Models\Currency;
use Lunar\Models\Language;
use Lunar\Models\Price;
use Lunar\Models\Product;
use Lunar\Models\ProductVariant;

it('mounts home component', function (): void {
    Livewire::test(Home::class)
        ->assertViewIs('livewire.home');
});

it('returns null sale collection images when sale collection does not exist', function (): void {
    $home = resolve(Home::class);

    expect($home->saleCollectionImages())->toBeNull();
});

it('returns chunked sale collection images when sale collection exists', function (): void {
    Language::factory()->create(['default' => true]);
    $currency = Currency::factory()->create(['default' => true]);

    $saleCollection = Collection::factory()
        ->hasUrls(1, [
            'default' => true,
            'slug' => 'sale',
        ])
        ->has(
            Product::factory(4)
                ->hasUrls(1, ['default' => true])
                ->has(ProductVariant::factory()->afterCreating(function ($variant) use ($currency): void {
                    $variant->prices()->create(
                        Price::factory()->make(['currency_id' => $currency->id])->getAttributes()
                    );
                }), 'variants')
        )
        ->create();

    $images = resolve(Home::class)->saleCollectionImages();

    expect($images)
        ->not()->toBeNull()
        ->and($images?->count())->toBe(2)
        ->and($saleCollection->products()->count())->toBe(4);
});

it('does not return sale collection as random collection', function (): void {
    Language::factory()->create(['default' => true]);

    Collection::factory()
        ->hasUrls(1, [
            'default' => true,
            'slug' => 'sale',
        ])
        ->create();

    $other = Collection::factory()
        ->hasUrls(1, [
            'default' => true,
            'slug' => 'other',
        ])
        ->create();

    $random = resolve(Home::class)->randomCollection();

    expect($random)->not()->toBeNull()
        ->and($random?->id)->toBe($other->id);
});
