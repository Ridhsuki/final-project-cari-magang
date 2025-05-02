<?php

namespace App\Filament\Company\Resources\InternshipResource\RelationManagers;

use App\Models\InternshipApplication;
use App\Models\Notification;
use Filament\Forms;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Section;
use Filament\Tables;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Actions\Action;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\HtmlString;
use Joaopaulolndev\FilamentPdfViewer\Forms\Components\PdfViewerField;

class InternshipApplicationsRelationManager extends RelationManager
{
    protected static string $relationship = 'applications';
    protected static ?string $title = 'People Who Applied';

    public function form(Forms\Form $form): Forms\Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('full_name')->required(),
                Forms\Components\TextInput::make('education'),
                Forms\Components\Select::make('status')->options([
                    'pending' => 'Pending',
                    'accepted' => 'Accepted',
                    'rejected' => 'Rejected',
                ])->required(),
            ]);
    }

    public function table(Tables\Table $table): Tables\Table
    {
        return $table
            ->columns([
                TextColumn::make('full_name')->searchable(),
                TextColumn::make('cv')
                    ->label('CV')
                    ->formatStateUsing(fn($state) => $state ? 'CV' : '-')
                    ->url(fn($record) => $record->cv ? Storage::url($record->cv) : null, true)
                    ->openUrlInNewTab(),
                TextColumn::make('certificate')
                    ->label('Certificate')
                    ->formatStateUsing(fn($state) => $state ? 'Certificate' : '-')
                    ->url(fn($record) => $record->certificate ? Storage::url($record->certificate) : null, true),
                TextColumn::make('status')
                    ->label('Status')
                    ->formatStateUsing(function ($state) {
                        $colors = [
                            'pending' => '#facc15',
                            'approved' => '#4ade80',
                            'rejected' => '#f87171',
                        ];

                        $color = $colors[$state] ?? '#d1d5db';

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
            ])
            ->actions([
                Action::make('approve')
                    ->label('Approve')
                    ->action(function ($record) {
                        if ($record->status !== 'pending')
                            return;

                        $record->update(['status' => 'approved']);

                        Notification::create([
                            'sender_id' => auth()->id(),
                            'receiver_id' => $record->user_id,
                            'internship_id' => $record->internship_id,
                            'notifiable_id' => $record->id,
                            'notifiable_type' => InternshipApplication::class,
                            'type' => 'application_response',
                            'message' => 'Your application to "' . $record->internship?->title . '" has been approved.',
                            'is_read' => false,
                        ]);
                    })
                    ->color('success')
                    ->icon('heroicon-o-check')
                    ->visible(fn($record) => $record->status === 'pending'),
                Action::make('reject')
                    ->label('Reject')
                    ->action(function ($record) {
                        if ($record->status !== 'pending')
                            return;

                        $record->update(['status' => 'rejected']);

                        Notification::create([
                            'sender_id' => auth()->id(),
                            'receiver_id' => $record->user_id,
                            'internship_id' => $record->internship_id,
                            'notifiable_id' => $record->id,
                            'notifiable_type' => InternshipApplication::class,
                            'type' => 'application_response',
                            'message' => 'Your application to "' . $record->internship?->title . '" has been rejected.',
                            'is_read' => false,
                        ]);
                    })
                    ->color('danger')
                    ->icon('heroicon-o-x-circle')
                    ->visible(fn($record) => $record->status === 'pending'),
                Tables\Actions\EditAction::make(),
                Tables\Actions\ViewAction::make()
                    ->form([
                        Grid::make(1)->schema([
                            Placeholder::make('status')
                                ->label('Status')
                                ->content(function ($record) {
                                    $status = $record->status;
                                    $colors = [
                                        'pending' => '#facc15',
                                        'approved' => '#4ade80',
                                        'rejected' => '#f87171',
                                    ];

                                    $color = $colors[$status] ?? '#d1d5db';

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
                                            ->label('username')
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
                            Section::make('Documents')
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
            ])
            ->bulkActions([
                Tables\Actions\DeleteBulkAction::make(),
            ]);
    }
}
