<?php

declare(strict_types=1);

namespace App\Livewire\Account;

use Illuminate\View\View;
use Livewire\Component;

class AccountIndex extends Component
{
    public function render(): View
    {
        return view('livewire.account.index');
    }
}
