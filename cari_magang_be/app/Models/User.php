<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Filament\Models\Contracts\FilamentUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Filament\Panel;
use Illuminate\Support\Facades\Auth;

class User extends Authenticatable implements FilamentUser
{
    use HasFactory, Notifiable, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
        'profile_picture',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
    public function profile()
    {
        return $this->hasOne(UserProfile::class);
    }
    public function companyProfile()
    {
        return $this->hasOne(CompanyProfile::class);
    }
    public function internships()
    {
        return $this->hasMany(Internship::class);
    }
    public function applications()
    {
        return $this->hasMany(InternshipApplication::class);
    }
    public function favorites()
    {
        return $this->hasMany(Favorite::class);
    }
    public function sentNotifications()
    {
        return $this->hasMany(Notification::class, 'sender_id');
    }
    public function receivedNotifications()
    {
        return $this->hasMany(Notification::class, 'receiver_id');
    }
    public function canAccessPanel(Panel $panel): bool
    {
        if ($panel->getId() === 'admin' && $this->role === 'admin') {
            return true;
        }
        if ($panel->getId() === 'company' && $this->role === 'company') {
            return true;
        }
        return false;
    }
}
