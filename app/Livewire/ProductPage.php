<?php

declare(strict_types=1);

namespace App\Livewire;

use App\Traits\FetchesUrls;
use Illuminate\Support\Collection;
use Illuminate\View\View;
use Livewire\Attributes\Computed;
use Livewire\Component;
use Lunar\Models\Product;
use Lunar\Models\ProductVariant;
use Spatie\MediaLibrary\MediaCollections\Models\Media;

class ProductPage extends Component
{
    use FetchesUrls;

    /**
     * The selected option values.
     */
    public array $selectedOptionValues = [];

    public function mount(string $slug): void
    {
        $this->url = $this->fetchUrl(
            $slug,
            (new Product)->getMorphClass(),
            [
                'element.media',
                'element.variants.basePrices.currency',
                'element.variants.basePrices.priceable',
                'element.variants.values.option',
            ]
        );

        abort_unless($this->url, 404);

        $this->selectedOptionValues = $this->productOptions->mapWithKeys(fn (array $data): array => [$data['option']->id => $data['values']->first()->id])->toArray();
    }

    /**
     * Computed property to get variant.
     */
    #[Computed]
    public function variant(): ProductVariant
    {
        return $this->product->variants->first(fn (ProductVariant $variant): bool => ! $variant->values->pluck('id')
            ->diff(
                collect($this->selectedOptionValues)->values()
            )->count());
    }

    /**
     * Computed property to return all available option values.
     */
    #[Computed]
    public function productOptionValues(): Collection
    {
        return $this->product->variants->pluck('values')->flatten();
    }

    /**
     * Computed propert to get available product options with values.
     */
    #[Computed]
    public function productOptions(): Collection
    {
        return $this->productOptionValues->unique('id')->groupBy('product_option_id')
            ->map(fn (Collection $values): array => [
                'option' => $values->first()->option,
                'values' => $values,
            ])->values();
    }

    /**
     * Computed property to return product.
     */
    #[Computed]
    public function product(): Product
    {
        return $this->url->element;
    }

    /**
     * Return all images for the product.
     */
    #[Computed]
    public function images(): Collection
    {
        return $this->product->media->sortBy('order_column');
    }

    /**
     * Computed property to return current image.
     */
    #[Computed]
    public function image(): ?Media
    {
        if (count($this->variant->images) > 0) {
            return $this->variant->images->first();
        }

        if ($primary = $this->images->first(fn (Media $media): mixed => $media->getCustomProperty('primary'))) {
            return $primary;
        }

        return $this->images->first();
    }

    public function render(): View
    {
        return view('livewire.product-page');
    }
}
