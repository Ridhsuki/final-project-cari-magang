<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;

class CategoryController extends Controller
{
    public function index()
    {
        $categories = Category::all(['id', 'name']); // ambil hanya id & name

        return response()->json([
            'status' => 'success',
            'data' => $categories
        ]);
    }
}