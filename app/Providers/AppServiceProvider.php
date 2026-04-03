<?php

namespace App\Providers;

use App\Models\Product;
use App\Modifiers\ShippingModifier;
use Filament\Panel;
use Illuminate\Support\ServiceProvider;
use Lunar\Admin\Support\Facades\LunarPanel;
use Lunar\Base\ShippingModifiers;
use Lunar\Facades\ModelManifest;
use Lunar\Shipping\ShippingPlugin;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        LunarPanel::panel(
            fn (Panel $panel): Panel => $panel->plugins([
                new ShippingPlugin,
            ])
        )
            ->register();
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(ShippingModifiers $shippingModifiers): void
    {
        $shippingModifiers->add(
            ShippingModifier::class
        );

        ModelManifest::replace(
            \Lunar\Models\Contracts\Product::class,
            Product::class,
            // \App\Models\CustomProduct::class,
        );
    }
}
