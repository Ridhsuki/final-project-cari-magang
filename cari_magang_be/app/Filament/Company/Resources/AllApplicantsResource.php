<?php

namespace App\Filament\Company\Resources;

use App\Filament\Company\Resources\AllApplicantsResource\Pages;
use App\Filament\Company\Resources\AllApplicantsResource\RelationManagers;
use App\Models\InternshipApplication;
use App\Models\Notification;
use Filament\Tables\Actions\Action;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Section;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Joaopaulolndev\FilamentPdfViewer\Forms\Components\PdfViewerField;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\HtmlString;

class AllApplicantsResource extends Resource
{
    protected static ?string $model = InternshipApplication::class;
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $label = 'Applicants';
    protected static ?string $pluralLabel = 'Applicants';
    protected static ?string $navigationLabel = 'Applicants';
    protected static ?string $slug = 'applicants';
    protected static ?string $navigationGroup = 'Management';
    public static function getNavigationSort(): ?int
    {
        return 2;
    }
    public static function canCreate(): bool
    {
        return false;
    }
    public static function getNavigationBadge(): ?string
    {
        return InternshipApplication::whereHas('internship', function ($query) {
            $query->where('user_id', auth()->user()->id);
        })
            ->where('status', 'pending')
            ->count();
    }
    public static function getNavigationBadgeColor(): string|array|null
    {
        return InternshipApplication::whereHas('internship', function ($query) {
            $query->where('user_id', auth()->user()->id);
        })
            ->where('status', 'pending')
            ->count() > 1 ? 'warning' : 'secondary';
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
                Tables\Columns\TextColumn::make('internship.company.name')
                    ->sortable()
                    ->searchable()
                    ->label('At Company')
                    ->toggleable(isToggledHiddenByDefault: true),
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
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime('F d, Y')
                    ->sortable()
                    ->label('Apply Date'),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('internship.title')
                ->relationship('internship', 'title', function ($query) {
                    $query->where('user_id', auth()->user()->id);
                })
                ->label('Internship')
                ->placeholder('Internship'),
            ])
            ->actions([
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
                            Section::make('Internship Details')
                                ->schema([
                                    Grid::make(2)->schema([
                                        Placeholder::make('internship.title')
                                            ->label('Title')
                                            ->content(fn($record) => $record->internship?->title ?? '-'),
                                        Placeholder::make('internship.location')
                                            ->label('Location')
                                            ->content(fn($record) => $record->internship?->location ?? '-'),
                                        Placeholder::make('internship.system')
                                            ->label('System')
                                            ->content(function ($record) {
                                                $system = $record->internship?->system ?? 'default';
                                                $color = match ($system) {
                                                    'remote' => '#38B2AC',
                                                    'on-site' => '#F56565',
                                                    default => '#A0AEC0'
                                                };
                                                return new HtmlString("<span style='background-color: {$color}; color: white; padding: 0.2em 0.6em; border-radius: 0.3em; font-size: 0.9em; text-transform: capitalize;'>{$system}</span>");
                                            }),
                                        Placeholder::make('internship.description')
                                            ->label('Description')
                                            ->content(fn($record) => $record->internship?->description ?? '-'),
                                        Placeholder::make('internship.status')
                                            ->label('Status')
                                            ->content(function ($record) {
                                                $status = $record->internship?->status ?? 'default';
                                                $color = match ($status) {
                                                    'paid' => '#6BBF59',
                                                    'unpaid' => '#F4A259',
                                                    default => '#A0AEC0',
                                                };
                                                return new HtmlString("<span style='background-color: {$color}; color: white; padding: 0.2em 0.6em; border-radius: 0.3em; font-size: 0.9em; text-transform: capitalize;'>{$status}</span>");
                                            }),
                                        Placeholder::make('internship.category.name')
                                            ->label('Category')
                                            ->content(fn($record) => $record->internship?->category?->name ?? '-'),
                                        Placeholder::make('internship.company.name')
                                            ->label('Company')
                                            ->content(fn($record) => $record->internship?->company?->name ?? '-'),
                                        Placeholder::make('internship.created_at')
                                            ->label('Posted At')
                                            ->content(fn($record) => $record->internship?->created_at?->format('F d, Y') ?? '-'),
                                    ]),
                                ])
                                ->collapsible()
                                ->collapsed(),
                        ]),
                    ]),
                Tables\Actions\ActionGroup::make([
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
                                'type' => 'application_response',
                                'notifiable_id' => $record->id,
                                'notifiable_type' => InternshipApplication::class,
                                'message' => 'Your application to "' . $record->internship?->title . '" has been approved.',
                                'is_read' => false,
                            ]);
                        })
                        ->color('success')
                        ->icon('heroicon-o-check')
                        ->disabled(fn($record) => $record->status !== 'pending'),

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
                                'type' => 'application_response',
                                'notifiable_id' => $record->id,
                                'notifiable_type' => InternshipApplication::class,
                                'message' => 'Your application to "' . $record->internship?->title . '" has been rejected .',
                                'is_read' => false,
                            ]);
                        })
                        ->color('danger')
                        ->icon('heroicon-o-x-circle')
                        ->disabled(fn($record) => $record->status !== 'pending'),
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

    public static function getEloquentQuery(): Builder
    {
        return InternshipApplication::query()
            ->whereHas('internship', function ($query) {
                $query->where('user_id', auth()->id());
            });
    }


    public static function getPages(): array
    {
        return [
            'index' => Pages\ListAllApplicants::route('/'),
            // 'create' => Pages\CreateAllApplicants::route('/create'),
            // 'edit' => Pages\EditAllApplicants::route('/{record}/edit'),
        ];
    }
}
