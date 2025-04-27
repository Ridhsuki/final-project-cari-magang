@php
    use Filament\Support\Facades\FilamentView;
    use Illuminate\Support\Facades\Storage;  // Pastikan ini ada

    $hasInlineLabel = $hasInlineLabel();
    $statePath = $getStatePath();

    $filePath = is_array($getState()) ? current($getState()) : $getState();
    
    $fileUrl = $filePath ? Storage::url($filePath) : null;
@endphp

<x-dynamic-component
    :component="$getFieldWrapperView()"
    :field="$field"
    :has-inline-label="$hasInlineLabel"
>
    <x-slot
        name="label"
        @class([
            'sm:pt-1.5' => $hasInlineLabel,
        ])
    >
        {{ $getLabel() }}
    </x-slot>

    <x-filament::input.wrapper
        :attributes="
            \Filament\Support\prepare_inherited_attributes($getExtraAttributeBag())
                ->class(['fi-fo-textarea overflow-hidden'])
        "
    >
        @if(!empty($fileUrl))
            <iframe
                class="w-full"
                src="{{ $fileUrl }}" style="min-height: {{ $getMinHeight() }};">
            </iframe>
        @elseif(!empty($getFileUrl()))
            <iframe
                class="w-full"
                src="{{ $getFileUrl() }}" style="min-height: {{ $getMinHeight() }};">
            </iframe>
        @endif
    </x-filament::input.wrapper>
</x-dynamic-component>
