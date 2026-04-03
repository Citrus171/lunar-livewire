<?php

declare(strict_types=1);

use App\Livewire\CollectionPage;
use Livewire\Livewire;
use Lunar\Models\Collection;
use Lunar\Models\Currency;
use Lunar\Models\Language;
use Lunar\Models\Price;
use Lunar\Models\Product;
use Lunar\Models\ProductVariant;

it('mounts collection page component', function (): void {
    Language::factory()->create(['default' => true]);

    $collection = Collection::factory()
        ->hasUrls(1, ['default' => true])
        ->create();

    Livewire::test(CollectionPage::class, ['slug' => $collection->defaultUrl->slug])
        ->assertViewIs('livewire.collection-page');
});

it('returns 404 for unknown slug', function (): void {
    Language::factory()->create(['default' => true]);

    Collection::factory()
        ->hasUrls(1, ['default' => true])
        ->create();

    Livewire::test(CollectionPage::class, ['slug' => 'foobar'])
        ->assertStatus(404);
});

it('renders collection name', function (): void {
    Language::factory()->create(['default' => true]);

    $collection = Collection::factory()
        ->hasUrls(1, ['default' => true])
        ->create();

    Livewire::test(CollectionPage::class, ['slug' => $collection->defaultUrl->slug])
        ->assertSee($collection->translateAttribute('name'))
        ->assertViewIs('livewire.collection-page');
});

it('renders products in collection', function (): void {
    Language::factory()->create(['default' => true]);

    $currency = Currency::factory()->create(['default' => true]);

    $collection = Collection::factory()
        ->hasUrls(1, ['default' => true])
        ->has(
            Product::factory(4)
                ->hasUrls(1, ['default' => true])
                ->has(ProductVariant::factory()->afterCreating(function ($variant) use ($currency): void {
                    $variant->prices()->create(
                        Price::factory()->make(['currency_id' => $currency->id])->getAttributes()
                    );
                }), 'variants')
        )->create();

    $component = Livewire::test(CollectionPage::class, ['slug' => $collection->defaultUrl->slug])
        ->assertViewIs('livewire.collection-page');

    foreach ($collection->products as $product) {
        $component->assertSee($product->translateAttribute('name'));
    }
});
