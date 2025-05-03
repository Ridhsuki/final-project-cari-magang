<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function show(Request $request)
    {
        $user = $request->user();

        // Tentukan data dasar
        $responseData = [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'profile_picture' => $user->profile_picture ? asset('storage/profile_pictures/' . $user->profile_picture) : null,
            'role' => $user->role,
        ];

        // Tambahkan relasi sesuai role
        if ($user->role === 'user') {
            $user->load('profile');
            $responseData['profile'] = $user->profile;
        } elseif ($user->role === 'company') {
            $user->load('companyProfile');
            $responseData['companyProfile'] = $user->companyProfile;
        }

        return response()->json([
            'status' => 'success',
            'data' => $responseData,
        ], 200);
    }

    public function update(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'name' => 'string',
            'profile_picture' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        if ($request->hasFile('profile_picture')) {
            $profilePicture = $request->file('profile_picture');
            $profilePictureName = strtolower(str_replace(' ', '_', $user->name)) . '_' . time() . '.' . $profilePicture->getClientOriginalExtension();
            $profilePicture->storeAs('profile_pictures', $profilePictureName, 'public');

            $user->profile_picture = $profilePictureName;
        }

        $user->name = $request->name ?? $user->name;
        $user->save();

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

        $responseData = [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'profile_picture' => $user->profile_picture ? asset('storage/profile_pictures/' . $user->profile_picture) : null,
            'role' => $user->role,
        ];

        // Tambahkan relasi sesuai role
        if ($user->role === 'user') {
            $responseData['profile'] = $user->profile;
        } elseif ($user->role === 'company') {
            $responseData['companyProfile'] = $user->companyProfile;
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Profil berhasil diupdate!',
            'data' => $responseData,
        ], 200);
    }
}
