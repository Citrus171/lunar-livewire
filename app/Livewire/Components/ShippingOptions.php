<?php

namespace App\Livewire\Components;

use Illuminate\Support\Collection;
use Illuminate\View\View;
use Livewire\Component;
use Lunar\Facades\CartSession;
use Lunar\Facades\ShippingManifest;

class ShippingOptions extends Component
{
    /**
     * The chosen shipping option.
     */
    public ?string $chosenOption = null;

    public function mount(): void
    {
        if ($shippingOption = $this->shippingAddress?->shipping_option) {
            $option = $this->shippingOptions->first(function (\Lunar\DataTypes\ShippingOption $opt) use ($shippingOption): bool {
                return $opt->getIdentifier() == $shippingOption;
            });
            $this->chosenOption = $option?->getIdentifier();
        }
    }

    /**
     * Return available shipping options.
     */
    public function getShippingOptionsProperty(): Collection
    {
        return ShippingManifest::getOptions(
            CartSession::current()
        );
    }

    public function rules(): array
    {
        return [
            'chosenOption' => 'required',
        ];
    }

    /**
     * Save the shipping option.
     */
    public function save(): void
    {
        $this->validate();

        $option = $this->shippingOptions->first(fn (\Lunar\DataTypes\ShippingOption $option) => $option->getIdentifier() == $this->chosenOption);

        CartSession::setShippingOption($option);

        $this->dispatch('selectedShippingOption');
    }

    /**
     * Return whether we have a shipping address.
     */
    public function getShippingAddressProperty(): ?\Lunar\Models\CartAddress
    {
        return CartSession::getCart()->shippingAddress;
    }

    public function render(): View
    {
        return view('livewire.components.shipping-options');
    }
}
