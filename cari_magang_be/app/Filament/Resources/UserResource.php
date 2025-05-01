<?php

namespace App\Filament\Resources;

use stdClass;
use App\Filament\Resources\UserResource\Pages;
use App\Filament\Resources\UserResource\RelationManagers;
use App\Models\User;
use App\Models\UserProfile;
use Filament\Forms;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\ViewField;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Contracts\HasTable;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\HtmlString;

class UserResource extends Resource
{
    protected static ?string $model = User::class;
    protected static ?string $navigationIcon = 'heroicon-o-users';
    protected static ?string $navigationGroup = 'User & Company';
    protected static ?string $label = 'User';
    protected static ?string $recordTitleAttribute = 'name';
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
                ImageColumn::make('profile_picture')
                    ->label('Profile Picture')
                    ->circular()
                    ->size(50)
                    ->getStateUsing(function ($record) {
                        if ($record->profile_picture) {
                            return asset('storage/profile_pictures/' . $record->profile_picture);
                        }
                        return asset('storage/profile_pictures/default.png');
                    }),
                TextColumn::make('name')->searchable(),
                TextColumn::make('email')->searchable(),
                TextColumn::make('profile.phone')->label('Phone')->searchable()->copyable(),
            ])
            ->actions([
                Tables\Actions\ActionGroup::make([
                    Tables\Actions\ViewAction::make()
                        ->form([
                            Grid::make(2)->schema([
                                Placeholder::make('name')
                                    ->label('Name')
                                    ->content(fn($record) => $record->name ?? '-'),
                                Placeholder::make('email')
                                    ->label('Email')
                                    ->content(fn($record) => $record->email ?? '-'),
                                Placeholder::make('phone')
                                    ->label('Phone')
                                    ->content(fn($record) => $record->profile?->phone ?? '-'),
                                Placeholder::make('address')
                                    ->label('Address')
                                    ->content(fn($record) => $record->profile?->address ?? '-'),
                                Placeholder::make('education')
                                    ->label('Education')
                                    ->content(fn($record) => $record->profile?->education ?? '-'),
                                Placeholder::make('profile_picture')
                                    ->label('Profile Picture')
                                    ->content(function ($record) {
                                        $imageUrl = $record->profile_picture
                                            ? asset('storage/profile_pictures/' . $record->profile_picture)
                                            : asset('storage/profile_pictures/default.png');
                                        return new HtmlString("<img src='$imageUrl' style='width: 200px; height: 200px; object-fit: cover;'>");
                                    }),
                                DateTimePicker::make('created_at')
                                    ->label('Created At')
                                    ->displayFormat('d M Y H:i')
                                    ->default(fn($record) => $record->created_at),
                            ])
                        ]),
                    Tables\Actions\DeleteAction::make(),
                ])
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()->with('profile')->where('role', 'user');
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListUsers::route('/'),
        ];
    }

}