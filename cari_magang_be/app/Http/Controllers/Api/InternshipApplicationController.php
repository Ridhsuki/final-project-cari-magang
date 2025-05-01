<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Internship;
use App\Models\InternshipApplication;
use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class InternshipApplicationController extends Controller
{
    public function index()
    {
        if (auth()->user()->role !== 'company') {
            return response()->json(['status' => 'error', 'message' => 'Unauthorized'], 403);
        }

        // Asumsikan user yang login adalah company
        $companyId = auth()->id(); // Atau auth()->user()->id;

        // Ambil hanya aplikasi magang untuk internship milik company ini
        $applications = InternshipApplication::with(['user', 'internship'])
            ->whereHas('internship', function ($query) use ($companyId) {
                $query->where('user_id', $companyId);
            })
            ->get();
        // $applications = InternshipApplication::with(['user', 'internship'])->get();

        return response()->json([
            'status' => 'success',
            'data' => $applications
        ]);
    }

    public function show($id)
    {
        if (auth()->user()->role !== 'company') {
            return response()->json(['status' => 'error', 'message' => 'Unauthorized'], 403);
        }
        $companyId = auth()->id();

        $application = InternshipApplication::with(['user', 'internship'])
            ->where('id', $id)
            ->whereHas('internship', function ($query) use ($companyId) {
                $query->where('user_id', $companyId);
            })
            ->first();

        if (!$application) {
            return response()->json([
                'status' => 'error',
                'message' => 'Application not found or unauthorized access.'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => $application
        ]);
    }

    public function store(Request $request)
    {
        $user = Auth::user();
        if ($user->role === 'company' || $user->role === 'admin') {
            return response()->json([
                'status' => 'error',
                'message' => 'Pengguna dengan role company atau admin tidak diperbolehkan melamar magang.',
            ], 403);
        }

        $request->validate([
            'internship_id' => 'required|exists:internships,id',
            'cv' => 'required|file|mimes:pdf,doc,docx|max:2048',
            'certificate' => 'nullable|file|mimes:pdf,doc,docx|max:2048',
            'full_name' => 'required|string|max:255',
            'date_of_birth' => 'required|date',
            'address' => 'required|string|max:255',
            'education' => 'required|string|max:255',
        ]);

        $existingApplication = InternshipApplication::where('user_id', Auth::id())
            ->where('internship_id', $request->internship_id)
            ->first();

        if ($existingApplication) {
            return response()->json([
                'status' => 'error',
                'message' => 'Anda sudah pernah mengajukan lamaran untuk internship ini.',
            ], 400);
        }

        // Simpan CV
        $cvFile = $request->file('cv');
        $cvFilename = Auth::id() . '_' . time() . '_' . $cvFile->getClientOriginalName();
        $cvPath = $cvFile->storeAs('cv', $cvFilename, 'public');

        // Simpan Certificate (jika ada)
        $certificatePath = null;
        if ($request->hasFile('certificate')) {
            $certificateFile = $request->file('certificate');
            $certificateFilename = Auth::id() . '_' . time() . '_' . $certificateFile->getClientOriginalName();
            $certificatePath = $certificateFile->storeAs('certificate', $certificateFilename, 'public');
        }

        // Simpan ke database
        $application = InternshipApplication::create([
            'user_id' => Auth::id(),
            'internship_id' => $request->internship_id,
            'cv' => $cvPath,
            'certificate' => $certificatePath,
            'status' => 'pending',
            'full_name' => $request->full_name,
            'date_of_birth' => $request->date_of_birth,
            'address' => $request->address,
            'education' => $request->education,
        ]);

        $internship = Internship::findOrFail($request->internship_id);

        Notification::create([
            'sender_id' => $user->id,
            'receiver_id' => $internship->user_id,
            'internship_id' => $internship->id,
            'type' => 'user_applied',
            'message' => $user->name . ' telah melamar ke ' . $internship->title,
        ]);

        // Kirim respons
        return response()->json([
            'status' => 'success',
            'message' => 'Berhasil mengajukan lamaran, silakan tunggu konfirmasi dari perusahaan',
            'data' => [
                'id' => $application->id,
                'user_id' => $application->user_id,
                'internship_id' => $application->internship_id,
                'cv' => asset('storage/' . $application->cv),
                'certificate' => $application->certificate ? asset('storage/' . $application->certificate) : null,
                'status' => $application->status,
                'full_name' => $application->full_name,
                'date_of_birth' => $application->date_of_birth,
                'address' => $application->address,
                'education' => $application->education,
                'created_at' => $application->created_at,
                'updated_at' => $application->updated_at,
            ]
        ]);
    }


    // ================= USER METHODS =================
    public function myApply()
    {

        if (auth()->user()->role === 'company' || auth()->user()->role === 'admin') {
            return response()->json([
                'status' => 'error',
                'message' => 'Pengguna dengan role company atau admin tidak diperbolehkan melamar magang.',
            ], 403);
        }

        $applications = InternshipApplication::with('internship')
            ->where('user_id', auth()->id())
            ->latest()
            ->get();

        return response()->json([
            'status' => 'success',
            'data' => $applications->map(function ($app) {
                return [
                    'id' => $app->id,
                    'internship' => [
                        'id' => $app->internship->id,
                        'title' => $app->internship->title,
                        'company' => $app->internship->company->name,
                    ],
                    'cv' => asset('storage/' . $app->cv),
                    'certificate' => $app->certificate ? asset('storage/' . $app->certificate) : null,
                    'status' => $app->status,
                    'full_name' => $app->full_name,
                    'date_of_birth' => $app->date_of_birth,
                    'address' => $app->address,
                    'education' => $app->education,
                    'applied_at' => $app->created_at,
                ];
            })
        ]);
    }

    // ================= COMPANY METHODS =================
    public function applicants($internshipId)
    {
        // Mencari internship berdasarkan ID dan memastikan milik perusahaan yang sedang login
        $internship = Internship::with(['applications.user.profile'])
            ->where('id', $internshipId)
            ->where('user_id', auth()->id())
            ->first(); // Menggunakan first() daripada firstOrFail()

        // Jika internship tidak ditemukan
        if (!$internship) {
            return response()->json([
                'status' => 'error',
                'message' => 'Internship not found or not owned by this company.'
            ], 404); // Mengirimkan error 404 jika tidak ditemukan
        }

        // Mengambil data pelamar dan mengirimkannya dalam bentuk response JSON
        return response()->json([
            'status' => 'success',
            'data' => $internship->applications->map(function ($app) {
                return [
                    'id' => $app->id,
                    'user' => [
                        'id' => $app->user->id,
                        'name' => $app->user->name,
                        'email' => $app->user->email,
                        'profile' => $app->user->profile ?? null, // Menambahkan pengecekan profile
                    ],
                    'cv' => asset('storage/' . $app->cv),
                    'certificate' => $app->certificate ? asset('storage/' . $app->certificate) : null,
                    'status' => $app->status,
                    'full_name' => $app->full_name,
                    'date_of_birth' => $app->date_of_birth,
                    'address' => $app->address,
                    'education' => $app->education,
                    'applied_at' => $app->created_at,
                ];
            })
        ]);
    }

}
