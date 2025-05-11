<div class="bg-[#FFF8F4] min-h-screen flex items-center justify-center">
    <div class="w-full max-w-md bg-white p-8 rounded-xl shadow-lg border border-[#FEE3D8]">
        <a href="{{ url('/') }}" wire:navigate>
            <h2 class="text-2xl font-bold text-center text-[#F66527] mb-6">CariMagang</h2>
        </a>
        <form wire:submit.prevent='save' class="space-y-6">
            <!-- Name -->
            <div>
                <label for="name" class="block text-sm font-medium text-[#2D1E1B] mb-1">Company Name</label>
                <input type="text" id="name" name="name" wire:model="name" required
                    class="w-full px-4 py-2 border border-[#FFD1BF] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#F66527]"
                    aria-describedby="email-error" />
                @error('name')
                    <div class="absolute inset-y-0 right-0 flex items-center pointer-events-none pe-3">
                        <svg class="h-5 w-5 text-red-500" width="16" height="16" fill="currentColor"
                            viewBox="0 0 16 16" aria-hidden="true">
                            <path
                                d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" />
                        </svg>
                    </div>
                @enderror
            </div>
            @error('name')
                <p class="text-xs text-red-600 mt-2" id="email-error">{{ $message }}</p>
            @enderror

            <!-- Email -->
            <div>
                <label for="email" class="block text-sm font-medium text-[#2D1E1B] mb-1">Email</label>
                <input type="email" id="email" name="email" wire:model="email" required
                    class="w-full px-4 py-2 border border-[#FFD1BF] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#F66527]"
                    aria-describedby="email-error" />
                @error('email')
                    <div class="absolute inset-y-0 right-0 flex items-center pointer-events-none pe-3">
                        <svg class="h-5 w-5 text-red-500" width="16" height="16" fill="currentColor"
                            viewBox="0 0 16 16" aria-hidden="true">
                            <path
                                d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" />
                        </svg>
                    </div>
                @enderror
            </div>
            @error('email')
                <p class="text-xs text-red-600 mt-2" id="email-error">{{ $message }}</p>
            @enderror

            <!-- Password -->
            <div>
                <label for="password" class="block text-sm font-medium text-[#2D1E1B] mb-1">Kata Sandi</label>
                <input type="password" id="password" name="password" wire:model="password" required
                    class="w-full px-4 py-2 border border-[#FFD1BF] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#F66527]" />
                @error('password')
                    <div class="absolute inset-y-0 right-0 flex items-center pointer-events-none pe-3">
                        <svg class="h-5 w-5 text-red-500" width="16" height="16" fill="currentColor"
                            viewBox="0 0 16 16" aria-hidden="true">
                            <path
                                d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8 4a.905.905 0 0 0-.9.995l.35 3.507a.552.552 0 0 0 1.1 0l.35-3.507A.905.905 0 0 0 8 4zm.002 6a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" />
                        </svg>
                    </div>
                @enderror
            </div>
            @error('password')
                <p class="text-xs text-red-600 mt-2" id="password-error">{{ $message }}</p>
            @enderror

            @if (session()->has('error'))
                <div class="text-xs text-red-600 mt-2">
                    {{ session('error') }}
                </div>
            @endif

            <!-- Submit -->
            <button type="submit" wire:wire:navigate
                class="w-full bg-[#F66527] text-white py-2 rounded-lg font-semibold hover:bg-[#d8561e] transition duration-200">
                Daftar sebagai Perusahaan
            </button>
        </form>

        <!-- Divider -->
        <div class="my-6 text-center text-sm text-[#4B3C38]">
            Sudah punya akun? <a href="{{ route('login') }}" wire:navigate
                class="text-[#F66527] hover:underline">Masuk sebagai perusahaan</a>
        </div>
    </div>
</div>
