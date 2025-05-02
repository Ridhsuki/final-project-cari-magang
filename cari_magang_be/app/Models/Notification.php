<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Str;

class Notification extends Model
{
    use Notifiable;
    public $incrementing = false; 
    protected $keyType = 'string';

    protected $fillable = [
        'sender_id',
        'receiver_id',
        'internship_id',
        'type',
        'message',
        'is_read',
        'notifiable_id',
        'notifiable_type',
        'data',
        'read_at',
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
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            if (empty($model->id)) {
                $model->id = (string) Str::uuid();
            }
        });
    }
}