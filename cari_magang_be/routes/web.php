<?php

use App\Livewire\Company;
use App\Livewire\Login;
use App\Livewire\Register;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    if (auth()->check()) {
        $user = auth()->user();
        if ($user->role === 'admin') {
            return redirect('/admin');
        } elseif ($user->role === 'company') {
            return redirect('/company');
        } elseif ($user->role === 'user') {
            Auth::logout();
            session()->flash('error', 'Anda tidak memiliki akses ke web, silahkan buka aplikasi mobile');
            return redirect('/');
        }
    }
    return view('welcome');
})->name('home');

Route::middleware('guest')->group(function () {
    Route::get('/login', Login::class)->name('login');
    Route::get('/register', Register::class)->name('register');
});


Route::group(['middleware' => 'auth'], function () {
    Route::get('/company/edit', Company::class)->name('profile.edit');
});

Route::view('/coming-soon', 'coming-soon')->name('comingsoon');