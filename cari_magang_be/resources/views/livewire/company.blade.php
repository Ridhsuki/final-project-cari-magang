<div class="min-h-screen bg-[#FFF8F4] flex items-center justify-center py-10">
    <div class="bg-white shadow-lg rounded-lg w-full max-w-2xl p-8 border border-[#FEE3D8]">
        <h2 class="text-2xl font-bold text-center text-[#F66527] mb-6">
            Lengkapi Profil Perusahaan
        </h2>

        <form wire:submit.prevent="save" class="space-y-6">
            {{-- Email (disabled) --}}
            <div>
                <label for="email" class="block text-sm font-medium text-[#2D1E1B] mb-1">Email</label>
                <input type="email" id="email" value="{{ auth()->user()->email }}" disabled
                    class="w-full px-4 py-2 rounded-lg bg-gray-100 text-gray-500 border border-gray-300 shadow-sm cursor-not-allowed" />
            </div>

            {{-- Foto Profil --}}
            <div>
                <label for="profile_picture" class="block text-sm font-medium text-[#2D1E1B] mb-1">Foto Profil</label>
                <div class="mt-2 flex items-center space-x-4">
                    <img id="preview_img" class="h-16 w-16 rounded-full object-cover border"
                        src="{{ $profile_picture ? $profile_picture->temporaryUrl() : (auth()->user()->profile_picture ? asset('storage/profile_pictures/' . auth()->user()->profile_picture) : 'https://harvesthosts-marketing-assets.s3.amazonaws.com/wp-content/uploads/2021/11/whoknows-1.jpg') }}"
                        alt="Profile Picture">

                    <input type="file" wire:model="profile_picture" id="profile_picture"
                        class="w-full px-4 py-2 border border-[#FFD1BF] rounded-lg 
           bg-white text-gray-900 focus:ring-2 focus:ring-[#F66527] focus:outline-none"/>
                </div>
                @error('profile_picture')
                    <p class="text-sm text-red-600 mt-1">{{ $message }}</p>
                @enderror
            </div>

            {{-- Deskripsi --}}
            <div>
                <label for="description" class="block text-sm font-medium text-[#2D1E1B] mb-1">Deskripsi</label>
                <textarea wire:model.defer="description" id="description" rows="4"
                    class="w-full px-4 py-2 border border-[#FFD1BF] rounded-lg 
           bg-white text-gray-900 focus:ring-2 focus:ring-[#F66527] focus:outline-none resize-none"></textarea>
                @error('description')
                    <p class="text-sm text-red-600 mt-1">{{ $message }}</p>
                @enderror
            </div>

            {{-- Alamat --}}
            <div>
                <label for="address" class="block text-sm font-medium text-[#2D1E1B] mb-1">Alamat</label>
                <input type="text" wire:model.defer="address" id="address"
                    class="w-full px-4 py-2 border border-[#FFD1BF] rounded-lg 
           bg-white text-gray-900 focus:ring-2 focus:ring-[#F66527] focus:outline-none"
                    required />
                @error('address')
                    <p class="text-sm text-red-600 mt-1">{{ $message }}</p>
                @enderror
            </div>

            {{-- Nomor Telepon --}}
            <div>
                <label for="phone" class="block text-sm font-medium text-[#2D1E1B] mb-1">Nomor Telepon</label>
                <input type="text" wire:model.defer="phone" id="phone" inputmode="numeric"
                    placeholder="+62xxxxxxxxxx"
                    class="w-full px-4 py-2 border border-[#FFD1BF] rounded-lg
                       bg-white text-gray-900 focus:ring-2 focus:ring-[#F66527] focus:outline-none"
                    required />
                @error('phone')
                    <p class="text-sm text-red-600 mt-1">{{ $message }}</p>
                @enderror
            </div>

            {{-- Tombol Simpan --}}
            <button type="submit"
                class="w-full bg-[#F66527] text-white py-2 rounded-lg font-semibold hover:bg-[#d8561e] transition duration-200">
                Simpan Profil
            </button>
        </form>
    </div>
</div>

<script>
    const phoneInput = document.getElementById('phone');

    if (phoneInput) {
        phoneInput.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9+]/g, '');
        });
    }
</script>
