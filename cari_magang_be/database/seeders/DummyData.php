<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Faker\Factory as Faker;

use App\Models\User;
use App\Models\UserProfile;
use App\Models\CompanyProfile;
use App\Models\Category;
use App\Models\Internship;
use App\Models\InternshipApplication;
use App\Models\Favorite;

class DummyData extends Seeder
{
    public function run(): void
    {
        $companyNames = ['PT. RIdho tech','CV. Jalan Monas','IDN Foundation','PT. DEF','Yayasan Solo Peduli'];

        $categoryNames = ['IT','Design','Marketing','Finance','HR'];
        $faker = Faker::create();

        // Buat kategori
        $categories = [];
        foreach ($categoryNames as $name) {
            $categories[] = Category::create([
                'name' => $name,
            ]);
        }

        // Buat user biasa + profilnya
        for ($i = 0; $i < 10; $i++) {
            $user = User::create([
                'name' => $faker->name,
                'email' => $faker->unique()->safeEmail,
                'email_verified_at' => now(),
                'password' => Hash::make('password'),
                'role' => 'user',
                'profile_picture' => 'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg',
                'remember_token' => Str::random(10),
            ]);

            UserProfile::create([
                'user_id' => $user->id,
                'place_of_birth' => $faker->city,
                'date_of_birth' => $faker->date,
                'address' => $faker->address,
                'phone' => $faker->phoneNumber,
                'education' => $faker->randomElement(['SMA', 'SMK', 'D3', 'S1']),
            ]);
        }

        // Buat user company + profil perusahaan
        for ($i = 0; $i < 5; $i++) {
            $companyUser = User::create([
                'name' => $companyNames[$i],
                'email' => $faker->unique()->companyEmail,
                'email_verified_at' => now(),
                'password' => Hash::make('password'),
                'role' => 'company',
                'profile_picture' => null,
                'remember_token' => Str::random(10),
            ]);

            CompanyProfile::create([
                'user_id' => $companyUser->id,
                'description' => $faker->paragraph,
                'address' => $faker->address,
                'phone' => $faker->phoneNumber,
            ]);

            // Buat internship dari company
            for ($j = 0; $j < 3; $j++) {
                $internship = Internship::create([
                    'user_id' => $companyUser->id,
                    'title' => $faker->jobTitle,
                    'description' => $faker->paragraph,
                    'location' => $faker->city,
                    'category_id' => $faker->randomElement($categories)->id,
                    'status' => $faker->randomElement(['paid', 'unpaid']),
                    'system' => $faker->randomElement(['remote', 'on-site']),
                ]);

                // Buat aplikasi random dari user ke internship ini
                $applicants = User::where('role', 'user')->inRandomOrder()->take(rand(1, 3))->get();
                foreach ($applicants as $applicant) {
                    InternshipApplication::create([
                        'user_id' => $applicant->id,
                        'internship_id' => $internship->id,
                        'cv' => 'cv_' . $applicant->id . '.pdf',
                        'certificate' => rand(0, 1) ? 'cert_' . $applicant->id . '.pdf' : null,
                    ]);

                    // Tambah ke favorit juga
                    Favorite::create([
                        'user_id' => $applicant->id,
                        'internship_id' => $internship->id,
                    ]);
                }
            }
        }
    }
}
