<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Deal extends Model
{
    use HasFactory;

    protected $fillable = [
        'customer_id',
        'title',
        'customer',
        'stage',
        'amount',
        'probability',
        'expected_close_date',
    ];

    protected $casts = [
        'amount' => 'integer',
        'probability' => 'integer',
        'expected_close_date' => 'date',
    ];

    public function customerAccount(): BelongsTo
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
}
