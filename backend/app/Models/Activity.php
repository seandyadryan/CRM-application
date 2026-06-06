<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Activity extends Model
{
    use HasFactory;

    protected $fillable = [
        'title',
        'contact',
        'type',
        'due_at',
        'is_done',
    ];

    protected $casts = [
        'due_at' => 'datetime',
        'is_done' => 'boolean',
    ];
}
