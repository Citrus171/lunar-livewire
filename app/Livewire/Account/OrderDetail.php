<?php

declare(strict_types=1);

namespace App\Livewire\Account;

use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;
use Livewire\Component;
use Lunar\Models\Order;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class OrderDetail extends Component
{
    public int $orderId;

    public function mount(int $orderId): void
    {
        $order = Order::query()->find($orderId);

        throw_if($order === null || $order->user_id !== Auth::id(), NotFoundHttpException::class);
    }

    public function render(): View
    {
        $order = Order::query()
            ->where('user_id', Auth::id())
            ->with(['lines', 'shippingAddress'])
            ->findOrFail($this->orderId);

        return view('livewire.account.orders.show', [
            'order' => $order,
        ]);
    }
}
