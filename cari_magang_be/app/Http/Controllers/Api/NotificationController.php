<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class NotificationController extends Controller
{
    public function index(Request $request)
    {
        $notifications = Notification::with('sender', 'internship')
            ->where('receiver_id', $request->user()->id)
            ->latest()
            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $notifications,
        ]);
    }
    public function markAsRead($id)
    {
        $validator = Validator::make(['id' => $id], [
            'id' => 'required|uuid',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'ID tidak valid. Harus berupa UUID.',
            ], 400);
        }

        $notif = Notification::where('id', $id)
            ->where('receiver_id', auth()->id())
            ->first();

        if (!$notif) {
            return response()->json([
                'status' => 'error',
                'message' => 'Notifikasi tidak ditemukan atau bukan milik Anda.',
            ], 404);
        }

        if ($notif->receiver_id !== auth()->id()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized'
            ], 403);
        }

        $notif->update(['is_read' => true]);

        return response()->json([
            'status' => 'success',
            'message' => 'Notifikasi ditandai sebagai dibaca'
        ]);
    }
    public function destroy($id)
    {
        $validator = Validator::make(['id' => $id], [
            'id' => 'required|uuid',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'ID tidak valid. Harus berupa UUID.',
            ], 400);
        }

        $notif = Notification::where('id', $id)
            ->where('receiver_id', auth()->id())
            ->first();

        if (!$notif) {
            return response()->json([
                'status' => 'error',
                'message' => 'Notifikasi tidak ditemukan atau bukan milik Anda.',
            ], 404);
        }

        if ($notif->receiver_id !== auth()->id()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Unauthorized'
            ], 403);
        }

        $notif->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Notifikasi berhasil dihapus'
        ]);
    }
}