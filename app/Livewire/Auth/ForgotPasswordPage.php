<?php

declare(strict_types=1);

namespace App\Livewire\Auth;

use Illuminate\Support\Facades\Password;
use Illuminate\View\View;
use Livewire\Attributes\Validate;
use Livewire\Component;

class ForgotPasswordPage extends Component
{
    #[Validate('required|email')]
    public string $email = '';

    public bool $sent = false;

    public function sendResetLink(): void
    {
        $this->validate();

        Password::sendResetLink(['email' => $this->email]);

        $this->sent = true;
    }

    public function render(): View
    {
        return view('livewire.auth.forgot-password-page');
    }
}
