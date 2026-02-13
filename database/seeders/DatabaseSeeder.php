<?php

namespace Database\Seeders;

use App\Models\Booking;
use App\Models\Event;
use App\Models\Ticket;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $admin_users = User::factory()->count(2)->create([
            'role' => 'admin'
        ]);

        $organizer_users = User::factory()->count(3)->create([
            'role' => 'organizer'
        ]);

        $customers_users = User::factory()->count(10)->create([
            'role' => 'customer'
        ]);

        // Create 5 Events
        $events = Event::factory()->count(5)->for($organizer_users->first())->create();

        // Create 3 Event for 5 Events -> Total 15 Events
        foreach($events as $event){
            Ticket::factory()->count(3)->for($event)->create();
        }

        // Pulling all ticket_ids
        $ticket_ids = Ticket::all()->pluck('id')->toArray();

        // Create 20 Bookings - Each Customer 2 Bookings
        foreach($customers_users as $customer_user){
            $random_ticket_id = $ticket_ids[array_rand($ticket_ids)];
            Booking::factory()->count(2)->for($customer_user)->create([
                'ticket_id' => $random_ticket_id
            ]);
        }
    }
}
