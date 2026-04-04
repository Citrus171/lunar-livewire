<?php

declare(strict_types=1);

arch()->preset()->php();
arch()->preset()->security();

// アプリ固有コードに strict_types を強制
arch('strict types')
    ->expect([
        'App\Livewire',
        'App\Models',
        'App\Traits',
        'App\Modifiers',
        'App\View',
    ])
    ->toUseStrictTypes();
