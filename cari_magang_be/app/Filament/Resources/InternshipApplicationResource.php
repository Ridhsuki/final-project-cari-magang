<?php

namespace App\Filament\Resources;

use App\Filament\Resources\InternshipApplicationResource\Pages;
use App\Filament\Resources\InternshipApplicationResource\RelationManagers;
use App\Models\Internship;
use App\Models\InternshipApplication;
use App\Models\User;
use Filament\Forms;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Joaopaulolndev\FilamentPdfViewer\Forms\Components\PdfViewerField;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\Facades\Storage;

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
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Grid::make(2)->schema([
                    Select::make('user_id')
                        ->label('Name')
                        ->options(User::all()->pluck('name', 'id'))
                        ->searchable()
                        ->required(),
                    Select::make('internship_id')
                        ->label('Apply For')
                        ->options(Internship::all()->pluck('title', 'id'))
                        ->searchable()
                        ->required(),
                    FileUpload::make('cv')
                        ->label('CV'),
                    FileUpload::make('certificate')
                        ->label('Certificate'),
                ]),
                Forms\Components\Hidden::make('user_id')
                    ->default(auth()->id()),
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
                                PdfViewerField::make('cv')
                                    ->label('CV')
                                    ->default(function ($record) {
                                        return $record->cv ? Storage::url($record->cv) : null;
                                    }),
                                PdfViewerField::make('certificate')
                                    ->label('Certificate')
                                    ->default(function ($record) {
                                        return $record->certificate ? Storage::url($record->certificate) : null;
                                    }),
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
