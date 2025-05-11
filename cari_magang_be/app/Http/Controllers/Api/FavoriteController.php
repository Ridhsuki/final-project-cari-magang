<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Favorite;
use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    public function index(Request $request)
    {
        $favorites = Favorite::with('internship.category', 'internship.user')
            ->where('user_id', $request->user()->id)
            ->get()
            ->pluck('internship');

        return response()->json([
            'status' => 'success',
            'data' => $favorites,
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'internship_id' => 'required|exists:internships,id',
        ]);

        // Cek apakah internship sudah ada di favorit
        $favorite = Favorite::where('user_id', $request->user()->id)
            ->where('internship_id', $request->internship_id)
            ->first();

        if ($favorite) {
            // Jika sudah ada, hapus dari favorit
            $favorite->delete();

            return response()->json([
                'status' => 'success',
                'message' => 'Dihapus dari favorit.'
            ]);
        } else {
            // Jika belum ada, tambah ke favorit
            Favorite::create([
                'user_id' => $request->user()->id,
                'internship_id' => $request->internship_id,
            ]);

            return response()->json([
                'status' => 'success',
                'message' => 'Ditambahkan ke favorit.'
            ]);
        }
    }
}