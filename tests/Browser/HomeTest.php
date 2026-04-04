<?php

declare(strict_types=1);

it('shows the welcome banner on the home page', function (): void {
    $page = visit('/');

    $page->assertTitle('Demo Storefront')
        ->assertSee('Welcome to the')
        ->assertSee('Lunar');
});

it('home page path is root', function (): void {
    $page = visit('/');

    $page->assertPathIs('/');
});
