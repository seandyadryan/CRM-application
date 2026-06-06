<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Activity;
use App\Models\Customer;
use App\Models\Deal;
use App\Models\Lead;
use Illuminate\Http\JsonResponse;

class DashboardController extends Controller
{
    public function workspace(): JsonResponse
    {
        $customers = Customer::latest()->limit(8)->get();
        $leads = Lead::latest()->limit(8)->get();
        $deals = Deal::latest()->limit(8)->get();
        $activities = Activity::orderByRaw('is_done asc')
            ->orderBy('due_at')
            ->limit(8)
            ->get();

        return response()->json([
            'data' => [
                'stats' => [
                    'total_customers' => Customer::count(),
                    'open_leads' => Lead::whereNotIn('status', ['Won', 'Lost'])->count(),
                    'active_deals' => Deal::whereNotIn('stage', ['Won', 'Lost'])->count(),
                    'monthly_revenue' => Deal::where('stage', 'Won')->sum('amount'),
                    'conversion_rate' => $this->conversionRate(),
                ],
                'customers' => $customers,
                'leads' => $leads,
                'deals' => $deals,
                'activities' => $activities->map(fn (Activity $activity) => [
                    'id' => $activity->id,
                    'title' => $activity->title,
                    'contact' => $activity->contact,
                    'type' => $activity->type,
                    'due_at' => optional($activity->due_at)->format('M d, H:i') ?? '-',
                    'is_done' => $activity->is_done,
                ]),
            ],
        ]);
    }

    private function conversionRate(): int
    {
        $totalDeals = Deal::count();

        if ($totalDeals === 0) {
            return 0;
        }

        return (int) round((Deal::where('stage', 'Won')->count() / $totalDeals) * 100);
    }
}
