<?php

declare(strict_types=1);

namespace App\Livewire\Auth;

use Illuminate\View\View;
use Livewire\Component;

class VerifyEmailPage extends Component
{
    public function render(): View
    {
        return view('livewire.auth.verify-email-page');
    }
}
