<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Internship extends Model
{
    protected $fillable = [
        'user_id',
        'title',
        'description',
        'location',
        'category_id',
        'status',
        'system',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function company()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function applications()
    {
        return $this->hasMany(InternshipApplication::class);
    }

    public function favorites()
    {
        return $this->hasMany(Favorite::class);
    }

    public function notifications()
    {
        return $this->hasMany(Notification::class);
    }
}