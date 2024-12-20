<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            Log::info('Fetching all categories');
            $categories = Category::all();
            
            return response()->json($categories, 200);
        } catch (\Exception $e) {
            Log::error('Error fetching categories: ' . $e->getMessage());
            return response()->json([
                'message' => 'Failed to fetch categories',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        try {
            Log::info('Creating new category', $request->all());
            
            $validated = $request->validate([
                'name' => 'required|string|max:255|unique:categories',
                'icon' => 'required|string',
                'parent_id' => 'nullable|exists:categories,id'
            ]);

            $category = Category::create($validated);
            
            Log::info('Category created successfully', ['category_id' => $category->id]);
            
            return response()->json([
                'message' => 'Category created successfully',
                'category' => $category
            ], 201);
        } catch (\Exception $e) {
            Log::error('Error creating category: ' . $e->getMessage());
            return response()->json([
                'message' => 'Failed to create category',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        try {
            Log::info('Fetching category', ['category_id' => $id]);
            
            $category = Category::with('products')->findOrFail($id);
            
            return response()->json($category, 200);
        } catch (\Exception $e) {
            Log::error('Error fetching category: ' . $e->getMessage());
            return response()->json([
                'message' => 'Category not found',
                'error' => $e->getMessage()
            ], 404);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        try {
            Log::info('Updating category', ['category_id' => $id, 'data' => $request->all()]);
            
            $category = Category::findOrFail($id);
            
            $validated = $request->validate([
                'name' => 'required|string|max:255|unique:categories,name,' . $id,
                'icon' => 'required|string',
                'parent_id' => 'nullable|exists:categories,id'
            ]);

            $category->update($validated);
            
            Log::info('Category updated successfully', ['category_id' => $id]);
            
            return response()->json([
                'message' => 'Category updated successfully',
                'category' => $category
            ], 200);
        } catch (\Exception $e) {
            Log::error('Error updating category: ' . $e->getMessage());
            return response()->json([
                'message' => 'Failed to update category',
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
            Log::info('Deleting category', ['category_id' => $id]);
            
            $category = Category::findOrFail($id);
            
            // Check if category has products
            if ($category->products()->count() > 0) {
                throw new \Exception('Cannot delete category with existing products');
            }
            
            $category->delete();
            
            Log::info('Category deleted successfully', ['category_id' => $id]);
            
            return response()->json([
                'message' => 'Category deleted successfully'
            ], 200);
        } catch (\Exception $e) {
            Log::error('Error deleting category: ' . $e->getMessage());
            return response()->json([
                'message' => 'Failed to delete category',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Get categories with their products count
     */
    public function withProductsCount()
    {
        try {
            Log::info('Fetching categories with products count');
            
            $categories = Category::withCount('products')->get();
            
            return response()->json($categories, 200);
        } catch (\Exception $e) {
            Log::error('Error fetching categories with count: ' . $e->getMessage());
            return response()->json([
                'message' => 'Failed to fetch categories',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
