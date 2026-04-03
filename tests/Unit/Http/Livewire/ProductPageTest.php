<?php

declare(strict_types=1);

use App\Livewire\ProductPage;
use Illuminate\Http\UploadedFile;
use Livewire\Livewire;
use Lunar\Models\Currency;
use Lunar\Models\Language;
use Lunar\Models\Price;
use Lunar\Models\Product;
use Lunar\Models\ProductVariant;

it('mounts product page component', function (): void {
    Language::factory()->create(['default' => true]);

    $currency = Currency::factory()->create(['default' => true]);

    $product = Product::factory()
        ->hasUrls(1, ['default' => true])
        ->has(ProductVariant::factory()->afterCreating(function ($variant) use ($currency): void {
            $variant->prices()->create(
                Price::factory()->make(['currency_id' => $currency->id])->getAttributes()
            );
        }), 'variants')
        ->create();

    $product->addMedia(UploadedFile::fake()->image('product.jpg'))->toMediaCollection('images');

    Livewire::test(ProductPage::class, ['slug' => $product->defaultUrl->slug])
        ->assertViewIs('livewire.product-page');
});

it('loads the correct product', function (): void {
    Language::factory()->create(['default' => true]);

    $currency = Currency::factory()->create(['default' => true]);

    $product = Product::factory()
        ->hasUrls(1, ['default' => true])
        ->has(ProductVariant::factory()->afterCreating(function ($variant) use ($currency): void {
            $variant->prices()->create(
                Price::factory()->make(['currency_id' => $currency->id])->getAttributes()
            );
        }), 'variants')
        ->create();

    $product->addMedia(UploadedFile::fake()->image('product.jpg'))->toMediaCollection('images');

    Livewire::test(ProductPage::class, ['slug' => $product->defaultUrl->slug])
        ->assertViewIs('livewire.product-page')
        ->assertSet('product.id', $product->id);
});

it('renders product name', function (): void {
    Language::factory()->create(['default' => true]);

    $currency = Currency::factory()->create(['default' => true]);

    $product = Product::factory()
        ->hasUrls(1, ['default' => true])
        ->has(ProductVariant::factory()->afterCreating(function ($variant) use ($currency): void {
            $variant->prices()->create(
                Price::factory()->make(['currency_id' => $currency->id])->getAttributes()
            );
        }), 'variants')
        ->create();

    $product->addMedia(UploadedFile::fake()->image('product.jpg'))->toMediaCollection('images');

    Livewire::test(ProductPage::class, ['slug' => $product->defaultUrl->slug])
        ->assertViewIs('livewire.product-page')
        ->assertSee($product->translateAttribute('name'));
});
