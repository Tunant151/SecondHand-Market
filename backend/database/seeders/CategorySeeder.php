<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        // Main Categories
        $electronics = Category::create([
            'name' => 'Electronics',
            'icon' => 'fa-laptop',
        ]);

        $fashion = Category::create([
            'name' => 'Fashion',
            'icon' => 'fa-tshirt',
        ]);

        $home = Category::create([
            'name' => 'Home & Garden',
            'icon' => 'fa-home',
        ]);

        $health = Category::create([
            'name' => 'Health & Beauty',
            'icon' => 'fa-heartbeat',
        ]);

        // Electronics subcategories
        Category::create([
            'name' => 'Smartphones',
            'icon' => 'fa-mobile-alt',
            'parent_id' => $electronics->id,
        ]);

        Category::create([
            'name' => 'Laptops',
            'icon' => 'fa-laptop',
            'parent_id' => $electronics->id,
        ]);

        Category::create([
            'name' => 'Accessories',
            'icon' => 'fa-headphones',
            'parent_id' => $electronics->id,
        ]);

        // Fashion subcategories
        Category::create([
            'name' => "Men's Clothing",
            'icon' => 'fa-male',
            'parent_id' => $fashion->id,
        ]);

        Category::create([
            'name' => "Women's Clothing",
            'icon' => 'fa-female',
            'parent_id' => $fashion->id,
        ]);

        Category::create([
            'name' => 'Shoes',
            'icon' => 'fa-shoe-prints',
            'parent_id' => $fashion->id,
        ]);

        // Home & Garden subcategories
        Category::create([
            'name' => 'Furniture',
            'icon' => 'fa-couch',
            'parent_id' => $home->id,
        ]);

        Category::create([
            'name' => 'Kitchen',
            'icon' => 'fa-utensils',
            'parent_id' => $home->id,
        ]);

        Category::create([
            'name' => 'Garden Tools',
            'icon' => 'fa-leaf',
            'parent_id' => $home->id,
        ]);

        // Health & Beauty subcategories
        Category::create([
            'name' => 'Skincare',
            'icon' => 'fa-spa',
            'parent_id' => $health->id,
        ]);

        Category::create([
            'name' => 'Makeup',
            'icon' => 'fa-paint-brush',
            'parent_id' => $health->id,
        ]);

        Category::create([
            'name' => 'Personal Care',
            'icon' => 'fa-shower',
            'parent_id' => $health->id,
        ]);
    }
} 