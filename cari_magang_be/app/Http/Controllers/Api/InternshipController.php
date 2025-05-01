<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Internship;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class InternshipController extends Controller
{
    public function index(Request $request)
    {
        $query = Internship::query();

        // Filter berdasarkan category
        if ($request->has('category')) {
            $query->where('category_id', $request->input('category'));
        }
    
        // Filter berdasarkan system (remote/on-site)
        if ($request->has('system')) {
            $query->where('system', $request->input('system'));
        }
    
        // Filter berdasarkan status (paid/unpaid)
        if ($request->has('status')) {
            $query->where('status', $request->input('status'));
        }
    
        // Menambahkan hubungan yang diperlukan
        $query->with(['category', 'user']);
    
        // Menampilkan data
        $internships = $query->get();
        // $internships = Internship::with('category', 'user')->latest()->get();

        return response()->json([
            'status' => 'success',
            'data' => $internships,
        ]);
    }

    public function show($id)
    {
        $internship = Internship::with('category', 'user')->find($id);

        if (!$internship) {
            return response()->json([
                'status' => 'error',
                'message' => 'Data lowongan magang tidak ditemukan',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => $internship,
        ]);
    }

    public function store(Request $request)
    {
        if (Auth::user()->role !== 'company') {
            return response()->json([
                'status' => 'error',
                'message' => 'Only company can post internship'
            ], 403);
        }
        $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'required',
            'location' => 'nullable|string|max:255',
            'status' => 'required|in:paid,unpaid',
            'system' => 'required|in:remote,on-site',
            'category_id' => 'required|exists:categories,id',
        ]);
        $internship = Internship::create([
            'user_id' => Auth::id(),
            'title' => $request->title,
            'description' => $request->description,
            'location' => $request->location,
            'status' => $request->status,
            'system' => $request->system,
            'category_id' => $request->category_id,
        ]);
        return response()->json([
            'status' => 'success',
            'message' => 'Lowongan magang berhasil ditambahkan',
            'data' => $internship,
        ], 201);
    }
    public function update(Request $request, $id)
    {
        $internship = Internship::find($id);

        if (!$internship) {
            return response()->json([
                'status' => 'error',
                'message' => 'Internship not found',
            ], 404);
        }

        if (Auth::user()->role !== 'company' || Auth::id() !== $internship->user_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'You are not authorized to update this internship',
            ], 403);
        }

        $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'description' => 'sometimes|required|string',
            'location' => 'nullable|string|max:255',
            'status' => 'sometimes|required|in:paid,unpaid',
            'system' => 'sometimes|required|in:remote,on-site',
            'category_id' => 'sometimes|required|exists:categories,id',
        ]);

        $internship->update($request->only([
            'title',
            'description',
            'location',
            'status',
            'system',
            'category_id'
        ]));

        return response()->json([
            'status' => 'success',
            'message' => 'Data lowongan magang berhasil diupdate',
            'data' => $internship,
        ]);
    }

    public function destroy($id)
    {
        $internship = Internship::find($id);

        if (!$internship) {
            return response()->json([
                'status' => 'error',
                'message' => 'Internship not found',
            ], 404);
        }

        if (Auth::user()->role !== 'company' || Auth::id() !== $internship->user_id) {
            return response()->json([
                'status' => 'error',
                'message' => 'You are not authorized to delete this internship',
            ], 403);
        }

        $internship->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Data lowongan magang berhasil dihapus',
        ]);
    }
}
