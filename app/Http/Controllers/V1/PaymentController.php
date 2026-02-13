<?php

namespace App\Http\Controllers\V1;

use App\Helpers\ResponseHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\CreatePaymentDto;
use App\Models\Booking;
use App\Models\Payment;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    public function show($id)
    {
        try {
            $payment = Payment::findOrFail($id);
            return ResponseHelper::success($payment, 'Payment Retrieved', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Payment not found', null, 404);
        }
    }

    // Create Payment
    public function store(CreatePaymentDto $request, string $bookingId)
    {
        try {
            $booking = Booking::findOrFail($bookingId);
            $this->authorize('create', $booking);
            $payment = new Payment();
            $payment->status = 'failed';
            $payment->amount = $request->amount;
            $payment->booking_id = $booking->id;
            $payment->save();
            return ResponseHelper::success($payment, 'Payment Success', 200);
        } catch (ModelNotFoundException $e) {
            return ResponseHelper::error('Booking not found', null, 404);
        }
        
    }
}
