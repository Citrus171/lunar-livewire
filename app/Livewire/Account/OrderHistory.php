<?php

declare(strict_types=1);

namespace App\Livewire\Account;

use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;
use Livewire\Component;
use Lunar\Models\Order;

class OrderHistory extends Component
{
    public function render(): View
    {
        $orders = Order::query()
            ->where('user_id', Auth::id())
            ->with(['currency'])
            ->latest('placed_at')
            ->get();

        return view('livewire.account.orders.index', [
            'orders' => $orders,
        ]);
    }
}
