<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CompanyResource\Pages;
use App\Filament\Resources\CompanyResource\RelationManagers;
use App\Models\Company;
use App\Models\CompanyProfile;
use Dom\Text;
use Filament\Forms;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\RichEditor;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\HtmlString;

class CompanyResource extends Resource
{
    protected static ?string $model = CompanyProfile::class;
    protected static ?string $navigationIcon = 'heroicon-o-building-office';
    protected static ?string $navigationGroup = 'User & Company';
    protected static ?string $label = 'Company';
    protected static ?string $recordTitleAttribute = 'company_name';
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
                ImageColumn::make('user.profile_picture')
                    ->label('Logo')
                    ->circular()
                    ->size(50)
                    ->getStateUsing(function ($record) {
                        if ($record->user->profile_picture) {
                            return asset('storage/profile_pictures/' . $record->user->profile_picture);
                        }
                        return asset('storage/profile_pictures/default.png');
                    }),
                TextColumn::make('user.name')->label('Company Name')->searchable(),
                TextColumn::make('user.email')->label('Email')->searchable(),
                TextColumn::make('phone'),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\ActionGroup::make([
                    Tables\Actions\ViewAction::make()
                        ->form([
                            Grid::make(2)->schema([
                                Placeholder::make('user.name')
                                    ->label('Company Name')
                                    ->content(fn($record) => $record->user?->name ?? '-'),
                                Placeholder::make('user.email')
                                    ->content(fn($record) => $record->user?->email ?? '-'),
                                Placeholder::make('phone')
                                    ->content(fn($record) => $record->phone ?? '-'),
                                Placeholder::make('address')
                                    ->content(fn($record) => $record->address ?? '-'),
                                RichEditor::make('description'),
                                Placeholder::make('profile_picture')
                                    ->label('Company Logo')
                                    ->content(function ($record) {
                                        $imageUrl = asset("storage/profile_pictures/{$record->user->profile_picture}");
                                        return new HtmlString("<img src='$imageUrl' style='width: 200px; height: 200px; object-fit: cover;'>");
                                    }),

                                DateTimePicker::make('created_at')
                                    ->label('Created At')
                                    ->displayFormat('d M Y H:i'),
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

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCompanies::route('/'),
        ];
    }
}
