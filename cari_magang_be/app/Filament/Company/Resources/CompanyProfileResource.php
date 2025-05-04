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
use Filament\Forms\Components\Actions\Action as FormAction;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Illuminate\Support\HtmlString;

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
                Tables\Columns\ImageColumn::make('user.profile_picture')
                    ->label('Logo')
                    ->circular()
                    ->size(50)
                    ->getStateUsing(function ($record) {
                        if ($record->user->profile_picture) {
                            return asset('storage/profile_pictures/' . $record->user->profile_picture);
                        }
                        return asset('default.png');
                    }),
                Tables\Columns\TextColumn::make('user.name')
                    ->label('Company Name'),
                Tables\Columns\TextColumn::make('user.email')->label('Email'),
            ])
            ->actions([
                Tables\Actions\ViewAction::make()
                    ->form([
                        Grid::make(2)->schema([
                            Placeholder::make('profile_picture')
                                ->label('Company Logo')
                                ->content(function ($record) {
                                    $imageUrl = $record->user->profile_picture
                                        ? asset('storage/profile_pictures/' . $record->user->profile_picture)
                                        : asset('storage/profile_pictures/default.png');
                                    return new HtmlString("<img src='$imageUrl' style='width: 200px; height: 200px; object-fit: cover; border-radius: 50%;' alt='Company Logo' />");
                                }),
                            Forms\Components\Textarea::make('description')
                                ->label('Company Description')
                                ->maxLength(500)
                                ->disabled()
                                ->cols(16)
                                ->rows(8),
                        ]),
                        Forms\Components\TextInput::make('address')
                            ->label('Address')
                            ->maxLength(255)
                            ->disabled(),
                        Placeholder::make('phone')
                            ->label('Phone Number')
                            ->content(fn($record) => $record->phone),
                        Grid::make(2)->schema([
                            Placeholder::make('created_at')
                                ->label('Created At')
                                ->content(fn($record) => $record->created_at->format('d M Y H:i:s')),
                            Placeholder::make('updated_at')
                                ->label('Updated At')
                                ->content(fn($record) => $record->updated_at->format('d M Y H:i:s')),
                        ]),
                        Forms\Components\Actions::make([
                            FormAction::make('edit')
                                ->label('Edit Profile')
                                ->url(fn() => route('profile.edit'))
                                ->icon('heroicon-o-pencil')
                        ])->fullWidth(),
                    ])
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
