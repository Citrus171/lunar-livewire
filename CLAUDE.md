# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Lunar PHP Livewire Starter Kit — Laravel + Livewire ベースのヘッドレス EC デモアプリ。
`lunarphp/lunar` パッケージの実装例であり、本番利用を想定したものではない。

## Commands

### フロントエンド
```bash
npm run dev      # Vite 開発サーバー起動
npm run build    # 本番ビルド
```

### テスト
```bash
php artisan test                          # 全テスト実行
php artisan test --filter TestClassName   # 単一テスト実行
./vendor/bin/phpunit                      # phpunit 直接実行
```
テスト環境は SQLite インメモリ（`phpunit.xml` で定義済み）。

### Artisan
```bash
php artisan lunar:install   # Lunar 初期化（初回のみ）
php artisan db:seed         # シードデータ投入
php artisan storage:link    # ストレージリンク作成
```

### Docker 環境
```bash
cp .env.docker.example .env
docker-compose up
```
サービス構成: MySQL 8 / Caddy / PHP-FPM / Meilisearch / Redis / Mailhog

### Lando 環境
```bash
lando start
cp .env.lando.example .env
lando artisan migrate
lando artisan lunar:install
lando artisan db:seed
lando artisan storage:link
```

## Architecture

### ルーティングと Livewire ページコンポーネント

`routes/web.php` のルートは全て full-page Livewire コンポーネントに直接マッピングされる：

| Route | Component |
|-------|-----------|
| `/` | `App\Livewire\Home` |
| `/collections/{slug}` | `App\Livewire\CollectionPage` |
| `/products/{slug}` | `App\Livewire\ProductPage` |
| `/search` | `App\Livewire\SearchPage` |
| `/checkout` | `App\Livewire\CheckoutPage` |
| `/checkout/success` | `App\Livewire\CheckoutSuccessPage` |

### サブコンポーネント (`app/Livewire/Components/`)

- `Cart` — カートの表示・行の更新・削除。`CartSession` ファサード経由で操作
- `AddToCart` — 商品をカートに追加
- `CheckoutAddress` — 住所フォーム（shipping/billing 共用）
- `ShippingOptions` — 配送オプション選択
- `Navigation` — ナビゲーションバー

### Lunar との統合ポイント

- **CartSession** ファサード: カートの取得・更新・配送オプション設定
- **Payments** ファサード: 決済処理（Stripe ドライバあり）
- **ShippingManifest** ファサード: 配送オプション一覧の取得
- **ModelManifest::replace()**: `AppServiceProvider` で `Lunar\Models\Product` を `App\Models\Product` に差し替え済み

### モデル拡張パターン

Lunar モデルを拡張する場合は `App\Models\Product` のように継承し、`AppServiceProvider::boot()` の `ModelManifest::replace()` で登録する。

### FetchesUrls トレイト

`App\Traits\FetchesUrls` は slug から `Lunar\Models\Url` を引くユーティリティ。`CollectionPage`・`ProductPage` などのページコンポーネントで使用。

### 管理画面

`/lunar` でアクセス（デフォルト: `admin@lunarphp.io` / `password`）。`lunarphp/table-rate-shipping` の `ShippingPlugin` が登録済み。

### フロントエンド

Tailwind CSS v3 + Alpine.js（Livewire 経由）+ `@ryangjchandler/alpine-clipboard`。レイアウトは `resources/views/layouts/` に、ページビューは `resources/views/livewire/` に対応する blade ファイルが存在する。

## PHP規約

- 不要なPHP Annotationsを書かない（`@` で始まる型アノテーション以外）

### コンストラクタ
- `__construct()` ではコンストラクタプロパティプロモーションを使用する
    - 例: `public function __construct(public GitHub $github) { }`
- パラメータが0個の空の `__construct()` は書かない（private コンストラクタを除く）

### 型宣言
- メソッド・関数には必ず明示的な戻り値型を宣言する
- メソッドパラメータには適切な型ヒントを使用する

### PHPDoc
- 必要に応じて配列のshape型定義を記述する

## Laravel規約

- `env()` をconfigファイル外で直接使用しない。必ず `config('app.name')` のように `config()` を使う
- N+1問題を防ぐためEager Loadingを使用する
- Eloquentリレーションメソッドには戻り値型ヒントを付ける
- バリデーションはコントローラにインラインで書かず、Form Requestクラスに分離する
- `DB::` を避け、`Model::query()` を優先する

## テスト規約

- 変更には必ずテストを書くか既存テストを更新する
- happy path・失敗ケース・境界値を必ずテストする
- `php artisan test --compact` でフィルタを使い最小限のテストを実行する

## Notes

### テスト一覧ファイルの更新

テストコードを追加・変更・削除した後は、必ず以下の2つのファイルを最新の状態に更新すること。

- `tests/TESTS.md` — チェックボックス付きリスト形式
- `tests/TESTS_TREE.md` — ツリー形式
