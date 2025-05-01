<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use Illuminate\Http\Request;

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
        $notif = Notification::findOrFail($id);

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
        $notif = Notification::findOrFail($id);

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