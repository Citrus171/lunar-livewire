<?php

declare(strict_types=1);

namespace App\Livewire;

use Illuminate\View\View;
use Livewire\Attributes\Computed;
use Livewire\Component;
use Lunar\Models\Collection;
use Lunar\Models\Product;
use Lunar\Models\Url;

class Home extends Component
{
    /**
     * Return the sale collection.
     */
    #[Computed]
    public function saleCollection(): ?Collection
    {
        return Url::whereElementType((new Collection)->getMorphClass())->whereSlug('sale')->first()?->element ?? null;
    }

    /**
     * Return all images in sale collection.
     */
    #[Computed]
    public function saleCollectionImages(): ?\Illuminate\Support\Collection
    {
        if (! $this->saleCollection() instanceof Collection) {
            return null;
        }

        $collectionProducts = $this->saleCollection()
            ->products()->inRandomOrder()->limit(4)->get();

        $saleImages = $collectionProducts->map(fn (Product $product) => $product->thumbnail);

        return $saleImages->chunk(2);
    }

    /**
     * Return a random collection.
     */
    #[Computed]
    public function randomCollection(): ?Collection
    {
        $collections = Url::whereElementType((new Collection)->getMorphClass());

        if ($this->saleCollection() instanceof Collection) {
            $collections = $collections->where('element_id', '!=', $this->saleCollection()?->id);
        }

        return $collections->inRandomOrder()->first()?->element;
    }

    public function render(): View
    {
        return view('livewire.home');
    }
}
