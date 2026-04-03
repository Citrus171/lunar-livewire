<?php

namespace Database\Seeders;

use Illuminate\Support\Facades\DB;
use Lunar\Models\Attribute;
use Lunar\Models\AttributeGroup;

class AttributeSeeder extends AbstractSeeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $attributes = $this->getSeedData('attributes');

        $attributeGroup = AttributeGroup::query()->first();

        DB::transaction(function () use ($attributes, $attributeGroup): void {
            foreach ($attributes as $attribute) {
                Attribute::query()->create([
                    'attribute_group_id' => $attributeGroup->id,
                    'attribute_type' => $attribute->attribute_type,
                    'handle' => $attribute->handle,
                    'section' => 'main',
                    'type' => $attribute->type,
                    'required' => false,
                    'searchable' => true,
                    'filterable' => false,
                    'system' => false,
                    'position' => $attributeGroup->attributes()->count() + 1,
                    'name' => [
                        'en' => $attribute->name,
                    ],
                    'description' => [
                        'en' => $attribute->name,
                    ],
                    'configuration' => (array) $attribute->configuration,
                ]);
            }
        });
    }
}
