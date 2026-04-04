<div class="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8">
        <div>
            <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
                パスワードをお忘れの方
            </h2>
        </div>

        @if ($sent)
            <div class="rounded-md bg-green-50 p-4">
                <p class="text-sm text-green-800">
                    パスワードリセット用のリンクをメールで送信しました。メールをご確認ください。
                </p>
            </div>
        @else
            <form wire:submit="sendResetLink" class="mt-8 space-y-6">
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">メールアドレス</label>
                    <input id="email"
                           wire:model="email"
                           type="email"
                           autocomplete="email"
                           required
                           class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                           placeholder="example@example.com">
                    @error('email')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <div>
                    <button type="submit"
                            class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        リセットメールを送信
                    </button>
                </div>

                <div class="text-center text-sm">
                    <a href="{{ url('/login') }}" class="font-medium text-indigo-600 hover:text-indigo-500" wire:navigate>
                        ログインページへ戻る
                    </a>
                </div>
            </form>
        @endif
    </div>
</div>
