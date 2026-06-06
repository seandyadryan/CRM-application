<?php

use App\Http\Controllers\Api\ActivityController;
use App\Http\Controllers\Api\CustomerController;
use App\Http\Controllers\Api\DashboardController;
use App\Http\Controllers\Api\DealController;
use App\Http\Controllers\Api\LeadController;
use Illuminate\Support\Facades\Route;

Route::get('/workspace', [DashboardController::class, 'workspace']);

Route::apiResource('customers', CustomerController::class);
Route::apiResource('leads', LeadController::class);
Route::apiResource('deals', DealController::class);
Route::apiResource('activities', ActivityController::class);
