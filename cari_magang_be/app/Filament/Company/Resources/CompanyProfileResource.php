<?php

namespace App\Filament\Company\Resources;

use App\Filament\Company\Resources\CompanyProfileResource\Pages;
use App\Models\CompanyProfile;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class CompanyProfileResource extends Resource
{
    protected static ?string $model = CompanyProfile::class;

    protected static ?string $navigationIcon = 'heroicon-o-user-circle';
    protected static ?string $label = 'Company Profile';
    protected static ?string $pluralLabel = 'Your Profile';
    protected static ?string $navigationLabel = 'Profile';
    protected static ?string $navigationGroup = 'Profile';
    public static function canCreate(): bool
    {
        return false;
    }
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Hidden::make('user_id')->default(auth()->id())->dehydrated(),
                Forms\Components\Textarea::make('description')
                    ->label('Company Description')
                    ->maxLength(500)
                    ->nullable()
                    ->rows(4)
                    ->columnSpan(2),
                Forms\Components\TextInput::make('address')
                    ->label('Address')
                    ->maxLength(255)
                    ->nullable(),
                Forms\Components\TextInput::make('phone')
                    ->label('Phone Number')
                    ->tel()
                    ->numeric()
                    ->maxLength(20)
                    ->nullable(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('user.name')
                    ->label('Company Name'),
                Tables\Columns\TextColumn::make('user.email')->label('Email'),

            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\ViewAction::make()
                    ->form([
                        Forms\Components\Textarea::make('description')
                            ->label('Company Description')
                            ->maxLength(500)
                            ->disabled()
                            ->rows(4)
                            ->columnSpan(2),
                        Forms\Components\TextInput::make('address')
                            ->label('Address')
                            ->maxLength(255)
                            ->disabled(),
                        Forms\Components\TextInput::make('phone')
                            ->label('Phone Number')
                            ->tel()
                            ->numeric()
                            ->maxLength(20)
                            ->disabled(),
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
        return parent::getEloquentQuery()
            ->where('user_id', auth()->id())
            ->with('user');
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCompanyProfiles::route('/'),
        ];
    }
}
