<?php

namespace App\Policies;

use App\Models\Booking;
use App\Models\User;

class BookingPolicy
{
    /**
     * Create a new policy instance.
     */
    public function __construct()
    {
        //
    }

    public function view(User $user, Booking $booking){ 
        return $user->role == "admin" || ($user->id === $booking->user_id && $user->role == "customer") || ($user->id === $booking->ticket->event->created_by && $user->role == "organizer");
    }

    public function create(User $user){ 
        return $user->role == "admin" || $user->role == "customer";
    }
    
    public function update(User $user, Booking $booking){
        return ($user->id === $booking->user_id && $user->role == "customer") || $user->role === 'admin';
    }
}
