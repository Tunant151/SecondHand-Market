<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $products = Product::with('user', 'category')->get();
        
        $formattedProducts = $products->map(function ($product) {
            return [
                'id' => $product->id,
                'name' => $product->name,
                'description' => $product->description,
                'price' => $product->price,
                'status' => $product->status,
                'views_count' => $product->views_count,
                'district' => $product->district,
                'category' => [
                    'id' => $product->category->id,
                    'name' => $product->category->name,
                ],
                'user' => [
                    'id' => $product->user->id,
                    'name' => $product->user->name,
                    'phone' => $product->user->phone,
                ],
                'image_urls' => array_map(function($path) {
                    return asset('storage/' . $path);
                }, $product->images ?? []),
                'created_at' => $product->created_at,
            ];
        });

        return response()->json($formattedProducts, 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'name' => 'required|string|max:255',
                'description' => 'required|string',
                'price' => 'required|numeric|min:0',
                'images.*' => 'required|image|mimes:jpeg,png,jpg,gif|max:5120', // 5MB max per image
                'category_id' => 'required|exists:categories,id',
                'district' => 'required|string',
                'status' => 'sometimes|in:active,sold,pending',
            ]);

            // Handle multiple image uploads
            $imagePaths = [];
            if ($request->hasFile('images')) {
                foreach ($request->file('images') as $image) {
                    $path = $image->store('product-images', 'public');
                    $imagePaths[] = $path;
                }
            }

            $product = Product::create([
                'name' => $validated['name'],
                'description' => $validated['description'],
                'price' => $validated['price'],
                'images' => $imagePaths,
                'category_id' => $validated['category_id'],
                'district' => $validated['district'],
                'status' => $validated['status'] ?? 'active',
                'user_id' => auth()->id(),
            ]);

            // Format image URLs for response
            $imageUrls = array_map(function($path) {
                return asset('storage/' . $path);
            }, $imagePaths);

            return response()->json([
                'message' => 'Product created successfully',
                'product' => array_merge(
                    $product->toArray(),
                    ['image_urls' => $imageUrls]
                )
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to create product',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $product = Product::with('user', 'category')->find($id);

        if (!$product) {
            return response()->json(['message' => 'Product not found'], 404);
        }

        // Increment views count
        $product->increment('views_count');

        $formattedProduct = [
            'id' => $product->id,
            'name' => $product->name,
            'description' => $product->description,
            'price' => $product->price,
            'status' => $product->status,
            'views_count' => $product->views_count,
            'district' => $product->district,
            'category' => [
                'id' => $product->category->id,
                'name' => $product->category->name,
            ],
            'user' => [
                'id' => $product->user->id,
                'name' => $product->user->name,
                'phone' => $product->user->phone,
            ],
            'image_urls' => array_map(function($path) {
                return asset('storage/' . $path);
            }, $product->images ?? []),
            'created_at' => $product->created_at,
        ];

        return response()->json($formattedProduct, 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        try {
            $product = Product::findOrFail($id);

            // Check if user owns the product
            if ($product->user_id !== auth()->id()) {
                return response()->json(['message' => 'Unauthorized'], 403);
            }

            $validated = $request->validate([
                'name' => 'sometimes|string|max:255',
                'description' => 'sometimes|string',
                'price' => 'sometimes|numeric|min:0',
                'images.*' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:5120',
                'category_id' => 'sometimes|exists:categories,id',
                'district' => 'sometimes|string',
                'status' => 'sometimes|in:active,sold,pending',
            ]);

            // Handle image uploads if new images are provided
            if ($request->hasFile('images')) {
                $imagePaths = [];
                foreach ($request->file('images') as $image) {
                    $path = $image->store('product-images', 'public');
                    $imagePaths[] = $path;
                }
                $validated['images'] = $imagePaths;
            }

            $product->update($validated);

            // Format image URLs for response
            $imageUrls = array_map(function($path) {
                return asset('storage/' . $path);
            }, $product->images ?? []);

            return response()->json([
                'message' => 'Product updated successfully',
                'product' => array_merge(
                    $product->toArray(),
                    ['image_urls' => $imageUrls]
                )
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update product',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        try {
            $product = Product::findOrFail($id);

            // Check if user owns the product
            if ($product->user_id !== auth()->id()) {
                return response()->json(['message' => 'Unauthorized'], 403);
            }

            $product->delete();

            return response()->json([
                'message' => 'Product deleted successfully'
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete product',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
