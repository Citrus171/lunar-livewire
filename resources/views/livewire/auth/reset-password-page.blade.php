<div class="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
    <div class="max-w-md w-full space-y-8">
        <div>
            <h2 class="mt-6 text-center text-3xl font-extrabold text-gray-900">
                パスワードの再設定
            </h2>
        </div>

        <form wire:submit="resetPassword" class="mt-8 space-y-6">
            <div class="space-y-4">
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
                    <label for="password" class="block text-sm font-medium text-gray-700">新しいパスワード</label>
                    <input id="password"
                           wire:model="password"
                           type="password"
                           autocomplete="new-password"
                           required
                           class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                           placeholder="8文字以上">
                    @error('password')
                        <p class="mt-1 text-sm text-red-600">{{ $message }}</p>
                    @enderror
                </div>

                <div>
                    <label for="password_confirmation" class="block text-sm font-medium text-gray-700">新しいパスワード（確認）</label>
                    <input id="password_confirmation"
                           wire:model="password_confirmation"
                           type="password"
                           autocomplete="new-password"
                           required
                           class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                           placeholder="パスワードを再入力">
                </div>
            </div>

            <div>
                <button type="submit"
                        class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    パスワードを再設定する
                </button>
            </div>
        </form>
    </div>
</div>
