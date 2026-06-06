<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Activity;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ActivityController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json(['data' => Activity::latest()->paginate(20)]);
    }

    public function store(Request $request): JsonResponse
    {
        $activity = Activity::create($this->validated($request));

        return response()->json(['data' => $activity], 201);
    }

    public function show(Activity $activity): JsonResponse
    {
        return response()->json(['data' => $activity]);
    }

    public function update(Request $request, Activity $activity): JsonResponse
    {
        $activity->update($this->validated($request));

        return response()->json(['data' => $activity]);
    }

    public function destroy(Activity $activity): JsonResponse
    {
        $activity->delete();

        return response()->json(['message' => 'Activity deleted']);
    }

    private function validated(Request $request): array
    {
        return $request->validate([
            'title' => ['required', 'string', 'max:160'],
            'contact' => ['required', 'string', 'max:120'],
            'type' => ['required', 'string', 'max:60'],
            'due_at' => ['nullable', 'date'],
            'is_done' => ['boolean'],
        ]);
    }
}
