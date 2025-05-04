<div class="flex items-center justify-center min-h-screen bg-white" onclick="toggleAwo()">
    <div class="text-center max-w-md mx-auto p-6 rounded-lg shadow-md">
        <div class="relative w-64 h-64 mx-auto mb-6 rounded-xl overflow-hidden cursor-pointer">
            <img src="https://media.tenor.com/UFpi4Wt4JRwAAAAM/awoo-cat-baby-cat.gif"
                alt="Masih Dalam Pengembangan"
                class="w-full h-full object-cover transition-transform duration-500 hover:scale-105"
                style="filter: brightness(110%);" id="awoImage">
            <div class="absolute inset-0 bg-[#F66527] opacity-20 animate-pulse rounded-xl"></div>
        </div>

        <h1 class="text-3xl font-bold mb-4 text-[#F66528]">Masih Dalam Pengembangan</h1>

        <p class="text-lg mb-4 text-gray-800">
            Fitur ini sedang dalam tahap pengembangan. Kami berusaha keras untuk memberikan pengalaman terbaik bagi Anda.
        </p>

        <p class="text-sm mb-8 text-gray-800">
            Menyukai pekerjaan kami? Berikan bintang pada
            <a href="https://github.com/Ridhsuki/final-project-cari-magang" target="_blank"
                class="text-[#F66527] hover:underline font-medium">Repositori Cari Magang</a> dan ikuti untuk pembaruan!
        </p>

        <a href="javascript:history.back()"
            class="px-6 py-3 text-white bg-[#F66527] hover:bg-[#E05219] rounded-lg text-sm font-medium transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-[#FFC2B2] focus:ring-offset-2">
            Kembali
        </a>

        <!-- Audio -->
        <audio id="awoSound" loop>
            <source src="https://www.myinstants.com/media/sounds/awoo-cat.mp3" type="audio/mpeg">
        </audio>
    </div>
</div>

<script>
    let isPlaying = false;

    function toggleAwo() {
        const audio = document.getElementById('awoSound');

        if (!isPlaying) {
            audio.currentTime = 0;
            audio.play().then(() => {
                isPlaying = true;
                console.log("Playing...");
            }).catch((err) => {
                console.log('Playback failed:', err);
            });
        } else {
            audio.pause();
            audio.currentTime = 0;
            isPlaying = false;
            console.log("Stopped.");
        }
    }
</script>
