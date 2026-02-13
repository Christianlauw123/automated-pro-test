<?php

namespace App\Http\Controllers\V1;

use App\Helpers\ResponseHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\CreateTicketDto;
use App\Http\Requests\UpdateTicketDto;
use App\Models\Event;
use App\Models\Ticket;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;

class TicketController extends Controller
{
    // Create Ticket
    public function store(CreateTicketDto $request, string $eventId)
    {
        try {
            $event = Event::findOrFail($eventId);
            $this->authorize('create', Ticket::class);
            $ticket = new Ticket();
            $ticket->type = $request->type;
            $ticket->price = $request->price;
            $ticket->quantity = $request->quantity;
            $ticket->event_id = $event->id;
            $ticket->save();
            return ResponseHelper::success($ticket, 'Create Ticket Success', 200);
            
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Event not found', null, 404);
        }
    }

    // Update a Ticket
    public function update(UpdateTicketDto $request, string $id)
    {
        try {
            $ticket = Ticket::findOrFail($id);
            $this->authorize('update', $ticket);
            $ticket->type = $request->type;
            $ticket->price = $request->price;
            $ticket->quantity = $request->quantity;
            $ticket->event_id = $request->event_id;
            $ticket->save();
            return ResponseHelper::success($ticket, 'Update Ticket Success', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Event not found', null, 404);
        }
        
    }

    // Destroy a Ticket
    public function destroy($id)
    {
        try {
            $ticket = Ticket::findOrFail($id);
            $this->authorize('delete', $ticket);
            $ticket->delete();
            return ResponseHelper::success(null, 'Delete Ticket Success', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Ticket not found', null, 404);
        }
    }
}
