<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Booking>
 */
class BookingFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $booking_statuses = ['pending', 'confirmed', 'cancelled'];
        $random_booking_status = $booking_statuses[array_rand($booking_statuses)];
        return [
            'quantity' => rand(1,5),
            'status' =>  $random_booking_status,
        ];
    }
}
