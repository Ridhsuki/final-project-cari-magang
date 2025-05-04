<?php

namespace App\Livewire;

use Livewire\Component;
use Livewire\Attributes\Title;

#[Title('Cooming Soon')]
class ComingSoon extends Component
{
    public function render()
    {
        return view('livewire.coming-soon');
    }
}
