<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\FavoriteController;
use App\Http\Controllers\Api\InternshipApplicationController;
use App\Http\Controllers\Api\InternshipController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\ProfileController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/login',[AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');

Route::middleware('auth:sanctum')->group(function (){
    Route::get('/profile', [ProfileController::class, 'show']);
    Route::post('/profile', [ProfileController::class, 'update']);
});

Route::apiResource('/internships', InternshipController::class)->middleware('auth:sanctum');

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/applications', [InternshipApplicationController::class, 'index']);
    Route::post('/applications', [InternshipApplicationController::class, 'store']);
    Route::get('/applications/{id}', [InternshipApplicationController::class, 'show']);

    Route::get('/company/internships/{id}/applicants', [InternshipApplicationController::class, 'applicants']);
    Route::get('/user/my-applications', [InternshipApplicationController::class, 'myApply']);
});

Route::get('/categories', [CategoryController::class, 'index']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/favorites', [FavoriteController::class, 'store']);      // Tambah atau hapus favorit
    Route::get('/favorites', [FavoriteController::class, 'index']);       // Lihat semua favorit
});

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/notifications', [NotificationController::class, 'index']);
    Route::put('/notifications/{id}/read', [NotificationController::class, 'markAsRead']);
    Route::delete('/notifications/{id}', [NotificationController::class, 'destroy']);
});