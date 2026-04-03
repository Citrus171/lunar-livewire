<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Lunar\FieldTypes\TranslatedText;
use Lunar\Models\Attribute;
use Lunar\Models\AttributeGroup;
use Lunar\Models\Channel;
use Lunar\Models\Collection;
use Lunar\Models\CollectionGroup;
use Lunar\Models\Currency;
use Lunar\Models\CustomerGroup;
use Lunar\Models\Language;
use Lunar\Models\Product;
use Lunar\Models\ProductType;
use Lunar\Models\TaxClass;

class LunarBaselineSeeder extends Seeder
{
  /**
   * Seed baseline Lunar data needed by project seeders.
   */
  public function run(): void
  {
    Channel::query()->firstOrCreate(
      ['handle' => 'webstore'],
      [
        'name' => 'Webstore',
        'default' => true,
        'url' => 'http://localhost',
      ]
    );

    Language::query()->firstOrCreate(
      ['code' => 'en'],
      [
        'name' => 'English',
        'default' => true,
      ]
    );

    Currency::query()->firstOrCreate(
      ['code' => 'USD'],
      [
        'name' => 'US Dollar',
        'exchange_rate' => 1,
        'decimal_places' => 2,
        'default' => true,
        'enabled' => true,
      ]
    );

    CustomerGroup::query()->firstOrCreate(
      ['handle' => 'retail'],
      [
        'name' => 'Retail',
        'default' => true,
      ]
    );

    CollectionGroup::query()->firstOrCreate(
      ['handle' => 'main'],
      [
        'name' => 'Main',
      ]
    );

    TaxClass::query()->firstOrCreate(
      ['name' => 'Default Tax Class'],
      [
        'default' => true,
      ]
    );

    $productAttributeGroup = AttributeGroup::query()->firstOrCreate(
      [
        'attributable_type' => Product::morphName(),
        'handle' => 'details',
      ],
      [
        'name' => collect(['en' => 'Details']),
        'position' => 1,
      ]
    );

    $collectionAttributeGroup = AttributeGroup::query()->firstOrCreate(
      [
        'attributable_type' => Collection::morphName(),
        'handle' => 'collection_details',
      ],
      [
        'name' => collect(['en' => 'Details']),
        'position' => 1,
      ]
    );

    Attribute::query()->firstOrCreate(
      [
        'attribute_type' => Product::morphName(),
        'handle' => 'name',
      ],
      [
        'attribute_group_id' => $productAttributeGroup->id,
        'position' => 1,
        'name' => ['en' => 'Name'],
        'section' => 'main',
        'type' => TranslatedText::class,
        'required' => true,
        'system' => true,
        'description' => ['en' => ''],
        'configuration' => ['richtext' => false],
      ]
    );

    Attribute::query()->firstOrCreate(
      [
        'attribute_type' => Product::morphName(),
        'handle' => 'description',
      ],
      [
        'attribute_group_id' => $productAttributeGroup->id,
        'position' => 2,
        'name' => ['en' => 'Description'],
        'section' => 'main',
        'type' => TranslatedText::class,
        'required' => false,
        'system' => false,
        'description' => ['en' => ''],
        'configuration' => ['richtext' => true],
      ]
    );

    Attribute::query()->firstOrCreate(
      [
        'attribute_type' => Collection::morphName(),
        'handle' => 'name',
      ],
      [
        'attribute_group_id' => $collectionAttributeGroup->id,
        'position' => 1,
        'name' => ['en' => 'Name'],
        'section' => 'main',
        'type' => TranslatedText::class,
        'required' => true,
        'system' => true,
        'description' => ['en' => ''],
        'configuration' => ['richtext' => false],
      ]
    );

    Attribute::query()->firstOrCreate(
      [
        'attribute_type' => Collection::morphName(),
        'handle' => 'description',
      ],
      [
        'attribute_group_id' => $collectionAttributeGroup->id,
        'position' => 2,
        'name' => ['en' => 'Description'],
        'section' => 'main',
        'type' => TranslatedText::class,
        'required' => false,
        'system' => false,
        'description' => ['en' => ''],
        'configuration' => ['richtext' => true],
      ]
    );

    $productType = ProductType::query()->firstOrCreate(['name' => 'Stock']);

    $productAttributeIds = Attribute::query()
      ->where('attribute_type', Product::morphName())
      ->pluck('id');

    $productType->mappedAttributes()->syncWithoutDetaching($productAttributeIds);
  }
}
