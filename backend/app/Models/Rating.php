<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Rating extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<string>
     */
    protected $fillable = [
        'rater_id',
        'rated_user_id',
        'rating',
        'comment',
    ];

    /**
     * Define the relationship with the rater (Rating belongs to a rater).
     */
    public function rater()
    {
        return $this->belongsTo(User::class, 'rater_id');
    }

    /**
     * Define the relationship with the rated user (Rating belongs to a rated user).
     */
    public function ratedUser()
    {
        return $this->belongsTo(User::class, 'rated_user_id');
    }
}
