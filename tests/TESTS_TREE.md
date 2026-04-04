# テスト構造

```
tests/
├── Unit/
│   ├── ArchTest.php
│   │   ├── preset → php
│   │   ├── preset → security
│   │   └── strict types
│   └── Http/
│       └── Livewire/
│           ├── HomeTest.php
│           │   ├── mounts home component
│           │   ├── returns null sale collection images when sale collection does not exist
│           │   ├── returns chunked sale collection images when sale collection exists
│           │   └── does not return sale collection as random collection
│           ├── CollectionPageTest.php
│           │   ├── mounts collection page component
│           │   ├── renders collection name
│           │   ├── renders products in collection
│           │   └── returns 404 for unknown slug
│           ├── ProductPageTest.php
│           │   ├── mounts product page component
│           │   ├── loads the correct product
│           │   └── renders product name
│           ├── CheckoutPageTest.php
│           │   ├── mounts checkout component
│           │   ├── has correct step on load
│           │   ├── has correct step with shipping address on load
│           │   ├── is on billing step when shipping option is selected
│           │   ├── is on payment step when billing address exists
│           │   ├── can save shipping address
│           │   └── can save billing address
│           ├── CheckoutSuccessPageTest.php
│           │   ├── redirects to home when there is no completed order
│           │   └── sets completed order and clears cart session
│           ├── SearchPageTest.php
│           │   ├── renders search page
│           │   └── returns paginated search results
│           ├── Auth/
│           │   └── LoginPageTest.php
│           │       ├── /loginでログインフォームが表示されること
│           │       ├── 正しい認証情報でログインすると/accountへリダイレクトされること
│           │       └── 誤った認証情報でエラーメッセージが表示されること
│           └── Components/
│               ├── AddToCartTest.php
│               │   ├── adds item to cart when stock is sufficient
│               │   └── fails when requested quantity exceeds stock
│               ├── CartTest.php
│               │   ├── renders cart component
│               │   ├── shows cart lines after add-to-cart event
│               │   ├── removes a cart line
│               │   └── updates editable cart lines
│               ├── CheckoutAddressTest.php
│               │   ├── refreshes address from cart by type
│               │   ├── saves billing address details
│               │   └── saves shipping and billing when shipping-is-billing is enabled
│               ├── NavigationTest.php
│               │   ├── mounts navigation component
│               │   ├── renders all collections in navigation
│               │   ├── 未ログイン状態のナビに「ログイン」「新規登録」リンクが表示されること
│               │   ├── ログイン済み状態のナビに「マイページ」リンクが表示されること
│               │   └── ログアウトすると/へリダイレクトされること
│               └── ShippingOptionsTest.php
│                   ├── validates selected option and saves it into cart session
│                   └── preselects shipping option from shipping address
├── Feature/
│   ├── UserModelTest.php
│   │   ├── usersテーブルにfirst_name・last_name・phoneカラムが存在すること
│   │   ├── phoneカラムがnullableであること
│   │   ├── MustVerifyEmailを実装していること
│   │   └── first_name・last_name・phoneがfillableに含まれていること
│   ├── Auth/
│   │   └── AuthTest.php
│   │       ├── ログアウト後にトップページ（/）へリダイレクトされること
│   │       └── 未認証状態で/accountにアクセスすると/loginへリダイレクトされること
│   └── Http/
│       └── Livewire/
│           └── HomeTest.php
│               └── renders home page with livewire components
├── Browser/
│   └── HomeTest.php
│       ├── shows the welcome banner on the home page
│       └── home page path is root
└── e2e/
    └── home.spec.ts  (Playwright/TypeScript)
        ├── home page responds successfully
        └── can add a product to cart from product detail page
```
