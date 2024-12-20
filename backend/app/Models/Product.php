<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<string>
     */
    protected $fillable = [
        'name',
        'description',
        'price',
        'images',
        'status',
        'views_count',
        'category_id',
        'user_id',
        'district',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'images' => 'array',
        'price' => 'decimal:2',
        'views_count' => 'integer',
    ];

    /**
     * Define the relationship with the user (Product belongs to a user).
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Define the relationship with the category (Product belongs to a category).
     */
    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    /**
     * Define the relationship with chats (Product has many chats).
     */
    public function chats()
    {
        return $this->hasMany(Chat::class);
    }

    /**
     * Define the relationship with favorites (Product has many favorites).
     */
    public function favorites()
    {
        return $this->hasMany(Favorite::class);
    }
}
