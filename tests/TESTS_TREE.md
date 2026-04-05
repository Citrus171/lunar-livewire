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
│           │   ├── can save billing address
│           │   ├── カートが空の時、トップページにリダイレクトされること
│           │   ├── 決済が成功した時、チェックアウト完了ページにリダイレクトされること
│           │   ├── 決済が失敗した時、チェックアウト完了ページにリダイレクトされないこと
│           │   ├── payment_intentパラメータ付きでStripe決済が成功した時、成功ページにリダイレクトされること
│           │   └── payment_intentパラメータ付きでStripe決済が失敗した時、成功ページにリダイレクトされないこと
│           ├── CheckoutSuccessPageTest.php
│           │   ├── redirects to home when there is no completed order
│           │   └── sets completed order and clears cart session
│           ├── SearchPageTest.php
│           │   ├── renders search page
│           │   └── returns paginated search results
│           ├── Auth/
│           │   ├── LoginPageTest.php
│           │   │   ├── /loginでログインフォームが表示されること
│           │   │   ├── 正しい認証情報でログインすると/accountへリダイレクトされること
│           │   │   └── 誤った認証情報でエラーメッセージが表示されること
│           │   ├── RegisterPageTest.php
│           │   │   ├── /registerで新規登録フォームが表示されること
│           │   │   ├── 必須フィールドが未入力の時、バリデーションエラーが表示されること
│           │   │   ├── パスワードが一致しない時、バリデーションエラーが表示されること
│           │   │   ├── 既存のメールアドレスで登録しようとした時、バリデーションエラーが表示されること
│           │   │   ├── 正常登録後に/email/verifyへリダイレクトされること
│           │   │   └── 正常な情報を入力した時、ユーザーがDBに保存されメール認証メールが送信されること
│           │   └── VerifyEmailPageTest.php
│           │       ├── /email/verifyでメール未認証ユーザーに案内ページが表示されること
│           │       └── メール認証リンクをクリックするとアカウントが認証済みになること
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
│   │   ├── AuthTest.php
│   │   │   ├── ログアウト後にトップページ（/）へリダイレクトされること
│   │   │   ├── 未認証状態で/accountにアクセスすると/loginへリダイレクトされること
│   │   │   ├── メール認証済みのユーザーが/accountにアクセスするとエラーなく表示されること
│   │   │   └── メール未認証のユーザーが/accountにアクセスすると/email/verifyへリダイレクトされること
│   │   └── PasswordResetTest.php
│   │       ├── /forgot-passwordでパスワードリセット申請フォームが表示されること
│   │       ├── 登録済みメールアドレスを入力した時、リセットメールが送信されること
│   │       ├── 未登録のメールアドレスを入力した時、メール存在有無が漏洩しないこと
│   │       ├── /reset-passwordでパスワード再設定フォームが表示されること
│   │       ├── 有効なトークンで新しいパスワードを設定できること
│   │       ├── パスワードリセット完了後に/loginへリダイレクトされること
│   │       └── 無効なトークンを使用した時、エラーメッセージが表示されること
│   │   └── LinkGuestOrdersAfterEmailVerificationTest.php
│   │       ├── メール認証完了の時、一致するゲスト注文が会員に紐付くこと
│   │       ├── メール認証完了の時、既に会員紐付け済みの注文は上書きされないこと
│   │       └── メール認証完了の時、紐付け対象の注文がなくてもエラーにならないこと
│   ├── Account/
│   │   ├── AccountIndexTest.php
│   │   │   ├── ウェルカムメッセージにfirst_nameが表示されること
│   │   │   ├── 直近3件の注文が表示されること
│   │   │   ├── 注文履歴テキストが表示されること
│   │   │   └── ログアウトボタンが表示されること
│   │   ├── OrderHistoryTest.php
│   │   │   ├── 注文一覧ページがログイン済みの時、表示されること
│   │   │   ├── 注文が0件の時、メッセージが表示されること
│   │   │   └── 注文一覧の時、自分の注文のみ表示されること
│   │   └── OrderDetailTest.php
│   │       ├── 他ユーザーの注文詳細にアクセスした時、404になること
│   │       ├── 注文詳細ページがログイン済みの時、表示されること
│   │       ├── 注文詳細の時、注文明細（商品名・数量・単価）が表示されること
│   │       └── 注文詳細の時、配送先住所が表示されること
│   ├── StripeConfigTest.php
│   │   ├── config lunar.stripe が policy=automatic で設定されていること
│   │   ├── config lunar.payments に stripe ドライバーが登録されていること
│   │   └── lunar_stripe_payment_intents テーブルが存在すること
│   └── Http/
│       ├── StripeWebhookTest.php
│       │   ├── services.stripe.webhooks.lunar に STRIPE_WEBHOOK_SECRET が設定されていること
│       │   ├── 不正なシグネチャを持つリクエストが 400 で拒否されること
│       │   └── 正当なシグネチャを持つ payment_intent.succeeded イベントが 200 で処理されること
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
