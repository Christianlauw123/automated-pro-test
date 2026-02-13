<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Payment>
 */
class PaymentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $payment_statuses = ['success', 'failed', 'refunded'];
        $random_payment_status = $payment_statuses[array_rand($payment_statuses)];
        return [
            'amount' => rand(1,5),
            'status' =>  $random_payment_status,
        ];
    }
}
