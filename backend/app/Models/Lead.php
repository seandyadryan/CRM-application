<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lead extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'company',
        'source',
        'value',
        'status',
        'contact_email',
        'contact_phone',
    ];

    protected $casts = [
        'value' => 'integer',
    ];
}
