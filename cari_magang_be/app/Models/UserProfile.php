<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserProfile extends Model
{
    protected $fillable = [
        'user_id',
        'place_of_birth',
        'date_of_birth',
        'address',
        'phone',
        'education',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}