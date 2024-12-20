<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Category extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<string>
     */
    protected $fillable = [
        'name',
        'icon',
        'parent_id',
    ];

    /**
     * Define the relationship with products (Category has many products).
     */
    public function products()
    {
        return $this->hasMany(Product::class);
    }

    /**
     * Define the relationship with the parent category (Category belongs to a parent category).
     */
    public function parent()
    {
        return $this->belongsTo(Category::class, 'parent_id');
    }

    /**
     * Define the relationship with subcategories (Category has many subcategories).
     */
    public function subcategories()
    {
        return $this->hasMany(Category::class, 'parent_id');
    }
}
