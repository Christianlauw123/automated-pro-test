<?php

namespace App\Http\Controllers\V1;

use App\Helpers\ResponseHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\CreateBookingDto;
use App\Models\Booking;
use App\Models\Ticket;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;

class BookingController extends Controller
{
    // Get List of Bookings Customer
    public function index(Request $request)
    {
        $bookings = Booking::query();
        
        // Organizer: Only Show Booking Under their Event - booking->ticket->user-
        if ($request->user()->role == "organizer"){
            $bookings = $bookings->whereHas('ticket.event', function ($q) use ($request) {
                $q->where('created_by', $request->user()->id);
            });
        }

        // Customer: Only Show Booking Under Their user - booking->user-
        if ($request->user()->role == "customer")
            $bookings = $bookings->where('user_id',$request->user()->id);

        if ($request->filled('per_page')) {
            $bookings = $bookings->paginate($request->filled('per_page'));
        }else{
            $bookings = $bookings->paginate(10);
        }

        return ResponseHelper::success($bookings, 'Booking Retrieved', 200);
    }

    // Create Booking
    public function store(CreateBookingDto $request, string $ticketId)
    {
        $this->authorize('create', Booking::class);
        try {
            $ticket = Ticket::findOrFail($ticketId);
            $booking = new Booking();
            $booking->status = 'pending';
            $booking->quantity = $request->quantity;
            $booking->user_id = $request->user_id ?? $request->user()->id;
            $booking->ticket_id = $ticket->id;
            $booking->save();
            return ResponseHelper::success($ticket, 'Create Booking Success', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Ticket not found', null, 404);
        }
    }

    // Update Specific Booking to cancel
    public function update(string $id)
    {
        try {
            $booking = Booking::findOrFail($id);
            $this->authorize('update', $booking);

            $booking->status = 'cancelled';
            $booking->save();
            return response()->json([
                'data' => $booking
            ]);
            return ResponseHelper::success($booking, 'Booking Cancelled', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Booking not found', null, 404);
        }
        
    }
}
