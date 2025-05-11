<?php

namespace App\Livewire;

use Illuminate\Support\Facades\Auth;
use Livewire\Component;
use Livewire\WithFileUploads;
use Livewire\Attributes\Title;
use Filament\Notifications\Notification;

#[Title('Profil Perusahaan')]
class Company extends Component
{
    use WithFileUploads;

    public $description;
    public $address;
    public $phone;
    public $profile_picture;
    public $current_profile_picture;

    public function mount()
    {
        $user = Auth::user();
        $company = $user->companyProfile;

        // Pastikan data perusahaan dan gambar profil di-set
        if ($company) {
            $this->description = $company->description;
            $this->address = $company->address;
            $this->phone = $company->phone;
        }

        // Menetapkan gambar profil jika ada
        $this->current_profile_picture = $user->profile_picture ?? 'default.png';
        // dd($this->description, $this->address, $this->phone, $this->profile_picture);

    }

    public function save()
    {
        $this->validate([
            'description' => 'nullable|string',
            'address' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:255',
            'profile_picture' => 'nullable|image|max:2048',
        ]);

        $user = Auth::user();

        // Simpan data perusahaan
        $user->companyProfile()->updateOrCreate(
            ['user_id' => $user->id],
            [
                'description' => $this->description,
                'address' => $this->address,
                'phone' => $this->phone,
            ]
        );

        // Proses upload gambar
        if ($this->profile_picture) {
            // Membuat nama file gambar sesuai dengan aturan yang ada
            $profilePictureName = strtolower(str_replace(' ', '_', $user->name)) . '_' . time() . '.' . $this->profile_picture->getClientOriginalExtension();

            // Menyimpan gambar dengan nama yang sudah ditentukan
            $this->profile_picture->storeAs('profile_pictures', $profilePictureName, 'public');

            // Update nama file pada user
            $user->profile_picture = $profilePictureName;
            $user->save();
        }

        Notification::make()
            ->title('Success')
            ->body('Your profile has been updated successfully')
            ->success()
            ->send();

        return redirect()->to('/company');
    }

    protected function cleanupOldUploads()
    {
        $storage = \Storage::disk('public');

        foreach ($storage->allFiles('livewire-tmp') as $filePathname) {
            $yesterdaysStamp = now()->subSeconds(3)->timestamp;
            if ($yesterdaysStamp > $storage->lastModified($filePathname)) {
                $storage->delete($filePathname);
            }
        }
    }

    public function render()
    {
        return view('livewire.company');
    }
}
