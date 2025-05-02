<?php

namespace App\Filament\Company\Resources\InternshipResource\Pages;

use App\Filament\Company\Resources\InternshipResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListInternships extends ListRecords
{
    protected static string $resource = InternshipResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
