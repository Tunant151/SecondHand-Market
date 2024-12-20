<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Message extends Model
{
    use HasFactory, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<string>
     */
    protected $fillable = [
        'chat_id',
        'user_id',
        'message',
        'read_status',
    ];

    /**
     * Define the relationship with the chat (Message belongs to a chat).
     */
    public function chat()
    {
        return $this->belongsTo(Chat::class);
    }

    /**
     * Define the relationship with the user (Message belongs to a user).
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
