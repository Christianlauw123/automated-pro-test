<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Ticket>
 */
class TicketFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $ticket_types = ['VVIP', 'VIP', 'Standard'];
        $random_ticket_type = $ticket_types[array_rand($ticket_types)];
        return [
            'type' => $random_ticket_type,
            'price' => rand(30000,50000),
            'quantity' => rand(1,5)
        ];
    }
}
