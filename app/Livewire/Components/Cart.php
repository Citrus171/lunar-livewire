<?php

declare(strict_types=1);

namespace App\Livewire\Components;

use Illuminate\Support\Collection;
use Illuminate\View\View;
use Livewire\Attributes\Computed;
use Livewire\Component;
use Lunar\Facades\CartSession;
use Lunar\Models\CartLine;

class Cart extends Component
{
    /**
     * The editable cart lines.
     */
    public array $lines;

    public bool $linesVisible = false;

    protected $listeners = [
        'add-to-cart' => 'handleAddToCart',
    ];

    public function rules(): array
    {
        return [
            'lines.*.quantity' => 'required|numeric|min:1|max:10000',
        ];
    }

    public function mount(): void
    {
        $this->mapLines();
    }

    /**
     * Get the current cart instance.
     */
    #[Computed]
    public function cart(): ?\Lunar\Models\Cart
    {
        return CartSession::current();
    }

    /**
     * Return the cart lines from the cart.
     */
    #[Computed]
    public function cartLines(): Collection
    {
        return $this->cart->lines ?? collect();
    }

    /**
     * Update the cart lines.
     */
    public function updateLines(): void
    {
        $this->validate();

        CartSession::updateLines(
            collect($this->lines)
        );
        $this->mapLines();
        $this->dispatch('cartUpdated');
    }

    public function removeLine(int|string $id): void
    {
        CartSession::remove($id);
        $this->mapLines();
    }

    /**
     * Map the cart lines.
     *
     * We want to map out our cart lines like this so we can
     * add some validation rules and make them editable.
     */
    public function mapLines(): void
    {
        $this->lines = $this->cartLines->map(fn (CartLine $line): array => [
            'id' => $line->id,
            'identifier' => $line->purchasable->getIdentifier(),
            'quantity' => $line->quantity,
            'description' => $line->purchasable->getDescription(),
            'thumbnail' => $line->purchasable->getThumbnail()?->getUrl(),
            'option' => $line->purchasable->getOption(),
            'options' => $line->purchasable->getOptions()->implode(' / '),
            'sub_total' => $line->subTotal->formatted(),
            'unit_price' => $line->unitPrice->formatted(),
        ])->toArray();
    }

    public function handleAddToCart(): void
    {
        $this->mapLines();
        $this->linesVisible = true;
    }

    public function render(): View
    {
        return view('livewire.components.cart');
    }
}
