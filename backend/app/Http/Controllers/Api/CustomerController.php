<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Customer;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    public function index(): JsonResponse
    {
        return response()->json(['data' => Customer::latest()->paginate(20)]);
    }

    public function store(Request $request): JsonResponse
    {
        $customer = Customer::create($this->validated($request));

        return response()->json(['data' => $customer], 201);
    }

    public function show(Customer $customer): JsonResponse
    {
        return response()->json(['data' => $customer->load('deals')]);
    }

    public function update(Request $request, Customer $customer): JsonResponse
    {
        $customer->update($this->validated($request));

        return response()->json(['data' => $customer]);
    }

    public function destroy(Customer $customer): JsonResponse
    {
        $customer->delete();

        return response()->json(['message' => 'Customer deleted']);
    }

    private function validated(Request $request): array
    {
        return $request->validate([
            'name' => ['required', 'string', 'max:120'],
            'company' => ['required', 'string', 'max:160'],
            'email' => ['required', 'email', 'max:160'],
            'phone' => ['nullable', 'string', 'max:40'],
            'segment' => ['required', 'string', 'max:60'],
            'status' => ['required', 'string', 'max:40'],
            'notes' => ['nullable', 'string'],
        ]);
    }
}
