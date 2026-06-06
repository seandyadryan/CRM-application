<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Deal;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class DealController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json(['data' => Deal::latest()->paginate(20)]);
    }

    public function store(Request $request): JsonResponse
    {
        $deal = Deal::create($this->validated($request));

        return response()->json(['data' => $deal], 201);
    }

    public function show(Deal $deal): JsonResponse
    {
        return response()->json(['data' => $deal]);
    }

    public function update(Request $request, Deal $deal): JsonResponse
    {
        $deal->update($this->validated($request));

        return response()->json(['data' => $deal]);
    }

    public function destroy(Deal $deal): JsonResponse
    {
        $deal->delete();

        return response()->json(['message' => 'Deal deleted']);
    }

    private function validated(Request $request): array
    {
        return $request->validate([
            'customer_id' => ['nullable', 'exists:customers,id'],
            'title' => ['required', 'string', 'max:160'],
            'customer' => ['required', 'string', 'max:160'],
            'stage' => ['required', 'string', 'max:60'],
            'amount' => ['required', 'integer', 'min:0'],
            'probability' => ['required', 'integer', 'min:0', 'max:100'],
            'expected_close_date' => ['nullable', 'date'],
        ]);
    }
}
