<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Notifications\Messages\DatabaseMessage;
use App\Models\InternshipApplication;

class UserAppliedNotification extends Notification
{
    use Queueable;

    protected $application;

    public function __construct(InternshipApplication $application)
    {
        $this->application = $application;
    }

    public function via($notifiable)
    {
        return ['database'];
    }

    public function toDatabase($notifiable)
    {
        return [
            'message' => $this->application->user->name . ' telah melamar ke ' . $this->application->internship->title,
            'application_id' => $this->application->id,
            'user_id' => $this->application->user_id,
            'internship_id' => $this->application->internship_id,
        ];
    }
}