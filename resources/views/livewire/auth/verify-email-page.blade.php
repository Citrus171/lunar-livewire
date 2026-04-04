<div class="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8 text-center">
        <div>
            <h2 class="mt-6 text-3xl font-extrabold text-gray-900">
                メールアドレスの確認
            </h2>
            <p class="mt-4 text-sm text-gray-600">
                登録したメールアドレスに確認メールを送信しました。<br>
                メール内のリンクをクリックして、アカウントを有効化してください。
            </p>
        </div>

        <div class="mt-8 space-y-4">
            <form wire:submit="resend" class="mt-4">
                <button type="submit"
                        class="w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    確認メールを再送する
                </button>
            </form>

            <form action="{{ route('logout') }}" method="POST">
                @csrf
                <button type="submit" class="text-sm text-gray-600 hover:text-gray-900">
                    ログアウト
                </button>
            </form>
        </div>
    </div>
</div>
