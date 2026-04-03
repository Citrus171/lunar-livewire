<?php

namespace App\Livewire\Components;

use Illuminate\View\View;
use Livewire\Attributes\Computed;
use Livewire\Attributes\Url;
use Livewire\Component;
use Lunar\Models\Collection;

class Navigation extends Component
{
    /**
     * The search term for the search input.
     */
    #[Url]
    public ?string $term = null;

    /**
     * Return the collections in a tree.
     */
    #[Computed]
    public function collections(): \Illuminate\Support\Collection
    {
        return Collection::with(['defaultUrl'])->get()->toTree();
    }

    public function render(): View
    {
        return view('livewire.components.navigation');
    }
}
