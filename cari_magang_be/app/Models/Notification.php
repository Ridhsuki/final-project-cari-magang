<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Notification extends Model
{
    protected $fillable = [
        'sender_id', 'receiver_id', 'internship_id', 'message', 'is_read',
    ];
    
    public function sender()
    {
        return $this->belongsTo(User::class, 'sender_id');
    }
    
    public function receiver()
    {
        return $this->belongsTo(User::class, 'receiver_id');
    }
    
    public function internship()
    {
        return $this->belongsTo(Internship::class);
    }    
}