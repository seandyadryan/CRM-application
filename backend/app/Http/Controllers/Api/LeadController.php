<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Lead;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class LeadController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json(['data' => Lead::latest()->paginate(20)]);
    }

    public function store(Request $request): JsonResponse
    {
        $lead = Lead::create($this->validated($request));

        return response()->json(['data' => $lead], 201);
    }

    public function show(Lead $lead): JsonResponse
    {
        return response()->json(['data' => $lead]);
    }

    public function update(Request $request, Lead $lead): JsonResponse
    {
        $lead->update($this->validated($request));

        return response()->json(['data' => $lead]);
    }

    public function destroy(Lead $lead): JsonResponse
    {
        $lead->delete();

        return response()->json(['message' => 'Lead deleted']);
    }

    private function validated(Request $request): array
    {
        return $request->validate([
            'name' => ['required', 'string', 'max:160'],
            'company' => ['required', 'string', 'max:160'],
            'source' => ['required', 'string', 'max:80'],
            'value' => ['required', 'integer', 'min:0'],
            'status' => ['required', 'string', 'max:40'],
            'contact_email' => ['nullable', 'email', 'max:160'],
            'contact_phone' => ['nullable', 'string', 'max:40'],
        ]);
    }
}
