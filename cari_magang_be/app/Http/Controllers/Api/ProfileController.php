<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function show(Request $request)
    {
        $user = $request->user();

        if ($user->role === 'company') {
            $user->load('companyProfile');
        } else if ($user->role === 'user') {
            $user->load('profile');
        }

        return response()->json([
            'status' => 'success',
            'data' => $user,
        ], 200);
    }

    public function update(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'name' => 'string',
            'profile_picture' => 'nullable|url',
        ]);

        $user->update([
            'name' => $request->name ?? $user->name,
            'profile_picture' => $request->profile_picture ?? $user->profile_picture,
        ]);

        if ($user->role === 'company') {
            $request->validate([
                'description' => 'nullable|string',
                'address' => 'nullable|string',
                'phone' => 'nullable|string|numeric',
            ]);

            $user->companyProfile()->updateOrCreate(
                [],
                $request->only('description', 'address', 'phone')
            );

            $user->load('companyProfile');
            unset($user->profile);

        } elseif ($user->role === 'user') {
            $request->validate([
                'place_of_birth' => 'nullable|string',
                'date_of_birth' => 'nullable|date',
                'address' => 'nullable|string',
                'phone' => 'nullable|string',
                'education' => 'nullable|string',
            ]);

            $user->profile()->updateOrCreate(
                [],
                $request->only('place_of_birth', 'date_of_birth', 'address', 'phone', 'education')
            );

            $user->load('profile');
            unset($user->companyProfile);

        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Role tidak dikenali.',
            ], 400);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Profil berhasil diupdate!',
            'data' => $user,
        ], 200);
    }
}
