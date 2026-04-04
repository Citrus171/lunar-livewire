# テスト一覧

## Unit

### ArchTest
- [ ] preset → php
- [ ] preset → security
- [ ] strict types

### Http/Livewire/HomeTest
- [ ] mounts home component
- [ ] returns null sale collection images when sale collection does not exist
- [ ] returns chunked sale collection images when sale collection exists
- [ ] does not return sale collection as random collection

### Http/Livewire/CollectionPageTest
- [ ] mounts collection page component
- [ ] renders collection name
- [ ] renders products in collection
- [ ] returns 404 for unknown slug

### Http/Livewire/ProductPageTest
- [ ] mounts product page component
- [ ] loads the correct product
- [ ] renders product name

### Http/Livewire/CheckoutPageTest
- [ ] mounts checkout component
- [ ] has correct step on load
- [ ] has correct step with shipping address on load
- [ ] is on billing step when shipping option is selected
- [ ] is on payment step when billing address exists
- [ ] can save shipping address
- [ ] can save billing address

### Http/Livewire/CheckoutSuccessPageTest
- [ ] redirects to home when there is no completed order
- [ ] sets completed order and clears cart session

### Http/Livewire/SearchPageTest
- [ ] renders search page
- [ ] returns paginated search results

### Http/Livewire/Components/AddToCartTest
- [ ] adds item to cart when stock is sufficient
- [ ] fails when requested quantity exceeds stock

### Http/Livewire/Components/CartTest
- [ ] renders cart component
- [ ] shows cart lines after add-to-cart event
- [ ] removes a cart line
- [ ] updates editable cart lines

### Http/Livewire/Components/CheckoutAddressTest
- [ ] refreshes address from cart by type
- [ ] saves billing address details
- [ ] saves shipping and billing when shipping-is-billing is enabled

### Http/Livewire/Auth/LoginPageTest
- [ ] /loginでログインフォームが表示されること
- [ ] 正しい認証情報でログインすると/accountへリダイレクトされること
- [ ] 誤った認証情報でエラーメッセージが表示されること

### Http/Livewire/Components/NavigationTest
- [ ] mounts navigation component
- [ ] renders all collections in navigation
- [ ] 未ログイン状態のナビに「ログイン」「新規登録」リンクが表示されること
- [ ] ログイン済み状態のナビに「マイページ」リンクが表示されること
- [ ] ログアウトすると/へリダイレクトされること

### Http/Livewire/Components/ShippingOptionsTest
- [ ] validates selected option and saves it into cart session
- [ ] preselects shipping option from shipping address

## Feature

### UserModelTest
- [ ] usersテーブルにfirst_name・last_name・phoneカラムが存在すること
- [ ] phoneカラムがnullableであること
- [ ] MustVerifyEmailを実装していること
- [ ] first_name・last_name・phoneがfillableに含まれていること

### Auth/AuthTest
- [ ] ログアウト後にトップページ（/）へリダイレクトされること
- [ ] 未認証状態で/accountにアクセスすると/loginへリダイレクトされること

### Http/Livewire/HomeTest
- [ ] renders home page with livewire components

## Browser (pest-plugin-browser)

### Browser/HomeTest
- [ ] shows the welcome banner on the home page
- [ ] home page path is root

## E2E (Playwright/TypeScript)

### e2e/home.spec.ts
- [ ] home page responds successfully
- [ ] can add a product to cart from product detail page
