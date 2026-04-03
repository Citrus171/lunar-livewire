<?php

namespace App\Livewire;

use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\View\View;
use Livewire\Attributes\Computed;
use Livewire\Attributes\Url;
use Livewire\Component;
use Livewire\WithPagination;
use Lunar\Models\Product;

class SearchPage extends Component
{
    use WithPagination;

    /**
     * The search term.
     */
    #[Url]
    public ?string $term = null;

    /**
     * Return the search results.
     */
    #[Computed]
    public function results(): LengthAwarePaginator
    {
        return Product::search($this->term)->paginate(50);
    }

    public function render(): View
    {
        return view('livewire.search-page');
    }
}
