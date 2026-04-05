import { expect, test, type Page } from '@playwright/test';

/**
 * カートに商品を追加してチェックアウトページに遷移するヘルパー
 */
async function addProductAndGoToCheckout(page: Page): Promise<void> {
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

    await page.getByRole('button', { name: 'Add to Cart' }).click();
    await page.getByRole('button', { name: /^Cart$/ }).click();

    const cartPopover = page.locator('div[x-show="linesVisible"]').first();
    await expect(cartPopover).toBeVisible();
    await expect(cartPopover.getByText('Your cart is empty')).toHaveCount(0);
    await expect(cartPopover.getByText(productName)).toBeVisible();

    await page.goto('/checkout');
    await expect(page).toHaveURL('/checkout');
}

/**
 * 配送先住所フォームを入力してSave Addressするヘルパー
 */
async function fillShippingAddress(page: Page): Promise<void> {
    const section = page.locator('form').filter({ hasText: 'Shipping Details' });

    await section.getByLabel('First name').fill('Test');
    await section.getByLabel('Last name').fill('User');
    await section.getByLabel('Contact email').fill('test@example.com');
    await section.getByLabel('Address line 1').fill('123 Test Street');
    await section.getByLabel('City').fill('New York');
    await section.getByLabel('Postcode').fill('10001');
    await section.locator('select').selectOption({ label: 'United States' });

    await section.getByRole('button', { name: 'Save Address' }).click();
}

/**
 * 配送オプションを選択してChoose Shippingするヘルパー
 */
async function selectShippingOption(page: Page): Promise<void> {
    const shippingSection = page.locator('form').filter({ hasText: 'Shipping Options' });
    await expect(shippingSection).toBeVisible({ timeout: 10000 });

    // 最初のオプションを選択（デフォルト選択済みの場合もある）
    const firstOptionLabel = shippingSection.locator('label[for]').first();
    if (await firstOptionLabel.count() > 0) {
        await firstOptionLabel.click();
    }

    await shippingSection.getByRole('button', { name: 'Choose Shipping' }).click();
}

/**
 * Stripe Payment Elementのiframe内にカード情報を入力するヘルパー
 */
async function fillStripeCard(page: Page, cardNumber: string): Promise<void> {
    // Stripe Payment Element は実装やバージョンで iframe 名が変わるため、src でも検出する
    const stripeFrameSelector = 'iframe[src*="js.stripe.com"], iframe[name^="__privateStripeFrame"]';
    await expect(page.locator(stripeFrameSelector).first()).toBeVisible({ timeout: 30000 });

    const stripeFrame = page.frameLocator(stripeFrameSelector).first();
    const cardNumberInput = stripeFrame.locator(
        '[placeholder="1234 1234 1234 1234"], input[name="cardnumber"], input[autocomplete="cc-number"]'
    ).first();
    const expiryInput = stripeFrame.locator('[placeholder="MM / YY"], input[name="exp-date"], input[autocomplete="cc-exp"]').first();
    const cvcInput = stripeFrame.locator('[placeholder="CVC"], input[name="cvc"], input[autocomplete="cc-csc"]').first();

    await cardNumberInput.waitFor({ timeout: 30000 });
    await cardNumberInput.fill(cardNumber);
    await expiryInput.fill('12/30');
    await cvcInput.fill('123');
}

function shouldSkipStripeTest(): boolean {
    const key = process.env.STRIPE_KEY;

    return !key || !/^pk_(test|live)_/.test(key);
}

test('成功フロー: テストカード 4242 4242 4242 4242 で決済すると注文完了ページが表示されること', async ({ page }) => {
    test.setTimeout(90_000);
    test.skip(shouldSkipStripeTest(), '有効な STRIPE_KEY (pk_test_*/pk_live_*) が未設定のため Stripe テストをスキップ');
    await addProductAndGoToCheckout(page);

    // ステップ1: 配送先住所を入力（shippingIsBilling=true がデフォルトなので請求先も自動設定）
    await fillShippingAddress(page);

    // ステップ2: 配送オプションを選択
    await selectShippingOption(page);

    // ステップ4: 支払いセクションに到達（請求先はステップ3をスキップ）
    const paymentSection = page.locator('div').filter({ hasText: 'Payment' }).first();
    await expect(paymentSection).toBeVisible({ timeout: 10000 });

    // カード払いを選択
    await page.getByRole('button', { name: 'Pay by card' }).click();
    await expect(page.getByRole('button', { name: 'Make Payment' })).toBeVisible({ timeout: 15000 });

    // Stripe Payment Elementが読み込まれるまで待機
    await expect(page.locator('iframe[src*="js.stripe.com"], iframe[name^="__privateStripeFrame"]').first()).toBeVisible({ timeout: 30000 });

    // テストカード入力
    await fillStripeCard(page, '4242424242424242');

    // 決済ボタンをクリック
    await page.getByRole('button', { name: 'Make Payment' }).click();

    // Stripe処理後、/checkout/success にリダイレクトされることを確認
    await expect(page).toHaveURL(/\/checkout\/success/, { timeout: 30000 });

    // 注文参照番号が表示されることを確認
    await expect(page.getByText('Order Successful!')).toBeVisible();
    await expect(page.getByText(/Your order reference number is/)).toBeVisible();
    // 注文参照番号が空でないことを確認
    const referenceText = page.locator('strong').filter({ hasText: /\S+/ }).first();
    await expect(referenceText).toBeVisible();
});

test('失敗フロー: 拒否カード 4000 0000 0000 0002 で決済するとインラインエラーが表示されること', async ({ page }) => {
    test.setTimeout(90_000);
    test.skip(shouldSkipStripeTest(), '有効な STRIPE_KEY (pk_test_*/pk_live_*) が未設定のため Stripe テストをスキップ');
    await addProductAndGoToCheckout(page);

    // ステップ1: 配送先住所を入力
    await fillShippingAddress(page);

    // ステップ2: 配送オプションを選択
    await selectShippingOption(page);

    // ステップ4: 支払いセクションに到達
    const paymentSection = page.locator('div').filter({ hasText: 'Payment' }).first();
    await expect(paymentSection).toBeVisible({ timeout: 10000 });

    // カード払いを選択
    await page.getByRole('button', { name: 'Pay by card' }).click();
    await expect(page.getByRole('button', { name: 'Make Payment' })).toBeVisible({ timeout: 15000 });

    // Stripe Payment Elementが読み込まれるまで待機
    await expect(page.locator('iframe[src*="js.stripe.com"], iframe[name^="__privateStripeFrame"]').first()).toBeVisible({ timeout: 30000 });

    // 拒否カードを入力
    await fillStripeCard(page, '4000000000000002');

    // 決済ボタンをクリック
    await page.getByRole('button', { name: 'Make Payment' }).click();

    // インラインエラーメッセージが表示されること
    // Alpine.jsのエラーdiv (x-show="error") またはLivewireのpaymentError表示
    const stripeErrorDiv = page.locator('[x-show="error"]').filter({ hasText: /\S+/ });
    const livewireErrorDiv = page.locator('[role="alert"]').filter({ hasText: /\S+/ });

    await expect(stripeErrorDiv.or(livewireErrorDiv)).toBeVisible({ timeout: 15000 });

    // エラー表示後もチェックアウトページに留まることを確認
    await expect(page).toHaveURL('/checkout');
});
