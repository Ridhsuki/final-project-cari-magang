<?php

namespace App\Filament\Resources;

use App\Filament\Resources\InternshipApplicationResource\Pages;
use App\Filament\Resources\InternshipApplicationResource\RelationManagers;
use App\Models\Internship;
use App\Models\InternshipApplication;
use App\Models\User;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Section;
use Joaopaulolndev\FilamentPdfViewer\Forms\Components\PdfViewerField;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\HtmlString;

class InternshipApplicationResource extends Resource
{
    protected static ?string $model = InternshipApplication::class;
    protected static ?string $navigationIcon = 'heroicon-o-clipboard';
    protected static ?string $navigationGroup = 'Management';
    protected static ?string $label = 'Internship Apply';
    public static function getNavigationSort(): ?int
    {
        return 2;
    }
    public static function canCreate(): bool
    {
        return false;
    }
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('user.name')
                    ->sortable()
                    ->searchable()
                    ->label('Name'),
                Tables\Columns\TextColumn::make('internship.title')
                    ->sortable()
                    ->searchable()
                    ->label('Apply For'),
                Tables\Columns\TextColumn::make('cv')
                    ->label('CV')
                    ->formatStateUsing(fn($state) => $state ? 'CV' : '-')
                    ->url(fn($record) => $record->cv ? Storage::url($record->cv) : null, true)
                    ->openUrlInNewTab(),
                Tables\Columns\TextColumn::make('certificate')
                    ->label('Certificate')
                    ->formatStateUsing(fn($state) => $state ? 'Certificate' : '-')
                    ->url(fn($record) => $record->certificate ? Storage::url($record->certificate) : null, true),
                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->formatStateUsing(function ($state) {
                        $colors = [
                            'pending' => '#facc15',  // gold/yellow
                            'approved' => '#4ade80', // soft green
                            'rejected' => '#f87171', // soft red
                        ];

                        $color = $colors[$state] ?? '#d1d5db'; // fallback gray

                        return new HtmlString("
                            <span style='
                                display: inline-block;
                                background-color: {$color};
                                color: #1f2937;
                                padding: 0.3em 0.75em;
                                border-radius: 0.5em;
                                font-size: 0.9em;
                                font-weight: 600;
                                text-transform: capitalize;
                                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                                transform: scale(0.95);
                                animation: popIn 0.4s ease-out forwards;
                            '>
                                {$state}
                            </span>
                    
                            <style>
                                @keyframes popIn {
                                    from {
                                        opacity: 0;
                                        transform: scale(0.8);
                                    }
                                    to {
                                        opacity: 1;
                                        transform: scale(1);
                                    }
                                }
                            </style>
                        ");
                    }),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime('F d, Y')
                    ->sortable()
                    ->label('Application Date'),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\ActionGroup::make([
                    Tables\Actions\ViewAction::make()
                        ->form([
                            Grid::make(1)->schema([
                                Placeholder::make('status')
                                    ->label('Status')
                                    ->content(function ($record) {
                                        $status = $record->status;
                                        $colors = [
                                            'pending' => '#facc15',  // gold/yellow
                                            'approved' => '#4ade80', // soft green
                                            'rejected' => '#f87171', // soft red
                                        ];

                                        $color = $colors[$status] ?? '#d1d5db'; // fallback gray
                            
                                        return new HtmlString("
                                            <span style='
                                                display: inline-block;
                                                background-color: {$color};
                                                color: #1f2937;
                                                padding: 0.3em 0.75em;
                                                border-radius: 0.5em;
                                                font-size: 0.9em;
                                                font-weight: 600;
                                                text-transform: capitalize;
                                                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                                                transform: scale(0.95);
                                                animation: popIn 0.4s ease-out forwards;
                                            '>
                                                {$status}
                                            </span>
                                    
                                            <style>
                                                @keyframes popIn {
                                                    from {
                                                        opacity: 0;
                                                        transform: scale(0.8);
                                                    }
                                                    to {
                                                        opacity: 1;
                                                        transform: scale(1);
                                                    }
                                                }
                                            </style>
                                        ");
                                    }),
                            ]),
                            Grid::make(2)->schema([
                                Placeholder::make('name')
                                    ->label('Name')
                                    ->content(fn($record) => $record->user?->name ?? '-'),
                                Placeholder::make('internship.title')
                                    ->label('Apply For')
                                    ->content(fn($record) => $record->internship?->title ?? '-'),
                                Placeholder::make('internship.company.name')
                                    ->label('At Company')
                                    ->content(fn($record) => $record->internship?->company?->name ?? '-'),
                                Placeholder::make('created_at')
                                    ->label('Application Date')
                                    ->content(fn($record) => $record->created_at?->format('F d, Y') ?? '-'),
                                Section::make('User Details')
                                    ->schema([
                                        Grid::make(3)->schema([
                                            Placeholder::make('user.name')
                                                ->label('Full Name')
                                                ->content(fn($record) => $record->user?->name ?? '-'),
                                            Placeholder::make('user.email')
                                                ->label('Email')
                                                ->content(fn($record) => $record->user?->email ?? '-'),
                                            Placeholder::make('full_name')
                                                ->label('Full Name')
                                                ->content(fn($record) => $record->full_name ?? '-'),
                                            Placeholder::make('date_of_birth')
                                                ->label('Date of Birth')
                                                ->content(fn($record) => $record->date_of_birth ?? '-'),
                                            Placeholder::make('address')
                                                ->label('Address')
                                                ->content(fn($record) => $record->address ?? '-'),
                                            Placeholder::make('education')
                                                ->label('Education')
                                                ->content(fn($record) => $record->education ?? '-'),
                                        ]),
                                    ])
                                    ->collapsible()
                                    ->collapsed(),
                                Section::make('Internship Details')
                                    ->schema([
                                        Grid::make(2)->schema([
                                            PdfViewerField::make('cv')
                                                ->label('CV')
                                                ->default(fn($record) => $record->cv ? Storage::url($record->cv) : null)
                                                ->visible(fn($record) => filled($record->cv)),
                                            Placeholder::make('cv_placeholder')
                                                ->label('CV')
                                                ->content('Tidak ada CV')
                                                ->visible(fn($record) => empty($record->cv)),
                                            PdfViewerField::make('certificate')
                                                ->label('Certificate')
                                                ->default(fn($record) => $record->certificate ? Storage::url($record->certificate) : null)
                                                ->visible(fn($record) => filled($record->certificate)),
                                            Placeholder::make('certificate_placeholder')
                                                ->label('Certificate')
                                                ->content('Tidak ada Certificate')
                                                ->visible(fn($record) => empty($record->certificate)),
                                        ]),

                                    ])
                                    ->collapsible()
                                    ->collapsed(),
                            ]),
                        ]),
                    Tables\Actions\DeleteAction::make(),
                ]),

            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListInternshipApplications::route('/'),
        ];
    }
}
