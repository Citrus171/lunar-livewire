<?php

declare(strict_types=1);

namespace App\Listeners;

use Illuminate\Auth\Events\Verified;
use Lunar\Models\Order;

class AttachGuestOrdersToVerifiedUser
{
    public function handle(Verified $event): void
    {
        $email = $event->user->getEmailForVerification();
        $userId = data_get($event->user, 'id');

        if (blank($email) || ! is_numeric($userId)) {
            return;
        }

        Order::query()
            ->whereNull('user_id')
            ->whereHas('addresses', function ($query) use ($email): void {
                $query->where('contact_email', $email);
            })
            ->update([
                'user_id' => (int) $userId,
            ]);
    }
}