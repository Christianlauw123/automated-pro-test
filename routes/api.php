<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\V1\UserController as V1UserController;
use App\Http\Controllers\V1\EventController as V1EventController;
use App\Http\Controllers\V1\BookingController as V1BookingController;
use App\Http\Controllers\V1\PaymentController as V1PaymentController;
use App\Http\Controllers\V1\TicketController as V1TicketController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::prefix('v1')->group(function () {
    Route::get('/', function(){
        return response()->json([
            'success' => true
        ]);
    });
    Route::post('/login', [V1UserController::class, 'login']);
    Route::post('/register', [V1UserController::class, 'register']);

    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/me', [V1UserController::class, 'me']);
        Route::post('/logout', [V1UserController::class, 'logout']);

        // Get All Events - Paginated
        Route::get('/events', [V1EventController::class, 'index']);

        // Get Specific Event
        Route::get('/events/{id}', [V1EventController::class, 'show']);

        // Get Bookings, Admin - Organizer - Customer
        Route::get('/bookings', [V1BookingController::class, 'index']);

        // Get Specific Payment
        Route::get('/payments/{id}', [V1PaymentController::class, 'show']);

        Route::middleware('role:admin')->group(function () {
            // Event API
            Route::post('/events', [V1EventController::class, 'store']);
            Route::put('/events/{id}', [V1EventController::class, 'update']);
            Route::delete('/events/{id}', [V1EventController::class, 'destroy']);

            // Ticket API
            Route::post('/events/{event_id}/tickets', [V1TicketController::class, 'store']);
            Route::put('/tickets/{id}', [V1TicketController::class, 'update']);
            Route::delete('/tickets/{id}', [V1TicketController::class, 'destroy']);

            // Booking API
            Route::post('/tickets/{id}/bookings', [V1BookingController::class, 'store']);
            Route::put('/bookings/{id}/cancel', [V1BookingController::class, 'update']);

            // Payment API
            Route::post('/bookings/{id}/payment', [V1PaymentController::class, 'store']);
        });

        Route::middleware('role:organizer')->group(function () {
            // Event API
            Route::post('/events', [V1EventController::class, 'store']);
            Route::put('/events/{id}', [V1EventController::class, 'update']);
            Route::delete('/events/{id}', [V1EventController::class, 'destroy']);

            // Ticket API
            Route::put('/tickets/{id}', [V1TicketController::class, 'update']);
            Route::delete('/tickets/{id}', [V1TicketController::class, 'destroy']);
        });

        Route::middleware('role:customer')->group(function () {
            // Booking API
            Route::post('/tickets/{id}/bookings', [V1BookingController::class, 'store']);
            Route::put('/bookings/{id}/cancel', [V1BookingController::class, 'update']);

            // Payment API
            Route::post('/bookings/{id}/payment', [V1PaymentController::class, 'store']);
        });
    });
});
