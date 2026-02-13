<?php

namespace App\Policies;

use App\Models\Booking;
use App\Models\User;

class PaymentPolicy
{
    /**
     * Create a new policy instance.
     */
    public function __construct()
    {
        //
    }

    public function create(User $user, Booking $booking){ 
        return $user->role == "admin" || ($user->role == "customer" && $booking->user_id == $user->id);
    }
}
