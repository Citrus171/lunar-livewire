<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <h1 class="text-2xl font-bold text-gray-900">注文履歴</h1>

    @if($orders->isEmpty())
        <p class="mt-4 text-gray-500">注文はまだありません。</p>
    @else
        <div class="mt-6 space-y-4">
            @foreach($orders as $order)
                <div class="border border-gray-200 rounded-lg p-4">
                    <div class="flex justify-between items-start">
                        <div>
                            <p class="font-medium text-gray-900">注文番号: {{ $order->reference }}</p>
                            <p class="text-sm text-gray-500">{{ $order->placed_at?->format('Y年m月d日') }}</p>
                        </div>
                        <div class="text-right">
                            <p class="font-medium text-gray-900">{{ $order->total->formatted() }}</p>
                            <p class="text-sm text-gray-500">{{ $order->status }}</p>
                        </div>
                    </div>
                    <div class="mt-2">
                        <a href="{{ route('account.orders.show', $order->id) }}" class="text-indigo-600 hover:text-indigo-500 text-sm">
                            詳細を見る
                        </a>
                    </div>
                </div>
            @endforeach
        </div>
    @endif
</div>
