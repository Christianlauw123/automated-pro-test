<?php

namespace App\Policies;

use App\Models\Ticket;
use App\Models\User;

class TicketPolicy
{
    /**
     * Create a new policy instance.
     */
    public function __construct()
    {
        //
    }

    public function create(User $user){ 
        return $user->role == "admin" || $user->role == "organizer";
    }
    
    public function update(User $user, Ticket $ticket){
        return ($user->id === $ticket->event->created_by && $user->role == "organizer") || $user->role === 'admin';
    }

    public function delete(User $user, Ticket $ticket){
        return ($user->id === $ticket->event->created_by && $user->role == "organizer") || $user->role === 'admin';
    }
}
