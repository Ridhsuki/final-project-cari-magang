<?php

namespace App\Filament\Company\Resources\AllApplicantsResource\Pages;

use App\Filament\Company\Resources\AllApplicantsResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditAllApplicants extends EditRecord
{
    protected static string $resource = AllApplicantsResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
