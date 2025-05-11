<?php

namespace App\Filament\Company\Resources\InternshipResource\Pages;

use App\Filament\Company\Resources\InternshipResource;
use Filament\Resources\Pages\ViewRecord;
use Filament\Forms\Form;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Grid;
use Illuminate\Support\HtmlString;

class ViewInternship extends ViewRecord
{
    protected static string $resource = InternshipResource::class;

    public function form(Form $form): Form
    {
        return $form->schema([
            Grid::make(2)->schema([
                Placeholder::make('title')
                    ->label('Title')
                    ->content(fn($record) => $record->title),

                Placeholder::make('category')
                    ->label('Category')
                    ->content(fn($record) => $record->category?->name ?? '-'),

                Placeholder::make('location')
                    ->label('Location')
                    ->content(fn($record) => $record->location),

                Placeholder::make('status')
                    ->label('Status')
                    ->content(function ($record) {
                        $color = match ($record->status) {
                            'paid' => '#6BBF59',
                            'unpaid' => '#F4A259',
                            default => '#A0AEC0',
                        };

                        return new HtmlString(
                            "<span style='background-color: {$color}; color: white; padding: 0.2em 0.6em; border-radius: 0.3em; font-size: 0.9em; text-transform: capitalize;'>{$record->status}</span>"
                        );
                    }),

                Placeholder::make('system')
                    ->label('System')
                    ->content(function ($record) {
                        $color = match ($record->system) {
                            'remote' => '#38B2AC',
                            'on-site' => '#F56565',
                            default => '#A0AEC0',
                        };

                        return new HtmlString(
                            "<span style='background-color: {$color}; color: white; padding: 0.2em 0.6em; border-radius: 0.3em; font-size: 0.9em; text-transform: capitalize;'>{$record->system}</span>"
                        );
                    }),
                Placeholder::make('applications')
                    ->label('People Applied')
                    ->content(fn($record) => $record->applications()->count()),
            ]),

            Grid::make(1)->schema([
            Placeholder::make('description')
                ->label('Description')
                ->content(fn($record) => new HtmlString($record->description)),
            ]),
            Grid::make(2)->schema([
                Placeholder::make('company')
                    ->label('Posted By')
                    ->content(fn($record) => $record->company?->name ?? '-'),

                Placeholder::make('created_at')
                    ->label('Posted At')
                    ->content(fn($record) => $record->created_at->format('d M Y H:i')),
            ]),
        ]);
    }
}
