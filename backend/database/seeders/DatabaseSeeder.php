<?php

namespace Database\Seeders;

use App\Models\Activity;
use App\Models\Customer;
use App\Models\Deal;
use App\Models\Lead;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $customers = collect([
            [
                'name' => 'Aditya Pratama',
                'company' => 'Nusantara Retail',
                'email' => 'aditya@nusantararetail.id',
                'phone' => '+62 812 3300 1984',
                'segment' => 'Enterprise',
                'status' => 'Active',
            ],
            [
                'name' => 'Maya Cahyani',
                'company' => 'Sagara Logistic',
                'email' => 'maya@sagaralogistic.id',
                'phone' => '+62 811 9044 7788',
                'segment' => 'SMB',
                'status' => 'Active',
            ],
            [
                'name' => 'Rafi Wiratama',
                'company' => 'Bright Edu',
                'email' => 'rafi@brightedu.id',
                'phone' => '+62 857 2199 7701',
                'segment' => 'Startup',
                'status' => 'Prospect',
            ],
        ])->map(fn (array $customer) => Customer::create($customer));

        Lead::insert([
            [
                'name' => 'Procurement System',
                'company' => 'Mandala Group',
                'source' => 'Website',
                'value' => 72000000,
                'status' => 'Qualified',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Sales Automation',
                'company' => 'Bumi Medika',
                'source' => 'Referral',
                'value' => 46000000,
                'status' => 'New',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'CRM Migration',
                'company' => 'Karya Finance',
                'source' => 'Campaign',
                'value' => 93500000,
                'status' => 'Contacted',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        Deal::insert([
            [
                'customer_id' => $customers[0]->id,
                'title' => 'Enterprise CRM Rollout',
                'customer' => 'Nusantara Retail',
                'stage' => 'Negotiation',
                'amount' => 115000000,
                'probability' => 74,
                'expected_close_date' => now()->addDays(21)->toDateString(),
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'customer_id' => $customers[1]->id,
                'title' => 'Helpdesk Integration',
                'customer' => 'Sagara Logistic',
                'stage' => 'Proposal',
                'amount' => 38000000,
                'probability' => 51,
                'expected_close_date' => now()->addDays(35)->toDateString(),
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'customer_id' => $customers[2]->id,
                'title' => 'Analytics Add-on',
                'customer' => 'Bright Edu',
                'stage' => 'Won',
                'amount' => 29500000,
                'probability' => 100,
                'expected_close_date' => now()->subDays(8)->toDateString(),
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);

        Activity::insert([
            [
                'title' => 'Follow up proposal',
                'contact' => 'Aditya Pratama',
                'type' => 'Call',
                'due_at' => now()->setTime(10, 30),
                'is_done' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Demo pipeline report',
                'contact' => 'Maya Cahyani',
                'type' => 'Meeting',
                'due_at' => now()->setTime(14, 0),
                'is_done' => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Send renewal quotation',
                'contact' => 'Rafi Wiratama',
                'type' => 'Email',
                'due_at' => now()->addDay(),
                'is_done' => true,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
