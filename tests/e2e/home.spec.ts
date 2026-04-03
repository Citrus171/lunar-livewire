import { expect, test } from '@playwright/test';

test('home page responds successfully', async ({ page }) => {
    const response = await page.goto('/');

    expect(response?.ok()).toBeTruthy();
    await expect(page.locator('body')).toBeVisible();
});

test('can add a product to cart from product detail page', async ({ page }) => {
    await page.goto('/');

    let productCardLocator = page.locator('a[href*="/products/"]');

    if (await productCardLocator.count() === 0) {
        const firstCollectionLink = page.locator('a[href*="/collections/"]').first();
        await expect(firstCollectionLink).toBeVisible();
        await firstCollectionLink.click();
        await expect(page).toHaveURL(/\/collections\//);
        productCardLocator = page.locator('a[href*="/products/"]');
    }

    await expect(productCardLocator.first()).toBeVisible();

    const firstProductCard = productCardLocator.first();

    const productName = (await firstProductCard.locator('strong').first().innerText()).trim();

    await firstProductCard.click();

    await expect(page).toHaveURL(/\/products\//);
    await expect(page.getByRole('heading', { level: 1 })).toBeVisible();

    await page.getByRole('button', { name: 'Add to Cart' }).click();
    await page.getByRole('button', { name: /^Cart$/ }).click();

    const cartPopover = page.locator('div[x-show="linesVisible"]').first();
    await expect(cartPopover).toBeVisible();
    await expect(cartPopover.getByText('Your cart is empty')).toHaveCount(0);
    await expect(cartPopover.getByText(productName)).toBeVisible();
});