<?php

declare(strict_types=1);

namespace App\Livewire\Account;

use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;
use Livewire\Component;
use Lunar\Models\Order;

class AccountIndex extends Component
{
    public function render(): View
    {
        $recentOrders = Order::query()
            ->where('user_id', Auth::id())
            ->with('currency')
            ->latest('placed_at')
            ->limit(3)
            ->get();

        return view('livewire.account.index', [
            'recentOrders' => $recentOrders,
        ]);
    }
}
