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
        // Stripe リダイレクト後は CartSession が新しい空カートを返すため、
        // セッションに保存した orderId から直接注文を取得する
        $orderId = session()->pull('checkout.completed_order_id');
        if ($orderId) {
            $order = Order::find($orderId);
            if ($order?->placed_at) {
                $this->order = $order;
                CartSession::forget();

                return;
            }
        }

        $this->cart = CartSession::current();
        if (! $this->cart || ! $this->cart->completedOrder) {
            $this->redirect('/');

            return;
        }

        $this->order = $this->cart->completedOrder;

        CartSession::forget();
    }

    public function render(): View
    {
        return view('livewire.checkout-success-page');
    }
}
