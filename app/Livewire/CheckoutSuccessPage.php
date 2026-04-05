<?php

declare(strict_types=1);

namespace App\Livewire;

use Illuminate\View\View;
use Livewire\Component;
use Lunar\Facades\CartSession;
use Lunar\Models\Cart;
use Lunar\Models\Order;

class CheckoutSuccessPage extends Component
{
    public ?Cart $cart = null;

    public Order $order;

    public function mount(): void
    {
        if ($this->restoreOrderFromSignedUrl()) {
            return;
        }

        $this->cart = CartSession::current();
        if (! $this->cart || ! $this->cart->completedOrder) {
            $this->redirect('/');

            return;
        }

        $this->order = $this->cart->completedOrder;

        CartSession::forget();
    }

    protected function restoreOrderFromSignedUrl(): bool
    {
        if (! request()->hasValidSignature()) {
            return false;
        }

        $orderId = request()->integer('order');

        if (! $orderId) {
            return false;
        }

        $order = Order::query()
            ->whereKey($orderId)
            ->whereNotNull('placed_at')
            ->first();

        if (! $order) {
            return false;
        }

        $this->order = $order;
        CartSession::forget();

        return true;
    }

    public function render(): View
    {
        return view('livewire.checkout-success-page');
    }
}
