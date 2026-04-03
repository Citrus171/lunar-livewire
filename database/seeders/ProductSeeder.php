<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Lunar\Admin\Actions\Products\MapVariantsToProductOptions;
use Lunar\FieldTypes\ListField;
use Lunar\FieldTypes\Text;
use Lunar\FieldTypes\TranslatedText;
use Lunar\Models\Attribute;
use Lunar\Models\Brand;
use Lunar\Models\Collection;
use Lunar\Models\Currency;
use Lunar\Models\Language;
use Lunar\Models\Price;
use Lunar\Models\Product;
use Lunar\Models\ProductOption;
use Lunar\Models\ProductOptionValue;
use Lunar\Models\ProductType;
use Lunar\Models\ProductVariant;
use Lunar\Models\TaxClass;

class ProductSeeder extends AbstractSeeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $products = $this->getSeedData('products');

        $attributes = Attribute::query()->get();

        $productType = ProductType::query()->first();

        $taxClass = TaxClass::getDefault();

        $currency = Currency::getDefault();

        $collections = Collection::query()->get();

        Language::getDefault();

        DB::transaction(function () use ($products, $attributes, $productType, $taxClass, $currency, $collections): void {
            $products->each(function ($product) use ($attributes, $productType, $taxClass, $currency, $collections): void {
                $attributeData = [];

                foreach ($product->attributes as $attributeHandle => $value) {
                    $attribute = $attributes->first(fn ($att): bool => $att->handle === $attributeHandle);

                    if ($attribute->type === TranslatedText::class) {
                        $attributeData[$attributeHandle] = new TranslatedText([
                            'en' => new Text($value),
                        ]);

                        continue;
                    }

                    if ($attribute->type === ListField::class) {
                        $attributeData[$attributeHandle] = new ListField((array) $value);
                    }
                }

                $brand = Brand::query()->firstOrCreate([
                    'name' => $product->brand,
                ]);

                $productModel = Product::query()->create([
                    'attribute_data' => $attributeData,
                    'product_type_id' => $productType->id,
                    'status' => 'published',
                    'brand_id' => $brand->id,
                ]);

                $variant = ProductVariant::query()->create([
                    'product_id' => $productModel->id,
                    'purchasable' => 'always',
                    'shippable' => true,
                    'backorder' => 0,
                    'sku' => $product->sku,
                    'tax_class_id' => $taxClass->id,
                    'stock' => 500,
                ]);

                if (count($product->options ?? []) === 0) {
                    Price::query()->create([
                        'customer_group_id' => null,
                        'currency_id' => $currency->id,
                        'priceable_type' => (new ProductVariant)->getMorphClass(),
                        'priceable_id' => $variant->id,
                        'price' => $product->price,
                        'min_quantity' => 1,
                    ]);
                }

                $media = $productModel->addMedia(
                    base_path('database/seeders/data/images/'.$product->image)
                )->preservingOriginal()->toMediaCollection('images');

                $media->setCustomProperty('primary', true);
                $media->save();

                $collections->each(function ($coll) use ($product, $productModel): void {
                    if (in_array(strtolower((string) $coll->translateAttribute('name')), $product->collections, true)) {
                        $coll->products()->attach($productModel->id);
                    }
                });

                if (count($product->options ?? []) === 0) {
                    return;
                }

                $options = ProductOption::query()->get();

                $optionValues = ProductOptionValue::query()->get();

                $optionValueMapping = collect($product->options)->mapWithKeys(
                    fn ($option): array => [
                        $option->name => $option->values,
                    ]
                )->toArray();

                $optionIds = [];

                foreach ($product->options ?? [] as $optionIndex => $option) {
                    // Do we have this option already?
                    $optionModel = $options->first(fn ($opt): bool => $option->name === $opt->translate('name'));

                    if (! $optionModel) {
                        $optionModel = ProductOption::query()->create([
                            'name' => [
                                'en' => $option->name,
                            ],
                            'label' => [
                                'en' => $option->name,
                            ],
                            'shared' => $option->shared,
                            'handle' => Str::slug($option->name),
                        ]);
                    }

                    $optionIds[$optionModel->id] = [
                        'position' => $optionIndex + 1,
                    ];

                    foreach ($option->values as $value) {
                        $valueModel = $optionValues->first(fn ($val): bool => $value === $val->translate('name'));

                        if (! $valueModel) {
                            ProductOptionValue::query()->create([
                                'product_option_id' => $optionModel->id,
                                'position' => $optionIndex,

                                'name' => [
                                    'en' => $value,
                                ],
                            ]);
                        }
                    }
                }

                if (count($product->options ?? []) === 0) {
                    return;
                }

                $productModel->productOptions()->sync($optionIds);

                $variants = collect([$variant])->map(fn ($variant): array => [
                    'id' => $variant->id,
                    'sku' => $variant->sku,
                    'price' => $product->price,
                    'values' => [],
                ])->all();

                $variants = MapVariantsToProductOptions::map($optionValueMapping, $variants, true);

                foreach ($variants as $variant) {
                    if (! $variant['variant_id']) {
                        $variantModel = ProductVariant::query()->create([
                            'product_id' => $productModel->id,
                            'purchasable' => 'always',
                            'shippable' => true,
                            'backorder' => 0,
                            'sku' => $variant['sku'],
                            'tax_class_id' => $taxClass->id,
                            'stock' => 500,
                        ]);
                        $variant['variant_id'] = $variantModel->id;
                    } else {
                        $variantModel = ProductVariant::query()->find($variant['variant_id']);
                    }

                    Price::query()->create([
                        'customer_group_id' => null,
                        'currency_id' => $currency->id,
                        'priceable_type' => (new ProductVariant)->getMorphClass(),
                        'priceable_id' => $variant['variant_id'],
                        'price' => $variant['price'],
                        'min_quantity' => 1,
                    ]);

                    $valueIds = ProductOptionValue::query()->get()->filter(fn ($option): bool => in_array($option->translate('name'), $variant['values'], true))->pluck('id');

                    $variantModel->values()->sync($valueIds);
                }
            });
        });
    }
}
