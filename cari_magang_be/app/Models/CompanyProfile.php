<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CompanyProfile extends Model
{
    protected $fillable = [
        'user_id', 'description', 'address', 'phone',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }   
}