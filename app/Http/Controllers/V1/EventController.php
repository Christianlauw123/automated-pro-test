<?php

namespace App\Http\Controllers\V1;

use App\Helpers\ResponseHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\CreateEventDto;
use App\Http\Requests\UpdateEventDto;
use App\Models\Event;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;

class EventController extends Controller
{
    public function index(Request $request)
    {
        // Query Builder
        $events = Event::query();

        // Organizer: Only Show their Event
        if ($request->user()->role == "organizer")
            $events = $events->where('created_by',$request->user()->id);

        if ($request->filled('search')) {
            // Lower the keyword 
            $search_keyword = strtolower(trim($request->search));
            $events = $events->where(function ($query) use ($search_keyword) {
                $query->where('title', 'ILIKE', '%' . $search_keyword . '%')->orWhere('description', 'ILIKE', '%' . $search_keyword . '%');
            });
        }

        if ($request->filled('date')) {
            $events = $events->whereDate('date', $request->date);
        }

        if ($request->filled('location')) {
            $events = $events->where('location', $request->location);
        }

        if ($request->filled('limit')) {
            $events = $events->paginate($request->filled('limit'));
        }else{
            $events = $events->paginate(10);
        }

        return ResponseHelper::success($events, 'Event Retrieved', 200);
    }

    // Create Event
    public function store(CreateEventDto $request)
    {
        $this->authorize('create', Event::class);
        
        $event = new Event();
        $event->title = $request->title;
        $event->description = $request->description;
        $event->date = $request->date;
        $event->location = $request->location;
        $event->created_by = $request->user()->id;
        $event->save();
        return ResponseHelper::success($event, 'Create Event Success', 200);
    }

    // Get a Event
    public function show(string $id)
    {
        try {
            $event = Event::with('tickets')->findOrFail($id);
            return response()->json([
                'data' => $event
            ]);
            return ResponseHelper::success($event, 'Get Event Success', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Event not found', null, 404);
        }
    }

    // Update Event
    public function update(UpdateEventDto $request, string $id)
    {
        try {
            $event = Event::with('tickets')->findOrFail($id);
            
            $this->authorize('update', $event);

            $event->title = $request->title;
            $event->description = $request->description;
            $event->date = $request->date;
            $event->location = $request->location;
            $event->save();
            return ResponseHelper::success($event, 'Update Event Success', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Event not found', null, 404);
        }
    }

    // Delete Event
    public function destroy(string $id)
    {
        try {
            $event = Event::with('tickets')->findOrFail($id);
            $this->authorize('delete', $event);

            $event->delete();
            return ResponseHelper::success(null, 'Delete Event Success', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Event not found', null, 404);
        }
    }
}
