<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="h-full">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Cari Magang | Landing Page</title>
    <meta name="description" content="Cari Magang is a platform to find internships easily." />
    <meta name="keywords" content="internship, job, career, find internship" />
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/9366/9366528.png" type="image/x-icon" />
    <script src="https://cdn.tailwindcss.com"></script>
    @livewireStyles
    <style>
        @keyframes float {

            0%,
            100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-5px);
            }
        }

        .animate-float {
            animation: float 6s ease-in-out infinite;
        }

        ::selection {
            background-color: #F66527;
            color: #fff;
        }
    </style>
</head>

<body class="bg-[#FFF8F4] text-[#2D1E1B]">

    <!-- Navbar -->
    <header class="relative bg-[#FFF8F4] shadow-sm">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between py-4">
                <div class="text-2xl font-bold text-[#F66527]">Cari Magang</div>
                <div class="hidden md:flex space-x-6">
                    <a href="#lowongan" class="text-[#2D1E1B] hover:text-[#F66527]">Lowongan</a>
                    <a href="#fitur" class="text-[#2D1E1B] hover:text-[#F66527]">Fitur</a>
                </div>
                <div class="flex items-center space-x-4">
                    <a href="{{ route('login') }}" wire:navigate class="text-[#2D1E1B] hover:text-[#F66527]">Masuk</a>
                    <a href="#daftar"
                        class="px-5 py-2 bg-[#F66527] text-white font-medium rounded-lg shadow-lg hover:bg-[#d8561e]">
                        Coba Sekarang
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="relative bg-[#FFF8F4] overflow-hidden">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex flex-col lg:flex-row items-center lg:space-x-12 py-16">
                <!-- Text Content -->
                <div class="lg:w-1/2 text-center lg:text-left">
                    <h1 class="text-4xl sm:text-5xl font-extrabold text-[#2D1E1B] mb-6">
                        Temukan <span class="text-[#F66527]">Magang Impianmu</span> Dengan Mudah
                    </h1>
                    <p class="text-lg text-[#4B3C38] mb-8">
                        CariMagang adalah aplikasi pencari magang untuk siapa saja. Temukan lowongan, kirim CV, dan
                        mulai
                        karirmu sekarang!
                    </p>
                    <div class="flex justify-center lg:justify-start space-x-4">
                        <a href="#lowongan"
                            class="px-5 py-3 bg-[#F66527] text-white font-medium rounded-lg shadow-lg hover:bg-[#d8561e]">
                            Lihat Lowongan
                        </a>
                        <a href="#fitur"
                            class="px-5 py-3 bg-white text-[#F66527] border border-[#F66527] font-medium rounded-lg hover:bg-[#FFE3D8]">
                            Fitur Aplikasi
                        </a>
                    </div>
                </div>
                <!-- Hero Image -->
                <div class="lg:w-1/2 mt-8 lg:mt-0 relative">
                    <img src="https://img.freepik.com/free-vector/internship-job-training-illustration_23-2148751280.jpg?semt=ais_hybrid&w=740"
                        alt="Internship illustration" class="rounded-lg shadow-lg" />
                    <div class="absolute -top-6 -left-6 w-10 h-10 bg-[#FFE3D8] rounded-full animate-float"></div>
                    <div class="absolute -bottom-10 -right-10 w-12 h-12 bg-[#FFD1BF] rounded-full animate-float"></div>
                    <div class="absolute top-4 right-0 w-8 h-8 bg-[#F66527] rounded-full opacity-50 animate-float">
                    </div>
                </div>
            </div>
        </div>
        <!-- Background Decorations -->
        <div class="absolute inset-0 pointer-events-none" aria-hidden="true">
            <div
                class="absolute top-0 left-0 w-24 h-24 bg-[#FFE3D8] rounded-full opacity-50 transform -translate-x-1/2 -translate-y-1/2">
            </div>
            <div
                class="absolute bottom-0 right-0 w-32 h-32 bg-[#FFD1BF] rounded-full opacity-30 transform translate-x-1/2 translate-y-1/2">
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-[#2D1E1B] text-[#FFF8F4]">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
                <div class="text-xl font-bold">CariMagang</div>
                <div class="flex space-x-8">
                    <a href="#tentang" class="hover:text-[#F66527]">Tentang</a>
                    <a href="#kebijakan" class="hover:text-[#F66527]">Kebijakan Privasi</a>
                    <a href="#syarat" class="hover:text-[#F66527]">Syarat & Ketentuan</a>
                    <a href="#bantuan" class="hover:text-[#F66527]">Bantuan</a>
                    <a href="https://github.com/Ridhsuki/final-project-cari-magang" target="_blank" class="hover:text-[#F66527]">GitHub</a>
                </div>
                <div class="text-sm text-[#FFE3D8]">© 2025 CariMagang. All rights reserved.</div>
            </div>
        </div>
    </footer>
    @livewireScripts
</body>

</html>
