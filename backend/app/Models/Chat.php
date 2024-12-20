<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Chat extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<string>
     */
    protected $fillable = [
        'product_id',
        'seller_id',
        'buyer_id',
    ];

    /**
     * Define the relationship with the product (Chat belongs to a product).
     */
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    /**
     * Define the relationship with the seller (Chat belongs to a seller).
     */
    public function seller()
    {
        return $this->belongsTo(User::class, 'seller_id');
    }

    /**
     * Define the relationship with the buyer (Chat belongs to a buyer).
     */
    public function buyer()
    {
        return $this->belongsTo(User::class, 'buyer_id');
    }

    /**
     * Define the relationship with messages (Chat has many messages).
     */
    public function messages()
    {
        return $this->hasMany(Message::class);
    }
}
