<?php

declare(strict_types=1);

namespace App\Livewire\Auth;

use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;
use Livewire\Attributes\Validate;
use Livewire\Component;

class LoginPage extends Component
{
    #[Validate('required|email')]
    public string $email = '';

    #[Validate('required')]
    public string $password = '';

    public function login(): void
    {
        $this->validate();

        if (! Auth::attempt(['email' => $this->email, 'password' => $this->password])) {
            $this->addError('email', 'メールアドレスまたはパスワードが正しくありません。');

            return;
        }

        $this->redirect('/account', navigate: true);
    }

    public function render(): View
    {
        return view('livewire.auth.login-page');
    }
}
