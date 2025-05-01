<?php

namespace App\Filament\Resources;

use App\Filament\Resources\InternshipResource\Pages;
use App\Filament\Resources\InternshipResource\RelationManagers;
use App\Models\Category;
use App\Models\Internship;
use Dom\Text;
use Filament\Forms;
use Filament\Forms\Components\DateTimePicker;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
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
    protected static ?string $navigationGroup = 'Management';
    protected static ?string $label = 'Internship';
    protected static ?string $recordTitleAttribute = 'title';
    public static function getNavigationSort(): ?int
    {
        return 1;
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Grid::make(2)->schema([
                    TextInput::make('title')
                        ->required()
                        ->maxLength(255),
                    Select::make('category_id')
                        ->label('Category')
                        ->options(Category::all()->pluck('name', 'id'))
                        ->searchable()
                        ->required(),
                    TextInput::make('location')
                        ->nullable()
                        ->maxLength(255),
                    Select::make('status')
                        ->options([
                            'paid' => 'Paid',
                            'unpaid' => 'Unpaid',
                        ])
                        ->default('unpaid')
                        ->label('Status')
                        ->required(),
                ]),
                RichEditor::make('description')
                    ->required()
                    ->maxLength(65535)
                    ->columnSpan(2),
                Forms\Components\Hidden::make('user_id')
                    ->default(Auth::id()),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('title')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('company.name')
                    ->label('Posted By')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('category.name')
                    ->label('Category')
                    ->sortable(),
                // TextColumn::make('location'),
                TextColumn::make('status')
                    ->badge()
                    ->colors([
                        'warning' => 'unpaid',
                        'success' => 'paid',
                    ])
                    ->label('Status')
                    ->sortable(),
                TextColumn::make('created_at')
                    ->dateTime('F d, Y')
                    ->sortable(),
            ])
            ->filters([
                SelectFilter::make('category_id')
                    ->label('Category')
                    ->relationship('category', 'name'),
                SelectFilter::make('company_id')
                    ->label('Company')
                    ->relationship(
                        'company',
                        'name',
                        fn($query) => $query->where('role', 'company') // filter hanya user company
                    ),
            ])

            ->actions([
                Tables\Actions\ActionGroup::make([
                    Tables\Actions\ViewAction::make()
                        ->form([
                            Grid::make(2)->schema([
                                TextInput::make('title')
                                    ->maxLength(255),
                                Select::make('category_id')
                                    ->label('Category')
                                    ->options(Category::all()->pluck('name', 'id'))
                                    ->required(),
                                Grid::make(3)->schema([
                                    TextInput::make('location')
                                        ->nullable()
                                        ->maxLength(255),
                                    Placeholder::make('status')
                                        ->label('Status')
                                        ->content(function ($record) {
                                            $color = match ($record->status) {
                                                'paid' => '#6BBF59',
                                                'unpaid' => '#F4A259',
                                                'default' => '#A0AEC0'
                                            };
                                            return new HtmlString("<span style='background-color: {$color}; color: white; padding: 0.2em 0.6em; border-radius: 0.3em; font-size: 0.9em; text-transform: capitalize;'>{$record->status}</span>");
                                        }),
                                    Placeholder::make('system')
                                        ->label('System')
                                        ->content(function ($record) {
                                            $color = match ($record->system) {
                                                'remote' => '#38B2AC',
                                                'on-site' => '#F56565',
                                                'default' => '#A0AEC0'
                                            };
                                            return new HtmlString("<span style='background-color: {$color}; color: white; padding: 0.2em 0.6em; border-radius: 0.3em; font-size: 0.9em; text-transform: capitalize;'>{$record->system}</span>");
                                        }),
                                ]),
                                Grid::make(1)->schema([
                                    RichEditor::make('description'),
                                ]),
                                Placeholder::make('company_name')
                                    ->label('Posted By')
                                    ->content(fn($record) => $record->company?->name ?? '-'),
                                DateTimePicker::make('created_at')
                                    ->label('Created At')
                                    ->displayFormat('d M Y H:i'),
                            ])
                        ]),
                    Tables\Actions\EditAction::make(),
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
        return [];
    }
    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()->with(['company', 'category']);
    }
    public static function getPages(): array
    {
        return [
            'index' => Pages\ListInternships::route('/'),
            'create' => Pages\CreateInternship::route('/create'),
        ];
    }
}