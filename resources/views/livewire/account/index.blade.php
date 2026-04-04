<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <h1 class="text-2xl font-bold text-gray-900">マイページ</h1>
    <p class="mt-4 text-gray-600">ようこそ、{{ auth()->user()->first_name }} さん</p>

    <div class="mt-8">
        <h2 class="text-lg font-semibold text-gray-800">直近の注文</h2>

        @if($recentOrders->isEmpty())
            <p class="mt-2 text-gray-500">注文はまだありません。</p>
        @else
            <div class="mt-4 space-y-4">
                @foreach($recentOrders as $order)
                    <div class="border border-gray-200 rounded-lg p-4">
                        <div class="flex justify-between items-start">
                            <div>
                                <p class="font-medium text-gray-900">注文番号: {{ $order->reference }}</p>
                                <p class="text-sm text-gray-500">
                                    {{ $order->placed_at?->format('Y年m月d日') }}
                                </p>
                            </div>
                            <div class="text-right">
                                <p class="font-medium text-gray-900">{{ $order->total->formatted() }}</p>
                                <p class="text-sm text-gray-500">{{ $order->status }}</p>
                            </div>
                        </div>
                    </div>
                @endforeach
            </div>
        @endif

        <div class="mt-4">
            <a href="/account/orders" class="text-indigo-600 hover:text-indigo-500 text-sm font-medium">
                注文履歴をすべて見る
            </a>
        </div>
    </div>

    <div class="mt-8">
        <form method="POST" action="{{ route('logout') }}">
            @csrf
            <button type="submit" class="text-sm text-gray-600 hover:text-gray-900">
                ログアウト
            </button>
        </form>
    </div>
</div>
