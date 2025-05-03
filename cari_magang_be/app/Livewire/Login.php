<?php

namespace App\Livewire;

use Illuminate\Support\Facades\Auth;
use Livewire\Component;
use Livewire\Attributes\Title;


#[Title('Login')]
class Login extends Component
{
    public $email;
    public $password;

    public function save()
    {
        $this->validate([
            'email' => 'required|email|max:255|exists:users,email',
            'password' => 'required|min:6|max:255'
        ]);

        if (
            !Auth::attempt([
                'email' => $this->email,
                'password' => $this->password
            ])
        ) {
            session()->flash('error', 'Email atau password salah');
            return;
        }

        $user = Auth::user();
        if ($user->role === 'admin') {
            return redirect('/admin');
        }

        if ($user->role === 'company') {
            return redirect('/company');
        }

        if ($user->role === 'user') {
            Auth::logout();
            session()->flash('error', 'Anda tidak memiliki akses ke web, silahkan buka aplikasi mobile');
            return redirect('/login');
        }
        return redirect()->intended();
    }
    public function render()
    {
        return view('livewire.login');
    }
}
