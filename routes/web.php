<?php

use App\Livewire\Account\AccountIndex;
use App\Livewire\Auth\ForgotPasswordPage;
use App\Livewire\Auth\LoginPage;
use App\Livewire\Auth\RegisterPage;
use App\Livewire\Auth\ResetPasswordPage;
use App\Livewire\Auth\VerifyEmailPage;
use App\Livewire\CheckoutPage;
use App\Livewire\CheckoutSuccessPage;
use App\Livewire\CollectionPage;
use App\Livewire\Home;
use App\Livewire\ProductPage;
use App\Livewire\SearchPage;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', Home::class);

Route::get('/collections/{slug}', CollectionPage::class)->name('collection.view');

Route::get('/products/{slug}', ProductPage::class)->name('product.view');

Route::get('search', SearchPage::class)->name('search.view');

Route::get('checkout', CheckoutPage::class)->name('checkout.view');

Route::get('checkout/success', CheckoutSuccessPage::class)->name('checkout-success.view');

Route::get('/login', LoginPage::class)->name('login')->middleware('guest');

Route::get('/forgot-password', ForgotPasswordPage::class)->name('password.request')->middleware('guest');

Route::get('/reset-password/{token}', ResetPasswordPage::class)->name('password.reset')->middleware('guest');

Route::get('/register', RegisterPage::class)->name('register')->middleware('guest');

Route::get('/email/verify', VerifyEmailPage::class)->name('verification.notice')->middleware('auth');

Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request): RedirectResponse {
    $request->fulfill();

    return redirect('/account');
})->middleware(['auth', 'signed', 'throttle:6,1'])->name('verification.verify');

Route::post('/email/verification-notification', function (Request $request): RedirectResponse {
    $request->user()->sendEmailVerificationNotification();

    return back()->with('status', 'verification-link-sent');
})->middleware(['auth', 'throttle:6,1'])->name('verification.send');

Route::post('/logout', function () {
    Auth::logout();
    request()->session()->invalidate();
    request()->session()->regenerateToken();

    return redirect('/');
})->name('logout');

Route::middleware(['auth', 'verified'])->prefix('account')->group(function (): void {
    Route::get('/', AccountIndex::class)->name('account.index');
});
