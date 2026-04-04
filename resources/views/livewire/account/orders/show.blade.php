<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
    <h1 class="text-2xl font-bold text-gray-900">注文詳細</h1>
    <p class="mt-2 text-gray-600">注文番号: {{ $order->reference }}</p>
    <p class="text-sm text-gray-500">{{ $order->placed_at?->format('Y年m月d日') }}</p>

    <div class="mt-6">
        <h2 class="text-lg font-semibold text-gray-800">注文明細</h2>
        <div class="mt-4 space-y-2">
            @foreach($order->lines as $line)
                <div class="flex justify-between items-center border-b border-gray-100 py-2">
                    <div>
                        <p class="font-medium text-gray-900">{{ $line->description }}</p>
                        <p class="text-sm text-gray-500">数量: {{ $line->quantity }}</p>
                    </div>
                    <p class="font-medium text-gray-900">{{ $line->unit_price->formatted() }}</p>
                </div>
            @endforeach
        </div>
    </div>

    @if($order->shippingAddress)
        <div class="mt-6">
            <h2 class="text-lg font-semibold text-gray-800">配送先</h2>
            <div class="mt-2 text-gray-600">
                <p>{{ $order->shippingAddress->first_name }} {{ $order->shippingAddress->last_name }}</p>
                <p>〒{{ $order->shippingAddress->postcode }}</p>
                <p>{{ $order->shippingAddress->city }} {{ $order->shippingAddress->line_one }}</p>
            </div>
        </div>
    @endif

    <div class="mt-6">
        <a href="{{ route('account.orders.index') }}" class="text-indigo-600 hover:text-indigo-500 text-sm">
            注文履歴に戻る
        </a>
    </div>
</div>
