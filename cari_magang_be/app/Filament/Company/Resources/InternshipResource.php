<?php

namespace App\Filament\Company\Resources;

use App\Filament\Company\Resources\InternshipResource\Pages;
use App\Filament\Company\Resources\InternshipResource\RelationManagers;
use App\Models\Internship;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Hidden;
use Filament\Forms\Components\RichEditor;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\HtmlString;

class InternshipResource extends Resource
{
    protected static ?string $model = Internship::class;

    protected static ?string $navigationIcon = 'heroicon-o-briefcase';
    protected static ?string $label = 'Internship';
    protected static ?string $pluralLabel = 'Your Internships';
    protected static ?string $navigationLabel = 'Internships';
    protected static ?string $navigationGroup = 'Management';
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Grid::make(2)
                    ->schema([
                        TextInput::make('title')
                            ->required()
                            ->maxLength(255),
                        TextInput::make('location')
                            ->required()
                            ->maxLength(255),
                        Select::make('category_id')
                            ->relationship('category', 'name')
                            ->required(),
                        Select::make('status')
                            ->options([
                                'paid' => 'Paid',
                                'unpaid' => 'Unpaid',
                            ])->default('paid')
                            ->required(),
                        Select::make('system')
                            ->options([
                                'remote' => 'Remote',
                                'on-site' => 'On-Site',
                            ])->default('on-site')
                            ->required(),
                    ]),
                Grid::make(1)
                    ->schema([
                        RichEditor::make('description')
                            ->required(),
                    ]),
                Hidden::make('user_id')
                    ->default(Auth::id())
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('title')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('company.name')
                    ->sortable()
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('category.name')
                    ->sortable()
                    ->searchable()
                    ->label('Category'),
                TextColumn::make('location')
                    ->sortable()
                    ->searchable()
                    ->toggleable(isToggledHiddenByDefault: true),
                TextColumn::make('status')
                    ->sortable()
                    ->searchable()
                    ->label('Status')
                    ->formatStateUsing(function ($state) {
                        $color = match ($state) {
                            'paid' => '#6BBF59',
                            'unpaid' => '#F4A259',
                            default => '#A0AEC0'
                        };
                        return new HtmlString("<span style='background-color: {$color}; color: white; padding: 0.2em 0.6em; border-radius: 0.3em; font-size: 0.9em; text-transform: capitalize;'>{$state}</span>");
                    }),
                TextColumn::make('system')
                    ->sortable()
                    ->searchable()
                    ->label('System')
                    ->formatStateUsing(function ($state) {
                        $color = match ($state) {
                            'remote' => '#38B2AC',
                            'on-site' => '#F56565',
                            default => '#A0AEC0'
                        };
                        return new HtmlString("<span style='background-color: {$color}; color: white; padding: 0.2em 0.6em; border-radius: 0.3em; font-size: 0.9em; text-transform: capitalize;'>{$state}</span>");
                    })
                ,
                TextColumn::make('applications_count')
                    ->counts('applications')
                    ->label('Applicants count')
                    ->sortable()
                    ->toggleable(),
                TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->label('Posted At')
                    ->formatStateUsing(fn($state) => $state->format('d M Y H:i')),
            ])
            ->actions([
                Tables\Actions\ActionGroup::make([
                    Tables\Actions\ViewAction::make('view')
                        ->icon('heroicon-o-eye'),
                    Tables\Actions\EditAction::make(),
                    Tables\Actions\DeleteAction::make(),
                ])
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->filters([
                SelectFilter::make('status')
                    ->label('Status')
                    ->options([
                        'paid' => 'Paid',
                        'unpaid' => 'Unpaid',
                    ]),
                SelectFilter::make('system')
                    ->label('System')
                    ->options([
                        'remote' => 'Remote',
                        'on-site' => 'On-site',
                    ]),
                SelectFilter::make('category_id')
                    ->label('Category')
                    ->relationship('category', 'name'),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            RelationManagers\InternshipApplicationsRelationManager::class,
        ];
    }


    public static function getPages(): array
    {
        return [
            'index' => Pages\ListInternships::route('/'),
            'create' => Pages\CreateInternship::route('/create'),
            'view' => Pages\ViewInternship::route('/{record}'),
        ];
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->where('user_id', auth()->id());
    }
}
