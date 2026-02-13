<?php

namespace App\Policies;

use App\Models\Event;
use App\Models\User;

class EventPolicy
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
    
    public function update(User $user, Event $event){
        return ($user->id === $event->created_by && $user->role == "organizer") || $user->role === 'admin';
    }

    public function delete(User $user, Event $event){
        return ($user->id === $event->created_by && $user->role == "organizer") || $user->role === 'admin';
    }
}
