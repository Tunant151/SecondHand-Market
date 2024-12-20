<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Hash;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'profile_image',
        'district',
        'rating',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];

    /**
     * Define the relationship with products (User has many products).
     */
    public function products()
    {
        return $this->hasMany(Product::class);
    }

    /**
     * Define the relationship with chats (User has many chats).
     */
    public function chats()
    {
        return $this->hasMany(Chat::class);
    }

    /**
     * Define the relationship with favorites (User has many favorites).
     */
    public function favorites()
    {
        return $this->hasMany(Favorite::class);
    }

    /**
     * Define the relationship with ratings received by the user.
     */
    public function receivedRatings()
    {
        return $this->hasMany(Rating::class, 'rated_user_id');
    }

    /**
     * Define the relationship with ratings given by the user.
     */
    public function givenRatings()
    {
        return $this->hasMany(Rating::class, 'rater_id');
    }
}
